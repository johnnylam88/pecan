#!/bin/sh

openldap_version=2.4.33
PECAN_PKGNAME="openldap-client-${openldap_version}+4"

pecan_description="Lightweight Directory Access Protocol (LDAP) client & libraries"

pecan_fetch_file="openldap-${openldap_version}.tgz"
pecan_fetch_suffix=".tgz"
pecan_fetch_url=`cat << EOF
	ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/%FILE%
	ftp://gd.tuwien.ac.at/infosys/network/OpenLDAP/openldap-release/%FILE%
	ftp://ftp.dti.ad.jp/pub/net/OpenLDAP/openldap-release/%FILE%
	ftp://sunsite.cnlab-switch.ch/mirror/OpenLDAP/openldap-release/%FILE%
EOF
`

pecan_prereq_lib=">= cyrus-sasl-2.1.12"
pecan_prereq_lib="${pecan_prereq_lib} >= openssl-1.0.1c"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_configure_style="gnu"

# Don't build the slapd(8) server.
configure_args="--disable-slapd"

configure_args="${configure_args} --enable-dynamic"
configure_args="${configure_args} --with-threads"
configure_args="${configure_args} --with-tls=openssl"
configure_args="${configure_args} --without-fetch"

pecan_configure_args="${pecan_configure_args} ${configure_args}"

pecan_post_stage()
{
	echo "exclude etc" >> "${pecan_stage_encapinfo}"
	cp "${pecan_srcdir}/COPYRIGHT" "${pecan_stagedir}"
	cp "${pecan_srcdir}/LICENSE" "${pecan_stagedir}"
}

openldap_sysconfdir="${pecan_pkgdir}/etc/openldap"
pecan_install_args="${pecan_install_args} sysconfdir=${openldap_sysconfdir}"

pecan_post_install()
{
	rm -f "${openldap_sysconfdir}"/*.default
}

pecan_main "$@"
