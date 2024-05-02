component=frontend
source common.sh

Head "INSTALLING NGINX"
dnf install nginx -y &>>/tmp/expense.log
echo $?

Head "XPENSE CONFIG FILE"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo $?

App_Prereq "/usr/share/nginix/html"

Head  "STARTING NGINX SERVICE"
systemctl enable nginx &>>/tmp/expense.log
systemctl restart nginx &>>/tmp/expense.log
echo $?