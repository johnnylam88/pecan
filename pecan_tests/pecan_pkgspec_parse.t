#!/bin/sh

. ../pecan/pecan_lib.subr

pecan_pkgspec_parse_test_helper()
{
	test_pkgspec="$1"
	pecan_pkgspec_parse $test_pkgspec test_pkgname test_version
	echo "$test_pkgspec: <$test_pkgname, $test_version>"
}

pecan_pkgspec_parse_test()
{
	pecan_pkgspec_parse_test_helper zlib-1.2.7
	pecan_pkgspec_parse_test_helper perl-5.005
	pecan_pkgspec_parse_test_helper png-1.2.8c
	pecan_pkgspec_parse_test_helper openssl-0.9.9g+10
	pecan_pkgspec_parse_test_helper pkg-config-0.27
	pecan_pkgspec_parse_test_helper "foo-*"
}

pecan_pkgspec_parse_test
