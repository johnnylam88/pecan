#!/bin/sh

PECAN_PKGNAME="openssl-1.1.0c"

pecan_description="SSLv2/v3 & TLSv1 protocol & cryptography library"

pecan_fetch_url="http://openssl.org/source/%FILE%"

pecan_prereq_lib=">= zlib-1.2.7"
pecan_prereq_pkg=">= perl-5.005"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
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
	echo "exclude etc" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"
}

pecan_install_args="OPENSSLDIR=${pecan_pkgdir}/etc/ssl"
pecan_install_args="${pecan_install_args} MANDIR=${pecan_mandir}"
pecan_install_args="${pecan_install_args} DOCDIR=${pecan_docdir}"

pecan_main "$@"
