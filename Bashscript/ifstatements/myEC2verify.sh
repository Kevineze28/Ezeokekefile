#!/bin/bash 

STATUS=$(aws ec2 describe-instances --instance-ids i-0092234540adf2268 | grep running | cut -c34-40)

if [ $STATUS = running ]

then 

echo "your EC2 is running" 

else 

echo "your EC2 is not running,i will now start your EC2 instance for you"

aws ec2 start-instances --instance-ids i-0092234540adf2268 

fi 



