#!/bin/sh

PECAN_PKGNAME="coreutils-8.20"

pecan_description="GNU find utilities for basic directory searches"

pecan_extract_suffix=".tar.xz"

pecan_prereq_build="* bash"
pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= gmp-5.0.5"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_gnu_configure_shell="${pecan_tooldir}/bin/bash"
pecan_test_style=make

pecan_pre_build()
{
	# Don't regenerate the sort(1) manpage after patching sort.c.
	touch "${pecan_srcdir}/man/sort.1"
}

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_post_install()
{
	# Remove empty `lib' directory.
	rmdir "${pecan_pkgdir}/lib"
}

pecan_main "$@"
