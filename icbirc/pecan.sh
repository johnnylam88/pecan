#!/bin/sh

PECAN_PKGNAME="icbirc-1.8"

pecan_description="Proxy IRC client and ICB server"

pecan_extract_subdir="icbirc"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# ``icbirc'' has a simplistic build and install process, so just
# do it ourselves in pecan_build() and pecan_install() hooks.

pecan_configure=:

pecan_build()
{
	( cd "${pecan_srcdir}"
	  cc ${pecan_cflags} ${pecan_cppflags} -c icbirc.c
	  cc ${pecan_cflags} ${pecan_cppflags} -c icb.c
	  cc ${pecan_cflags} ${pecan_cppflags} -c irc.c
	  cc ${pecan_ldflags} -o icbirc *.o )
}

pecan_post_stage()
{
	sed -e '1,/^[/][*]/d' -e '/^ [*][/]/,$d' -e 's/^ *[*]//' \
		"${pecan_srcdir}/icbirc.c" > "${pecan_stagedir}/COPYRIGHT"
}

pecan_install()
{
	mkdir -p "${pecan_pkgdir}/bin"
	cp "${pecan_srcdir}/icbirc" "${pecan_pkgdir}/bin"
	mkdir -p "${pecan_pkgdir}/share/man/man8"
	cp "${pecan_srcdir}/icbirc.8" "${pecan_pkgdir}/share/man/man8"
}

pecan_main "$@"
