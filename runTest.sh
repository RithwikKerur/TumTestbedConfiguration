#!/bin/bash

pos nodes image $1 debian-buster
pos nodes reset $1
pos commands launch --infile setup.sh $1 --blocking
#pos commands launch --infile measurement.sh $node --blocking

