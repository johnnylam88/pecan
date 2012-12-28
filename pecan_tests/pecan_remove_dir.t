#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"

. ../pecan/pecan_pkg_script.subr

pecan_remove_dir_test()
{
	mkdir -p "${ENCAP_TARGET}"
	mkdir -p "${ENCAP_TARGET}/etc"
	mkdir -p "${ENCAP_TARGET}/etc/dir1"
	mkdir -p "${ENCAP_TARGET}/etc/dir2"
	mkdir -p "${ENCAP_TARGET}/etc/dir3"
	touch "${ENCAP_TARGET}/etc/dir2/file2"

	pecan_remove_dir etc/dir1
	pecan_remove_dir etc/dir2
	pecan_remove_dir etc/dir3

	retval=0
	if [ -d "${ENCAP_TARGET}/etc/dir1" ]; then 
		echo "FAIL: ${ENCAP_TARGET}/etc/dir1 exists"
		retval=1
	fi
	if [ ! -d "${ENCAP_TARGET}/etc/dir2" ]; then 
		echo "FAIL: ${ENCAP_TARGET}/etc/dir2 doesn't exist"
		retval=1
	fi
	if [ -d "${ENCAP_TARGET}/etc/dir3" ]; then 
		echo "FAIL: ${ENCAP_TARGET}/etc/dir3 exists"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_remove_dir_test
