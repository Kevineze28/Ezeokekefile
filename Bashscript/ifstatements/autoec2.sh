#!/bin/bash

STATUS=$(aws ec2 describe-instances --instance-ids i-02327fc9e1554a177 | grep running | cut -c34-40)

if [ $STATUS = running ]

then 

echo "your ec2 is running"

else 

echo "your ec2 is not running,i will now start your ec2"
aws ec2 start-instances --instance-ids i-02327fc9e1554a177

fi
