#!/bin/sh

PECAN_PKGNAME="expat-2.1.0"

pecan_description="XML stream-oriented parser library"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
