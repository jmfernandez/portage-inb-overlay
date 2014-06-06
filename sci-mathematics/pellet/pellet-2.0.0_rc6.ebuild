# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An OWL-DL Reasoner"
HOMEPAGE="http://pellet.owldl.com/"
SRC_URI="http://pellet.owldl.com/downloads/pellet-2.0.0-rc6.zip"

LICENSE="AGPL-3"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE="doc test dig"

RDEPEND=">=virtual/jre-1.5
	dig? ( =dev-java/servletapi-2.3* )
	test? ( >=dev-java/junit-4.4 )"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5"

S=${WORKDIR}/${P/_rc/-rc}

src_install() {

	java-pkg_dojar lib/pellet-cli.jar
	java-pkg_dojar lib/pellet-core.jar
	java-pkg_dojar lib/pellet-datatypes.jar
	java-pkg_dojar lib/pellet-el.jar
	java-pkg_dojar lib/pellet-explanation.jar
	java-pkg_dojar lib/pellet-jena.jar
	java-pkg_dojar lib/pellet-modularity.jar
	java-pkg_dojar lib/pellet-owlapi.jar
	java-pkg_dojar lib/pellet-pellint.jar
	java-pkg_dojar lib/pellet-query.jar
	java-pkg_dojar lib/pellet-rules.jar

	use dig && (
		java-pkg_jar-from servletapi-2.3
		java-pkg_dojar lib/pellet-dig.jar
		)

	use test && (
		java-pkg_jar-from junit-4
		java-pkg_dojar lib/pellet-test.jar
		)

	java-pkg_dojar lib/aterm-java-1.6.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jena
	java-pkg_dojar lib/jena/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jetty
	java-pkg_dojar lib/jetty/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/jgrapht
	java-pkg_dojar lib/jgrapht/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/owlapi
	java-pkg_dojar lib/owlapi/*.jar
	java-pkg_jarinto ${JAVA_PKG_SHAREPATH}/lib/xsdlib
	java-pkg_dojar lib/xsdlib/*.jar
	java-pkg_dolauncher ${PN}-${SLOT} \
		--jar pellet-cli.jar \
		${JAVA_OPTIONS}

	dodoc BUGS.txt README.txt doc/FAQ.txt
	dohtml doc/index.html
	
	use doc && java-pkg_dojavadoc doc/javadoc
	use source && (
		insinto "${JAVA_PKG_SHAREPATH}/sources/"
		insopts -m a=r
		doins src/pellet-cli-src.jar
		doins src/pellet-core-src.jar
		doins src/pellet-datatypes-src.jar
		doins src/pellet-el-src.jar
		doins src/pellet-explanation-src.jar
		doins src/pellet-jena-src.jar
		doins src/pellet-modularity-src.jar
		doins src/pellet-owlapi-src.jar
		doins src/pellet-pellint-src.jar
		doins src/pellet-query-src.jar
		doins src/pellet-rules-src.jar

		use dig && doins src/pellet-dig-src.jar
		use test && doins src/pellet-test-src.jar
		)
}
