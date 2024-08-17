#!/bin/bash
read -n 1 -p "database to search: global, fb, polish, All? (g/f/p/A) " ans;
echo ""
case $ans in
        g|G)
                echo "query:"
                read query
                echo ""
                echo "searching in global:"
                zgrep -iraE --color "$query" ./global;;

        f|F)
                echo "query:"
                read query
                echo "searching in Facebook:"
                7z x -so fb.7z | egrep -i --color "$query";;
        p|P)
                echo "query:"
                read query
                echo "searching in pl:"
                egrep -ir --color "$query" ./pl;;
        a|A)
                echo "query:"
                read query
                echo ""
                echo "searching in global:"
                zgrep -iraE --color "$query" ./global
                echo "--------------------------"
                echo "searching in Facebook:"
                7z x -so fb.7z | egrep -i --color "$query"
                echo "---------------------------"
                echo "searching in polish:"
                egrep -ir --color "$query" ./pl
                echo ""
esac

echo "search completed"
