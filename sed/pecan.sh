#!/bin/sh

PECAN_PKGNAME="sed-4.2.1"

pecan_description="GNU stream editor"

pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.DOC" "${pecan_stagedir}"
}

pecan_main "$@"
