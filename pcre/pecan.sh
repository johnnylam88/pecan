#!/bin/sh

PECAN_PKGNAME="pcre-8.31+1"

pecan_description="Perl-compatible regular expression library"

pecan_fetch_url="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/%FILE%"

pecan_abi_version="8.30"
pecan_api_version="3.4"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
configure_args="${configure_args} --enable-utf8"
configure_args="${configure_args} --enable-unicode-properties"
configure_args="${configure_args} --enable-pcre16"

pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/LICENCE" "${pecan_stagedir}"
}

pecan_main "$@"
