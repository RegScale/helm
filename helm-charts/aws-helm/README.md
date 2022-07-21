# RegScale Helm Chart Templates to deploy in Kubernetes

This project provides template Helm Charts for deploying RegScale web application into AWS Kubernetes cloud.

Following files are provided for this project:

| File                                            | Description                                                             |
|-------------------------------------------------|-------------------------------------------------------------------------|  
| `/aws-helm/Chart.yaml`                          | The definition file for your application                                | 
| `/aws-helm/values.yaml`                         | Configurable values that are inserted into the following template files | 
| `/aws-helm/templates/regscale-aws-cm.yaml`      | Template to configure your application deployment.                      |
| `/aws-helm/templates/regscale-aws-deploy.yaml`  | Template to configure your application deployment.                      |
| `/aws-helm/templates/regscale-aws-pv.yaml`      | Template to configure your application deployment.                      |
| `/aws-helm/templates/regscale-aws-pvc.yaml`     | Template to configure your application deployment.                      | 
| `/aws-helm/templates/regscale-aws-secrets.yaml` | Template to configure your application deployment.                      | 
| `/aws-helm/templates/regscale-aws-svc.yaml`     | Template to configure your application deployment.                      | 

RegScale aws-helm package comes in zip file. Once you unzip it in you application directory you can edit the `Chart.yaml` and `values.yaml` files.

## Prerequisites

Using the template Helm charts assumes the following pre-requisites are complete:  

- Kubernetes >= 1.19
- IAM permissions
- Helm v3
- AWS EFS or NFS file system set up
- Optional dependencies
  - cert-manager


### Setting the `namespace` parameter

By default, `namespace` is set to regscale, if default is intended to be used then you need to create it by running `kubectl create namespace regscale`.

If other namespace will be used then `namespace` parameter needs to be changed. Open the `/aws-helm/values.yaml` file and change the following entry:  

```sh
namespace:
```

## Configuring the Chart for your Application

The following table lists the configurable parameters of the template Helm chart and their default values.

| Parameter                      | Description                               | Default                             |
| -------------------------------|-------------------------------------------|-------------------------------------|
| `service.name`                 | Kubernetes service name                   | `regscale-svc`                      |
| `service.type`                 | Kubernetes service type exposing port     | `ClusterIP`                         |
| `service.port`                 | TCP Port for this service                 | 80                                  |
| `service.targetPort`           | Target Port for this service              | 80                                  |
| `storageClassName`             | Storage Class name                        | `aws-efs`                           |
| `capacity.storage`             | StorageClass size                         | `1Gi`                               |
| `csi.driver`                   | AWS file system type                      | `efs.csi.aws.com`                   |
| `csi.volumeHandle`             | Client's AWS EFS (or NFS) volume handler  | `fs-084654b`                        |
| `persistentVolumeReclaimPolicy`| Volume Reclaiming policy                  | `Retain`                            |
| `JWTSecretKey`                 | Generated JWT Secret Key                  | `JWTSecretKeyFromSomeWhere6789012`  |
| `SQLConn`                      | SQL Connection info                       | `defined in values.yaml`            |
| `EncryptionKey`                | Encryption key                            | `YourEncryptionKeyFromSomeWhere12`  |


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

