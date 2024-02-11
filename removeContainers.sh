#!/bin/bash
docker ps -a | grep adventureland- | awk '{print $NF}' | xargs docker remove
