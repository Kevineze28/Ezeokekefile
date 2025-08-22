#!/bin/bash

PORTS='22 3389 27 80'

for x in $PORTS 

do 

aws ec2 authorize-security-group-ingress \
    --group-id sg-003e4997e6e318f63 \
    --protocol tcp \
    --port $x \
    --cidr 0.0.0.0/0

done


