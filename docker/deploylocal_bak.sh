#!/bin/bash
#!chmod +x ./deploy.sh

if [ "$#" != "1" ]; then
    echo "usage: $0 sit | uat"
    exit 1
fi

BASE_PATH=/Users/mark/work/svn/dsp-service-common
#REMOTE_PATH=root@10.86.65.136:/home/cma-dsp

echo web update
cd $BASE_PATH
svn update
cd $BASE_PATH/dsp-web-auth-application/src/main/resources/static
cp www/modules/common/util-$1.js www/modules/common/util.js

echo mvn clean install......
cd $BASE_PATH
mvn clean install

if [ "$1" = "uat" ]; then
    echo uat
    echo send web-app.........
    sshpass -p "z+z4rd@nqJ#9Zo9]" scp -P 22 $BASE_PATH/dsp-web-auth-application/target/dsp-web-auth-application-1.1-SNAPSHOT.war $REMOTE_PATH/uat/dsp-web-auth-application-1.1-SNAPSHOT.war
    echo restart uat docker
    sshpass -p "z+z4rd@nqJ#9Zo9]" ssh -p 22  root@10.86.65.136 "cd /home/cma-dsp/uat ; ./redocker.sh"
    open -a /Applications/Google\ Chrome.app/ https://cepessouat.lynkco.com/partner/login
fi

echo $1 ok.
