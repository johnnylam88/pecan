#!/bin/sh

PECAN_PKGNAME="pdksh-5.2.14"

pecan_description="Public Domain Korn Shell"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="--program-transform-name='s/^ksh/pdksh/'"
pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_post_stage()
{
	cp "${pecan_srcdir}/LEGAL" "${pecan_stagedir}"
}

pecan_install_args="${pecan_install_args} mandir=${pecan_mandir}/man1"

pecan_main "$@"
