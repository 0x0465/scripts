#!/bin/bash
i=1
while [ $i -le 10 ]
    do
	echo "$i"
	pdfunite FD_"$i"_9_21.pdf FD_"$i"_9_21_wagi.pdf FD_"$i"_9_21_P.pdf
	((i++))
    done
