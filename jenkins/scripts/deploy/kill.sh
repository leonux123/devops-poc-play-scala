#!/bin/bash

# Kill admin pid
kill -9 `cat poc/play.pid`
echo "done"
exit 0;
