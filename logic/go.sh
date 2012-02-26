#!/bin/bash
UniqueFolder=tmp

Data=$UniqueFolder/data.tmp
File=\'$1\'

prolog -f j2p.pl -g 'start('$File')' -t halt 2>>/dev/null > $Data
./run.sh $Data 27 5
