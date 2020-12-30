docker build -t jfrsbg/multi-client:latest -t jfrsbg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jfrsbg/multi-server:latest -t jfrsbg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jfrsbg/multi-worker:latest -t jfrsbg/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jfrsbg/multi-client:latest
docker push jfrsbg/multi-server:latest
docker push jfrsbg/multi-worker:latest

docker push jfrsbg/multi-client:$SHA
docker push jfrsbg/multi-server:$SHA
docker push jfrsbg/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jfrsbg/multi-client:$SHA
kubectl set image deployments/server-deployment server=jfrsbg/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jfrsbg/multi-worker:$SHA