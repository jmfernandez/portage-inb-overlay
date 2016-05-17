# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PERL_EXPORT_PHASE_FUNCTIONS=no
inherit perl-module autotools eutils toolchain-funcs

#MY_P="${PN}_${PV}"

DESCRIPTION="Tools for working with VCF (Variant Call Format) files"
HOMEPAGE="https://vcftools.github.io/"
SRC_URI="https://github.com/vcftools/${PN}/archive/v${PV}.tar.gz -> vcftools-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="pca"

RDEPEND="pca? ( virtual/lapack )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#S="${WORKDIR}/${MY_P}"

src_prepare() {
#	#epatch "${FILESDIR}"/${P}-buildsystem.patch
#	tc-export CXX PKG_CONFIG
	eautoreconf
}

src_configure(){
	econf \
		$(use_enable pca)	# Enable Principal Components Analysis
}

#src_compile() {
#	local myconf
#	use lapack && myconf="VCFTOOLS_PCA=1"
#	emake -C cpp ${myconf}
#}

#src_install(){
#	perl_set_version
#	dobin cpp/${PN}
#	insinto ${VENDOR_LIB}
#	doins perl/*.pm
#	dobin perl/{fill,vcf}-*
#	dodoc README.txt
#}
