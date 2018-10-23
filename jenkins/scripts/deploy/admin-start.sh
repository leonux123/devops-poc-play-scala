#!/bin/bash

# Start admin
cd
nohup poc/pocadmin/bin/poc_admin > output.txt 2>&1 &
echo "done"
exit 0;
