#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-roboshop"
USERID=$(id -u)
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOGG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started at : $(date)"
echo "Script started executing at: $date"
if [ $USERID -ne 0 ];then
   echo -e " ERROR::Please run script with root prevelages " | tee -a $LOGG_FILE
   exit 1
fi

VALIDATE(){ ## Functions receives inputs through args just like shell scripts
    if [ $? -ne 0 ];then
        echo -e " $2 ... is $R FAILED $N" | tee -a $LOGG_FILE
        exit 1
    else
        echo -e " $2 ... is $G SUCCESS $N" | tee -a $LOGG_FILE
    fi
}


#$@

for package in $@;do
   echo "package is : $package"

done

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGG_FILE
VALIDATE $? "Adding mongo repo" &>>$LOGG_FILE

dnf install mongodb-org -y &>>$LOGG_FILE
VALIDATE $? "Installing mongoDB" &>>$LOGG_FILE

systemctl enable mongod &>>$LOGG_FILE
VALIDATE $? "Enabling mongo DB" &>>$LOGG_FILE

systemctl start mongod &>>$LOGG_FILE
VALIDATE $? "Starting MongoDB" &>>$LOGG_FILE

systemctl restart mongod &>>$LOGG_FILE
VALIDATE $? "Restarting MongoDb" &>>$LOGG_FILE