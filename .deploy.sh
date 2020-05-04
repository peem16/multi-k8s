docker build -t peem16/multi-client:latest -t peem16/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peem16/multi-server:latest -t peem16/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peem16/multi-worker:latest -t peem16/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push peem16/multi-client:latest
docker push peem16/multi-server:latest
docker push peem16/multi-worker:latest

docker push peem16/multi-client:$SHA
docker push peem16/multi-server:$SHA
docker push peem16/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peem16/multi-server:$SHA
kubectl set image deployments/client-deployment client=peem16/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peem16/multi-worker:$SHA
