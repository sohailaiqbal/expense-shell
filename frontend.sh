source common.sh
component=frontend

Head "INSTALLING NGINX"
dnf install nginx -y &>>/tmp/expense.log
echo $?

Head "XPENSE CONFIG FILE"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo $?

Head "REMOVING OLD/DEFAULT CONTENT"
rm -rf /usr/share/nginx/html/*
echo $?

Head "DOWNLOADING APPLICATION CODE"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log
echo $?

cd /usr/share/nginx/html


Head "EXTRACTING APPLICATION CODE"
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?

Head  "STARTING NGINX SERVICE"
systemctl enable nginx &>>/tmp/expense.log
systemctl restart nginx &>>/tmp/expense.log
echo $?