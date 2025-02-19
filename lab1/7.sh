#!/bin/bash

grep -roahE '[[:alnum:]_.]+@[[:alpha:]]+\.[[:alpha:]]+' /etc | tr '\n' ',' | sed 's/,$//' > emails.lst 
