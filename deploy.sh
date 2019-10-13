docker build -t denissweat/multi-client:latest -t denissweat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t denissweat/multi-server:latest -t denissweat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t denissweat/multi-worker:latest -t denissweat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push denissweat/multi-client:latest
docker push denissweat/multi-server:latest
docker push denissweat/multi-worker:latest

docker push denissweat/multi-client:$SHA
docker push denissweat/multi-server:$SHA
docker push denissweat/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=denissweat/multi-client:$SHA
kubectl set image deployments/server-deployment server=denissweat/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=denissweat/multi-worker:$SHA

