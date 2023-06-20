#!/bin/bash

COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"
ID=$(id -u)


if [ $ID -ne 0 ]; then
echo "This action perform only root user"
exit 1
fi

status(){
    if [ $1 -eq 0 ]; then
        echo "Success"
    else
        echo "Failure"
    fi
}

echo "Configur the ${COMPONENT} repo"

curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
status $1


# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod
