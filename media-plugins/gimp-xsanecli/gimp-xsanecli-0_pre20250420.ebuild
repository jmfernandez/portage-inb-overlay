# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# inherit toolchain-funcs

DESCRIPTION="GIMP 3.0 plug-in for scanning via XSane"
HOMEPAGE="https://yingtongli.me/git/gimp-xsanecli"
COMMIT="d4fa7e8afcc5a86e00263d4d71e2279cf295ec02"
SRC_URI="
	https://yingtongli.me/git/gimp-xsanecli/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
"

# License at the end of README.md
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	media-gfx/gimp:0/3
	media-gfx/xsane
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	default

	local plugindir gimptool=( "${ESYSROOT}"/usr/bin/gimptool* )
	if [[ ${#gimptool[@]} -gt 0 ]]; then
		plugindir="$("${gimptool[0]}" --gimpplugindir)/plug-ins"
	else
		die "Can't find GIMP plugin directory."
	fi
	insinto "${plugindir}/${PN}"
	insopts -m755
	doins xsanecli.py
}
