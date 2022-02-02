#!/bin/bash 
mount -t drvfs '\\192.168.5.3\nas\Wysyłka - skaner\' /mnt/skaner
dir="202202"
for i in {01..31}; do
    mkdir ./"$dir$i"
    touch ./$dir$i/AW.txt ./$dir$i/PS.txt ./$dir$i/W.txt ./$dir$i/O.txt ./$dir$i/JG.txt ./$dir$i/LT.txt ./$dir$i/NP.txt ./$dir$i/JK.txt
done
