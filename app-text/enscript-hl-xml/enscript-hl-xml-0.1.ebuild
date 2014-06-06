# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Enscript highlight patterns for XML"
HOMEPAGE="http://www.pdg.cnb.uam.es/jmfernandez/personal"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha x86 amd64 ppc ia64 sparc mips"
IUSE=""

RDEPEND="app-text/enscript"

src_install() {
	insinto /usr/share/enscript/hl
	doins ${FILESDIR}/${PVR}/*
}

pkg_postinst() {
	einfo "In order to invoke these filters at full power, you should use a line
	like:"
	einfo "\tenscript -Exml --color --style=xml {inputfile} -o {outputfile}"
	einfo "or"
	einfo "\tenscript -Exml --color --style=xml --language=rtf {inputfile} -o {outputfile}"
}
