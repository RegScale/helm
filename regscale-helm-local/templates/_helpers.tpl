{{/*
Expand the name of the chart.
*/}}
{{- define "regscale-local.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "regscale-local.fullname" -}}
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
{{- define "regscale-local.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "regscale-local.labels" -}}
helm.sh/chart: {{ include "regscale-local.chart" . }}
{{ include "regscale-local.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "regscale-local.selectorLabels" -}}
app.kubernetes.io/name: {{ include "regscale-local.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "regscale-local.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "regscale-local.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "regscale-local.pvcName" -}}
{{- printf "%s-%s" (include "regscale-local.fullname" .) "data" }}
{{- end }}

{{- define "regscale-local.cmName" -}}
{{- printf "%s-%s" (include "regscale-local.fullname" .) "config" }}
{{- end }}

{{- define "regscale-local.secretName" -}}
{{- printf "%s-%s" (include "regscale-local.fullname" .) "secrets" }}
{{- end }}
