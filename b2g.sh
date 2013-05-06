#!/bin/bash
# see https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Preparing_for_your_first_B2G_build

device="nexus-s"
# Valid devices to configure are:
# - galaxy-s2
# - galaxy-nexus
# - nexus-s
# - nexus-s-4g
# - otoro
# - unagi
# - inari
# - keon
# - peak
# - leo
# - hamachi
# - tara
# - pandaboard
# - emulator
# - emulator-x86

root=$(pwd)/build-b2g.noindex

cmd=$1
case "${cmd}" in

init)
	if [ -d "${root}" ]
	then
		echo "ERR: Looks like init already ran. If you want to re-init, move $root out of the way first." >&2
		exit 2
	fi

	mkdir -p "${root}"
	cd "${root}"
	curl -fsSL https://raw.github.com/mozilla-b2g/B2G/master/scripts/bootstrap-mac.sh >b2g-bootstrap-mac.sh
	chmod +x b2g-bootstrap-mac.sh
	./b2g-bootstrap-mac.sh
	git clone git://github.com/mozilla-b2g/B2G.git
	cd B2G/
	./config.sh "${device}"
	;;

update)
	cd "${root}/B2G"
	git pull
	./repo sync
	;;

build)
	time (
		cd "${root}/B2G"
		./build.sh $2 $3 $4
	)
	;;

flash)
	cd "${root}/B2G"
	sudo ./flash.sh $2 $3 $4
	;;

*)
	echo "woot!"
	exit 5

esac

