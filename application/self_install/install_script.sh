#!/bin/bash

line=`wc -l $0 | awk '{print $1}'`
line=`expr $line - 12`
tmpdir=`mktemp`
/bin/rm -f $tmpdir
mkdir -p $tmpdir
tail -n $line $0 | tar -x -f - -C $tmpdir
cd $tmpdir
bash ./unpack.sh
ret=$?
echo $tmpdir
exit $ret
