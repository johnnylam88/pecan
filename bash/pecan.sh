#!/bin/sh

PECAN_PKGNAME="bash-4.2+1"

pecan_description="GNU sh-compatible shell"

pecan_fetch_url="http://ftp.gnu.org/gnu/bash/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"
pecan_prereq_lib="${pecan_prereq_lib} >= ncurses-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= readline-2.2"

pecan_tools_build="msgfmt"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --with-installed-readline"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
