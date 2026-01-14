# helm-traefik

Crossplane configuration that installs the Traefik Helm chart with a minimal, stable interface.

## Overview

This configuration provides a Crossplane XRD for deploying Traefik Proxy using the Helm provider. Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy.

## Usage

### Minimal Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Traefik
metadata:
  name: traefik
  namespace: my-namespace
spec:
  clusterName: my-cluster
```

### Standard Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Traefik
metadata:
  name: traefik
  namespace: my-namespace
spec:
  clusterName: my-cluster
  namespace: traefik
  labels:
    team: platform
    environment: production
  providerConfigRef:
    name: my-cluster
    kind: ProviderConfig
  values:
    deployment:
      replicas: 2
    ingressRoute:
      dashboard:
        enabled: true
    ports:
      web:
        redirectTo:
          port: websecure
```

## Configuration Options

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Target cluster name (used for provider config) | Required |
| `namespace` | Kubernetes namespace for the release | `traefik` |
| `name` | Helm release name | XR metadata.name |
| `labels` | Labels applied to managed resources | See below |
| `providerConfigRef.name` | Helm ProviderConfig name | `clusterName` |
| `providerConfigRef.kind` | ProviderConfig kind | `ProviderConfig` |
| `values` | Helm values (merged with defaults) | `{}` |
| `overrideAllValues` | Helm values (replaces all defaults) | `{}` |
| `managementPolicies` | Crossplane management policies | `["*"]` |

### Default Labels

```yaml
hops.ops.com.ai/managed: "true"
hops.ops.com.ai/traefik: "<name>"
```

## Helm Chart

- **Chart**: traefik
- **Repository**: https://traefik.github.io/charts
- **Version**: 38.0.2

## Dependencies

- Provider: crossplane-contrib/provider-helm >= v1.0.6
- Function: crossplane-contrib/function-auto-ready >= v0.6.0
