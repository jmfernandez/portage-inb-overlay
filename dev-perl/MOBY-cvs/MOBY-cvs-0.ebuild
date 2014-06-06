# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28-r1.ebuild,v 1.16 2005/01/04 13:34:23 mcummings Exp $

ECVS_SERVER="cvs.open-bio.org:/home/repository/moby"
ECVS_MODULE="moby-live/Perl"
ECVS_USER="cvs"
ECVS_PASS="cvs"
ECVS_CVS_OPTIONS="-dP"


inherit perl-module cvs

DESCRIPTION="A Perl Module for BioMOBY (CVS)"
#SRC_URI="http://www.pdg.cnb.uam.es/jmfernandez/soft/${P}.tar.bz2"
HOMEPAGE="http://www.biomoby.org/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
IUSE="server"

RESTRICT="nomirror"

S="${WORKDIR}/${ECVS_MODULE}"

DEPEND="${DEPEND}
	!dev-perl/MOBY
	>=dev-perl/SOAP-Lite-0.60
	dev-perl/XML-DOM
	>=dev-perl/XML-LibXML-1.58
	>=dev-perl/XML-XPath-1.12
	>=dev-perl/Text-Shellwords-1.00
	dev-perl/HTML-Parser
	>=perl-core/Test-Simple-0.60
	server? (
		dev-perl/DBI
		dev-perl/DBD-mysql
		dev-perl/RDF-Core
	)
"
#	>=dev-perl/SOAP-MIME-0.55
