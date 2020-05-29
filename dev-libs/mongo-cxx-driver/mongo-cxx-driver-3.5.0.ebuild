# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic toolchain-funcs

DESCRIPTION="C++ Driver for MongoDB"
HOMEPAGE="https://github.com/mongodb/mongo-cxx-driver"
SRC_URI="https://github.com/mongodb/${PN}/archive/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libressl sasl ssl static-libs"


RDEPEND="
	!dev-db/tokumx
	>=dev-libs/mongo-c-driver-1.16.2
	dev-libs/boost:=[threads(+)]
	sasl? ( dev-libs/cyrus-sasl )
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)"
DEPEND="${RDEPEND}"

# Maintainer notes
# TODO: enable test in IUSE with
# test? ( >=dev-cpp/gtest-1.7.0 dev-db/mongodb )

S="${WORKDIR}/${PN}-r${PV}"

src_configure() {
	append-cxxflags -std=c++17
	
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_VERSION=${PV}
		-DCMAKE_CXX_STANDARD=17
		-DENABLE_UNINSTALL=OFF
	)
	
	cmake-utils_src_configure
}

#src_compile() {
#	escons "${scons_opts[@]}"
#}
#
#src_install() {
#	escons "${scons_opts[@]}" install --prefix="${ED%/}"/usr
#
#	# fix multilib-strict QA failures
#	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
#
#	einstalldocs
#
#	if ! use static-libs; then
#		find "${D}" -name '*.a' -delete || die
#	fi
#}
