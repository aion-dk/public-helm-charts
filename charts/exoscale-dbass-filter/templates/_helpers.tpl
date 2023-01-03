{{/*
Expand the name of the chart.
*/}}
{{- define "exoscale-dbass-filter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "exoscale-dbass-filter.fullname" -}}
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
{{- define "exoscale-dbass-filter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "exoscale-dbass-filter.labels" -}}
helm.sh/chart: {{ include "exoscale-dbass-filter.chart" . }}
{{ include "exoscale-dbass-filter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "exoscale-dbass-filter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "exoscale-dbass-filter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "exoscale-dbass-filter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "exoscale-dbass-filter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role
*/}}
{{- define "exoscale-dbass-filter.clusterRoleName" -}}
{{- printf "%s:%s:%s" "exoscale" .Release.Namespace "nodelist" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
