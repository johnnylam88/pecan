#!/bin/sh

PECAN_PKGNAME="xz-5.0.4"

pecan_description="Library and command line tools for XZ and LZMA compressed files"

pecan_prereq_lib=">= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

pecan_tools_build="msgfmt sed"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.GPLv2" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.GPLv3" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.LGPLv2.1" "${pecan_stagedir}"
}

pecan_main "$@"
