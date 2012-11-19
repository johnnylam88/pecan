#!/bin/sh

PECAN_PKGNAME="readline-6.2"

pecan_description="GNU command-line editing library"

pecan_prereq_lib=">= ncurses-5.0"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_gnu_configure_args="${pecan_gnu_configure_args} --with-curses"

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_post_install()
{
	# Remove empty `bin' directory.
	rmdir "${pecan_pkgdir}/bin"
}

pecan_main "$@"
