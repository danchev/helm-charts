#!/usr/bin/env python3
"""Exercise rendered AIBrix Redis server and init commands in local containers.

Requires Helm, Docker, and PyYAML (installed by chart-testing in CI).
"""

import base64
from pathlib import Path
import subprocess
import time
import uuid

import yaml


ROOT = Path(__file__).resolve().parents[1]


def run(*args, timeout=120, **kwargs):
    return subprocess.run(
        args, check=True, text=True, capture_output=True, timeout=timeout, **kwargs
    ).stdout.strip()


def check_case(values):
    manifests = yaml.safe_load_all(
        run("helm", "template", "auth-test", str(ROOT / "charts/aibrix"), "-f", "-",
            input=yaml.safe_dump(values))
    )
    docs = [doc for doc in manifests if doc]
    deployments = [doc for doc in docs if doc["kind"] == "Deployment"]
    redis = next(doc for doc in deployments
                 if doc["metadata"]["name"].endswith("-redis-master"))
    container = redis["spec"]["template"]["spec"]["containers"][0]
    secrets = {doc["metadata"]["name"]: doc.get("data", {})
               for doc in docs if doc["kind"] == "Secret"}

    def password_for(spec):
        for env in spec.get("env", []):
            if env["name"] == "REDIS_PASSWORD":
                ref = env["valueFrom"]["secretKeyRef"]
                return base64.b64decode(secrets[ref["name"]][ref["key"]]).decode()
        return ""

    password = password_for(container)
    # Kubernetes expands $(VAR) in container arguments without shell evaluation.
    args = [arg.replace("$(REDIS_PASSWORD)", password)
            for arg in container.get("args", [])]
    server_name = "aibrix-redis-auth-" + uuid.uuid4().hex
    cleanup = [server_name]
    try:
        run("docker", "run", "--detach", "--name", server_name,
            "--env", "REDIS_PASSWORD=" + password, container["image"], *args)
        expected = "NOAUTH Authentication required." if password else "PONG"
        for _ in range(30):
            try:
                reply = run("docker", "exec", server_name, "redis-cli", "ping")
            except subprocess.CalledProcessError:
                reply = "Redis is not ready"
            if reply == expected:
                break
            time.sleep(0.2)
        else:
            raise AssertionError(f"Unexpected unauthenticated Redis reply: {reply!r}")
        if password:
            assert run("docker", "exec", "--env", "REDISCLI_AUTH=" + password,
                       server_name, "redis-cli", "ping") == "PONG"

        # Run the actual BusyBox commands rendered for both Redis-dependent init
        # containers. Sharing the server's network avoids exposing any host port.
        for deployment in deployments:
            for init in deployment["spec"]["template"]["spec"].get("initContainers", []):
                client_name = server_name + "-" + init["name"]
                cleanup.append(client_name)
                command = init["command"][:]
                if password:
                    command[-2:] = ["127.0.0.1", "6379"]
                else:
                    command[2] = command[2].replace(redis["metadata"]["name"], "127.0.0.1")
                run("docker", "run", "--rm", "--name", client_name,
                    "--network", "container:" + server_name,
                    "--env", "REDIS_PASSWORD=" + password_for(init),
                    "--entrypoint", command[0], init["image"], *command[1:], timeout=30)
    finally:
        subprocess.run(["docker", "rm", "--force", *cleanup],
                       check=False, capture_output=True, timeout=30)


if __name__ == "__main__":
    cases = [
        ("no authentication", {}),
        ("password-only authentication", {"metadata": {"redis": {"password": "test-password"}}}),
        ("explicit authentication with special characters", {"metadata": {"redis": {
            "enablePassword": True, "password": "test password \"'$special\\value\n☃",
        }}}),
    ]
    for name, values in cases:
        check_case(values)
        print(f"PASS: {name}", flush=True)
