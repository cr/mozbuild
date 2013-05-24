#!/bin/bash
# see https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client
#

root=$(pwd)/build-gaia.noindex

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
	git clone https://github.com/mozilla-b2g/gaia
	;;

update)
	cd "${root}/gaia"
	git pull
	cd ..
	;;

build|make)
	time (
		cd "${root}/gaia" \
		&& DEBUG=1 make
	)
	;;

run)
	[ -x /Applications/FirefoxNightly.app/Contents/MacOS/firefox ] \
	  && fx=/Applications/FirefoxNightly.app/Contents/MacOS/firefox
	#[ -x /Applications/NightlyDebug.app/Contents/MacOS/firefox ] \
	#  && fx=/Applications/NightlyDebug.app/Contents/MacOS/firefox
	"$fx" -profile "${root}/gaia/profile"
	;;

*)
	echo "woot!"
	exit 5

esac

