# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

#inherit eutils rpm xdg-utils
inherit eutils xdg-utils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
MY_PV=${PV/./}
#SRC_URI="http://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux.x86_64.rpm"
SRC_URI="http://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux-x64.tgz"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~amd64"
IUSE="openexr bundled-libs"

B_QT_VERSION=5.9.5
B_QT_WK_VERSION=5.9.0
B_ICU_VERSION=56
BUNDLED_LIBS="
	libQt5Concurrent.so.5	   libQt5Concurrent.so.${B_QT_VERSION}
	libQt5Core.so.5	   libQt5Core.so.${B_QT_VERSION}
	libQt5DBus.so.5	   libQt5DBus.so.${B_QT_VERSION}
	libQt5Gui.so.5	  libQt5Gui.so.${B_QT_VERSION}
	libQt5Multimedia.so.5	 libQt5Multimedia.so.${B_QT_VERSION}
	libQt5MultimediaWidgets.so.5	libQt5MultimediaWidgets.so.${B_QT_VERSION}
	libQt5Network.so.5	  libQt5Network.so.${B_QT_VERSION}
	libQt5OpenGL.so.5	 libQt5OpenGL.so.${B_QT_VERSION}
	libQt5Positioning.so.5	  libQt5Positioning.so.${B_QT_VERSION}
	libQt5PrintSupport.so.5	   libQt5PrintSupport.so.${B_QT_VERSION}
	libQt5Qml.so.5	  libQt5Qml.so.${B_QT_VERSION}
	libQt5Quick.so.5	libQt5Quick.so.${B_QT_VERSION}
	libQt5Sensors.so.5	  libQt5Sensors.so.${B_QT_VERSION}
	libQt5Sql.so.5	  libQt5Sql.so.${B_QT_VERSION}
	libQt5Svg.so.5	  libQt5Svg.so.${B_QT_VERSION}
	libQt5WebChannel.so.5	 libQt5WebChannel.so.${B_QT_VERSION}
	libQt5WebKit.so.5	 libQt5WebKit.so.${B_QT_WK_VERSION}
	libQt5WebKitWidgets.so.5	libQt5WebKitWidgets.so.${B_QT_WK_VERSION}
	libQt5Widgets.so.5	  libQt5Widgets.so.${B_QT_VERSION}
	libQt5X11Extras.so.5	libQt5X11Extras.so.${B_QT_VERSION}
	libQt5XcbQpa.so.5	 libQt5XcbQpa.so.${B_QT_VERSION}
	libQt5Xml.so.5	  libQt5Xml.so.${B_QT_VERSION}
	libQtAV.so.1       libQtAV.so.1.12.0
	libQtAVWidgets.so.1      libQtAVWidgets.so.1.12.0
	
	libavcodec.so.58
	libavfilter.so.7
	libavformat.so.58
	libavutil.so.56
	
	libicudata.so	libicudata.so.${B_ICU_VERSION}	libicudata.so.${B_ICU_VERSION}.1
	libicui18n.so	libicui18n.so.${B_ICU_VERSION}	libicui18n.so.${B_ICU_VERSION}.1
	libicuio.so	libicuio.so.${B_ICU_VERSION}	libicuio.so.${B_ICU_VERSION}.1
	libicule.so	libicule.so.${B_ICU_VERSION}	libicule.so.${B_ICU_VERSION}.1
	libiculx.so	libiculx.so.${B_ICU_VERSION}	libiculx.so.${B_ICU_VERSION}.1
	libicutest.so	libicutest.so.${B_ICU_VERSION}	libicutest.so.${B_ICU_VERSION}.1
	libicutu.so	libicutu.so.${B_ICU_VERSION}	libicutu.so.${B_ICU_VERSION}.1
	libicuuc.so	libicuuc.so.${B_ICU_VERSION}	libicuuc.so.${B_ICU_VERSION}.1
	
	libqgsttools_p.so	libqgsttools_p.so.1	libqgsttools_p.so.1.0.0
	
	libswresample.so.3
	libswscale.so.5
	libva-drm.so.1
	libva-x11.so.1
	libva.so.1
	libvdpau.so.1
	
	libwebp.so	libwebp.so.6
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
	media-libs/qtav:0
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
#
#src_unpack() {
#	rpm_src_unpack ${A}
#}

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
