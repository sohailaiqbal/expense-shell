log_file=/tmp/expense.log

Head() {
  echo -e "\e[35m$1\e[0m"
}

App_Prereq() {
  DIR=$1

  Head "Removing Existing App Content"
  rm -rf $1 &>>/tmp/expense.log
  echo $?

  Head "CREATING APPLICATION DIRECTORY"
  mkdir $1 &>>/tmp/expense.log
  echo $?

  Head "DOWNLOADING APPLICATION CONTENT"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/expense.log
  echo $?

  cd $1

  Head "EXTRACTING APPLICATION CONTENT"
  unzip /tmp/${component}.zip &>>/tmp/expense.log
  echo $?
}