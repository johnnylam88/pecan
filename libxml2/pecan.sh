#!/bin/sh

PECAN_PKGNAME="libxml2-2.9.0"

pecan_description="XML C parser library and toolkit"

pecan_fetch_url="ftp://xmlsoft.org/libxml2/%FILE%"

pecan_prereq_lib=">= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= xz-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.7"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# This library needs to be usable by non-threaded applications.
pecan_configure_args="${pecan_configure_args} --without-threads"

pecan_configure_style="gnu"
pecan_test_style=make

pecan_post_stage()
{
	pkgname="${pecan_pkgname}-${pecan_swver}"
	echo "linkdir share/doc/${pkgname}" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/Copyright" "${pecan_stagedir}"
}

pecan_main "$@"
