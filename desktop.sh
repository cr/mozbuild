#!/bin/bash
# see https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client
#

root=$(pwd)/build-desktop

mozconfig () {
	cat <<-EOF
	mk_add_options MOZ_OBJDIR=../build
	mk_add_options MOZ_MAKE_FLAGS="-j9 -s"
	
	ac_add_options --enable-application=b2g
	ac_add_options --disable-libjpeg-turbo
	ac_add_options --with-ccache
	 
	# This option is required if you want to be able to run Gaia's tests
	ac_add_options --enable-tests
	
	# turn on mozTelephony/mozSms interfaces
	# Only turn this line on if you actually have a dev phone
	# you want to forward to. If you get crashes at startup,
	# make sure this line is commented.
	#ac_add_options --enable-b2g-ril
	EOF

}

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
	hg clone http://hg.mozilla.org/mozilla-central
	mozconfig >>mozilla-central/.mozconfig
	git clone https://github.com/mozilla-b2g/gaia
	;;

update)
	cd "${root}/mozilla-central"
	hg pull -u
	cd "${root}/gaia"
	git pull
	cd ..
	;;

build)
	time (
		cd "${root}/gaia" \
		&& make \
		&& cd "${root}/mozilla-central" \
		&& make -f client.mk
	)
	;;

run)
	"${root}"/build/dist/B2G.app/Contents/MacOS/b2g \
		-jsconsole \
		--screen=nexus_s \
		-profile "${root}/gaia/profile"
	;;

*)
	echo "woot!"
	exit 5

esac

