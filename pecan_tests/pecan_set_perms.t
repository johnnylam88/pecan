#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"

. ../pecan/pecan_pkg_script.subr

pecan_set_perms_test()
{
	if [ `id -u` != 0 ]; then
		echo 1>&2 "$0: skipping"
		return 0
	fi

	mkdir -p "${ENCAP_TARGET}"
	if [ ! -f "${ENCAP_TARGET}/file1" ]; then
		touch "${ENCAP_TARGET}/file1"
	fi

	pecan_set_perms ${ENCAP_TARGET}/file1 0600 0 0
	/bin/ls -ln "${ENCAP_TARGET}/file1" |
	( read mode x owner group x &&
	  echo "perms: ${mode} ${owner} ${group}" &&
	  [ "${mode}" = "-rw-------" ] &&
	  [ "${owner}" = 0 ] &&
	  [ "${group}" = 0 ] &&
	  echo "success" && return 0;
	  echo "FAIL" && return 1 )
	retval=$?

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_set_perms_test
