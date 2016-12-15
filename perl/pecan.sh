#!/bin/sh

PECAN_PKGNAME="perl-5.24.0+1"

pecan_description="Perl 5 scripting language interpreter"

pecan_fetch_url="http://www.cpan.org/src/5.0/%FILE%"

pecan_abi_version="5.24.0"
pecan_api_version="5.005"

pecan_tools_build="sed"

if [ -f ./pecan/pecan.subr ]; then
	. ./pecan/pecan.subr
elif [ -f ../pecan/pecan.subr ]; then
	. ../pecan/pecan.subr
else
	exit 1
fi

pecan_post_extract()
{
	sed -e "s,@prefix@,${pecan_pkgdir},g" \
	    -e "s,@siteprefix@,${PECAN_TARGET},g" \
	    -e "s,@vendorprefix@,${PECAN_TARGET},g" \
	    -e "s|@ldflags@|${pecan_ldflags}|g" \
		Policy.sh.in > "${pecan_srcdir}/Policy.sh"
}

pecan_configure()
{
	( cd "${pecan_srcdir}" && ./Configure -des )
}

pecan_post_stage()
{
	echo "linkdir lib/perl5/${pecan_swver}" >> "${pecan_stage_encapinfo}"
}

pecan_test_style=make
pecan_test_target=test

pecan_main "$@"
