#!/bin/sh

PECAN_PKGNAME="pkg-config-0.27.1"

pecan_description="Utility that details how to compile and link against a library"

pecan_fetch_url="http://pkgconfig.freedesktop.org/releases/%FILE%"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="--with-internal-glib"
configure_args="${configure_args} --with-pc-path=${PECAN_TARGET}/lib/pkgconfig"

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
