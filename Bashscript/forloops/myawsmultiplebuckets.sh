#!/bin/bash 

BUCKETS='kevonezoe1 nonyenezeo2 izuchuezeo3 chiderahhezeo4 ebubenaezeo5'

for x in $BUCKETS

do 

aws s3 $1 s3://$x

done 
