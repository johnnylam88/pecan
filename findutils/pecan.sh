#!/bin/sh

PECAN_PKGNAME="findutils-4.4.2+2"

pecan_description="GNU find utilities for basic directory searches"

pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"
pecan_prereq_pkg="* coreutils"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Location for the default locate(1) database.
pecan_vardir="${PECAN_TARGET}/var/db"

# updatedb(1) requires a working sort(1) from `coreutils'.
SORT="${PECAN_TARGET}/bin/sort"; export SORT

pecan_configure_style="gnu"
pecan_test_style=make

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
