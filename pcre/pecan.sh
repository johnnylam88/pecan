#!/bin/sh

PECAN_PKGNAME="pcre-8.31"

pecan_description="Perl-compatible regular expression library"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="${configure_args} --enable-utf8"
configure_args="${configure_args} --enable-unicode-properties"
configure_args="${configure_args} --enable-pcre16"

pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/LICENCE" "${pecan_stagedir}"
}

pecan_main "$@"
