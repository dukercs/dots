#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)
LOG=$dir/polylog.log
if [ -n $2 ] 
then
	for i in error warning notice info trace
	do
		if [ "$2" == "$i" ]
		then
			LOGLVL=$2
		fi
	done
fi

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar > $LOG 2>&1

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done 

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -l ${LOGLVL:-notice} top -c "$dir/$style/config.ini">> $LOG 2>&1 &
		polybar -l ${LOGLVL:-notice} bottom -c "$dir/$style/config.ini" >> $LOG 2>&1 &
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main >> $LOG 2>&1
	elif [[ "$style" == "colorblocksMOD" ]]; then
		polybar -l ${LOGLVL:-notice} right -c "$dir/$style/config.ini">> $LOG 2>&1 &
		polybar -l ${LOGLVL:-notice} left -c "$dir/$style/config.ini" >> $LOG 2>&1 &

	else
		polybar -l ${LOGLVL:-notice} main -c "$dir/$style/config.ini" >> $LOG 2>&1 &	
	fi
}
if [[ "$1" == "--hack1bar" ]]; then
	style="hack1bar"
	launch_bar

elif [[ "$1" == "--material" ]]; then
	style="material"
	launch_bar

elif [[ "$1" == "--shades" ]]; then
	style="shades"
	launch_bar

elif [[ "$1" == "--hack" ]]; then
	style="hack"
	launch_bar

elif [[ "$1" == "--docky" ]]; then
	style="docky"
	launch_bar

elif [[ "$1" == "--cuts" ]]; then
	style="cuts"
	launch_bar

elif [[ "$1" == "--shapes" ]]; then
	style="shapes"
	launch_bar

elif [[ "$1" == "--grayblocks" ]]; then
	style="grayblocks"
	launch_bar

elif [[ "$1" == "--blocks" ]]; then
	style="blocks"
	launch_bar

elif [[ "$1" == "--colorblocks" ]]; then
	style="colorblocks"
	launch_bar

elif [[ "$1" == "--colorblocksMOD" ]]; then
	style="colorblocksMOD"
	launch_bar

elif [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

elif [[ "$1" == "--pwidgets" ]]; then
	style="pwidgets"
	launch_bar

elif [[ "$1" == "--panels" ]]; then
	style="panels"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
	--blocks    --colorblocks    --cuts      --docky
	--forest    --grayblocks     --hack      --material
	--panels    --pwidgets       --shades    --shapes
	--hack1bar  --colorblocksMOD
	EOF
fi
