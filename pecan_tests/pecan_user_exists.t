#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="user_exists-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_user_exists_test()
{
	if [ `id -u` != 0 ]; then
		echo 1>&2 "$0: skipping"
		return 0
	fi

	mkdir -p "${ENCAP_PKGDIR}"
	retval=0

	if ! pecan_user_exists root; then
		echo "FAIL: \`\`root'' doesn't exist"
		retval=1
	fi
	if ! pecan_user_exists root 0; then
		echo "FAIL: \`\`root == 0'' doesn't exist"
		retval=1
	fi
	if pecan_user_exists _nOnExIsTeNt_; then
		echo "FAIL: \`\`_nOnExIsTeNt_'' exists"
		retval=1
	fi
	if pecan_user_exists root 12345; then
		echo "FAIL: \`\`root == 12345'' exists"
		retval=1
	fi
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_user_exists_test
