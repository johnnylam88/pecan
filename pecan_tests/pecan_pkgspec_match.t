#!/bin/sh

PECAN_TARGET="`pwd`/.pecan"
PECAN_SOURCE="${PECAN_TARGET}/pecan"

. ../pecan/pecan_lib.subr

pecan_pkgspec_match_test_helper()
{
	if pecan_pkgspec_match "$1" "$2" test_result; then
		echo "\`$1 $2' best match is $test_result."
	else
		echo "\`$1 $2' does not match any package."
	fi
}

pecan_pkgspec_match_test()
{
	mkdir -p ${PECAN_SOURCE}
	mkdir -p ${PECAN_SOURCE}/zlib-1.2.1
	mkdir -p ${PECAN_SOURCE}/zlib-1.2.5
	mkdir -p ${PECAN_SOURCE}/zlib-1.2.7

	pecan_pkgspec_match_test_helper "=" "zlib-1.2.3" 
	pecan_pkgspec_match_test_helper "<" "zlib-1.2.3" 
	pecan_pkgspec_match_test_helper "*" "zlib-1.2.3" 
	pecan_pkgspec_match_test_helper "*" "zlib-*" 
	pecan_pkgspec_match_test_helper "<=" "zlib-1.2.5" 
	pecan_pkgspec_match_test_helper ">=" "zlib-1.2.5" 

	rm -rf "${PECAN_TARGET}"
}

pecan_pkgspec_match_test
