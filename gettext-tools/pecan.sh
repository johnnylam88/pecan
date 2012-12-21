#!/bin/sh

PECAN_PKGNAME="gettext-tools-0.18.1.1"

pecan_description="GNU internationalization & localization tools"

pecan_prereq_lib=">= expat-2.1.0"
pecan_prereq_lib="${pecan_prereq_lib} >= gettext-runtime-0.18.1.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= ncurses-5.0"

pecan_extract_file="gettext-0.18.1.1.tar.gz"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_srcdir="${pecan_workdir}/gettext-${pecan_swver}/${pecan_pkgname}"

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-java"
pecan_configure_args="${pecan_configure_args} --without-included-gettext"

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/../COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
