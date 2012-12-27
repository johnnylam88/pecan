#!/bin/sh

ENCAP_TARGET="`pwd`/.pecan"
ENCAP_SOURCE="${ENCAP_TARGET}/pecan"
ENCAP_PKGNAME="copy_file-0"

. ../pecan/pecan_pkg_script.tmpl

pecan_copy_file_helper()
{
	mkdir -p ${ENCAP_PKGDIR}
	mkdir -p ${ENCAP_PKGDIR}/etc
	mkdir -p ${ENCAP_PKGDIR}/var

	touch ${ENCAP_PKGDIR}/etc/file1
	touch ${ENCAP_PKGDIR}/var/file2

	mkdir -p ${ENCAP_TARGET}
	mkdir -p ${ENCAP_TARGET}/etc
	mkdir -p ${ENCAP_TARGET}/var
	touch ${ENCAP_TARGET}/var/file2
}

pecan_copy_file_test()
{
	[ -d ${ENCAP_PKGDIR} ] || pecan_copy_file_helper

	( find ${ENCAP_TARGET} | grep -v "^${ENCAP_TARGET}/[.]out_*";
	  echo ${ENCAP_TARGET}/etc/file1 ) |
	sort > "${ENCAP_TARGET}/.out_pre1"
	pecan_copy_file etc/file1 &&
	( find ${ENCAP_TARGET} | grep -v "^${ENCAP_TARGET}/[.]out_*" ) |
	sort > "${ENCAP_TARGET}/.out_post1"

	if cmp -s "${ENCAP_TARGET}/.out_pre1" \
		  "${ENCAP_TARGET}/.out_post1"; then
		( find ${ENCAP_TARGET} | grep -v "^${ENCAP_TARGET}/[.]out_*" ) |
		sort > "${ENCAP_TARGET}/.out_pre2"
		pecan_copy_file var/file2 &&
		( find ${ENCAP_TARGET} | grep -v "^${ENCAP_TARGET}/[.]out_*" ) |
		sort > "${ENCAP_TARGET}/.out_post2"
		
		if cmp -s "${ENCAP_TARGET}/.out_pre2" \
			  "${ENCAP_TARGET}/.out_post2"; then
			echo "success"
			retval=0
		else
			echo "FAIL: 2" 
			cat "${ENCAP_TARGET}/.out_pre2"
			cat "${ENCAP_TARGET}/.out_post2"
			retval=1
		fi
	else
		echo "FAIL: 1"
		cat "${ENCAP_TARGET}/.out_pre1"
		cat "${ENCAP_TARGET}/.out_post1"
		retval=1
	fi

	rm -fr "${ENCAP_TARGET}"
	return ${retval}
}

pecan_copy_file_test
