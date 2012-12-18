#!/bin/sh

PECAN_PKGNAME="openpam-20120526"

pecan_description="Pluggable authentication mechanism (PAM) library"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Pass in additional CPPFLAGS to openpam Makefiles.
AM_CPPFLAGS="-DOPENPAM_COMMON_MODULE_DIR=\\\"${PECAN_TARGET}/lib/security\\\""
AM_CPPFLAGS="${AM_CPPFLAGS} -DSYSCONFDIR=\\\"${pecan_etcdir}\\\""
export AM_CPPFLAGS

pecan_post_stage()
{
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"
}

pecan_main "$@"
