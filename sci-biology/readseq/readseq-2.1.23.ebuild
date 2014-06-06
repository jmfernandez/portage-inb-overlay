# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proxool/proxool-0.8.3.ebuild,v 1.6 2005/07/15 17:53:24 axxo Exp $

inherit java-pkg-2

MY_P="${P}-src"
S="${WORKDIR}"
DESCRIPTION="Readseq: Read & reformat biosequences (Java)"
HOMEPAGE="http://iubio.bio.indiana.edu/soft/molbio/readseq/version2/"
SRC_URI="http://iubio.bio.indiana.edu/soft/molbio/readseq/version2/old/${MY_P}.zip"

LICENSE="public-domain"
SLOT="2"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes source"

RESTRICT="nomirror"

RDEPEND=">=virtual/jre-1.3"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	unpack "${A}"
	mkdir META-INF
	cp "${FILESDIR}/MANIFEST.MF" META-INF
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar build/${PN}.jar ${PN}.jar
	echo "#!/bin/sh" > ${PN}${SLOT}
	echo '${JAVA_HOME}/bin/java -jar $(java-config -p' "${PN}-${SLOT}" ') "$@"' >> ${PN}${SLOT}
	dobin ${PN}${SLOT}

	java-pkg_dohtml -r rez/*
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/*
}
