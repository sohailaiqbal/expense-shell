log_file=/tmp/expense.log

Head() {
  echo -e "\e[36m$1\e[0m"
}

App_prereq() {
  DIR=$1

Head "REMOVING EXITING APP CONTENT"
rm -rf $1 &>>/tmp/expense.log
echo $?

Head "CREATING APPLICATION DIRECTORY"
mkdir $1 &>>/tmp/expense.log
echo $?

Head "DOWNLOADING APPLICATION CONTENT"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/expense.log
cd $1
echo $?

Head "EXTRACTING APPLICATION CONTENT"
unzip /tmp/${component}.zip &>>/tmp/expense.log
echo $?
}


