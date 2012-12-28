#!/bin/sh

PECAN_PKGNAME="epkg-2.3.9+5"

pecan_description="Encap package manager"

pecan_prereq_lib=">= curl-7.28.0+1"
pecan_prereq_lib="${pecan_prereq_lib} >= expat-2.1.0"
pecan_prereq_lib="${pecan_prereq_lib} >= libidn-1.25"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.7"
pecan_prereq_pkg=">= m4-1.4"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="--disable-epkg-install"
configure_args="${configure_args} --with-encap-source=${PECAN_SOURCE}"
configure_args="${configure_args} --with-encap-target=${PECAN_TARGET}"

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	echo "exclude etc" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYRIGHT" "${pecan_stagedir}"
	mkdir "${pecan_stagedir}/etc"
	cp "${pecan_srcdir}/mkencap/mkencap_environment" "${pecan_stagedir}/etc"
}

pecan_install_target="install-recurse"
pecan_install_args="${pecan_install_args} docdir=${pecan_pkgdir}/share/doc"

pecan_main "$@"
