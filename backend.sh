MYSQL_PASSWORD=$1
log_file=/tmp/expense.log
echo -e "\e[31mDISABEL DEFAULT VERSION OF NODEJS\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log

echo -e "\e[31mENABLE NODEJS VERSION\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e "\e[32mINSTALL NODEJS\e[0m"
dnf install nodejs -y &>>/tmp/expense.log

echo -e "\e[31mecho CONFIGURE BACKEND SERVICE\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[33mADDING APPLICATION USER\e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[31mREMOVING EXITING APP CONTENT\e[0m"
rm -rf /app &>>/tmp/expense.log

echo -e "\e[34mCREATING APPLICATION DIRECTORY\e[0m"
mkdir /app &>>/tmp/expense.log

echo -e "\e[35mDOWNLOADING APPLICATION CONTENT\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app

echo -e "\e[36mEXTRACTING APPLICATION CONTENT\e[0m"
unzip /tmp/backend.zip &>>/tmp/expense.log

DOWNLOADING APPLICATION DEPENDENCIES
npm install &>>/tmp/expense.log

echo -e "\e[31mRELOADING SYSTEMD & START BACKEND SERVICE\e[0m"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

echo -e "\e[32mINSTALLING MYSQL CLIENT\e[0m"
dnf install mysql -y &>>/tmp/expense.log

echo -e "\e[33mLOADING SCHEMA\e[0m"
mysql -h mysql-dev.sidevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>/tmp/expense.log