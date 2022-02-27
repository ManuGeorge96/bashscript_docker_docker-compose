#!/bin/bash
docker-composenst () {
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose >> /dev/null
  chmod +x /usr/local/bin/docker-compose
  which docker-compose > /dev/null 2>&1
  if [ $? = 0 ]; then
    printf "\n\tDocker-Compose Installed\t"
    printf "\n"
    printf "Installed Version"
    printf "\n"
    docker-compose --version
  else
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    printf "\n\tDocker-Compose Installed\t"
    printf "\n"
    printf "Installed Version"
    printf "\n"
    docker-compose --version
  fi
}
printf "\n\tInstalling Docker....\n"
sleep 4
ver=$(lsb_release -a | grep "Distributor ID:" | awk '{print $3}')
if [ $ver == 'Ubuntu' ]; then
  snap install docker >> /dev/null
  snap start docker
else
  yum install docker -y >> /dev/null
  service docker restart >> /dev/null
fi
printf "\nInstalled Version\n"
docker version
printf "\n\tInstalling Docker Compose....\n"
which wget >/dev/null 2>&1
sleep 3
if [ $? = 0 ]; then
  sleep 3
  docker-composenst
else
  sleep 3
  yum install wget -y >> /dev/null
  docker-composenst
fi	
