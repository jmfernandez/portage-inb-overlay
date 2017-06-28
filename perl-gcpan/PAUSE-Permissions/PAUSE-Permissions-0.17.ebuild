# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.16.9

EAPI=5

MODULE_AUTHOR="NEILB"
MODULE_VERSION="0.17"


inherit perl-module

DESCRIPTION="interface to PAUSE's module permissions file (06perms.txt)"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/Time-Duration-Parse
	dev-perl/Path-Tiny
	dev-perl/Moo
	perl-gcpan/MooX-Options
	dev-perl/File-HomeDir
	dev-perl/HTTP-Date
	dev-lang/perl"
