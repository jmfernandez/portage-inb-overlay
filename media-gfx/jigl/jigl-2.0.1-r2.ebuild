# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit eutils

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

# Short one-line description of this package.
DESCRIPTION="jigl - Jason's Image Gallery: a static photo gallery generator with EXIF capabilities"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://xome.net/projects/jigl/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="
	http://xome.net/projects/jigl/${P}.tar.gz
	http://xome.net/projects/jigl/patch-jigl-vs.txt -> jigl-vs-${PV}.patch
"

# License of the package. This must match the name of file(s) in
# /usr/portage/licenses/. For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

# Comprehensive list of any and all USE flags leveraged in the ebuild,
# with the exception of any ARCH specific flags, i.e. "ppc", "sparc",
# "x86" and "alpha". This is a required variable. If the
# ebuild doesn't use any USE flags, set to "".
IUSE=""

# Build-time dependencies, such as
#    ssl? ( >=dev-libs/openssl-0.9.6b )
#    >=dev-lang/perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="dev-lang/perl:=
	media-gfx/imagemagick
	>=media-gfx/jhead-2.0"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_unpack() {
	default
	# Formatting the patch header according to what eapply prefers
	sed "s#/usr/bin/jigl#jigl-vs#;s#jigl-vs#jigl-${PV}/jigl-vs.pl#" "${DISTDIR}"/jigl-vs-${PV}.patch > "${WORKDIR}"/jigl-vs.patch
}

src_prepare() {
	default
	cp jigl.pl jigl-vs.pl
	eapply "${WORKDIR}"/jigl-vs.patch
}

src_compile() {
	for p in jigl.pl jigl-vs.pl ; do
		perl -c "$p" || die "perl checking $p failed"
	done
}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.

	dodoc ChangeLog INSTALL Themes Todo UPGRADING
	newbin jigl.pl jigl
	newbin jigl-vs.pl jigl-vs
}
