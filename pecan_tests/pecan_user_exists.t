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
	if pecan_user_exists root; then
		echo "user \`\`root'' exists!"
	fi
	if pecan_user_exists root 0; then
		echo "user \`\`root == 0'' exists!"
	fi
	if ! pecan_user_exists _nOnExIsTeNt_; then
		echo "user \`\`_nOnExIsTeNt_'' does not exist"
	fi
	if ! pecan_user_exists root 12345; then
		echo "user \`\`root == 12345'' does not exist"
	fi

	rm -fr "${ENCAP_TARGET}"
}

pecan_user_exists_test
