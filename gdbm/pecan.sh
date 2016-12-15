#!/bin/sh

PECAN_PKGNAME="gdbm-1.10+2"

pecan_description="GNU key/data-pair database library"

pecan_fetch_url="http://ftp.gnu.org/gnu/gdbm/%FILE%"

pecan_abi_version="1.10"
pecan_api_version="1.8.3"

pecan_prereq_lib=">= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"

pecan_tools_build="msgfmt"

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
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
