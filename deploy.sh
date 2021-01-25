docker build -t xinboxia/multi-client:latest -t xinboxia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xinboxia/multi-server:latest -t xinboxia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xinboxia/multi-worker:latest -t xinboxia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xinboxia/multi-client:latest
docker push xinboxia/multi-server:latest
docker push xinboxia/multi-worker:latest

docker push xinboxia/multi-client:latest:$SHA
docker push xinboxia/multi-server:latest:$SHA
docker push xinboxia/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xinboxia/multi-server:$SHA
kubectl set image deployments/client-deployment client=xinboxia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xinboxia/multi-worker:$SHA
