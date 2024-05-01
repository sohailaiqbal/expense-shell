MYSQL_PASSWORD=$1
log_file=/tmp/expense.log

Head() {
  echo -e "\e[31m$1\e[0m"
  }

Head "DISABEL DEFAULT VERSION OF NODEJS"
dnf module disable nodejs -y &>>/tmp/expense.log

Head "ENABLE NODEJS VERSION"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

Head "INSTALL NODEJS"
dnf install nodejs -y &>>/tmp/expense.log

Head "CONFIGURE BACKEND SERVICE"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

Head "ADDING APPLICATION USER"
useradd expense &>>/tmp/expense.log

Head "REMOVING EXITING APP CONTENT"
rm -rf /app &>>/tmp/expense.log

Head "CREATING APPLICATION DIRECTORY"
mkdir /app &>>/tmp/expense.log

Head "DOWNLOADING APPLICATION CONTENT"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app

Head "EXTRACTING APPLICATION CONTENT"
unzip /tmp/backend.zip &>>/tmp/expense.log

Head "DOWNLOADING APPLICATION DEPENDENCIES"
npm install &>>/tmp/expense.log

Head "RELOADING SYSTEMD & START BACKEND SERVICE"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

Head "INSTALLING MYSQL CLIENT"
dnf install mysql -y &>>/tmp/expense.log

Head "LOADING SCHEMA"
mysql -h mysql-dev.sidevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>/tmp/expense.log
}