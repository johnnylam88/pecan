#!/bin/sh

PECAN_PKGNAME="m4-1.4.16+2"

pecan_description="SVr4-compatible Unix macro processor"

pecan_fetch_url="http://ftp.gnu.org/gnu/m4/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.18"

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
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
