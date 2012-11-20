#!/bin/sh

PECAN_PKGNAME="epkg-2.3.9+1"

pecan_description="Encap package manager"

pecan_prereq_lib=">= zlib-1.2.7"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
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
