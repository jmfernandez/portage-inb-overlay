# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

DESCRIPTION="Graphical front-end for pam-bioapi"
HOMEPAGE="http://code.google.com/p/pam-bioapi/"
SRC_URI="http://pam-bioapi.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=gnome-base/libglade-2
>=gnome-base/libgnome-2
>=gnome-base/libgnomeui-2"
RDEPEND="${DEPEND}
>=sys-auth/pam_bioapi-0.4.0"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
