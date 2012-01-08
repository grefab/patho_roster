#!/bin/bash
UniqueFolder=tmp

Data=$UniqueFolder/data.tmp
File=\'$1\'

prolog -f j2p.pl -g 'start('$File')' -t 2>>/dev/null halt > $Data
./run.sh $Data 26 5
