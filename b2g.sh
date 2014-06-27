#!/bin/bash
# see https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Preparing_for_your_first_B2G_build

#Valid devices to configure are:
#- galaxy-s2
#- galaxy-nexus
#- nexus-4
#- nexus-4-kk
#- nexus-5
#- nexus-s
#- nexus-s-4g
#- flo (Nexus 7 2013)
#- otoro
#- unagi
#- inari
#- keon
#- peak
#- leo
#- hamachi
#- helix
#- wasabi
#- fugu
#- tarako
#- tara
#- dolphin
#- pandaboard
#- vixen
#- flatfish
#- flame
#- emulator
#- emulator-jb
#- emulator-kk
#- emulator-x86
#- emulator-x86-jb
#- emulator-x86-kk

# device specifier is extracted from script name or taken from first argument
# naming convention: b2g-$device.sh
device=$(basename "$0")
device=${device%.sh}
device=${device#b2g-}

# if script name is b2g.sh, use first argument as device specifier
if [ "$device" == "b2g" ]
then
  device=$1
  shift
fi

if [ -z "$device" ]
then
  echo "ERROR: first argument mut be a valid device specifier"
  exit 5
fi

root="$(pwd)/build-b2g-${device}.noindex"

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
	./flash.sh $2 $3 $4
	;;

*)
	echo "woot!"
	exit 5

esac

