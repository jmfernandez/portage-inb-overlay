# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils xdg-utils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
MY_PV=${PV/./}
SRC_URI="x86? ( http://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux.tgz )
       amd64? ( http://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux-x64.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86 ~amd64"
IUSE="openexr bundled-libs"

BUNDLED_LIBS="
	libQt5Core.so.5	   libQt5Core.so.5.6.2
	libQt5Gui.so.5	  libQt5Gui.so.5.6.2
	libQt5XcbQpa.so.5	 libQt5XcbQpa.so.5.6.2
	libQt5Multimedia.so.5	 libQt5Multimedia.so.5.6.2
	libQt5MultimediaWidgets.so.5	libQt5MultimediaWidgets.so.5.6.2
	libqgsttools_p.so	libqgsttools_p.so.1	libqgsttools_p.so.1.0.0
	libQt5DBus.so.5	   libQt5DBus.so.5.6.2
	libQt5Network.so.5	  libQt5Network.so.5.6.2
	libQt5PrintSupport.so.5	   libQt5PrintSupport.so.5.6.2
	libQt5Svg.so.5	  libQt5Svg.so.5.6.2
	libQt5OpenGL.so.5	 libQt5OpenGL.so.5.6.2
	libQt5Positioning.so.5	  libQt5Positioning.so.5.6.2
	libQt5Qml.so.5	  libQt5Qml.so.5.6.2
	libQt5Quick.so.5	libQt5Quick.so.5.6.2
	libQt5Sensors.so.5	  libQt5Sensors.so.5.6.2
	libQt5Sql.so.5	  libQt5Sql.so.5.6.2
	libQt5WebChannel.so.5	 libQt5WebChannel.so.5.6.2
	libQt5WebKit.so.5	 libQt5WebKit.so.5.6.1
	libQt5WebKitWidgets.so.5	libQt5WebKitWidgets.so.5.6.1
	libQt5Widgets.so.5	  libQt5Widgets.so.5.6.2
	libQt5X11Extras.so.5	libQt5X11Extras.so.5.6.2
	libQt5Xml.so.5	  libQt5Xml.so.5.6.2
	libQt5Concurrent.so.5	 libQt5Concurrent.so.5.6.2
	libwebp.so	libwebp.so.6
	libicudata.so		libicui18n.so		libicuuc.so
	libicudata.so.56	libicui18n.so.56	libicuuc.so.56
	libicudata.so.56.1	libicui18n.so.56.1	libicuuc.so.56.1
	audio/ platforms/ printsupport/"

BUNDLED_LIBS_DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtx11extras:5
	dev-qt/qtconcurrent:5
	dev-qt/qtxml:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtdbus:5
	dev-qt/qtwebkit:5
	dev-qt/qtimageformats:5
	media-libs/libwebp:0
	dev-libs/icu"

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	openexr? ( ~media-libs/ilmbase-1.0.2 )
	!bundled-libs? ( ${BUNDLED_LIBS_DEPEND} )
"

DEPEND="$RDEPEND"

RESTRICT="mirror strip"
S="${WORKDIR}/XnView"

src_prepare() {
	default

	if ! use bundled-libs ; then
		einfo Removing bundled libraries
		for libname in ${BUNDLED_LIBS} ; do
			rm -rv "${S}"/lib/${libname} || die "Failed removing bundled ${libname}"
		done
		rm "${S}"/qt.conf
	fi
}

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
EOF
	use bundled-libs && cat <<EOF >>"${D}"/opt/bin/xnview
LD_LIBRARY_PATH="/opt/XnView/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/opt/XnView/lib
export QT_PLUGIN_PATH
EOF
	cat <<EOF >>"${D}"/opt/bin/xnview
exec /opt/XnView/XnView "\$@"
EOF
	fperms 0755 /opt/bin/xnview


	# Install icon and .desktop for menu entry
	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
	make_desktop_entry xnview XnviewMP ${PN} "Graphics" || die "desktop file sed failed"
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}