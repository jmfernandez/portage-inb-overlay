# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.16.9

EAPI=5

MODULE_AUTHOR="ISHIGAKI"
MODULE_VERSION="0.19"


inherit perl-module

DESCRIPTION="parses local .pm files as PAUSE does"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=perl-gcpan/Parse-PMFile-0.41
	>=dev-perl/Test-UseAllModules-0.170.0
	dev-lang/perl"
