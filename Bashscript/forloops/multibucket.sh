#!/bin/bash

BUCKETS='jamesnonsobucket0 marydutybucket8 johnbucket9 danielbucket6'

for x in $BUCKETS

do

aws s3 $1 s3://$x

done 
