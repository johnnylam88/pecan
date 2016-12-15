#!/bin/sh

PECAN_PKGNAME="bzip2-1.0.6+1"

pecan_description="Patent-free data compressor"

pecan_fetch_url="http://www.bzip.org/1.0.6/%FILE%"

pecan_abi_version="1.0"
pecan_api_version="1.0"

pecan_prereq_build="* autoconf"
pecan_prereq_build="${pecan_prereq_build} * automake"

pecan_tools_build="libtool"

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
	( cd "${pecan_srcdir}" && sh ./autogen.sh )
}

pecan_test_style=make
pecan_test_target=test

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
