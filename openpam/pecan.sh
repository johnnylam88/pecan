#!/bin/sh

PECAN_PKGNAME="openpam-20120526+1"

pecan_description="Pluggable authentication mechanism (PAM) library"

pecan_fetch_file_url=`cat << EOF
	openpam-20120526.tar.gz
	http://sourceforge.net/projects/openpam/files/openpam/Micrampelis/%FILE%/download
EOF
`

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

pecan_configure_style="gnu"

pecan_post_stage()
{
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"
}

pecan_main "$@"
