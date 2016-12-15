#!/bin/sh

sendmail_version=8.14.5
PECAN_PKGNAME="libmilter-${sendmail_version}"

pecan_description="Sendmail mail filter API (milter)"

pecan_fetch_file="sendmail.${sendmail_version}.tar.gz"
pecan_fetch_url="ftp://ftp.sendmail.org/pub/sendmail/%FILE%"

pecan_api_version="8.14"

pecan_extract_subdir="sendmail-${sendmail_version}/libmilter"

pecan_tools_build="libtool m4 sed"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure()
{
	( echo "define(\`confDEPEND_TYPE', \`generic')"
	  echo "define(\`confINCLUDEDIR', \`${pecan_pkgdir}/inc\`'lude')"
	  echo "define(\`confINCOWN', \`root')"
	  echo "define(\`confINCGRP', \`wheel')"
	  echo "define(\`confLIBDIR', \`${pecan_pkgdir}/lib')"
	  echo "define(\`confLIBOWN', \`root')"
	  echo "define(\`confLIBGRP', \`wheel')"
	) > "${pecan_srcdir}/../devtools/Site/site.config.m4"

	cp "${pecan_topdir}/libtool.m4" "${pecan_srcdir}/../devtools/M4/UNIX"
	mv -f "${pecan_srcdir}/Makefile.m4" "${pecan_srcdir}/Makefile.m4.presed"
	sed -e "/bldPRODUCT_START/s/library/libtool/" \
 		"${pecan_srcdir}/Makefile.m4.presed" \
		> "${pecan_srcdir}/Makefile.m4"
}

pecan_post_stage()
{
	cp "${pecan_srcdir}/../LICENSE" "${pecan_stagedir}"
}

pecan_main "$@"
