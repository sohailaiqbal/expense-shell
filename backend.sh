echo -e "\e[31mDISABEL DEFAULT VERSION OF NODEJS\e[0m"
dnf module disable nodejs -y

echo -e "\e[31mENABLE NODEJS VERSION\e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[32mINSTALL NODEJS\e[0m"
dnf install nodejs -y

echo -e "\e[31mecho CONFIGURE BACKEND SERVICE\e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[33mADDING APPLICATION USER\e[0m"
useradd expense

echo -e "\e[31mREMOVING EXITING APP CONTENT\e[0m"
rm -rf /app

echo -e "\e[34mCREATING APPLICATION DIRECTORY\e[0m"
mkdir /app

echo -e "\e[35mDOWNLOADING APPLICATION CONTENT\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
pwd
cd /app

echo -e "\e[36mEXTRACTING APPLICATION CONTENT\e[0m"
unzip /tmp/backend.zip

DOWNLOADING APPLICATION DEPENDENCIES
npm install

echo -e "\e[31mRELOADING SYSTEMD & START BACKEND SERVICE\e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo -e "\e[32mINSTALLING MYSQL CLIENT\e[0m"
dnf install mysql -y

echo -e "\e[33mLOADING SCHEMA\e[0m"
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql