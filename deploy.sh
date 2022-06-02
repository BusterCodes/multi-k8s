docker build -t bustercodes/multi-client:latest -t bustercodes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bustercodes/multi-server:latest -t bustercodes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bustercodes/multi-worker:latest -t bustercodes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bustercodes/multi-client:latest
docker push bustercodes/multi-server:latest
docker push bustercodes/multi-worker:latest

docker push bustercodes/multi-client:$SHA
docker push bustercodes/multi-server:$SHA
docker push bustercodes/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bustercodes/multi-server:$SHA
kubectl set image deployments/client-deployment client=bustercodes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bustercodes/multi-worker:$SHA
