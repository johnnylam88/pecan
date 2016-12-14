#!/bin/sh

PECAN_PKGNAME="pdksh-5.2.14+2"

pecan_description="Public Domain Korn Shell"

pecan_fetch_url=`cat << EOF
	ftp://ftp.lip6.fr/pub/unix/shells/pdksh/%FILE%
	https://fossies.org/linux/misc/old/%FILE%
	http://gd.tuwien.ac.at/utils/shells/pdksh/%FILE%
EOF
`

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
configure_args="--program-transform-name='s/^ksh/pdksh/'"
pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	cp "${pecan_srcdir}/LEGAL" "${pecan_stagedir}"
}

pecan_install_args="${pecan_install_args} mandir=${pecan_mandir}/man1"

pecan_main "$@"
