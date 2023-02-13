#!/bin/bash
export CONTAINER_NAME=LAB
export STEP=1

echo "Pulling the Oracle database version database image" | tee -a /tmp/setup-docker.log
docker pull phx.ocir.io/ax1cxmhdo0fd/oracle/db:
docker images | tee -a /tmp/setup-docker.log

#echo "Pulling demo data" | tee -a /tmp/setup-docker.log
#sudo su - oracle -c "curl https://objectstorage.us-phoenix-1.oraclecloud.com/p/eYQyRavdcR2ouoY8-5vkGQW1WPRA9TkW1VRHYEbU3VPTRmo48j_mvAZPb9b2eD4V/n/ax1cxmhdo0fd/b/oraclesean-object-store/o/${lab_version}.tgz > /oradata/backups/${lab_version}.tgz"
#echo "Expanding demo data to /oradata/backups" | tee -a /tmp/setup-docker.log
#sudo su - oracle -c "tar -C /oradata/backups -xzf /oradata/backups/${lab_version}.tgz"
#echo "Removing tar file" | tee -a /tmp/setup-docker.log
#sudo su - oracle -c "rm /oradata/backups/${lab_version}.tgz"

#echo "Pulling scripts repo" | tee -a /tmp/setup-docker.log
#sudo su - oracle -c "git clone https://github.com/oraclesean/upgrade-21c-lab-scripts /oradata/scripts"

#echo "Starting container" | tee -a /tmp/setup-docker.log
#/oradata/scripts/refresh_container.sh
#sleep 10
#docker ps -a | tee -a /tmp/setup-docker.log
#docker logs $CONTAINER_NAME | tee -a /tmp/setup-docker.log
echo "Docker and database setup is complete" | tee -a /tmp/setup-docker.log
