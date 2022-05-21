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
