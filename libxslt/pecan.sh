#!/bin/sh

PECAN_PKGNAME="libxslt-1.1.27"

pecan_description="XSLT C library"

pecan_prereq_lib=">= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= libxml2-2.9.0"
pecan_prereq_lib="${pecan_prereq_lib} >= xz-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.7"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_test_style=make

pecan_post_stage()
{
	pkgname="${pecan_pkgname}-${pecan_swver}"
	echo "linkdir share/doc/${pkgname}" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/Copyright" "${pecan_stagedir}"
}

pecan_main "$@"
