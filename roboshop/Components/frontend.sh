#!/bin/bash
COMPONENT=frontend
LOGFILE = "/tmp/${COMPONENT}.txt"
ID=$(id -u)


if [ $ID -ne 0 ]; then
echo "This action perform only root user"
exit 1
fi


echo "Nginix install"
yum install nginx -y &>> $LOGFILE

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi

echo "Downloading the ${COMPONENT} component"

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# systemctl enable nginx
# systemctl start nginx