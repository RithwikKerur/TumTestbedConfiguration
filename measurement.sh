#!/bin/bash
set -x
set -e
cd SailfishTest/benchmark
pip3 install google-api-python-client
pip3 install google-cloud-compute==1.18.0
pip3 install google-cloud==0.34.0
pip3 install asyncssh
fab local > output.txt 
pos_upload -f output.txt
pwd
ls
pos_upload -f -r logs
