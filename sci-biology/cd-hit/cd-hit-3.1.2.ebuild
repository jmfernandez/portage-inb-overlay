# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw/clustalw-1.83-r1.ebuild,v 1.6 2005/06/19 19:38:59 corsair Exp $

inherit toolchain-funcs

MY_PV="2009-0427"
DESCRIPTION="CD-HIT stands for Cluster Database at High Identity with Tolerance for DNA and proteins"
HOMEPAGE="http://www.bioinformatics.org/project/?group_id=350"
SRC_URI="http://www.bioinformatics.org/download/cd-hit/cd-hit-${MY_PV}.tar.gz"
RESTRICT="nomirror"

LICENSE="cd-hit"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/libc"
		
RDEPEND="
	virtual/libc
	dev-lang/perl"

S="${WORKDIR}/${PN}"

src_compile() {
	#emake clean
	emake CCFLAGS="${CXXFLAGS}" || die
}

CDHIT_BINARIES="cd-hit cd-hit-est cd-hit-2d cd-hit-div cd-hit-est-2d"
CDHIT_SCRIPTS="cd-hit-2d-para.pl cd-hit-div.pl cd-hit-para.pl clstr2tree.pl
clstr_merge.pl clstr_merge_noorder.pl clstr_reduce.pl clstr_renumber.pl
clstr_rev.pl clstr_sort_by.pl clstr_sort_prot_by.pl make_multi_seq.pl plot_2d.pl
plot_len1.pl psi-cd-hit-2d.pl psi-cd-hit-local.pl psi-cd-hit.pl"

src_install() {
	dobin $CDHIT_BINARIES || die
	dobin $CDHIT_SCRIPTS || die
	dodoc cd-hit-user-guide.txt README psi-cd-hit.README
	#dodoc cd-hit-user-guide.pdf
}
