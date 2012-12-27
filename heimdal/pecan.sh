#!/bin/sh

PECAN_PKGNAME="heimdal-1.5.2+2"

pecan_description="Heimdal Kerberos 5 implementation"

pecan_prereq_lib="${pecan_prereq_lib} >= gettext-runtime-0.18.1"
pecan_prereq_lib="${pecan_prereq_lib} >= libiconv-1.14"
pecan_prereq_lib="${pecan_prereq_lib} >= ncurses-5.0"
pecan_prereq_lib="${pecan_prereq_lib} >= openldap-client-2.4.33"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"
pecan_prereq_lib="${pecan_prereq_lib} >= readline-6.2"
pecan_prereq_lib="${pecan_prereq_lib} >= sqlite-3.7.14"

pecan_tools_build="grep msgfmt pkg-config sed"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Rename some of Heimdal's applications with common names so they won't
# conflict with other packages or with system applications.
heimdal_transform='s/^ftp/k&/;s/^login/k&/;s/^rcp/k&/;s/^rsh/k&/;s/^su/k&/;s/^telnet/k&/'

pecan_configure_style="gnu"

configure_args="--program-transform-name=${heimdal_transform}"
configure_args="${configure_args} --enable-hdb-openldap-module"
configure_args="${configure_args} --enable-kcm"
configure_args="${configure_args} --enable-pthread-support"

configure_args="${configure_args} --with-hdbdir=${pecan_vardir}/heimdal"
configure_args="${configure_args} --without-hesiod"
configure_args="${configure_args} --without-x"

pecan_pre_configure()
{
	# Heimdal's configure script can't find headers and libraries
	# even if CPPFLAGS and LDFLAGS are correctly set.  Instead it
	# wants the installation prefix of each package.
	#
	pecan_prereq_pkgdir gettext-runtime libintl_pkgdir
	configure_args="${configure_args} --with-libintl=${libintl_pkgdir}"

	pecan_prereq_pkgdir openldap-client openldap_pkgdir
	configure_args="${configure_args} --with-openldap=${openldap_pkgdir}"

	pecan_prereq_pkgdir openssl openssl_pkgdir
	configure_args="${configure_args} --with-openssl=${openssl_pkgdir}"

	pecan_prereq_pkgdir sqlite sqlite_pkgdir
	configure_args="${configure_args} --with-sqlite3=${sqlite_pkgdir}"

	pecan_readline_hack

	pecan_configure_args="${pecan_configure_args} ${configure_args}"

	# Force building Heimdal's compile_et(1).
	COMPILE_ET=no; export COMPILE_ET

	# Fix some places in the Heimdal sources that don't point to the
	# correct Heimdal binaries when exec'ing programs.
	#
	( cd "${pecan_srcdir}" &&
	  for file in \
		appl/rcp/rcp.c appl/rcp/rcp_locl.h \
		appl/rsh/rsh_locl.h appl/telnet/telnetd/telnetd.h
	  do
		mv "$file" "$file.presed" &&
		sed -e '/RSH_PROGRAM/s,rsh,krsh,g' \
		    -e '/PATH_RSH/s,/rsh,/krsh,g' \
		    -e '/_PATH_LOGIN/s,/login,/klogin,g' \
			"$file.presed" > "$file"
	  done )

	# Only install the manpages that don't conflict with OpenSSL.
	( cd "${pecan_srcdir}/doc/doxyout/hcrypto" &&
	  mv manpages manpages.pregrep &&
	  grep -e "/hcrypto_" -e "/page_" manpages.pregrep > manpages )
}

pecan_readline_hack()
{
	pecan_prereq_pkgdir readline readline_pkgdir
	pecan_prereq_pkgdir ncurses ncurses_pkgdir
	configure_args="${configure_args} --with-readline=${readline_pkgdir}"
	configure_args="${configure_args} --with-readline-config=${pecan_tooldir}/bin/readline-config"

	# Heimdal's readline library detection is broken so install a
	# custom readline-config script to tell it what to use..
	#
	cat >"${pecan_tooldir}/bin/readline-config" << EOF
#!/bin/sh
case "\$1" in
--cflags) echo "-I${readline_pkgdir}/include -I${readline_pkgdir}/include/readline" ;;
--libs) echo "-L${readline_pkgdir}/lib -L${ncurses_pkgdir}/lib -lreadline -lncurses" ;;
esac
EOF
	chmod +x "${pecan_tooldir}/bin/readline-config"
}

pecan_test_style="make"

pecan_post_stage()
{
	echo "exclude share/info/dir" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"

	# Install the hdb LDAP schema where slapd(8) can find it.
	mkdir -p "${pecan_stagedir}/etc/openldap/schema"
	cp "${pecan_srcdir}/lib/hdb/hdb.schema" \
		"${pecan_stagedir}/etc/openldap/schema"

	mkdir -p "${pecan_stagedir}/etc/rc.d"
	for file in \
		kadmind.in kcm.in kdc.in kpasswdd.in
	do
		cp "${pecan_topdir}/$file" "${pecan_stagedir}/etc/rc.d"
	done
}

pecan_main "$@"
