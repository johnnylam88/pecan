#!/bin/sh

PECAN_PKGNAME="zlib-1.2.7"

pecan_description="gzip-compatible compression library"

pecan_prereq_build="* sed"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_test_style=make

pecan_configure()
{
	( cd "${pecan_srcdir}" && ./configure --prefix="${pecan_pkgdir}" )
}

pecan_post_stage()
{
	sed -e '1,/^Copyright notice:/d' -e '/^If you use/,$d' \
		"${pecan_srcdir}/README" > "${pecan_stagedir}/COPYRIGHT"
}

pecan_main "$@"
