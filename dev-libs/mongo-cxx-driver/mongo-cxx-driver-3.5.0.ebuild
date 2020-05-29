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
IUSE="debug static-libs"


RDEPEND="
	!dev-db/tokumx
	>=dev-libs/libbson-1.16.2
	>=dev-libs/mongo-c-driver-1.16.2
	"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-r${PV}"

pkg_pretend() {
	if ! test-flag-CXX -std=c++17; then
			eerror "${P} requires C++17-capable C++ compiler. Your current compiler"
			eerror "does not seem to support -std=c++17 option. Please upgrade your compiler"
			eerror "to gcc-7.4 or an equivalent version supporting C++17."
			die "Currently active compiler does not support -std=c++17"
	fi
}

src_configure() {
	append-cxxflags -std=c++17
	
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_SHARED_AND_STATIC_LIBS=$(usex static-libs ON OFF)
		-DBUILD_VERSION=${PV}
		-DCMAKE_CXX_STANDARD=17
		-DENABLE_UNINSTALL=OFF
	)
	
	cmake-utils_src_configure
}

