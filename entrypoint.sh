#!/bin/ash

run_port=${PORT:-'3000'}
run_host=${HOST:-'127.0.0.1'}

json-server --host $run_host --port $run_port --routes /app/route.json /app/db.json