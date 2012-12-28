#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="subst_file-0"

. ../pecan/pecan_pkg_script.subr

pecan_subst_file_test()
{
	mkdir -p ${ENCAP_PKGDIR}
	mkdir -p ${ENCAP_PKGDIR}/etc
	touch ${ENCAP_PKGDIR}/etc/file1.in

	pecan_subst_file etc/file1.in

	retval=0
	if [ ! -f "${ENCAP_PKGDIR}/etc/file1" ]; then
		echo "FAIL: ${ENCAP_PKGDIR}/etc/file1 doesn't exist"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_subst_file_test
