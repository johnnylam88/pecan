#!/bin/sh

PECAN_PKGNAME="tar-1.26+1"

pecan_description="GNU tar archive program"

pecan_extract_file="tar-1.26.shar.gz"
pecan_extract_suffix=".shar.gz"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# This tar package is used as a bootstrap for extracting files for
# most other packages, so remove dependencies on other packages.
#
pecan_pre_configure()
{
	mkdir -p "${pecan_tooldir}/include"
	echo > "${pecan_tooldir}/include/iconv.h"
}

pecan_cppflags="-I${pecan_tooldir}/include"

configure_args="--disable-nls"
configure_args="${configure_args} --without-libiconv-prefix"
configure_args="${configure_args} --without-libintl-prefix"
pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_post_install()
{
	rmdir "${pecan_pkgdir}/sbin"
}

pecan_main "$@"
