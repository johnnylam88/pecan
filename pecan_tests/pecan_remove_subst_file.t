#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="remove_subst_file-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_remove_subst_file_test()
{
	mkdir -p "${ENCAP_PKGDIR}"
	mkdir -p "${ENCAP_PKGDIR}/etc"
	touch "${ENCAP_PKGDIR}/etc/file"
	touch "${ENCAP_PKGDIR}/etc/file.in"

	pecan_remove_subst_file etc/file

	retval=0
	if [ -f "${ENCAP_PKGDIR}/etc/file" ]; then 
		echo "FAIL: ${ENCAP_PKGDIR}/etc/file exists"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_remove_subst_file_test
