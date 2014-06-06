# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit versionator

MY_PV=$(delete_all_version_separators)
S="${WORKDIR}/GPRS_Easy_Connect_${MY_PV}"
SG_FOLDER="SG-1.0.1"

DESCRIPTION="Easily connect and monitor your GPRS connection"
HOMEPAGE="http://www.easyconnect.linuxuser.hu"
SRC_URI="http://www.easyconnect.linuxuser.hu/downloads/GPRS_Easy_Connect_${MY_PV}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

RDEPEND="dev-lang/perl
	dev-perl/perl-tk
	dev-perl/libwww-perl
	dev-perl/gnome2-perl
	dev-perl/gtk2-trayicon
	net-dialup/ppp
	"
		
src_compile() {
	# Fix some hardcoded paths. This really shouldn't work but it does...
	sed -r -i "s:/usr/local/src/${SG_FOLDER}/lng:/usr/share/gprsec/languages:g" data/src/${SG_FOLDER}/bin/SG
}

src_install(){
	cd data

	exeinto /usr/bin
	doexe bin/gprsec src/${SG_FOLDER}/bin/SG
	
	insinto /usr/share/icons
	doins share/gprsec/images/icons/*
	
	insinto /usr/share/gprsec/languages
	rm -f share/gprsec/languages/hu_HU
	doins share/gprsec/languages/*
	doins src/${SG_FOLDER}/lng/*
	
	insinto /usr/share/gprsec/images
	doins -r share/gprsec/images/*
	
	insinto /usr/share/gprsec/tools
	doins share/gprsec/tools/*[^~]
	
	dodoc share/gprsec/AUTHORS share/gprsec/README share/gprsec/history
	newdoc src/${SG_FOLDER}/AUTHORS AUTHORS.SG
	newdoc src/${SG_FOLDER}/README README.SG
}
