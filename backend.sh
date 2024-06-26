MYSQL_PASSWORD=$1
component=backend

source common.sh


Head "DISABLE DEFAULT VERSION OF NODEJS"
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