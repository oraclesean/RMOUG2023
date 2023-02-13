#!/bin/bash
export CONTAINER_NAME=LAB
export STEP=1

echo "Cloning the Oracle container repository" | tee -a /tmp/setup-docker.log
sudo su - oracle -c "git clone https://github.com/oracle/docker-images /oradata"

echo "Pulling database installation file" | tee -a /tmp/setup-docker.log
sudo su - oracle -c "curl https://objectstorage.us-phoenix-1.oraclecloud.com/p/DZ57l6Jr-KLyJzudUb11MYsDL-qBGU_cUNBAQsQvMFEbTrR-EbVoGVFTWQk6L_pM/n/axh0z5q052rw/b/RMOUG2023/o/LINUX.X64_193000_db_home.zip > /oradata/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/LINUX.X64_193000_db_home.zip"

echo "Docker setup is complete" | tee -a /tmp/setup-docker.log
