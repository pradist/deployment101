minikube-install:
	minikube start --driver=docker

minikube-install-with-ingress:
	minikube start --driver=docker --addons=ingress

minikube-dashboard:
	minikube addons enable dashboard

minikube-dashboard-access:
	kubectl get pods -n kubernetes-dashboard

minikube-dashboard-port-forward:
	kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8080:80
