#!/bin/sh

PECAN_PKGNAME="getmail-4.35.0"

pecan_description="Mail retriever from POP3/IMAP4 mailboxes"

pecan_prereq_pkg=">= python-2.6"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

python="${PECAN_TARGET}/bin/python"

pecan_build_style=
pecan_install_style=

pecan_build()
{
	( cd "${pecan_srcdir}" && "${python}" setup.py build )
}

pecan_post_stage()
{
	cp "${pecan_srcdir}/docs/COPYING" "${pecan_stagedir}"
}

pecan_install()
{
	( cd "${pecan_srcdir}" && \
	 "${python}" setup.py install --prefix="${pecan_pkgdir}" )
}

pecan_main "$@"
