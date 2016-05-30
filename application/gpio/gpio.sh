#!/system/bin/sh
# run in android command
# dependency: regrw busybox
# 功能：
#      支持操作： gpio写1，gpio写0，gpio读值, gpio poll-up(or drop-down) set (or clear)
#               H -> gpio写1
#               L -> gpio写0
#               V -> gpio读值
#               P -> gpio poll-up(or drop-down) set
#               Q -> gpio poll-up(or drop-down) clear
#               I -> gpio register value

if [ $# = 0 ]
then
echo "Usage: gpio.sh gpio_number H/L/V/P/Q/I"
echo "Usage:"
echo "               H -> gpio写1"
echo "               L -> gpio写0"
echo "               V -> gpio读值"
echo "               P -> gpio poll-up(or drop-down) set"
echo "               Q -> gpio poll-up(or drop-down) clear"
echo "               I -> set gpio input"
echo "For example: "
echo "            gpio.sh 117 H"
exit 1;
fi

#     ./regrw 0x10010000

port=`busybox expr $1 / 32`;
#echo $port
pin=`busybox expr $1 % 32`;
#echo $pin

pxpin=`busybox expr $((0x10010000)) + $((0x100)) \* $port`
#echo $pxpin

pxint=`busybox expr $((0x10010010)) + $((0x100)) \* $port`
#echo $pxinc

pxintc=`busybox expr $((0x10010018)) + $((0x100)) \* $port`
#echo $pxintc

pxmsk=`busybox expr $((0x10010020)) + $((0x100)) \* $port`
#echo $pxmsk

pxmsks=`busybox expr $((0x10010024)) + $((0x100)) \* $port`
#echo $pxmsks

pxpat1=`busybox expr $((0x10010030)) + $((0x100)) \* $port`
#echo $pxpat1

pxpat1c=`busybox expr $((0x10010038)) + $((0x100)) \* $port`
#echo $pxpat1c

pxpat0=`busybox expr $((0x10010040)) + $((0x100)) \* $port`
#echo $pxpat0

pxpat0c=`busybox expr $((0x10010048)) + $((0x100)) \* $port`
#echo $pxpat0c

pxpat0s=`busybox expr $((0x10010044)) + $((0x100)) \* $port`
#echo $pxpat0s

pxpe=`busybox expr $((0x10010070)) + $((0x100)) \* $port`
#echo $pxpe

pxpes=`busybox expr $((0x10010074)) + $((0x100)) \* $port`
#echo $pxpes

pxpec=`busybox expr $((0x10010078)) + $((0x100)) \* $port`
#echo $pxpec

value_array=(
0x00000001
0x00000002
0x00000004
0x00000008
0x00000010
0x00000020
0x00000040
0x00000080
0x00000100
0x00000200
0x00000400
0x00000800
0x00001000
0x00002000
0x00004000
0x00008000
0x00010000
0x00020000
0x00040000
0x00080000
0x00100000
0x00200000
0x00400000
0x00800000
0x01000000
0x02000000
0x04000000
0x08000000
0x10000000
0x20000000
0x40000000
0x80000000
)

value=`busybox expr $((${value_array[$pin]}))`
#echo $value


#echo "./regrw $pxintc $value"
#echo "./regrw $pxmsks $value"
#echo "./regrw $pxpat1c $value"
if [ "$2" = "L" ]
then
	regrw $pxintc $value
	regrw $pxmsks $value
	regrw $pxpat1c $value
	regrw $pxpat0c $value
fi

if [ "$2" = "H" ]
then
	regrw $pxintc $value
	regrw $pxmsks $value
	regrw $pxpat1c $value
	regrw $pxpat0s $value
fi

if [ "$2" = "V" ]
then
	val=$(regrw $pxpin)
	val=${val:12:10}
	#busybox printf "0x%08x\n" $value
	result=$((val&value))
	if [ $result = 0 ]
	then
		echo '0'
	else
		echo '1'
	fi

fi

if [ "$2" = "P" ]
then
	regrw $pxpec $value
	regrw $pxpe
fi

# pxpe是 pull disable状态寄存器, 1表示 pull disable, 0表示 pull enable
if [ "$2" = "Q" ]
then
	regrw $pxpes $value
	regrw $pxpe
fi

if [ "$2" = "I" ]
then
	regrw $pxint
	regrw $pxmsk
	regrw $pxpat1
	regrw $pxpat0
fi
