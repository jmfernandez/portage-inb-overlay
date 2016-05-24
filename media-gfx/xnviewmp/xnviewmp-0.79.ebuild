# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnViewMP-linux.tgz -> ${P}-linux.tar.gz )
       amd64? ( http://download.xnview.com/XnViewMP-linux-x64.tgz -> ${P}-linux-x64.tar.gz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86 ~amd64"
IUSE="openexr"

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	openexr? ( ~media-libs/ilmbase-1.0.2 )
"
# Dependencies on qt5 are not included, as the software contains its own qt5 copy

DEPEND="$RDEPEND"

RESTRICT="strip"
S="${WORKDIR}/XnView"

src_install() {
	declare XNVIEW_HOME=/opt/XnView

	# Install XnView in /opt
	dodir ${XNVIEW_HOME%/*}

	rm -f "${S}"/xnview.sh
	# As this plugin depends on ilmbase, remove it when the dependency is not available
	use openexr || rm -f "${S}"/Plugins/IlmImf.so
	mv "${S}" "${D}"${XNVIEW_HOME} || die "Unable to install XnView folder"

	# Create /opt/bin/xnview
	dodir /opt/bin/
	cat <<EOF >"${D}"/opt/bin/xnview
#!/bin/sh
LD_LIBRARY_PATH="/opt/XnView/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/opt/XnView/lib
export QT_PLUGIN_PATH
exec /opt/XnView/XnView "\$@"
EOF
	fperms 0755 /opt/bin/xnview


	# Install icon and .desktop for menu entry
	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
	make_desktop_entry xnview XnviewMP ${PN} "Graphics" || die "desktop file sed failed"


}

