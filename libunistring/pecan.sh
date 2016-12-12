#!/bin/sh

PECAN_PKGNAME="libunistring-0.9.7"

pecan_description="GNU Unicode string library"

pecan_fetch_url="http://ftp.gnu.org/gnu/libunistring/%FILE%"

pecan_prereq_lib=">= libiconv-1.14"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"

	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.LIB" "${pecan_stagedir}"
	sed -e '1,/^Copyright/d' -e '/^Download/,$d' -e '/^---/d' \
		"${pecan_srcdir}/README" > "${pecan_stagedir}/LICENSING"
}

pecan_main "$@"
