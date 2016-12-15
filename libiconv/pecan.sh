#!/bin/sh

PECAN_PKGNAME="libiconv-1.14+1"

pecan_description="GNU character set conversion library"

pecan_fetch_url="http://ftp.gnu.org/gnu/libiconv/%FILE%"

pecan_abi_version="1.9.1"
pecan_api_version="1.9.1"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-nls"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" ${pecan_stagedir}
	cp "${pecan_srcdir}/COPYING.LIB" ${pecan_stagedir}
}

pecan_main "$@"
