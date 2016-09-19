#!/bin/bash

# shell中 argc 用 $# 表示, 它并不像C那样包含a.out, 只包含真正参数的数目
echo $#

# 打印所有的参数

i=0
ARGC=$#
let ARGC++
while [ $i -lt $ARGC ]
do
	echo $1
	shift
	let i++ # i加1
done

# $0 相当于C里面的argv[0]
echo $0

# $*
echo "test: $*"
echo "test: $@"

# $? 上个shell命令执行的结果
echo "result of last shell command is : $?"


