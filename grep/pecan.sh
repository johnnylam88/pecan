#!/bin/sh

PECAN_PKGNAME="grep-2.14+2"

pecan_description="GNU regular expression search utility"

pecan_fetch_url="http://ftp.gnu.org/gnu/grep/%FILE%"
pecan_fetch_suffix=".tar.xz"

pecan_prereq_lib=">= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"
pecan_prereq_lib="${pecan_prereq_lib} >= pcre-3.4"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-threads"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
