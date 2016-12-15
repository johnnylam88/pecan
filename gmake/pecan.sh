#!/bin/sh

PECAN_PKGNAME="gmake-3.82+2"

pecan_description="GNU 'make' utility"

pecan_fetch_file="make-3.82.tar.gz"
pecan_fetch_url="http://ftp.gnu.org/gnu/make/%FILE%"

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
pecan_configure_args="${pecan_configure_args} --program-prefix=g"

#pecan_test_style=make

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
