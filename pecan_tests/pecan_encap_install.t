#!/bin/sh

PECAN_EPKG_CMD=/nonexistent
PECAN_TARGET="`pwd`/.pecan"
PECAN_SOURCE="${PECAN_TARGET}/pecan"

. ../pecan/pecan_encap.subr
. ../pecan/pecan_lib.subr

pecan_encap_install_test_helper()
{
	pkgdir=${PECAN_SOURCE}/test-pkg-1.0

	mkdir -p ${pkgdir}
	mkdir -p ${pkgdir}/bin
	mkdir -p ${pkgdir}/lib
	mkdir -p ${pkgdir}/share
	mkdir -p ${pkgdir}/share/doc
	mkdir -p ${pkgdir}/share/doc/test-pkg
	mkdir -p ${pkgdir}/share/man
	mkdir -p ${pkgdir}/share/man/man1
	mkdir -p ${pkgdir}/share/man/man3

	touch ${pkgdir}/bin/testprog
	touch ${pkgdir}/lib/libtest.a
	touch ${pkgdir}/lib/libtest.so
	touch ${pkgdir}/lib/libtest.so.1.0
	touch ${pkgdir}/share/doc/test-pkg/README
	touch ${pkgdir}/share/man/man1/testprog.1
	touch ${pkgdir}/share/man/man3/test_func.3

	echo "linkname bin/testprog gnutestprog" > ${pkgdir}/encapinfo
	echo "exclude lib/libtest.so*" >> ${pkgdir}/encapinfo
	echo "linkdir share/doc/test-pkg" >> ${pkgdir}/encapinfo
	echo "linkdir share/man" >> ${pkgdir}/encapinfo

	mkdir -p ${PECAN_TARGET}/share/man
}

pecan_encap_install_test()
{
	[ -d ${PECAN_SOURCE}/test-pkg-1.0 ] || \
		pecan_encap_install_test_helper

	( cd ${PECAN_SOURCE}/test-pkg-1.0 && find . | sort )

	pecan_encap_install test-pkg-1.0

	( cd ${PECAN_TARGET} && find . | grep -v "^[.]/pecan" | sort )

	rm -rf "${PECAN_TARGET}"
}

pecan_encap_install_test
