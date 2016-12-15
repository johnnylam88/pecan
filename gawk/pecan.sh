#!/bin/sh

PECAN_PKGNAME="gawk-4.0.2+2"

pecan_description="GNU 'awk' utility"

pecan_fetch_url="http://ftp.gnu.org/gnu/gawk/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"
pecan_prereq_lib="${pecan_prereq_lib} >= readline-2.2"

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

pecan_post_install()
{
	# Remove the symbolic link added during the ``install''.
	rm -f ${pecan_pkgdir}/bin/awk
}

pecan_main "$@"
