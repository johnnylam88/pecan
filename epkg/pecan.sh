#!/bin/sh

PECAN_PKGNAME="epkg-2.3.9+3"

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

configure_args="--with-encap-source=${PECAN_SOURCE}"
configure_args="${configure_args} --with-encap-target=${PECAN_TARGET}"

install_args="docdir=${pecan_pkgdir}/share/doc"

pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"
pecan_install_args="${pecan_install_args} ${install_args}"

pecan_main "$@"
