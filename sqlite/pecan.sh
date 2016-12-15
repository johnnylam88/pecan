#!/bin/sh

PECAN_PKGNAME="sqlite-3.7.15.1+2"

pecan_description="Server-less, transactional SQL database engine"

pecan_fetch_file="sqlite-autoconf-3071501.tar.gz"
pecan_fetch_url="http://sqlite.org/%FILE%"

pecan_abi_version="3.7.15"
pecan_api_version="3.0.8"

pecan_prereq_lib=">= ncurses-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= readline-2.2"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_cppflags="-DSQLITE_ENABLE_COLUMN_METADATA=1"

pecan_configure_style="gnu"
pecan_test_style=make
pecan_test_style=test

pecan_main "$@"
