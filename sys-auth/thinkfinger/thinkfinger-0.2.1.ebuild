# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils pam

DESCRIPTION="A driver for the SGS Thomson Microelectronics fingerprint reader found in most IBM/Lenovo ThinkPads."
HOMEPAGE="http://sourceforge.net/projects/thinkfinger"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.99"

src_compile() {
	econf --with-securedir=$(getpam_mod_dir) \
			|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	# .bir file loaction
	dodir /etc/pam_thinkfinger
	keepdir /etc/pam_thinkfinger

	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	elog "Use tf-tool --acquire to take a finger print"
	elog "tf-tool will write the finger print file to /tmp/test.bir"
	elog "move /tmp/test.bir to /etc/pam_thinkfinger/{USER_NAME}.bir"
	elog ""
	elog "add the following to /etc/pam.d/system-auth after pam_env.so"
	elog "auth     sufficient     pam_thinkfinger.so"
	elog ""
	elog "Your system-auth should look similar to:"
	elog "auth     required     pam_env.so"
	elog "auth     sufficient   pam_thinkfinger.so"
	elog "auth     sufficient   pam_unix.so try_first_pass likeauth nullok"
}

