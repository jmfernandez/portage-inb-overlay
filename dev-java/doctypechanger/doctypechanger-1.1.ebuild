# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proxool/proxool-0.8.3.ebuild,v 1.6 2005/07/15 17:53:24 axxo Exp $

inherit java-pkg-2

MY_PN="DoctypeChanger"
MY_P="${MY_PN}-${PV}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION=" DoctypeChanger is a Java class that lets you add, modify or remove a DOCTYPE declaration from a byte stream as it is fed into an XML parser"
HOMEPAGE="http://doctypechanger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes ctags"

RESTRICT="nomirror"

RDEPEND=">=virtual/jre-1.3"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	ctags? ( dev-util/ctags )
	jikes? ( dev-java/jikes )"
	#source? ( app-arch/zip )"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use ctags || antflags="${antflags} -Dno.ctags=true"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	sed -i 's#executable="ctags" os="Linux"#executable="exuberant-ctags" os="Linux"#' build.xml
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar build/${MY_PN}.jar ${PN}.jar

	dodoc PROJECT.txt
	java-pkg_dohtml build/etc/overview.html
	use doc && java-pkg_dohtml -r build/apidocs/*
	#use source && java-pkg_dosrc src/java/*
}
