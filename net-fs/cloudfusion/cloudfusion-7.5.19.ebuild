# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Linux file system (FUSE) to access Dropbox, Sugarsync, Amazon S3, Google Storage, Google Drive or WebDAV servers"
HOMEPAGE="http://joe42.github.com/CloudFusion/"
SRC_URI="https://github.com/joe42/CloudFusion/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
		>=dev-python/httplib2-0.8[${PYTHON_USEDEP}]
		>=dev-python/beautifulsoup-4.0.0[${PYTHON_USEDEP}]
		dev-python/python-ntplib[${PYTHON_USEDEP}]
		net-misc/gsutil[${PYTHON_USEDEP}]
		dev-python/argparse[${PYTHON_USEDEP}]
		dev-python/sh[${PYTHON_USEDEP}]
		dev-python/tinydav[${PYTHON_USEDEP}]
		dev-python/PyDrive[${PYTHON_USEDEP}]
		dev-python/profilehooks[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/CloudFusion-v.${PV}"
