#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="remove_copied_file-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_remove_copied_file_helper()
{
	mkdir -p "${ENCAP_PKGDIR}"
	mkdir -p "${ENCAP_PKGDIR}/etc"

	echo "data1" > "${ENCAP_PKGDIR}/etc/file1"
	echo "data2" > "${ENCAP_PKGDIR}/etc/file2"

	mkdir -p "${ENCAP_TARGET}"
	mkdir -p "${ENCAP_TARGET}/etc"

	echo "data1" > "${ENCAP_TARGET}/etc/file1"
	echo "changed data2" > ${ENCAP_TARGET}/etc/file2
}

pecan_remove_copied_file_test()
{
	[ -d ${ENCAP_PKGDIR} ] || pecan_remove_copied_file_helper

	pecan_remove_copied_file etc/file1
	pecan_remove_copied_file etc/file2

	retval=0
	if [ -f "${ENCAP_TARGET}/etc/file1" ]; then 
		echo "FAIL: ${ENCAP_TARGET}/etc/file1 exists"
		retval=1
	fi
	if [ -f "${ENCAP_PKGDIR}/etc/file1" ]; then 
		echo "FAIL: ${ENCAP_PKGDIR}/etc/file1 exists"
		retval=1
	fi
	if [ ! -f "${ENCAP_TARGET}/etc/file2" ]; then 
		echo "FAIL: ${ENCAP_TARGET}/etc/file2 doesn't exist"
		retval=1
	fi
	if [ -f "${ENCAP_PKGDIR}/etc/file2" ]; then 
		echo "FAIL: ${ENCAP_PKGDIR}/etc/file2 exists"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_remove_copied_file_test
