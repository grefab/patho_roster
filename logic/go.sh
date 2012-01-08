#!/bin/bash
File=\'$1\'
Data=test_data.lp
prolog -f j2p.pl -g 'start('$File')' -t 2>>/dev/null halt > $Data
./run.sh $Data 26 3
