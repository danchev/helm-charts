{{- define "kuberay-historyserver.fullname" -}}
{{- default .Release.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "kuberay-historyserver.selectorLabels" -}}
{{- if .Values.selectorLabels -}}
{{ toYaml .Values.selectorLabels }}
{{- else -}}
app.kubernetes.io/name: kuberay-historyserver
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- end -}}
{{- define "kuberay-historyserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "kuberay-historyserver.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
