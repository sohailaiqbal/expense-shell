echo DISABEL DEFAULT VERSION OF NODEJS
dnf module disable nodejs -y

echo ENABLE NODEJS VERSION
dnf module enable nodejs:18 -y

echo INSTALL NODEJS
dnf install nodejs -y

echo CONFIGURE BACKEND SERVICE
cp backend.service /etc/systemd/system/backend.service

echo ADDING APPLICATION USER
useradd expense

echo REMOVING EXITING APP CONTENT
rm -rf /app

echo CREATING APPLICATION DIRECTORY
mkdir /app

echo DOWNLOADING APPLICATION CONTENT
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
pwd
cd /app

echo EXTRACTING APPLICATION CONTENT
unzip /tmp/backend.zip

DOWNLOADING APPLICATION DEPENDENCIES
npm install

echo RELOADING SYSTEMD & START BACKEND SERVICE
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo INSTALLING MYSQL CLIENT
dnf install mysql -y

echo LOADING SCHEMA
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql