#!/bin/sh

PECAN_PKGNAME="sed-4.2.1+1"

pecan_description="GNU stream editor"

pecan_fetch_url="http://ftp.gnu.org/gnu/sed/%FILE%"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# This sed package is used as a bootstrap for modifying files for
# other packages, so remove dependencies on iconv and gettext.
#
pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-nls"
pecan_configure_args="${pecan_configure_args} --disable-i18n"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.DOC" "${pecan_stagedir}"
}

pecan_main "$@"
