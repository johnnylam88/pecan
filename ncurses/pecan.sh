#!/bin/sh

PECAN_PKGNAME="ncurses-5.9"

pecan_description="SVr4-compatible curses library"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

configure_args="${configure_args} --with-shared"
configure_args="${configure_args} --with-termlib=termcap"
configure_args="${configure_args} --without-debug"
configure_args="${configure_args} --without-ada"
configure_args="${configure_args} --enable-overwrite"
configure_args="${configure_args} --enable-rpath"
configure_args="${configure_args} --enable-pc-files"
configure_args="${configure_args} --enable-bsdpad"

pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_post_stage()
{
	echo "linkdir share/terminfo" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/AUTHORS" "${pecan_stagedir}"
}

pecan_main "$@"
