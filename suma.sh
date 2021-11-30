#!/bin/bash
grep number * | awk -F':' '{ print $3 }' | awk '{n += $1}; END{print n}'