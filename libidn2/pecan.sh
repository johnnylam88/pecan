#!/bin/sh

PECAN_PKGNAME="libidn2-0.11+1"

pecan_description="GNU implementation of the IDNA2008 specifications"

pecan_fetch_url="ftp://alpha.gnu.org/gnu/libidn/%FILE%"

pecan_prereq_lib=">= libunistring-0.9.3"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"

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

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
