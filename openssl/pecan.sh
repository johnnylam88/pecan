#!/bin/sh

PECAN_PKGNAME="openssl-1.0.1c"

pecan_description="SSLv2/v3 & TLSv1 protocol & cryptography library"

pecan_prereq_lib=">= zlib-1.2.7"
pecan_prereq_pkg=">= perl-5.005"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure()
{
	( cd "${pecan_srcdir}" &&
	  ./config --prefix="${pecan_pkgdir}" \
		--openssldir="${pecan_etcdir}/ssl" \
		threads zlib-dynamic shared \
		${pecan_cppflags} ${pecan_ldflags} )
}

pecan_test_style=make
pecan_test_target=test

pecan_post_stage()
{
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"
}

pecan_install_args="OPENSSLDIR=${pecan_pkgdir}/share/examples/openssl"
pecan_install_args="${pecan_install_args} MANDIR=${pecan_mandir}"

pecan_post_install()
{
	rmdir "${pecan_pkgdir}/share/examples/openssl/certs"
	rmdir "${pecan_pkgdir}/share/examples/openssl/private"
}

pecan_main "$@"
