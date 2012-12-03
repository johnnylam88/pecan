divert(-1)
#
#  Definitions for building Sendmail libraries with GNU libtool.
#
divert(0)dnl
include(confBUILDTOOLSDIR`/M4/'bldM4_TYPE_DIR`/links.m4')dnl
bldLIST_PUSH_ITEM(`bldC_PRODUCTS', bldCURRENT_PRODUCT)dnl
bldPUSH_TARGET(bldCURRENT_PRODUCT`.la')dnl
bldPUSH_INSTALL_TARGET(`install-'bldCURRENT_PRODUCT)dnl
bldPUSH_CLEAN_TARGET(bldCURRENT_PRODUCT`-clean')dnl

include(confBUILDTOOLSDIR`/M4/'bldM4_TYPE_DIR`/defines.m4')
divert(bldTARGETS_SECTION)
LIBTOOL=	ifdef(`confLIBTOOL', `confLIBTOOL', `libtool')

# libmilter version using libtool's versioning system.
#
# 1. If the library source code has changed at all since the last update,
#    then increment revision (.c:r:a. becomes .c:r+1:a.).
# 2. If any interfaces have been added, removed, or changed since the last
#    update, increment current, and set revision to 0.
# 3. If any interfaces have been added since the last public release, then
#    increment age.
# 4. If any interfaces have been removed or changed since the last public
#    release, then set age to 0.
#
libmilterLTVERSION=	0:0:0

define(`bldADD_LOBJS', ${$1LOBJS} )dnl
LOBJS=bldFOREACH(`bldADD_LOBJS(', bldC_PRODUCTS)

bldCURRENT_PRODUCT`LOBJS'= bldSUBST_EXTENSIONS(`lo', bldSOURCES) ifdef(`bldLINK_SOURCES', `bldSUBST_EXTENSIONS(`lo', bldLINK_SOURCES)') ${LOBJADD} ${bldCURRENT_PRODUCT`LOBJADD'}

bldCURRENT_PRODUCT.la: ${BEFORE} ${bldCURRENT_PRODUCT`LOBJS'}
	${LIBTOOL} --tag=CC --mode=link ${CCLINK} -o bldCURRENT_PRODUCT.la ${bldCURRENT_PRODUCT`LOBJS'} -rpath ${LIBDIR} -version-info ${bldCURRENT_PRODUCT`LTVERSION'}
ifdef(`bldLINK_SOURCES', `bldMAKE_SOURCE_LINKS(bldLINK_SOURCES)')

install-`'bldCURRENT_PRODUCT: bldCURRENT_PRODUCT.la
ifdef(`bldINSTALLABLE', `	ifdef(`confMKDIR', `if [ ! -d ${DESTDIR}${bldINSTALL_DIR`'LIBDIR} ]; then confMKDIR -p ${DESTDIR}${bldINSTALL_DIR`'LIBDIR}; else :; fi ')
	${LIBTOOL} --mode=install ${INSTALL} -c -o ${LIBOWN} -g ${LIBGRP} -m ${LIBMODE} bldCURRENT_PRODUCT.la ${DESTDIR}${LIBDIR}')

bldCURRENT_PRODUCT-clean:
	${LIBTOOL} --mode=clean rm -f ${LOBJS} bldCURRENT_PRODUCT.la ${MANPAGES}

.SUFFIXES:	.lo
.c.lo:
	${LIBTOOL} --tag=CC --mode=compile ${CC} ${CFLAGS} -c $<

divert(0)
