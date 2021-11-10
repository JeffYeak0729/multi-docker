docker build -t jeffyeak/multi-client:lastest -t jeffyeak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffyeak/multi-server:lastest -t jeffyeak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffyeak/multi-worker:lastest -t jeffyeak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffyeak/multi-client:lastest
docker push jeffyeak/multi-server:lastest
docker push jeffyeak/multi-worker:lastest

docker push jeffyeak/multi-client:$SHA
docker push jeffyeak/multi-server:$SHA
docker push jeffyeak/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=jeffyeak/multi-client:$SHA
kubectl set image deployment/server-deployment server=jeffyeak/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=jeffyeak/multi-worker:$SHA
