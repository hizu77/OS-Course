#!/bin/bash

mkdir ~/test && {echo "catalog test was created successfully" > ~/report ; touch ~/test/$(date +"%Y-%m-%d_%H:%M:%S")}

ping www.net_nikogo.ru || echo "$(date +"%Y-%m-%d_%H:%M:%S") error" >> ~/report 
