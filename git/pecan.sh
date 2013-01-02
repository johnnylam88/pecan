#!/bin/sh

git_version=1.8.0.1
PECAN_PKGNAME="git-${git_version}+1"

pecan_description="The stupid content tracker"

pecan_fetch_file="git-${git_version}.tar.gz git-manpages-${git_version}.tar.gz"
pecan_fetch_url="https://git-core.googlecode.com/files/%FILE%"

pecan_extract_file="git-${git_version}.tar.gz"

pecan_prereq_build=">= autoconf-2.62"
pecan_prereq_lib=">= curl-7.28.0"
pecan_prereq_lib="${pecan_prereq_lib} >= expat-2.1.0"
pecan_prereq_lib="${pecan_prereq_lib} >= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"
pecan_prereq_lib="${pecan_prereq_lib} >= pcre-8.31"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.7"
pecan_prereq_pkg=">= python-2.7"

pecan_tools_build="gmake msgfmt"
pecan_tools_pkg="bash perl"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
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

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/LGPL-2.1" "${pecan_stagedir}"

	# Extract the manpages into the staging area.
	mkdir -p "${pecan_stagedir}/share/man"
	( cd "${pecan_stagedir}/share/man" &&
	  tar zxvf "${PECAN_DISTDIR}/git-manpages-${pecan_swver}.tar.gz" )
}

pecan_post_install()
{
	rm -fr "${pecan_pkgdir}"/lib/perl5/[0-9]*
}

pecan_main "$@"
