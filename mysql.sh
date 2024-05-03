MYSQL_PASSWORD=$1
source common.sh

Head "DISABLING OLC MYSQL VERSION"
dnf module disable mysql -y &>>/tmp/expense.log
echo $?

Head "MYSQL REPO.FILE"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/expense.log
echo $?

Head "INSTALLING MYSQL"
dnf install mysql-community-server -y &>>/tmp/expense.log
echo $?

Head "ENABLING & STARTING MYSQL SERVICES"
systemctl enable mysqld &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log
echo $?
