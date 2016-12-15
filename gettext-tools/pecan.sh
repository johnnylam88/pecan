#!/bin/sh

PECAN_PKGNAME="gettext-tools-0.19.8.1+2"

pecan_description="GNU internationalization & localization tools"

pecan_fetch_file="gettext-0.19.8.1.tar.gz"
pecan_fetch_url="http://ftp.gnu.org/gnu/gettext/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.19.8.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.9.1"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --disable-curses"
pecan_configure_args="${pecan_configure_args} --disable-java"
pecan_configure_args="${pecan_configure_args} --without-emacs"
pecan_configure_args="${pecan_configure_args} --without-included-gettext"
pecan_configure_srcdir="${pecan_srcdir}/${pecan_pkgname}"

# All gettext packages put their documentation in a common directory.
pecan_docdir=${pecan_pkgdir}/share/doc/gettext

pecan_post_stage()
{
	echo "exclude lib/charset.alias" >> "${pecan_stage_encapinfo}"
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
