#!/bin/bash

(crontab -l ; echo "*/5 * * * 4 ./1.sh") | crontab


