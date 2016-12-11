#!/bin/sh

PECAN_PKGNAME="zlib-1.2.8"

pecan_description="gzip-compatible compression library"

pecan_fetch_url="http://zlib.net/%FILE%"

pecan_tools_build="sed"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
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
