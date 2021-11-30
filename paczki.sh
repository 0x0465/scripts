
lines=$(cat gls.txt)
for line in $lines 
do
    grep $line /mnt/skaner/2021/*
done