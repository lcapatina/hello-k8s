IMAGE_BASE=flask-vue
CLIENT_APP=vueapp
SERVER_APP=flaskapi
DB_APP=postgres
K8S_FOLDER=kubernetes

build-client:
	docker build -t $(IMAGE_BASE)-client:latest client/

build-server:
	docker build -t $(IMAGE_BASE)-server:latest server/

build-db:
	docker build -t $(IMAGE_BASE)-db:latest db/

create-config:
	kubectl apply -f $(K8S_FOLDER)/db-config.yml
	kubectl apply -f $(K8S_FOLDER)/secret-config.yml
	kubectl apply -f $(K8S_FOLDER)/client-configmap.yml

create-volume-persistence:
	kubectl apply -f $(K8S_FOLDER)/persistent-volume.yml
	kubectl apply -f $(K8S_FOLDER)/persistent-volume-claim.yml

create-service-all:
	kubectl apply -f $(K8S_FOLDER)/db-service.yml
	kubectl apply -f $(K8S_FOLDER)/server-service.yml
	kubectl apply -f $(K8S_FOLDER)/client-service.yml

create-deployment-all:
	kubectl apply -f $(K8S_FOLDER)/db-deployment.yml
	kubectl apply -f $(K8S_FOLDER)/server-deployment.yml
	kubectl apply -f $(K8S_FOLDER)/client-deployment.yml

create-ingress-proxy:
	kubectl apply -f $(K8S_FOLDER)/ingress.yml

recreate-client:
	kubectl scale deployment $(CLIENT_APP)-deployment --replicas=0
	sleep 5
	kubectl apply -f $(K8S_FOLDER)/client-deployment.yml	

recreate-server:
	kubectl scale deployment $(SERVER_APP)-deployment --replicas=0
	sleep 5
	kubectl apply -f $(K8S_FOLDER)/server-deployment.yml

recreate-db:
	kubectl scale deployment $(DB_APP)-deployment --replicas=0
	sleep 5
	kubectl apply -f $(K8S_FOLDER)/db-deployment.yml
