# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An OWL-DL Reasoner"
HOMEPAGE="http://pellet.owldl.com/"
SRC_URI="http://www.mindswap.org/2003/pellet/download/pellet-1.3.zip"

LICENSE="MIT"
SLOT="1.3"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4
	=dev-java/servletapi-2.3*"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}

	cd ${S}/lib

	rm servlet.jar
	java-pkg_jar-from servletapi-2.3
}

src_compile() {
	eant ${ant_extra_opts} label-release dist
}

src_install() {
	java-pkg_dojar dist/lib/pellet.jar

	java-pkg_dojar dist/lib/aterm-java-1.6.jar
	java-pkg_dojar dist/lib/rdfapi.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/econn-owlapi
	java-pkg_dojar dist/lib/econn-owlapi/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jena
	java-pkg_dojar dist/lib/jena/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jetty
	java-pkg_dojar dist/lib/jetty/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/junit-3.8.1
	java-pkg_dojar dist/lib/junit-3.8.1/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/xsdlib
	java-pkg_dojar dist/lib/xsdlib/*.jar
	java-pkg_dolauncher ${PN}-${SLOT} \
		--jar ${PN}.jar \
		${JAVA_OPTIONS}

	dodoc CHANGES.txt README.txt
	dohtml doc/index.html
	
	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc ${S}/src/{com,org}
}
