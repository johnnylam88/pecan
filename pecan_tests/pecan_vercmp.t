#!/bin/sh

. ../pecan/pecan_lib.subr

pecan_vercmp_test_helper()
{
	version1="$1"
	version2="$2"

	pecan_vercmp "$version1" "$version2"
	test_result=$?
	: ${version1:="(null)"}
	: ${version2:="(null)"}
	if test $test_result -eq 2; then
		echo "$version1 < $version2"
	elif test $test_result -eq 0; then
		echo "$version1 = $version2 [FAIL]"
	elif test $test_result -eq 1; then
		echo "$version1 > $version2 [FAIL]"
	fi
}

pecan_vercmp_test()
{
	pecan_vercmp_test_helper 1 1+1
	pecan_vercmp_test_helper 1.0 1.0.1
	pecan_vercmp_test_helper 1.23.2 1.23.11
	pecan_vercmp_test_helper 1.23.0alpha 1.23.0
	pecan_vercmp_test_helper 1.23.0alpha 1.23.0alpha1
	pecan_vercmp_test_helper 1.23.0alpha2 1.23.0alpha11
	pecan_vercmp_test_helper 1.23.0alpha 1.23.0beta
	pecan_vercmp_test_helper 1.23.0alpha 1.23.0rc
	pecan_vercmp_test_helper 1.23.0beta 1.23.0rc
	pecan_vercmp_test_helper 1.23.0alpha 1.23.0e
	pecan_vercmp_test_helper 1.23.0a 1.23.0b
	pecan_vercmp_test_helper 1.23.0a2 1.23.0a11
	pecan_vercmp_test_helper 1.23.0rc1 1.23.0a
	pecan_vercmp_test_helper 1.23.0 1.23.0+1
	pecan_vercmp_test_helper 1.23.0alpha99 1.23.0+1
	pecan_vercmp_test_helper 1.23.0+2 1.23.0+11
	pecan_vercmp_test_helper "*" 1.0
	pecan_vercmp_test_helper "" 1.0
}

pecan_vercmp_test
