#!/bin/bash 

PORTS='20' 

for x in $PORTS 

do 

aws ec2 authorize-security-group-ingress \
    --group-id sg-058a0691c8f8b4614 \
    --protocol tcp \
    --port $1 \
    --cidr 0.0.0.0/0

done

