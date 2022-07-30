# RegScale Helm Chart Templates to deploy in Kubernetes

This project provides template Helm Charts for deploying RegScale web application locally.

Following files are provided for this project:

| File                                                         | Description                                                             |
|--------------------------------------------------------------|-------------------------------------------------------------------------|
| `/regscale-helm-local/Chart.yaml`                            | The definition file for your application                                |
| `/regscale-helm-local/values.yaml`                           | Configurable values that are inserted into the following template files |
| `/regscale-helm-local/templates/configmap.yaml`              | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/deployment.yaml`             | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/persistentVolumeClaim.yaml`  | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/secret.yaml`                 | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/service.yaml`                | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/serviceaccount.yaml`         | Template to configure your application deployment.                      |

## Prerequisites

Using the template Helm charts assumes the following pre-requisites are complete:  

1. You have a local cluster set up (Docker desktop running Kubernetes or minikube)
  
2. You have kubectl installed and configured for your cluster  
  The [Kuberenetes command line](https://kubernetes.io/docs/tasks/tools/install-kubectl/) tool, `kubectl`, is used to view and control your Kubernetes cluster.

3. You have Helm installed  
  Helm can be installed using [this source](https://helm.sh/docs/intro/install/). 
   These charts are compatible with Helm v3

4. A compatible database is available to the application. RegScale currently uses MSSQL.

## Configuring the Chart for your Application

The following table lists the configurable parameters of the template Helm chart and their default values.

|                  Key                    |  Type  |                                                                                                                      Default                                                                                                                     |                                                       Description                                                      |
|-----------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| replicaCount                            | int    | `1`                                                                                                                                                                                                                                              |                                                                                                                        |
| image.repository                        | string | `"c2labs/atlasity"`                                                                                                                                                                                                                              |                                                                                                                        |
| image.pullPolicy                        | string | `"Always"`                                                                                                                                                                                                                                       |                                                                                                                        |
| image.tag                               | string | `"latest"`                                                                                                                                                                                                                                       | Overrides the image tag whose default is the chart appVersion.                                                         |
| imagePullSecrets                        | list   | `[]`                                                                                                                                                                                                                                             |                                                                                                                        |
| nameOverride                            | string | `""`                                                                                                                                                                                                                                             |                                                                                                                        |
| fullnameOverride                        | string | `"regscale-local"`                                                                                                                                                                                                                               |                                                                                                                        |
| secret.jwtSecretKey                     | string | `"JWTSecretKeyFromSomeWhere6789012"`                                                                                                                                                                                                             | A Valid JSON Web Token                                                                                                 |
| secret.encryptionKey                    | string | `"YourEncryptionKeyFromSomeWhere12"`                                                                                                                                                                                                             |                                                                                                                        |
| secret.dbConnectionString               | string | `"Server=tcp:yourdatabase.database.windows.net,1433;Initial Catalog=ATLAS;Persist Security Info=False;User ID=youruserID;Password=yourPassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"` | MSSQL Entity Framework Connection String                                                                               |
| configMap.storedFilesPathOverride       | string | `""`                                                                                                                                                                                                                                             | Override the location that RegScale saves files, this is automatically  set to the directory that the PV is mounted to |
| configMap.fileSizeLimit                 | string | `"104857600"`                                                                                                                                                                                                                                    |                                                                                                                        |
| configMap.sentry                        | string | `""`                                                                                                                                                                                                                                             | If you want to enable monitoring, enter your Sentry.io Sdn, otherwise, leave blank                                     |
| volumeMountPath                         | string | `"/regscale/files"`                                                                                                                                                                                                                              | The path that the PV is mounted to and where RegScale stores files                                                     |
| serviceAccount.create                   | bool   | `true`                                                                                                                                                                                                                                           | Specifies whether a service account should be created                                                                  |
| serviceAccount.annotations              | object | `{}`                                                                                                                                                                                                                                             | Annotations to add to the service account                                                                              |
| serviceAccount.name                     | string | `""`                                                                                                                                                                                                                                             | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| persistentVolumeClaim.storageClass      | string | `""`                                                                                                                                                                                                                                             |                                                                                                                        |
| persistentVolumeClaim.accessModes[0]    | string | `"ReadWriteOnce"`                                                                                                                                                                                                                                |                                                                                                                        |
| persistentVolumeClaim.capacity          | string | `"1Gi"`                                                                                                                                                                                                                                          |                                                                                                                        |
| podAnnotations                          | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |
| podSecurityContext                      | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |
| securityContext                         | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |
| service.type                            | string | `"ClusterIP"`                                                                                                                                                                                                                                    |                                                                                                                        |
| service.port                            | int    | `80`                                                                                                                                                                                                                                             |                                                                                                                        |
| resources                               | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |
| nodeSelector                            | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |
| tolerations                             | list   | `[]`                                                                                                                                                                                                                                             |                                                                                                                        |
| affinity                                | object | `{}`                                                                                                                                                                                                                                             |                                                                                                                        |

## Using the Chart to deploy your Application to Kubernetes

In order to use the Helm chart to deploy and verify your application in Kubernetes, run the following commands:

1. From the directory containing `Chart.yaml`, run:  

  ```sh
  helm install `any-release-name` .
  ```

  This deploys and runs your application in Kubernetes, and prints the following text to the console:  
  
  ```yaml
  NAME: `any-release-name`
  LAST DEPLOYED: 'deployed time'
  NAMESPACE: regscale
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  ```
You can list your helm releases by running `helm ls -A` and check for statuses.

You application should now be visible in your browser if backend is configured already.

## Uninstalling your Application

* Find the deployment using `helm list --all` and search for an entry with the chart `any-release-name` name .
* Remove the application with `helm delete --purge any-release-name`.

