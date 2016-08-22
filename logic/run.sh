#!/bin/bash

Data=$1
Model=model.lp
UniqueFolder=$(dirname $1)
Input=input.tmp
Gringo=gringo3
Clasp=clasp
Input=input.tmp

cat $Model > $UniqueFolder/$Input
cat .$UniquFolder/$Data >> $UniqueFolder/$Input

cd $UniqueFolder

Problem=problem.tmp
Output=output.tmp
FormatOutput=foutput
PrettyOutput=prettyOutput.csv
Error=error.tmp
Option=' --time-limit='$3' '
Option=$Option'--configuration='$2' ' 

cat $Input | $Gringo > $Problem
cat $Problem | $Clasp $Option 2>>$Error > $Output 
cat $Output | grep 'work' |  tail -n 1 | sed 's/ /\n/g' | sed 's/$/./g' | sort  > $FormatOutput
prolog -f ../../print.pl -g 'start' -t halt 2>> $Error > $PrettyOutput
column -t -s ';' $PrettyOutput
prolog -f ../../print_json.pl -g start -t halt 2>> $Error
