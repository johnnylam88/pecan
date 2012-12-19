#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="copy_file-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_copy_file_helper()
{
	mkdir -p ${ENCAP_PKGDIR}
	mkdir -p ${ENCAP_PKGDIR}/etc
	mkdir -p ${ENCAP_PKGDIR}/var

	touch ${ENCAP_PKGDIR}/etc/file1
	touch ${ENCAP_PKGDIR}/var/file2

	mkdir -p ${ENCAP_TARGET}
	mkdir -p ${ENCAP_TARGET}/etc
	mkdir -p ${ENCAP_TARGET}/var
	touch ${ENCAP_TARGET}/var/file2
}

pecan_copy_file_test()
{
	[ -d ${ENCAP_PKGDIR} ] || pecan_copy_file_helper

	( cd ${ENCAP_TARGET} && find . | sort )
	pecan_copy_file etc/file1
	( cd ${ENCAP_TARGET} && find . | sort )
	pecan_copy_file var/file2

	rm -fr "${ENCAP_TARGET}"
}

pecan_copy_file_test
