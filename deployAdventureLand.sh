#!/bin/bash
echo "Only intended for initial deploy
Use docker compose up - or a systemd level service tied to that to bring up the servers"
git pull origin dockerization
docker build -t adventureland .
docker compose up
