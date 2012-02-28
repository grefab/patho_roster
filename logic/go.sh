#!/bin/bash
UniqueFolder=tmp/$(date +%Y_%m_%d___%H_%M_%S)
mkdir -p $UniqueFolder

Data=$UniqueFolder/data.tmp
File=\'$1\'

prolog -f j2p.pl -g 'start('$File')' -t halt 2>>/dev/null > $Data
./run.sh $Data 27 5
