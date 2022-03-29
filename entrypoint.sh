#!/bin/ash

./init.sh

run_port=${PORT:-'3000'}
run_host=${HOST:-'0.0.0.0'}

json-server --host $run_host --port $run_port db.json