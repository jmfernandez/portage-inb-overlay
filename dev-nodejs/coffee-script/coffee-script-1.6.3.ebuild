# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
NODEJS_MODULE=${PN}

inherit multilib npm-alt

DESCRIPTION="Unfancy JavaScript"
HOMEPAGE="https://npmjs.org/package/coffee-script"
SRC_URI="http://registry.npmjs.org/${PN}/-/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=net-libs/nodejs-0.10.13"
RDEPEND="${DEPEND}"

