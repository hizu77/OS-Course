#!/bin/bash

ps ax -o pid,command | grep '/sbin/' | awk '{print $1}' > res2.txt

cat res2.txt

