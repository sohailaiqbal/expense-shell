MYSQL_PASSWORD=$1
log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
}

Head "DISABLING OLC MYSQL VERSION"
dnf module disable mysql -y
echo $?

Head "MYSQL REPO.FILE"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo $?

Head "INSTALLING MYSQL"
dnf install mysql-community-server -y
echo $?

Head "ENABLING & STARTING MYSQL SERVICES"
systemctl enable mysqld
systemctl start mysqld
echo $?

Head "SETTING DB PASSWORD"
mysql_secure_installation --set-root-pass ${MYSQL_PASSWORD}
echo $?
