#!/bin/bash
#!chmod +x ./deploylocal.sh



if [ "$#" != "2" ]; then
    echo "usage: $0 name prot"
    exit 1
fi


echo $1
echo $2
