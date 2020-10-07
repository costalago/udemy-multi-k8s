docker build -t costalago/multi-client:latest -t costalago/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t costalago/multi-server:latest -t costalago/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t costalago/multi-worker:latest -t costalago/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push costalago/multi-client:latest
docker push costalago/multi-client:$SHA
docker push costalago/multi-server:latest
docker push costalago/multi-server:$SHA
docker push costalago/multi-worker:latest
docker push costalago/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=costalago/multi-server:$SHA
kubectl set image deployments/client-deployment client=costalago/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=costalago/multi-worker:$SHA
