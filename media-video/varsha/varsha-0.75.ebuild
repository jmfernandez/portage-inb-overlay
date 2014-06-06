# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="GUI video DVD authoring utility"
HOMEPAGE="http://varsha.sourceforge.net/"
SRC_URI="mirror://sourceforge/varsha/${PN}.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
RESTRICT="nomirror"

DEPEND=""
RDEPEND="virtual/jre
	>=app-cdr/dvd+rw-tools-5.17.4.8.6
	>=app-cdr/cdrtools-2.01_alpha28-r1
	>=media-video/dvdauthor-0.6.10
	>=media-video/dvd-slideshow-0.6.0"

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	dodir /opt/${PN}
	dodir /opt/${PN}/lib

	insinto /opt/${PN}/lib

	doins ${WORKDIR}/${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo exec '"${JAVA_HOME}"'/bin/java -jar /opt/${PN}/lib/${PN}.jar '"$@"' >> ${PN}

	into /opt
	dobin ${PN}
}
