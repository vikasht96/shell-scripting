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
status $?

echo "Install ${COMPONENT}"
yum install -y mongodb-org &>> $LOGFILE
status $?



echo "updating the configeration file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> $LOGFILE
status $?

echo "Start ${COMPONENT}"
systemctl daemon.reload mongod &>> $LOGFILE
systemctl enable mongod &>> $LOGFILE
systemctl restart mongod &>> $LOGFILE
status $?

echo "Downoad the ${COMPONENT} schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip" &>> $LOGFILE
status $?

echo "Extract the ${COMPONENT} component schema"
cd /tmp
unzip -o mongodb.zip &>> $LOGFILE
status $?

echo "Inject the schema for ${COMPONENT}"
cd mongodb-main
mongo < catalogue.js &>> $LOGFILE
mongo < users.js     &>> $LOGFILE
status $?

echo "${COMPONENT} component is succuessfully installed"




# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod
