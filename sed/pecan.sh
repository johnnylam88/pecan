#!/bin/sh

PECAN_PKGNAME="sed-4.2.1+1"

pecan_description="GNU stream editor"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# This sed package is used as a bootstrap for modifying files for
# other packages, so remove dependencies on iconv and gettext.
#
pecan_gnu_configure_args="${pecan_gnu_configure_args} --disable-nls"
pecan_gnu_configure_args="${pecan_gnu_configure_args} --disable-i18n"

pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.DOC" "${pecan_stagedir}"
}

pecan_main "$@"
