# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="Controlador opensc para el DNI electrónico"
HOMEPAGE="http://www.dnie.es/"

HTTPDNIEPRE="http://www.dnielectronico.es/descargas/PKCS11_para_Sistemas_Unix/${PV}.Ubuntu_Karmic_"
HTTPDNIEPOST="/Ubuntu_Karmic_"
DNIESUBREV=2
DOWNDNIEPREF="${PN}_${PV}-${DNIESUBREV}_"
DEBDNIESUBREV=1
DEBDNIEPREF="${PN}_${PV}-${DEBDNIESUBREV}_"
SRC_URI="x86? ( ${HTTPDNIEPRE}32${HTTPDNIEPOST}${DOWNDNIEPREF}i386.tar )
amd64? ( ${HTTPDNIEPRE}64${HTTPDNIEPOST}${DOWNDNIEPREF}amd64.tar )"


LICENSE="DGP"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="<dev-libs/opensc-0.12
		sys-devel/binutils
		app-arch/tar"
RDEPEND="dev-lang/perl
		<dev-libs/opensc-0.12"

src_unpack() {
	if use amd64; then
		ARQ="amd64"
	else
		ARQ="i386"
	fi
	
	# Archive inside an archive inside an archive... too inefficent for my taste
	unpack "${A}"
	unpack "./${DEBDNIEPREF}${ARQ}.deb"
	mkdir -p "$S"
	ln -s "${WORKDIR}/data.tar.gz" "$S"
	cd "$S"
	unpack "./data.tar.gz"
	# Deleting the symlink
	rm data.tar.gz
}

src_compile() {
	# OpenSC configuration file patch
	mkdir etc
	cp /etc/opensc.conf etc
	
	# Is there a previous reader_drivers declaration?
	grep -q $'^[ \t]*reader_drivers' etc/opensc.conf
	if [ $? != 0 ] ; then
		patch -bt etc/opensc.conf ${FILESDIR}/no_reader_driver-opensc.conf.patch
	else
		grep -q $'^[ \t]*reader_drivers[ \t]*=.*dnie' etc/opensc.conf
		if [ $? != 0 ] ; then
			sed -i 's#^\([ \t]*reader_drivers[ \t]*=[^;]*\)\(.*\)$#\1 , dnie\2#' etc/opensc.conf
		fi
	fi
	
	# Is there a previous card_drivers declaration?
	grep -q $'^[ \t]*card_drivers' etc/opensc.conf
	if [ $? != 0 ] ; then
		patch -bt etc/opensc.conf ${FILESDIR}/no_card_driver-opensc.conf.patch
	else
		grep -q $'^[ \t]*card_drivers[ \t]*=.*dnie' etc/opensc.conf
		if [ $? != 0 ] ; then
			sed -i 's#^\([ \t]*card_drivers[ \t]*=[^;]*\)\(.*\)$#\1 , dnie\2#' etc/opensc.conf
		fi
	fi
	
	# Is there a previous card_driver declaration for dnie?
	grep -q $'^[ \t]*card_driver[ \t]\+dnie' etc/opensc.conf
	if [ $? != 0 ] ; then
		patch -bt etc/opensc.conf ${FILESDIR}/no_card_driver-opensc.conf.patch
	fi
	
	# OpenSC version patch dynamic library
	cp usr/lib/libopensc-dnie.so.1.0.3 "${T}"/libopensc-dnie.so.1.0.3.orig
	cd "$T"
	gcc -fpic -g -c -Wall "${FILESDIR}"/versionpatch.c
	objcopy --redefine-sym sc_driver_version=orig_sc_driver_version	libopensc-dnie.so.1.0.3.orig libopensc-dnie.so.1.0.3
	cp -p libopensc-dnie.so.1.0.3 "${S}"/usr/lib/
	gcc -shared -Wl,-soname,libwrapper-dnie.so libopensc-dnie.so.1.0.3 -lopensc versionpatch.o -o "${S}"/usr/lib/libwrapper-dnie.so.1.0.0
}

src_install() {
	dolib usr/lib/libwrapper-dnie.so.1.0.0 usr/lib/libopensc-dnie.so.1.0.3
	dodoc usr/share/doc/${PN}/*
	
	insinto /usr/share
	doins -r usr/share/locale usr/share/${PN}
	
	insinto /etc
	doins etc/opensc.conf
}
