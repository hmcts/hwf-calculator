#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")/../../docker/server"
docker-compose up
