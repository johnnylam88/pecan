#!/bin/sh

PECAN_PKGNAME="readline-6.2+2"

pecan_description="GNU command-line editing library"

pecan_fetch_url="http://ftp.gnu.org/gnu/readline/%FILE%"

pecan_abi_version="6.0"
pecan_api_version="2.2"

pecan_prereq_lib=">= ncurses-5.0"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Readline distribution patches say "apply with ``patch -p0''" in the header.
pecan_patchdist_opts="-p0"

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --with-curses"

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_post_install()
{
	# Remove empty `bin' directory.
	rmdir "${pecan_pkgdir}/bin"
}

pecan_main "$@"
