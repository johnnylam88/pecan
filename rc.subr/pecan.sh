#!/bin/sh

# This package tracks pkgsrc/pkgtools/rc.subr.

PECAN_PKGNAME="rc.subr-20090118"

pecan_description="Portable implementation of the NetBSD rc.d subsystem"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_extract()
{
	mkdir -p "${pecan_srcdir}"
	cp -R "${pecan_topdir}/files/"* "${pecan_srcdir}"
}

pecan_configure=:
pecan_build=:

pecan_post_stage()
{
	sed -e '1,/#[ 	]*$/d' -e '/^# rc.subr/,$d' \
		"${pecan_srcdir}/rc.subr" > "${pecan_stagedir}/COPYRIGHT"
}

rc_subr_exampledir="${pecan_pkgdir}/share/examples/rc.subr"

pecan_install()
{
	mkdir -p "${rc_subr_exampledir}"
	( cd "${pecan_srcdir}" &&
	  cp rc.subr "${rc_subr_exampledir}" &&
	  cp rc.conf.example "${rc_subr_exampledir}/rc.conf" )

	mkdir -p "${pecan_pkgdir}/share/examples/rc.d"
	cp -R "${pecan_srcdir}/rc.d/"* "${pecan_pkgdir}/share/examples/rc.d"
}

pecan_main "$@"
