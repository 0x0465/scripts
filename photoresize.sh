#!/bin/bash

# Skrypt zmniejsza rekursywnie zdjęcia we wszystkich katalogach z podanej ścieżki do 580px,
# tworzy też podkatalog z miniaturami (m) o wielkości 90px w każdym katalogu
# uwaga! skrypt zmienia nazwy plików na kolejne cyfry rozpoczynając od 1
# obsługuje PNG, JIFF i JPG

# zmniejsz główne zdjęcia do 580x
echo -n "podaj ścieżkę do folderu zdjęć: "
read maindir
find "$maindir" -type d -name "* *" | rename 's/ /_/g'
find "$maindir" -type f -name "* *" | rename 's/ /_/g'

for directory in $(find "$maindir"/ -maxdepth 1 -type d -printf "%f\n")
    do  
    licz=0
#png
        for file in $(find "$maindir"/"$directory"/ -maxdepth 1 -name "*.png" -printf "%f\n")
        do 
            convert "$maindir"/"$directory"/"$file" "$maindir"/"$directory"/"$file".jpg
            rm "$maindir"/"$directory"/"$file"
        done
#jiff
        for file in $(find "$maindir"/"$directory"/ -maxdepth 1 -name "*.jfif" -printf "%f\n")
        do 
            convert "$maindir"/"$directory"/"$file" "$maindir"/"$directory"/"$file".jpg
            rm "$maindir"/"$directory"/"$file"
        done
#jpg
        for file in $(find "$maindir"/"$directory"/ -maxdepth 1 -name "*.jpg" -printf "%f\n")
        do 
        licz=$((licz + 1))
            convert -resize 580x "$maindir"/"$directory"/"$file" "$maindir"/"$directory"/"$licz".jpg
            #echo $(pwd)
        rm "$maindir"/"$directory"/"$file"
        done
    done

# stwórz katalogi na miniatury
for directory in $(find "$maindir"/ -type d) 
    do 
        mkdir "$directory"/m
    done
# tworzenie miniatur w katalogu m 
for directory in $(find "$maindir"/ -maxdepth 1 -type d -printf "%f\n")
    do  
        for file in $(find "$maindir"/"$directory"/ -maxdepth 1 -name "*.jpg" -printf "%f\n")
        do 
            convert -resize 90x "$maindir"/"$directory"/"$file" "$maindir"/"$directory"/m/"$file"
            #echo $(pwd)
        done
    done 
find "$maindir" -empty -delete

