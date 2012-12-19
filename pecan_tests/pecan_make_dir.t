#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"

. ../pecan/pecan_pkg_script.tmpl

pecan_make_dir_test()
{
	mkdir -p "${ENCAP_TARGET}"
	pecan_make_dir etc/rc.d
	if [ -d "${ENCAP_TARGET}/etc/rc.d" ]; then
		echo "${ENCAP_TARGET}/etc/rc.d exists!"
	fi

	pecan_make_dir var/test 0700
	if [ -d "${ENCAP_TARGET}/var/test" ]; then
		echo "${ENCAP_TARGET}/var/test exists!"
		/bin/ls -dln "${ENCAP_TARGET}/var/test" |
		( read mode x; echo $mode )
	fi

	rm -fr "${ENCAP_TARGET}"
}

pecan_make_dir_test
