# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xxe/xxe-2.11.ebuild,v 1.1 2005/07/21 04:35:52 rizzo Exp $

MY_P="${P}-bin"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Pollo, the XML Editor written in Java"
SRC_URI="mirror://sourceforge/pollo/${MY_P}.zip"
HOMEPAGE="http://pollo.sourceforge.net/"
IUSE=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~amd64"

RESTRICT="nostrip nomirror"
RDEPEND=">=virtual/jre-1.4.1"
DEPEND=""
INSTALLDIR=/opt/${PN}

src_install() {
	dodir ${INSTALLDIR}
	cp -a ${S}/* ${D}/${INSTALLDIR}

	#dodir /etc/env.d
	#echo -e "PATH=${INSTALLDIR}/bin\nROOTPATH=${INSTALLDIR}" > ${D}/etc/env.d/10xxe

	insinto /usr/share/applications
	doins ${FILESDIR}/pollo.desktop

	insinto /usr/share/icons
	doins ${FILESDIR}/pollo_icon.gif

	echo "#!/bin/sh" > ${PN}
	echo "DIR='${INSTALLDIR}'" >> ${PN}
	echo 'CLASSPATH="$DIR/lib/pollo.jar:$DIR/lib/endorsed/dom3-xercesImpl.jar:$DIR/lib/endorsed/dom3-xmlParserAPIs.jar:$DIR/lib/avalon-configuration.jar:$DIR/lib/log4j-core.jar:$DIR/lib/jaxen-core.jar:$DIR/lib/jaxen-dom.jar:$DIR/lib/saxpath.jar:$DIR/lib/msv-20031002.jar:$DIR/lib/xsdlib.jar:$DIR/lib/relaxngDatatype.jar:$DIR/lib/isorelax.jar:$DIR/lib/xpp3-1.1.3.4-RC3_min.jar:$DIR/lib/commons-lang-exception-2.0.jar:$DIR/conf:$DIR/build"' >> ${PN}
	echo "export CLASSPATH" >> ${PN}
	echo 'exec java "-Djava.endorsed.dirs=${DIR}/lib/endorsed" org.outerj.pollo.Pollo "$@"' >> ${PN}

	into /opt
	dobin ${PN}
}

pkg_postinst() {
	einfo
	ewarn "If you need special/accented characters, you'll need to export LANG"
	ewarn "to your locale.  Example: export LANG=es_ES.ISO8859-1"
	#ewarn "See http://www.xmlmind.com/xmleditor/user_faq.html#linuxlocale"
	einfo
}
