# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

#inherit eutils rpm xdg-utils
inherit eutils unpacker xdg-utils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
MY_PV=${PV//./}
#SRC_URI="http://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux.x86_64.rpm"
SRC_URI="https://download.xnview.com/old_versions/XnViewMP-${MY_PV}-linux-x64.deb"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~amd64"
IUSE="openexr +bundled-libs"

B_QT_VERSION=5.12.6
B_QT_WK_VERSION=5.9.0
B_ICU_VERSION=56
B_AV_VERSION=58
B_QTAV_VERSION=1.12.0
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
	libQtAV.so.1       libQtAV.so.${B_QTAV_VERSION}
	libQtAVWidgets.so.1      libQtAVWidgets.so.${B_QTAV_VERSION}
	
	libavcodec.so.${B_AV_VERSION}
	libavdevice.so.${B_AV_VERSION}
	libavfilter.so.7
	libavformat.so.${B_AV_VERSION}
	libavutil.so.56
	
	libcrypto.so	libcrypto.so.1.1
	libdbus-1.so	libdbus-1.so.3
	libfreetype.so	libfreetype.so.6
	
	libicudata.so	libicudata.so.${B_ICU_VERSION}	libicudata.so.${B_ICU_VERSION}.1
	libicui18n.so	libicui18n.so.${B_ICU_VERSION}	libicui18n.so.${B_ICU_VERSION}.1
	libicuio.so	libicuio.so.${B_ICU_VERSION}	libicuio.so.${B_ICU_VERSION}.1
	libicule.so	libicule.so.${B_ICU_VERSION}	libicule.so.${B_ICU_VERSION}.1
	libiculx.so	libiculx.so.${B_ICU_VERSION}	libiculx.so.${B_ICU_VERSION}.1
	libicutest.so	libicutest.so.${B_ICU_VERSION}	libicutest.so.${B_ICU_VERSION}.1
	libicutu.so	libicutu.so.${B_ICU_VERSION}	libicutu.so.${B_ICU_VERSION}.1
	libicuuc.so	libicuuc.so.${B_ICU_VERSION}	libicuuc.so.${B_ICU_VERSION}.1
	
	libqgsttools_p.so	libqgsttools_p.so.1
	
	libssl.so	libssl.so.1.1
	
	libswresample.so.3
	libswscale.so.5
	libva-drm.so.1
	libva-x11.so.1
	libva.so.1
	libvdpau.so.1
	
	libwebp.so	libwebp.so.6
	audio/ generic/ mediaservice/ platforms/ platformthemes/ printsupport/ sensors/ styles/ ../Plugins/"

# imageformats/ must be kept

BUNDLED_LIBS_DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[gstreamer,widgets]
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtpositioning:5
	dev-qt/qtprintsupport:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtsensors:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwebchannel:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-libs/qtav:0
	media-video/ffmpeg:0/56.58.58
	dev-libs/openssl:0/1.1
	sys-apps/dbus
	media-libs/freetype
	dev-libs/icu
	x11-libs/libva
	x11-libs/libvdpau
	media-libs/libwebp:0
	dev-qt/qtimageformats:5
"

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	openexr? ( ~media-libs/ilmbase-1.0.2 )
	!bundled-libs? ( ${BUNDLED_LIBS_DEPEND} )
"

DEPEND="$RDEPEND"

RESTRICT="mirror strip"
S="${WORKDIR}"

src_unpack() {
	
	unpack_deb "${A}"
}

XNVIEW_HOME=/opt/XnView
src_prepare() {
	default

	if ! use bundled-libs ; then
		einfo Removing bundled libraries
		for libname in ${BUNDLED_LIBS} ; do
			rm -rv "${S}/${XNVIEW_HOME}"/lib/${libname} || die "Failed removing bundled ${libname}"
		done
		rm "${S}"/qt.conf
	fi
	sed 's#Exec=.*xnview.sh#Exec=xnview#g' ./opt/XnView/XnView.desktop > ./usr/share/applications/XnView.desktop
	rm ./usr/bin/xnview
	mkdir -p ./opt/bin
	ln -s ../XnView/xnview.sh ./opt/bin/xnview
}

src_install() {

	# Install XnView in /opt
	dodir ${XNVIEW_HOME%/*}

	#rm -f "${S}"/xnview.sh
	# As this plugin depends on ilmbase, remove it when the dependency is not available
	use openexr || rm -f "${S}"/Plugins/IlmImf.so
	
	insinto /
	doins -r .
	
#	mv "${S}" "${D}"${XNVIEW_HOME} || die "Unable to install XnView folder"

#	# Create /opt/bin/xnview
#	dodir /opt/bin/
#	cat <<EOF >"${D}"/opt/bin/xnview
##!/bin/sh
#EOF
#	use bundled-libs && cat <<EOF >>"${D}"/opt/bin/xnview
#LD_LIBRARY_PATH="/opt/XnView/lib:$LD_LIBRARY_PATH"
#export LD_LIBRARY_PATH
#QT_PLUGIN_PATH=/opt/XnView/lib
#export QT_PLUGIN_PATH
#EOF
#	cat <<EOF >>"${D}"/opt/bin/xnview
#exec /opt/XnView/XnView "\$@"
#EOF
	fperms +x /opt/XnView/XnView /opt/XnView/xnview.sh


#	# Install icon and .desktop for menu entry
#	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
#	make_desktop_entry xnview XnviewMP ${PN} "Graphics" || die "desktop file sed failed"
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
