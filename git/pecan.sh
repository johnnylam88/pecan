#!/bin/sh

PECAN_PKGNAME="git-1.8.0+1"

pecan_description="The stupid content tracker"

pecan_prereq_build=">= autoconf-2.50"
pecan_prereq_build="${pecan_prereq_build} * gmake"
pecan_prereq_build="${pecan_prereq_build} >= gettext-tools-0.18.1"
pecan_prereq_lib=">= curl-7.28.0"
pecan_prereq_lib="${pecan_prereq_lib} >= expat-2.1.0"
pecan_prereq_lib="${pecan_prereq_lib} >= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"
pecan_prereq_lib="${pecan_prereq_lib} >= pcre-5.8"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.7"
pecan_prereq_pkg="* bash"
pecan_prereq_pkg="${pecan_prereq_pkg} >= perl-5.8"
pecan_prereq_pkg="${pecan_prereq_pkg} >= python-2.6"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="${configure_args} --with-openssl"
configure_args="${configure_args} --with-libpcre"
configure_args="${configure_args} --with-curl"
configure_args="${configure_args} --with-expat"
configure_args="${configure_args} --with-iconv"
configure_args="${configure_args} --with-perl=${PECAN_TARGET}/bin/perl"
configure_args="${configure_args} --with-python=${PECAN_TARGET}/bin/python"
configure_args="${configure_args} --with-shell=${PECAN_TARGET}/bin/bash"
configure_args="${configure_args} --without-tcltk"

pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/LGPL-2.1" "${pecan_stagedir}"
}

pecan_post_install()
{
	rm -fr "${pecan_pkgdir}"/lib/perl5/[0-9]*
	mkdir -p "${pecan_mandir}"
	cd "${pecan_mandir}" && \
		tar zxvf "${PECAN_DISTDIR}/git-manpages-${pecan_swver}.tar.gz"
}

pecan_main "$@"
