#!/bin/bash

ps -eo pid=,etimes= | sort -k2n | head -n1 | awk '{print $1}'
