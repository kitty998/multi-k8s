docker build -t katarinacimesa/multi-client:latest -t katarinacimesa/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t katarinacimesa/multi-server:latest -t katarinacimesa/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t katarinacimesa/multi-worker:latest -t katarinacimesa/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push katarinacimesa/multi-client:latest
docker push katarinacimesa/multi-server:latest
docker push katarinacimesa/multi-worker:latest

docker push katarinacimesa/multi-client:$SHA
docker push katarinacimesa/multi-server:$SHA
docker push katarinacimesa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=katarinacimesa/multi-server:$SHA
kubectl set image deployments/client-deployment client=katarinacimesa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=katarinacimesa/multi-worker:$SHA