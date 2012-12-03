#!/bin/sh

sendmail_version=8.14.5
PECAN_PKGNAME="libmilter-${sendmail_version}"

pecan_extract_file="sendmail.${sendmail_version}.tar.gz"
pecan_extract_subdir="sendmail-${sendmail_version}/libmilter"

pecan_description="Sendmail mail filter API (milter)"

pecan_prereq_build="* libtool"
pecan_prereq_build="${pecan_prereq_build} * m4"
pecan_prereq_build="${pecan_prereq_build} * sed"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure()
{
	cd "${pecan_srcdir}"
	(
	  echo "define(\`confDEPEND_TYPE', \`generic')"
	  echo "define(\`confINCLUDEDIR', \`${pecan_pkgdir}/inc\`'lude')"
	  echo "define(\`confINCOWN', \`root')"
	  echo "define(\`confINCGRP', \`wheel')"
	  echo "define(\`confLIBDIR', \`${pecan_pkgdir}/lib')"
	  echo "define(\`confLIBOWN', \`root')"
	  echo "define(\`confLIBGRP', \`wheel')"
	) > ../devtools/Site/site.config.m4

	cp "${pecan_topdir}/libtool.m4" ../devtools/M4/UNIX
	mv -f Makefile.m4 Makefile.m4.presed
	sed -e "/bldPRODUCT_START/s/library/libtool/" \
 		Makefile.m4.presed > Makefile.m4
}

pecan_post_stage()
{
	cp "${pecan_srcdir}/../LICENSE" "${pecan_stagedir}"
}

pecan_main "$@"
