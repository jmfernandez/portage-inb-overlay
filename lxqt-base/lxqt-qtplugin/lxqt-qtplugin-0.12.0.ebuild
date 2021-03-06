# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils versionator

DESCRIPTION="LXQt system integration plugin for Qt"
HOMEPAGE="http://lxqt.org/"

MY_PV="$(get_version_component_range 1-2)*"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

RDEPEND="
	dev-libs/libdbusmenu-qt:=[qt5(+)]
	dev-libs/libqtxdg:0/3
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	=lxqt-base/liblxqt-${MY_PV}
	=x11-libs/libfm-qt-${MY_PV}
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	>=dev-util/lxqt-build-tools-0.4.0
	dev-qt/linguist-tools:5
"

mycmakeargs=( -DPULL_TRANSLATIONS=OFF )
