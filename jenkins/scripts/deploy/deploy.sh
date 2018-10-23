#!/bin/bash

setEnv(){
        cd
        cd poc/
        unzip poc_admin-1.0.zip
        mv poc_admin-1.0 ./pocadmin
}

startApp(){
        echo "[poc-deploy] starting application"
        cd
        ./admin-start.sh
}

run(){
        echo "[poc-deploy]"

        setEnv
        startApp
}

run

exit 0;
