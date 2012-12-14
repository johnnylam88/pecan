#!/bin/sh

PECAN_PKGNAME="cyrus-sasl-2.1.26"

pecan_description="Cyrus Simple Authentication Security Layer (SASL) library"

pecan_prereq_lib=">= gdbm-1.10"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"

pecan_tools_build="libtool"

if [ -f ./pecan.subr ]; then
	. ./pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

# Required on NetBSD<5 since OpenSSL was linked with -pthread and
# SASL uses dlopen() on a shared library that links against OpenSSL.
#
pecan_cflags="${pecan_cflags} -pthread"

# Enable only basic authentication mechanisms to reduce prereqs.
configure_args="${configure_args} --enable-anon"
configure_args="${configure_args} --enable-checkapop"
configure_args="${configure_args} --enable-cram"
configure_args="${configure_args} --enable-digest"
configure_args="${configure_args} --disable-krb4"
configure_args="${configure_args} --disable-gssapi"
configure_args="${configure_args} --disable-ldapdb"
configure_args="${configure_args} --disable-login"
configure_args="${configure_args} --disable-ntlm"
configure_args="${configure_args} --disable-otp"
configure_args="${configure_args} --disable-passdss"
configure_args="${configure_args} --enable-plain"
configure_args="${configure_args} --enable-scram"
configure_args="${configure_args} --disable-sql"
configure_args="${configure_args} --disable-srp"

# Prereqs for shared-secret mechanisms.
configure_args="${configure_args} --with-gdbm"
configure_args="${configure_args} --with-dblib=gdbm"
configure_args="${configure_args} --with-dbpath=${pecan_etcdir}/sasldb2"
configure_args="${configure_args} --with-openssl"
configure_args="${configure_args} --with-rc4"

# Explicitly disable PAM since it's for saslauthd only.
configure_args="${configure_args} --without-pam"

# Path configuration.
configure_args="${configure_args} --with-devrandom=/dev/urandom"
configure_args="${configure_args} --with-authdaemond=${pecan_vardir}/authdaemon/socket"
configure_args="${configure_args} --with-saslauthd=${pecan_vardir}/run/saslauthd"
configure_args="${configure_args} --with-plugindir=${pecan_pkgdir}/lib/sasl2"
configure_args="${configure_args} --with-configdir=${pecan_etcdir}/sasl2"

pecan_gnu_configure_args="${pecan_gnu_configure_args} ${configure_args}"

pecan_post_configure()
{
	# Replace the package's libtool script with our own.
	# Generate a script instead of a symlink to fool `make'.
	#
	pecan_prereq_pkgdir libtool libtool_pkgdir
	( echo "#/bin/sh"
	  echo "exec ${libtool_pkgdir}/bin/libtool \"\$@\""
	) > ${pecan_srcdir}/libtool
	chmod +x ${pecan_srcdir}/libtool
}

# Pass in additional CPPFLAGS.
AM_CPPFLAGS="-DPLUGINPATH=\\\"${PECAN_TARGET}/lib/sasl2:${pecan_pkgdir}/lib/sasl2\\\""
export AM_CPPFLAGS

pecan_post_stage()
{
	cp "${pecan_srcdir}/AUTHORS" "${pecan_stagedir}"
	cp "${pecan_srcdir}/COPYING" "${pecan_stagedir}"
}

pecan_main "$@"
