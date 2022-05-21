# Vue - flask application using K8s

Prerequisite:
- Have docker and kubectl installed
- Have a running local cluster: `minikube start --drivevr=none`


Notes:
- To deploy on k8s according to the manifest file in yml: `kubectl apply -f <manifest_file>`. This can be done for creating deployments, services, configuration maps.
- Important observation: in a deployment, if we point towards an image with the latest tag, k8s doesn't seem to detect if the image has changed. To be investigated later. The current solution is to increment the version.
- To bring down the pods in a deployment, this can be achieved through a scaling to 0 replicas: `kubectl scale deployment <deployment-name> --replicas=0`
- In order to redirect the necessary flow to the backend, try using ingress with 2 rules, forwarding `/` to the vue app and `/api` to the flask application.
- When on WSL, in order to visualize the webpage in the browser, the DNS entry `<minikubeIP> <ingressDomain>` needs to be added on the Windows side
- Pass sensitive information like password through a k8s secrets. The password is inserted in the file as base64 (`echo -n "mypassword" | base64`). The k8s can also be read from a file that would be not committed. (TODO)
- The config for postgres is shared between a k8s secret and a config map and injected in the manifest.
- The backend pod already contains the IP of the postgres service in an env variable. It can be used to target the db in app.py
- Data is persisted in the node using persistent volumes (on the node side saying that I create a space where data can be persisted) and persistent volume claims (on the pod side saying that i request in a PV to be able to persist). The postgres data doesn't seem to be removed even after the db pod, the PVC and the PV are deleted (it has to be in this order). Relaunching all 3 still gives a message in the postgres log saying that the db was already initialized. Even stopping/starting the cluster doesn't seem to remove the data. (TOOD)

Encountered a job not finishing when deleting a pvc and the resource was blocked in terminating mode. The solution was: `kubectl patch pvc {PVC_NAME} -p '{"metadata":{"finalizers":null}}'`