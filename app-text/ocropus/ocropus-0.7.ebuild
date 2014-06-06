# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit eutils mercurial python-single-r1
n
EHG_REPO_URI="https://code.google.com/p/${PN}"
EHG_REVISION="${P}"

DESCRIPTION="OCRopus is a state-of-the-art document analysis and OCR system."
HOMEPAGE="http://code.google.com/p/${PN}/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc"

#S="${WORKDIR}/${PN}/ocropy"

RDEPEND="app-text/tesseract
net-misc/curl
sci-libs/scipy[${PYTHON_USEDEP}]
dev-python/matplotlib[${PYTHON_USEDEP}]
dev-python/pytables[${PYTHON_USEDEP}]
media-gfx/imagemagick
media-libs/opencv[python,${PYTHON_USEDEP}]
doc? ( dev-python/beautifulsoup[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}"

src_configure() {
	S="${WORKDIR}/${P}/ocropy"
	#python_src_configure "$@"
}
