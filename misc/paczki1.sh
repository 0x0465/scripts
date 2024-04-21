#!/bin/bash
lines=$(cat gls.txt)
for line in $lines
do
    echo $line
    grep $line* /mnt/skaner/2021/* >> gls_grep.txt
done