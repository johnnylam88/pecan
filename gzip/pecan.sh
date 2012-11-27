#!/bin/sh

PECAN_PKGNAME="gzip-1.2.4b"

pecan_description="GNU compression program"

pecan_extract_file="gzip-1.2.4a.shar"
pecan_extract_suffix=".shar"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# gzip-1.2.4 has a very old GNU configure script.
pecan_configure()
{
	cd "${pecan_srcdir}" && ./configure --prefix="${pecan_pkgdir}"
}

# Make some top-level directories for the install targets.
pecan_pre_install()
{
	mkdir -p "${pecan_pkgdir}"
	mkdir -p "${pecan_pkgdir}/share"
	mkdir -p "${pecan_pkgdir}/share/man"
}

pecan_install_args="${pecan_install_args} infodir=${pecan_pkgdir}/share/info"
pecan_install_args="${pecan_install_args} mandir=${pecan_pkgdir}/share/man/man1"

pecan_test_style=make

pecan_post_stage()
{
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
