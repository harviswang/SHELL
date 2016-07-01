#!/bin/bash
# use to update some folder
# '='的两侧禁止有空格

# deal(name, from_path, to_path)
#      $1    $2         $3
function deal()
{
    rm -fr $3/$1
    cp -rv $2/$1 $3/$1
}

function elf_update()
{
	array=( "AmazingAlarmClock"
			"AmazingCalculator"
			"AmazingCalendar"
			"AmazingCalendarProvider"
			"AmazingClock"
			"AmazingCountdown"
			"AmazingHealth"
			"AmazingLauncher"
			"AmazingMobileCenter"
			"AmazingMusic"
			"AmazingNotification"
			"AmazingNotificationProvider"
			"AmazingRemoteCamera"
			"AmazingSettings"
			"AmazingSms"
			"AmazingSoundRecorder"
			"AmazingTheme"
			"AmazingTimer"
			"AmazingVoice"
			"AmazingWeather"
			"AntBuildConfig"
			"iwds-ui-res-jar"
			"JavaDocAndBuildOut"
			"mmitest"
			"samples"
			"watch-manager"
			"watch-manager-for-ios"
			"iwds-ui-with-res-jar")
	from_path=$1
	to_path=$2
	for name in ${array[@]}
	do
		echo $name
		deal $name $from_path $to_path
	done
}

function elf_update5()
{
	elf_update "$HOME/iwds" "$HOME/android5.1/elf"
}
