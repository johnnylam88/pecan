#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"

. ../pecan/pecan_lib.subr

encapinfo_path="${ENCAP_TARGET}/encapinfo"
pecan_abi_version="1.2.3"
pecan_description="unit test for pecan_encapinfo_lookup()"

pecan_encapinfo_lookup_helper()
{
	mkdir -p ${ENCAP_TARGET}
	cat > "${encapinfo_path}" <<EOF
date `date`
abi_version ${pecan_abi_version}
description ${pecan_description}
EOF
}

pecan_encapinfo_lookup_test()
{
	[ -d ${ENCAP_TARGET} ] || pecan_encapinfo_lookup_helper

	retval=0
	pecan_encapinfo_lookup "${encapinfo_path}" abi_version var1
	[ "$var1" = "${pecan_abi_version}" ] || retval=1
	pecan_encapinfo_lookup "${encapinfo_path}" description var2
	[ "$var2" = "${pecan_description}" ] || retval=2
	pecan_encapinfo_lookup "${encapinfo_path}" missing var3
	[ -z "$var3" ] || retval=3
	if [ "${retval}" = 0 ]; then
		echo "success"
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_encapinfo_lookup_test
