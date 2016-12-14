#!/bin/sh

PECAN_PKGNAME="python-2.7.3+2"

pecan_description="Python 2.x scripting langauge interpreter"

pecan_fetch_file=Python-2.7.3.tgz
pecan_fetch_url="http://python.org/download/releases/2.7.3/%FILE%"
pecan_fetch_suffix=.tgz

pecan_prereq_lib=">= bzip2-1.0.1"
pecan_prereq_lib="${pecan_prereq_lib} >= expat-1.95.7"
pecan_prereq_lib="${pecan_prereq_lib} >= gdbm-1.8.3"
pecan_prereq_lib="${pecan_prereq_lib} >= gettext-runtime-0.18"
pecan_prereq_lib="${pecan_prereq_lib} >= libffi-1.20"
pecan_prereq_lib="${pecan_prereq_lib} >= ncurses-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"
pecan_prereq_lib="${pecan_prereq_lib} >= readline-2.2"
pecan_prereq_lib="${pecan_prereq_lib} >= sqlite-2.8.0"
pecan_prereq_lib="${pecan_prereq_lib} >= zlib-1.2.3"

pecan_tools_build="pkg-config"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Allow extensions to find -lpython in ${pecan_srcdir} during linking.
pecan_ldflags="-L${pecan_srcdir} ${pecan_ldflags}"

python_sitedir="lib/python2.7/site-packages"

pecan_configure_style="gnu"
pecan_configure_args="${pecan_configure_args} --enable-shared"
pecan_configure_args="${pecan_configure_args} --with-system-expat"
pecan_configure_args="${pecan_configure_args} --with-system-ffi"
pecan_configure_args="${pecan_configure_args} --with-threads"

pecan_test_style=make
pecan_test_target=check

pecan_post_install()
{
	# Add site directory in ${PECAN_TARGET} to the module search path.
	echo "${PECAN_TARGET}/${python_sitedir}" \
		> "${pecan_pkgdir}/${python_sitedir}/pecan.pth"

	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"

	# Fix up permissions after installation is complete so that `clean'
	# works properly as an unprivileged user.
	#
	chmod -R ugo+rw "${pecan_srcdir}/Lib"
}

pecan_main "$@"
