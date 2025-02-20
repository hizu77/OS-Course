#!/bin/bash

man bash | grep -oiE '[[:alnum:]]{4,}' | sort -f | uniq -ci | sort -nrk1 | head -n3
