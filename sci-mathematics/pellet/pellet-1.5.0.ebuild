# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An OWL-DL Reasoner"
HOMEPAGE="http://pellet.owldl.com/"
SRC_URI="http://pellet.owldl.com/downloads/pellet-1.5.0.zip"

LICENSE="MIT"
SLOT="1.5"
KEYWORDS="~x86 ~amd64"
IUSE="doc test dig"

RDEPEND=">=virtual/jre-1.5
	=dev-java/servletapi-2.3*"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5"

S=${WORKDIR}/${P/_rc/-RC}

src_unpack() {
	unpack ${A}

	cd ${S}/lib

	rm -r junit servlet.jar
	java-pkg_jar-from servletapi-2.3
}

src_compile() {
	eant label-release dist
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_dojar dist/lib/pellet.jar

	java-pkg_dojar dist/lib/aterm-java-1.6.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jena
	java-pkg_dojar dist/lib/jena/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jetty
	java-pkg_dojar dist/lib/jetty/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/owlapi
	java-pkg_dojar dist/lib/owlapi/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/xsdlib
	java-pkg_dojar dist/lib/xsdlib/*.jar
	java-pkg_dolauncher ${PN}-${SLOT} \
		--jar ${PN}.jar \
		${JAVA_OPTIONS}
	use dig && java-pkg_dolauncher ${PN}-dig-${SLOT} \
		--main org.mindswap.pellet.dig.PelletDIGServer \
		${JAVA_OPTIONS}

	dodoc BUGS.txt CHANGES.txt README.txt doc/FAQ.txt
	dohtml doc/index.html
	
	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc ${S}/src/{com,org}
}
