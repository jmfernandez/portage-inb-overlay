# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=EASR

inherit multilib perl-module

DESCRIPTION="Manipulates OBO- and OWL-formatted ontologies (like the Gene Ontology)"
SRC_URI="mirror://cpan/authors/id/E/EA/${MODULE_AUTHOR}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+intact +owl +swissprot"

RDEPEND="
	swissprot? ( >=sci-biology/swissknife-1.67 )
	dev-perl/DateManip
	intact? ( >=dev-perl/XML-XPath-1.130.0 )
	owl? ( >=dev-perl/XML-Parser-2.34 )
	virtual/perl-File-Path"
DEPEND="${RDEPEND}"

SRC_TEST=do
#myconf="LIBS=-L/usr/$(get_libdir)"

src_prepare() {
	epatch "${FILESDIR}/${P}-use-XML-Parser.patch"
}
