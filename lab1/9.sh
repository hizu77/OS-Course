#!/bin/bash

wc -l $(find /var/log -type f -name "*.log") | awk 'END {print $1}'
