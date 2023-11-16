# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#FONT_SUFFIX="otf"
MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

inherit font

DESCRIPTION="The Monaspace type system is a monospaced type superfamily with some modern tricks up its sleeve. It consists of five variable axis typefaces. Each one has a distinct voice, but they are all metrics-compatible with one another, allowing you to mix and match them for a more expressive typographical palette."
HOMEPAGE="https://monaspace.githubnext.com/"
SRC_URI="https://github.com/githubnext/monaspace/releases/download/${MY_PV}/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"

BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_P}/fonts/otf"
FONT_S="${S}"
FONT_SUFFIX="otf"

