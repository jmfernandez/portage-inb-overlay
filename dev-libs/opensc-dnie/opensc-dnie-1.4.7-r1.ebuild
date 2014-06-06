# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools libtool multilib eutils

DESCRIPTION="Controlador opensc para el DNI electrónico"
HOMEPAGE="http://www.dnie.es/"

SRC_URI="http://www.dnielectronico.es/descargas/codigo_fuente_pkcs11/src.zip"


LICENSE="DGP"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="<dev-libs/opensc-0.12
	dev-libs/glib:2
	>=dev-libs/libassuan-2.0.0
	sys-libs/zlib
	dev-libs/openssl:0.9.8
	"
DEPEND="${RDEPEND}"

src_unpack() {
	# Archive inside an archive inside an archive... too inefficent for my taste
	mkdir -p "$S"
	cd "$S"
	unpack "${A}"
}

src_prepare() {
	cp "${FILESDIR}"/Makefile.am "${FILESDIR}"/configure.ac .
	cp "${FILESDIR}"/keys.inc src/libcard
	for PATCH in opensc-dnie-keys.patch opensc-dnie-build.patch \
		opensc-dnie-opensc_version.patch opensc-dnie-assuan2.patch ;do
		epatch "${FILESDIR}"/patches/"$PATCH" || die
	done

	touch NEWS README AUTHORS ChangeLog
	ln -s src/license COPYING
	
#	libtoolize || die
#	aclocal || die
#	autoheader || die
#	autoconf || die 
#	automake --add-missing || die
	
	mkdir -p m4
	eautoreconf
}

src_configure() {
	econf --disable-static || die
}

src_compile() {
	emake

	${CC:-gcc} ${CFLAGS} -DLIBDIR=\"/usr/$(get_libdir)\" -o opensc-add_dnie "${FILESDIR}"/opensc-add_dnie.c -lscconf || die
	# OpenSC configuration file patch
	mkdir -p etc
	cp /etc/opensc.conf etc

	./opensc-add_dnie etc/opensc.conf || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto /etc
	doins etc/opensc.conf
}
