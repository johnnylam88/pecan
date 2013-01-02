#!/bin/sh

PECAN_PKGNAME="libidn-1.25"

pecan_description="GNU internationalized domain name library"

pecan_fetch_url="http://ftp.gnu.org/gnu/libidn/%FILE%"

pecan_prereq_lib=">= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"

pecan_tools_build="pkg-config"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"

pecan_pre_build()
{
	# toutf8.c was patched to change only the implementation, so
	# touch the downstream documentation files generated from the
	# file so that they aren't regenerated.
	#
	( cd "${pecan_srcdir}/doc" &&
	  touch Makefile.gdoc texi/toutf8.c.texi \
		texi/stringprep_locale_charset.texi \
		man/stringprep_locale_charset.3 \
		texi/stringprep_convert.texi \
		man/stringprep_convert.3 \
		texi/stringprep_locale_to_utf8.texi \
		man/stringprep_locale_to_utf8.3 \
		texi/stringprep_utf8_to_locale.texi \
		man/stringprep_utf8_to_locale.3 )
}

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
