#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"

. ../pecan/pecan_pkg_script.subr

pecan_make_dir_test()
{
	if [ `id -u` != 0 ]; then
		echo 1>&2 "$0: skipping"
		return 0
	fi

	mkdir -p "${ENCAP_TARGET}"
	retval=0

	pecan_make_dir dir1
	if [ ! -d "${ENCAP_TARGET}/dir1" ]; then
		echo "FAIL: ${ENCAP_TARGET}/dir1 doesn't exist"
		retval=1
	fi

	pecan_make_dir var/dir2 0700 0 0
	if [ ! -d "${ENCAP_TARGET}/var/dir2" ]; then
		echo "FAIL: ${ENCAP_TARGET}/var/dir2 doesn't exist"
		retval=1
	fi

	/bin/ls -dln "${ENCAP_TARGET}/var/dir2" |
	( read mode x owner group x;
	  if [ "${mode}" != "drwx------" ]; then
		echo "FAIL: ${ENCAP_TARGET}/var/dir2 has mode \`\`${mode}''"
		return 1
	  fi
	  if [ "${owner}" != 0 ]; then
		echo "FAIL: ${ENCAP_TARGET}/var/dir2 has owner \`\`${owner}''"
		return 1
	  fi
	  if [ "${group}" != 0 ]; then
		echo "FAIL: ${ENCAP_TARGET}/var/dir2 has group \`\`${group}''"
		return 1
	  fi
	  return 0 )
	retval2=$?
	if [ "${retval2}" != 0 ]; then
		retval="${retval2}"
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_make_dir_test
