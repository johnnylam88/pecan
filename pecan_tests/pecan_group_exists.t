#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="group_exists-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_group_exists_test()
{
	if [ `id -u` != 0 ]; then
		echo 1>&2 "$0: skipping"
		return 0
	fi

	mkdir -p "${ENCAP_PKGDIR}"
	if pecan_group_exists wheel; then
		echo "group \`\`wheel'' exists!"
	fi
	if pecan_group_exists wheel 0; then
		echo "group \`\`wheel == 0'' exists!"
	fi
	if ! pecan_group_exists _nOnExIsTeNt_; then
		echo "group \`\`_nOnExIsTeNt_'' does not exist"
	fi
	if ! pecan_group_exists wheel 12345; then
		echo "group \`\`wheel == 12345'' does not exist"
	fi

	rm -fr "${ENCAP_TARGET}"
}

pecan_group_exists_test
