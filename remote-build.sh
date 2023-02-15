#!/bin/sh

wait_grpc_ready() {
    while ! grpcurl -plaintext $1:$2 grpc.health.v1.Health/Check; do
        sleep 1
    done
}

docker build buildfarm/ -t buildfarm
docker-compose -f buildfarm/docker-compose.yml up --detach
wait_grpc_ready 127.0.0.1 8980
bazel build --remote_executor=grpc://127.0.0.1:8980 "$@"
docker-compose -f buildfarm/docker-compose.yml down

