#!/bin/sh

PECAN_PKGNAME="libidn-1.33"

pecan_description="GNU internationalized domain name library"

pecan_fetch_url="http://ftp.gnu.org/gnu/libidn/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-gtk-doc"
pecan_configure_args="${pecan_configure_args} --disable-gtk-doc-html"
pecan_configure_args="${pecan_configure_args} --disable-gtk-doc-pdf"
pecan_configure_args="${pecan_configure_args} --disable-java"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.LESSERv2" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.LESSERv3" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYINGv2" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYINGv3" "${pecan_stagedir}"
}

pecan_main "$@"
