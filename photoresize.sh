#!/bin/bash
# zmniejsz główne zdjęcia do 580x
echo -n "podaj ścieżkę do folderu zdjęć: "
read maindir
for file in $(find "$maindir"/ -name *.jpg)
    do 
        convert -resize 580x "$file" "$file"
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

