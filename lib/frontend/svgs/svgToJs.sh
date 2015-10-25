#!/bin/bash
# shell script to turn svg into a javascript module
# experiment with inline svg performance using require
# usage: $ ./svgToJs.sh file1 file2 file3
for file in $@; do
y=`echo $file | sed "s/\..*//"`
echo "module.exports=\"\"\"" `cat $file` "\"\"\"" > $y.coffee
coffee -c $y.coffee
rm $y.coffee
done
