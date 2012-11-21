#!/bin/sh

PECAN_PKGNAME="tar-1.26"

pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

pecan_description="GNU tar archive program"

pecan_extract_file="tar-1.26.shar.gz"
pecan_extract_suffix=".shar.gz"

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
}

pecan_post_install()
{
	rmdir "${pecan_pkgdir}/sbin"
}

pecan_main "$@"
