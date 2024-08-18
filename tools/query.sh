#!/bin/bash
read -n 1 -p "database to search: global, facebook, polish, All? (g/f/p/A) " ans;
echo ""
case $ans in
        g|G)
                echo "query:"
                read query
                echo ""
                echo "searching global:"
                zgrep -iraE --color "$query" ./global;;

        f|F)
                echo "query:"
                read query
                echo""
                echo "searching facebook:"
                7z x -so Facebook_BF.7z | egrep -i --color "$query";;
        p|P)
                echo "query:"
                read query
                echo ""
                echo "searching polish:"
                egrep -ir --color "$query" ./pl;;
        a|A)
                echo "query:"
                read query
                echo ""
                echo "searching global:"
                zgrep -iraE --color "$query" ./global
                echo ""
                echo "--------------------------"
                echo""
                echo "searching facebook:"
                7z x -so Facebook_BF.7z | egrep -i --color "$query"
                echo ""
                echo "---------------------------"
                echo ""
                echo "searching polish:"
                egrep -ir --color "$query" ./pl
                echo ""
esac

echo "search completed"
