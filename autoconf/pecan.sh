#!/bin/sh

PECAN_PKGNAME="autoconf-2.69"

pecan_description="GNU automatic source configuration system"

pecan_prereq_pkg=">= m4-1.4.16"

pecan_tools_build="sed"
pecan_tools_pkg="perl"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_pre_configure()
{
	# Add ${PECAN_TARGET}/share/autoconf to the m4 search path.
	( cd "${pecan_srcdir}/bin" &&
	  mv autom4te.in autom4te.in.presed &&
	  sed -e "s|^my [@]include|my @include = (\"${PECAN_TARGET}/share/autoconf\")|" autom4te.in.presed > autom4te.in )
}

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING.EXCEPTION" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYINGv3" "${pecan_stagedir}"
}

pecan_main "$@"
