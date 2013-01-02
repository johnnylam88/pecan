#!/bin/sh

PECAN_PKGNAME="gmp-5.0.5"

pecan_description="GNU multiple precision arithmetic library"

pecan_fetch_url="http://ftp.gnu.org/gnu/gmp/%FILE%"
pecan_fetch_suffix=".tar.bz2"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"

pecan_pre_configure()
{
	# config.guess guesses incorrectly sometimes.
	( cd "${pecan_srcdir}" && mv -f configfsf.guess config.guess )
}

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.LIB" "${pecan_stagedir}"
	cp "${pecan_srcdir}/README" "${pecan_stagedir}/README.gmp"
}

pecan_main "$@"
