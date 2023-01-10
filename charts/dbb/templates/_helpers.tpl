{{/*
Expand the name of the chart.
*/}}
{{- define "dbb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dbb.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dbb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dbb.labels" -}}
helm.sh/chart: {{ include "dbb.chart" . }}
{{ include "dbb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/environment: {{ .Values.global.environment }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dbb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dbb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "dbb.hostname" -}}
  {{- $hostname := "" }}
  {{- if .Values.hostname }}
    {{- .Values.hostname }}
  {{- else if .Values.global.projectHostname }}
    {{- printf "%s.%s" "dbb" .Values.global.projectHostname }}
  {{- else }}
    {{- required "value for .Values.hostname or .Values.global.projectHostname" "" }}
  {{- end }}
{{- end }}

{{- define "dbb.randHex" -}}
    {{- $result := "" }}
    {{- range $i := until . }}
        {{- $rand_hex_char := mod (randNumeric 4 | atoi) 16 | printf "%x" }}
        {{- $result = print $result $rand_hex_char }}
    {{- end }}
    {{- $result }}
{{- end }}

{{- define "dbb.lockbox_master_key" -}}
    {{- if .Values.lockboxMasterKey }}
        {{- .Values.lockboxMasterKey }}
    {{- else }}
        {{- $k8s_state := lookup "v1" "Secret" .Release.Namespace .Values.databaseCredentials.secret | default (dict "data" (dict)) }}
        {{- if hasKey $k8s_state.data "lockboxMasterKey" }}
            {{- index $k8s_state.data "lockboxMasterKey" | b64dec }}
        {{- else }}
            {{- include "dbb.randHex" 64 }}
        {{- end }}
    {{- end }}
{{- end }}