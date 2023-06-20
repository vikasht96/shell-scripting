#!/bin/bash

COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"
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

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi

echo "Perfoming cleanup"
cd /usr/share/nginx/html
rm -rf * &>> $LOGFILE

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi





# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
# systemctl enable nginx
# systemctl start nginx