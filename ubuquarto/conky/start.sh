#!/bin/bash
killall conky

sleep 2 

/usr/bin/conky > conkylog.log 2>&1 & 

