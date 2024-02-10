# SGX-Remote-Attestation-on-K8s

Example Implementation of Remote Attestation with Kubernets and Humane-RAFW-MAA

## Installation

```bash
### clone
$ git clone https://github.com/ustato/SGX-Remote-Attestation-on-K8s

### terraform
$ cd SGX-Remote-Attestation-on-K8s/terraform
$ terraform init

### apply
$ terraform apply -auto-approve

### load kubeconfig
$ export KUBECONFIG=./azurek8s
```

## Quickstart

```bash
$ cd SGX-Remote-Attestation-on-K8s/terraform

### start ISV
$ kubectl apply -f ../manifest/isv.yaml

### wait deployment
$ sleep 30

### run firm
$ sh start_firm.sh
Succeed.
 INFO: Launched SP's untrusted application.
 INFO:
 INFO: ==============================================
 INFO: Remote Attestation Preparation
 INFO: ==============================================
 INFO:
 INFO: ==============================================
 INFO: Initialize RA
 INFO: ==============================================
 INFO:
DEBUG: Received RA context number -> 2
DEBUG:
DEBUG: Base64-encoded x-coordinate of Ga ->
DEBUG: g88fixKce/vuGYgFcUJa4zcp3Gu94sZOosXeewiAh/o=
    .
    .
    .
 INFO: ==============================================
 INFO: Sample Remote Computation
 INFO: ==============================================
 INFO:
 INFO: First integer to send ->
 INFO: 200
 INFO:
 INFO: Second integer to send ->
 INFO: 800
 INFO:
 INFO: Received addition result ->
 INFO: 1000
 INFO: ==============================================
 INFO: Destruct RA
 INFO: ==============================================
 INFO:
 INFO: Sent RA destruction request to ISV.
 INFO:
```

## Destroy

```bash
$ cd SGX-Remote-Attestation-on-K8s/terraform

### destroy ISV
$ kubectl delete -f ../manifest/isv.yaml

### destroy all
$ terraform destroy -auto-approve
```
