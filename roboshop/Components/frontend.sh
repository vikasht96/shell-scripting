#!/bin/bash

COMPONENT=frontend
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

echo "Nginix install"
yum install nginx -y &>> $LOGFILE

status $?

echo "Downloading the ${COMPONENT} component"

curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

status $?

echo "Perfoming cleanup"
cd /usr/share/nginx/html
rm -rf * &>> $LOGFILE



echo "Extract the content"
unzip /tmp/${COMPONENT}.zip &>> $LOGFILE
mv ${COMPONENT}-main/* . &>> $LOGFILE
mv static/* . &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE

status $?

echo "Start the service for ${COMPONENT} component"
systemctl enable nginx
systemctl start nginx
status $?





# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/${COMPONENT}.zip
# mv ${COMPONENT}-main/* .
# mv static/* .
# rm -rf ${COMPONENT}-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
# systemctl enable nginx
# systemctl start nginx