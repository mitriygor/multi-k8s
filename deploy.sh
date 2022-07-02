docker build -t mytrgor/multi-client:latest -t mytrgor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mytrgor/multi-server:latest -t mytrgor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mytrgor/multi-worker:latest -t mytrgor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mytrgor/multi-client:latest
docker push mytrgor/multi-server:latest
docker push mytrgor/multi-worker:latest

docker push mytrgor/multi-client:$SHA
docker push mytrgor/multi-server:$SHA
docker push mytrgor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mytrgor/multi-server:$SHA
kubectl set image deployments/client-deployment client=mytrgor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mytrgor/multi-worker:$SHA