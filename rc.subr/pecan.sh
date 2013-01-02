#!/bin/sh

# This package tracks pkgsrc/pkgtools/rc.subr.

PECAN_PKGNAME="rc.subr-20090118+3"

pecan_description="Portable implementation of the NetBSD rc.d subsystem"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_fetch=:

pecan_extract()
{
	mkdir -p "${pecan_srcdir}"
	cp -R "${pecan_topdir}/files/"* "${pecan_srcdir}"
}

pecan_configure=:
pecan_build=:

pecan_post_stage()
{
	echo "exclude etc" >> "${pecan_stage_encapinfo}"
	sed -e '1,/#[ 	]*$/d' -e '/^# rc.subr/,$d' \
		"${pecan_srcdir}/rc.subr" > "${pecan_stagedir}/COPYRIGHT"
}

pecan_install()
{
	mkdir -p "${pecan_pkgdir}/etc"
	( cd "${pecan_srcdir}" &&
	  cp rc.subr "${pecan_pkgdir}/etc" &&
	  cp rc.conf.example "${pecan_pkgdir}/etc/rc.conf" )

	mkdir -p "${pecan_pkgdir}/etc/rc.d"
	cp -R "${pecan_srcdir}/rc.d/"* "${pecan_pkgdir}/etc/rc.d"

	mkdir -p "${pecan_mandir}/man8"
	cp "${pecan_srcdir}/rc.subr.8" "${pecan_mandir}/man8"
}

pecan_main "$@"
