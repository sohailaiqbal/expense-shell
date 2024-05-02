MYSQL_PASSWORD=$1
component=backend
source common.sh

Head "DISABEL DEFAULT VERSION OF NODEJS"
dnf module disable nodejs -y &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "ENABLE NODEJS VERSION"
dnf module enable nodejs:18 -y &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "INSTALL NODEJS"
dnf install nodejs -y &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "CONFIGURE BACKEND SERVICE"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "ADDING APPLICATION USER"
useradd expense &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

App_Prereq "/app"

Head "DOWNLOADING APPLICATION DEPENDENCIES"
npm install &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "RELOADING SYSTEMD & START BACKEND SERVICE"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "INSTALLING MYSQL CLIENT"
dnf install mysql -y &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

Head "LOADING SCHEMA"
mysql -h mysql-dev.sidevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi
