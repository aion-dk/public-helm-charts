{{/*
Private/public key pair secret precondition check
*/}}
{{- define "key-pair" -}}
  {{- $namespace := index . 0 }}
  {{- $name := index . 1 }}
  # Check that prerequisite public key secret is present
  {{- $keyname := (print $name "-site-public-key") -}}
  {{ if empty (lookup "v1" "Secret" $namespace $keyname) }}
    {{ fail (cat "Public key secret " $keyname " must be present in the" $namespace "namespace. Create it manually, or use the the service-keypair.sh shell script. See the documentation in https://github.com/aion-dk/terraform-main/environments/exoscale-development/service-keypair.sh for more information") }}
  {{ end }}

  {{- $keyname := (print $name "-site-private-key") -}}
  {{ if empty (lookup "v1" "Secret" $namespace $keyname) }}
    {{ fail (cat "Private key secret " $keyname " must be present in the" $namespace "namespace. Create it manually, or use the the service-keypair.sh shell script. See the documentation in https://github.com/aion-dk/terraform-main/environments/exoscale-development/service-keypair.sh for more information") }}
  {{ end }}
{{- end }}