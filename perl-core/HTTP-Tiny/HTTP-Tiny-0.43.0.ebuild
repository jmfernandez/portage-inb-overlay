# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/HTTP-Tiny/HTTP-Tiny-0.29.0.ebuild,v 1.2 2013/09/05 09:14:57 patrick Exp $
EAPI=5
MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.043
inherit perl-module

DESCRIPTION='A small, simple, correct HTTP/1.1 client'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	>=virtual/perl-ExtUtils-MakeMaker-6.30
	virtual/perl-IO
	virtual/perl-Time-Local
	test? (
		virtual/perl-Data-Dumper
		virtual/perl-Exporter
		virtual/perl-ExtUtils-MakeMaker
		virtual/perl-File-Spec
		virtual/perl-File-Spec
		virtual/perl-File-Temp
		virtual/perl-IO
		virtual/perl-IPC-Cmd
		virtual/perl-Scalar-List-Utils
		>=virtual/perl-Test-Simple-0.96
	)
"
RDEPEND="
	virtual/perl-IO
	virtual/perl-Time-Local
"
SRC_TEST="do"
