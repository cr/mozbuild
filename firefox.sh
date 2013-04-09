#!/bin/bash
# see https://developer.mozilla.org/en-US/docs/Simple_Firefox_build/Linux_and_MacOS_build_preparation
# and https://developer.mozilla.org/en-US/docs/Simple_Firefox_build#Get_the_source
#

root=$(pwd)/build-firefox

mozconfig() {
	cat <<-EOF
	# If ccache was installed via Homebrew:
	export PATH="\`brew --prefix ccache\`/libexec:\$PATH"
	
	# Import the stock config for building the browser (Firefox)
	. \$topsrcdir/browser/config/mozconfig
	
	. \$topsrcdir/build/macosx/mozconfig.common
	
	# Define where build files should go. This places them in the directory
	# "obj-ff-dbg" under the current source directory
	mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-ff-dbg
	
	# -s makes builds quieter by default
	# -j4 allows 4 tasks to run in parallel. Set the number to be the amount of
	# cores in your machine. 4 is a good number.
	mk_add_options MOZ_MAKE_FLAGS="-s -j9"
	
	# Enable debug builds
	ac_add_options --enable-debug

	ac_add_options --with-ccache
	
	# Turn off compiler optimization. This will make applications run slower,
	# will allow you to debug the applications under a debugger, like GDB.
	ac_add_options --disable-optimize
	
	mk_add_options AUTOCONF=/usr/local/Cellar/autoconf213/2.13/bin/autoconf213
	EOF
}

##############################################################################
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
	curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py >bootstrap.py
	python bootstrap.py
	hg clone http://hg.mozilla.org/mozilla-central
	mozconfig >>mozilla-central/.mozconfig
	;;

update)
	cd "${root}/mozilla-central"
	hg pull -u
	;;

build)
	time (
		cd "${root}/mozilla-central" \
		&& ./mach build \
		&& ./mach package
	)
	;;

run)
	open "${root}/mozilla-central/obj-ff-dbg/dist/NightlyDebug.app/Contents/MacOS/firefox"
	;;

install)
	cp -r "${root}/mozilla-central/obj-ff-dbg/dist/NightlyDebug.app" /Applications
	;;

*)
	echo "woot!"
	exit 5

esac

