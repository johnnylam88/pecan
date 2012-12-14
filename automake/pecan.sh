#!/bin/sh

PECAN_PKGNAME="automake-1.12.5"

pecan_description="GNU automatic Makefile.in generation"

pecan_prereq_pkg=">= autoconf-2.62"

pecan_tools_build="perl sed"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_pre_configure()
{
	# Add ${PECAN_TARGET}/share/aclocal to the m4 search path.
	( cd "${pecan_srcdir}" &&
	  mv aclocal.in aclocal.in.presed &&
	  sed -e "/system_includes/s|@datadir@|${PECAN_TARGET}/share|" \
		aclocal.in.presed > aclocal.in )
}

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
