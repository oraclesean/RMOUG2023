#!/bin/bash
echo "Creating the Alpine filesystems" | tee -a /tmp/setup-docker.log
sudo su - opc -c "mkdir -p /home/opc/{alpine,overlay/{container,upper,work}}"
sudo su - opc -c "curl https://dl-cdn.alpinelinux.org/alpine/v3.17/releases/x86_64/alpine-minirootfs-3.17.2-x86_64.tar.gz > ~/alpine-minirootfs-3.17.2-x86_64.tar.gz"
sudo su - opc -c "tar -xvzf ~/alpine-minirootfs-3.17.2-x86_64.tar.gz -C /home/opc/alpine/ && rm /home/opc/alpine-minirootfs-3.17.2-x86_64.tar.gz"

echo "Mounting the Alpine filesystem" | tee -a /tmp/setup-docker.log
mount -t overlay overlay -o lowerdir=/home/opc/alpine,upperdir=/home/opc/overlay/upper,workdir=/home/opc/overlay/work /home/opc/overlay/container

echo "Cloning the Oracle container repository" | tee -a /tmp/setup-docker.log
sudo su - oracle -c "git clone https://github.com/oracle/docker-images /oradata/docker-images"

echo "Cloning the lab scripts" | tee -a /tmp/setup-docker.log
sudo su - oracle -c "git clone https://github.com/oraclesean/oracle-container-lab /oradata/scripts"

echo "Pulling the Oracle Database image" | tee -a /tmp/setup-docker.log
docker pull phx.ocir.io/axh0z5q052rw/oracle:19.3.0

echo "Pulling database installation file" | tee -a /tmp/setup-docker.log
sudo su - oracle -c "curl https://objectstorage.us-phoenix-1.oraclecloud.com/p/DZ57l6Jr-KLyJzudUb11MYsDL-qBGU_cUNBAQsQvMFEbTrR-EbVoGVFTWQk6L_pM/n/axh0z5q052rw/b/RMOUG2023/o/LINUX.X64_193000_db_home.zip > /oradata/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/LINUX.X64_193000_db_home.zip"

echo "Docker setup is complete" | tee -a /tmp/setup-docker.log
