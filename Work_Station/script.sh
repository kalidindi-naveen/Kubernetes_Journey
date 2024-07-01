#!/bin/bash
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

ID=$(id -u)
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "ERROR:: $2 ... FAILED"
        exit 1
    else
        echo "$2 ... SUCCESS"
    fi
}

if [ $ID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are root user"
fi

# Install EKSCTL
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp &>>$LOGFILE
VALIDATE $? "Downloaded EKSCTL"

sudo mv /tmp/eksctl /usr/local/bin &>>$LOGFILE
VALIDATE $? "Moved EKSCTL to BIN"

/usr/local/bin/eksctl version &>>$LOGFILE
VALIDATE $? "Printed eksctl version"

# Install Kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl &>>$LOGFILE
VALIDATE $? "Downloaded KUBECTL"

chmod +x ./kubectl &>>$LOGFILE
VALIDATE $? "Added Execution Permission to Kubectl"

sudo mv ./kubectl /usr/local/bin &>>$LOGFILE
VALIDATE $?  "Moved Kubectl to BIN"

/usr/local/bin/kubectl version --client &>>$LOGFILE
VALIDATE $? "Printed kubectl version"

dnf install docker -y &>>$LOGFILE
VALIDATE $? "Docker Installed Success...."