#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="group_exists-0"

. ../pecan/pecan_pkg_script.subr

pecan_group_exists_test()
{
	if [ `id -u` != 0 ]; then
		echo 1>&2 "$0: skipping"
		return 0
	fi

	mkdir -p "${ENCAP_PKGDIR}"
	retval=0

	if ! pecan_group_exists wheel; then
		echo "FAIL: \`\`wheel'' doesn't exist"
		retval=1
	fi
	if ! pecan_group_exists wheel 0; then
		echo "FAIL: \`\`wheel == 0'' doesn't exist"
		retval=1
	fi
	if pecan_group_exists _nOnExIsTeNt_; then
		echo "FAIL: \`\`_nOnExIsTeNt_'' exists"
		retval=1
	fi
	if pecan_group_exists wheel 12345; then
		echo "FAIL: \`\`wheel == 12345'' exists"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_group_exists_test
