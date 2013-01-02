#!/bin/sh

PECAN_PKGNAME="gzip-1.2.4a+1"

pecan_description="GNU compression program"

pecan_fetch_url="http://ftp.gnu.org/gnu/gzip/%FILE%"
pecan_fetch_suffix=".shar"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"

# gzip-1.2.4 has a very old GNU configure script.
pecan_configure()
{
	( cd "${pecan_srcdir}" && ./configure --prefix="${pecan_pkgdir}" )
}

# Make some top-level directories for the install targets.
pecan_pre_install()
{
	mkdir -p "${pecan_pkgdir}"
	mkdir -p "${pecan_pkgdir}/bin"
	mkdir -p "${pecan_pkgdir}/share"
	mkdir -p "${pecan_pkgdir}/share/info"
	mkdir -p "${pecan_pkgdir}/share/man"
	mkdir -p "${pecan_pkgdir}/share/man/man1"
}

pecan_install_target="installbin installman"
pecan_install_args="${pecan_install_args} infodir=${pecan_pkgdir}/share/info"
pecan_install_args="${pecan_install_args} mandir=${pecan_pkgdir}/share/man/man1"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
