MYSQL_PASSWORD=$1
component=backend
source common.sh

Head "DISABEL DEFAULT VERSION OF NODEJS"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

Head "ENABLE NODEJS VERSION"
dnf module enable nodejs:18 -y &>>/tmp/expense.log
echo $?

Head "INSTALL NODEJS"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

Head "CONFIGURE BACKEND SERVICE"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

Head "ADDING APPLICATION USER"
useradd expense &>>/tmp/expense.log
echo $?

App_prereq "/app"

Head "DOWNLOADING APPLICATION DEPENDENCIES"
npm install &>>/tmp/expense.log
echo $?

Head "RELOADING SYSTEMD & START BACKEND SERVICE"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log
echo $?

Head "INSTALLING MYSQL CLIENT"
dnf install mysql -y &>>/tmp/expense.log
echo $?

Head "LOADING SCHEMA"
mysql -h mysql-dev.sidevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?
