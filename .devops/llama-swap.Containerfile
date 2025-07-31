ARG BASE_TAG=server-cuda
FROM ghcr.io/danchev/ik_llama.cpp:${BASE_TAG}

# has to be after the FROM
ARG LS_VER=145

WORKDIR /app
RUN \
    curl -LO https://github.com/mostlygeek/llama-swap/releases/download/v"${LS_VER}"/llama-swap_"${LS_VER}"_linux_amd64.tar.gz && \
    tar -zxf llama-swap_"${LS_VER}"_linux_amd64.tar.gz && \
    rm llama-swap_"${LS_VER}"_linux_amd64.tar.gz

# COPY config.example.yaml /app/config.yaml
RUN curl -LO https://raw.githubusercontent.com/mostlygeek/llama-swap/HEAD/docker/config.example.yaml \
    && mv config.example.yaml /app/config.yaml

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
ENTRYPOINT [ "/app/llama-swap", "-config", "/app/config.yaml" ]
