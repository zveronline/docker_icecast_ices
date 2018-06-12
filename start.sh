#!/bin/bash
#chmod -R 777 /stream/*
#find /stream/tracks -type f -name \*.mp3 > /stream/playlist.txt
#cat /stream/playlist.txt
icecast2 -c icecast.xml -b
sleep 5
ices -c ices.xml -v 
while true; do sleep 10; done
