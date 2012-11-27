#!/bin/sh

PECAN_PKGNAME="libtool-2.4.2"

pecan_description="GNU tool for building, installing & using shared libraries"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_gnu_configure_args="${pecan_gnu_configure_args} --enable-ltdl-install"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
