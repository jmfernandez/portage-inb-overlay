# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils virtualx versionator

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0/$(get_version_component_range 1)"
IUSE="test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test" virtualmake
}
