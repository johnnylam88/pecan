#!/bin/sh

PECAN_PKGNAME="ncurses-5.9"

pecan_description="SVr4-compatible curses library"

pecan_fetch_url="http://ftp.gnu.org/gnu/ncurses/%FILE%"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"
configure_args="${configure_args} --with-shared"
configure_args="${configure_args} --with-termlib=termcap"
configure_args="${configure_args} --without-debug"
configure_args="${configure_args} --without-ada"
configure_args="${configure_args} --enable-overwrite"
configure_args="${configure_args} --enable-rpath"
configure_args="${configure_args} --enable-pc-files"
configure_args="${configure_args} --enable-bsdpad"

pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	echo "linkdir share/terminfo" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/AUTHORS" "${pecan_stagedir}"
}

pecan_main "$@"
