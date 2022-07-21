# RegScale Helm Chart Templates to deploy in Kubernetes

This project provides template Helm Charts for deploying RegScale web application locally.

Following files are provided for this project:

| File                                                   | Description                                                             |
|--------------------------------------------------------|-------------------------------------------------------------------------|  
| `/regscale-helm-local/Chart.yaml`                      | The definition file for your application                                | 
| `/regscale-helm-local/values.yaml`                     | Configurable values that are inserted into the following template files | 
| `/regscale-helm-local/templates/regscale-cm.yaml`      | Template to configure your application deployment.                      | 
| `/regscale-helm-local/templates/regscale-deploy.yaml`  | Template to configure your application deployment.                      |
| `/regscale-helm-local/templates/regscale-pv.yaml`      | Template to configure your application deployment.                      | 
| `/regscale-helm-local/templates/regscale-pvc.yaml`     | Template to configure your application deployment.                      | 
| `/regscale-helm-local/templates/regscale-secrets.yaml` | Template to configure your application deployment.                      | 
| `/regscale-helm-local/templates/regscale-svc.yaml`     | Template to configure your application deployment.                      | 

RegScale "regscale-helm-local" package comes in zip file. Once you unzip it in you application directory you can edit the `Chart.yaml` and `values.yaml` files.

## Prerequisites

Using the template Helm charts assumes the following pre-requisites are complete:  

1. You have a local cluster set up (Docker desktop running Kubernetes or minikube)
  
2. You have kubectl installed and configured for your cluster  
  The [Kuberenetes command line](https://kubernetes.io/docs/tasks/tools/install-kubectl/) tool, `kubectl`, is used to view and control your Kubernetes cluster.

3. You have Helm installed  
  Helm can be installed using [this source](https://helm.sh/docs/intro/install/). 
   These charts are compatible with Helm v3


### Setting the `namespace` parameter

By default, `namespace` is set to regscale, if default is intended to be used then you need to create it by running `kubectl create namespace regscale`.

If other namespace will be used then `namespace` parameter needs to be changed. Open the `/regscale-helm-local/values.yaml` file and change the following entry:  

```sh
namespace:
```

## Configuring the Chart for your Application

The following table lists the configurable parameters of the template Helm chart and their default values.

| Parameter                  | Description                                     | Default                                                    |
| -----------------------    | ---------------------------------------------   | ---------------------------------------------------------- |
| `service.name`             | Kubernetes service name                         | `regscale-svc`                                             |
| `service.type`             | Kubernetes service type exposing port           | `LoadBalancer`                                             |
| `service.port`             | TCP Port for this service                       | 80                                                         |
| `service.targetPort`       | Target Port for this service                    | 80                                                         |
| `storageClassName`         | Storage Class name                              | `hostpath`                                                 |
| `capacity.storage`         | StorageClass size                               | `1Gi`                                                      |
| `hostPath.path`            | hostpath path in your local                     | `yourFolderFilePathHere`                                   |
| `hostPath.type`            | hostpath type                                   | `DirectoryOrCreate`                                        |
| `parameters.skuName`       | StorageClass size                               | `Standard_LRS`                                             |
| `capacity.storage`         | StorageClass size                               | `Standard_LRS`                                             |
| `JWTSecretKey`             | Generated JWT Secret Key                        | `JWTSecretKeyFromSomeWhere6789012`                         |
| `SQLConn`                  | SQL Connection info                             | `defined in values.yaml`                                   |
| `EncryptionKey`            | Encryption key                                  | `YourEncryptionKeyFromSomeWhere12`                         |


## Using the Chart to deploy your Application to Kubernetes

In order to use the Helm chart to deploy and verify your application in Kubernetes, run the following commands:

1. From the directory containing `Chart.yaml`, run:  

  ```sh
  helm install `any-release-name` .
  ```

  This deploys and runs your application in Kubernetes, and prints the following text to the console:  
  
  ```sh
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

