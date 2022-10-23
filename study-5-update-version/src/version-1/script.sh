#!/bin/sh

echo "$(( 10#$(date +"%M") * 10#60 + 10#$(date +"%S") ))$(date +",%6N")";

 while true; do
          sleep 5;
          done