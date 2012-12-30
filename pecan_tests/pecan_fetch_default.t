#!/bin/sh

PECAN_TARGET="`pwd`/.pecan"
PECAN_SOURCE="${PECAN_TARGET}/pecan"
PECAN_DISTDIR="${PECAN_TARGET}/distfiles"

PECAN_PKGNAME="fetch-0"

. ../pecan/pecan_init.subr
. ../pecan/pecan_fetch.subr
. ../pecan/pecan_lib.subr

pecan_fetch_file="fetch-0.tar.gz fetch-extras-0.tar.xz"
pecan_fetch_url="http://uri/download.php?file=%FILE%&mode=binary"
pecan_fetch_file_url="fetch-extras2-0.sh ftp://host/pub/foo.sh"

pecan_fetch_default_test()
{
	mkdir -p "${PECAN_TARGET}"
	mkdir -p "${PECAN_DISTDIR}"

	pecan_init_vars
	pecan_fetch_vars

	pecan_fetch_default
	ls -l "${PECAN_DISTDIR}"

	rm -fr "${PECAN_TARGET}"
}

pecan_fetch_default_test
