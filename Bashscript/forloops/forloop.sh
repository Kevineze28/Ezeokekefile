#!/bin/bash

DAYS='Monday Tuesday WebDay Thursday Friday Saturday Sunday'

for x in $DAYS
do
echo "My fav day of the week is $x"
mkdir $x
touch $x.txt
done


ls -ltr

