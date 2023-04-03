# Copyright 2023 José Mª Fernández
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#	connman-resolvconf-0.2.0
CRATES="
	anyhow-1.0.57
	bitflags-1.3.2
	cfg-if-1.0.0
	dbus-0.9.5
	env_logger-0.9.0
	error-chain-0.12.4
	hostname-0.3.1
	humantime-2.1.0
	itoa-1.0.2
	libc-0.2.126
	libdbus-sys-0.2.2
	log-0.4.17
	match_cfg-0.1.0
	nix-0.24.1
	num_threads-0.1.6
	pkg-config-0.3.25
	signal-hook-0.3.14
	signal-hook-registry-1.4.0
	syslog-6.0.1
	time-0.3.9
	version_check-0.9.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo systemd

DESCRIPTION="A daemon that integrates ConnMan with resolvconf(8)"
HOMEPAGE="https://github.com/jirutka/connman-resolvconf"
SRC_URI="
	https://github.com/jirutka/connman-resolvconf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

RDEPEND="
	virtual/resolvconf
	net-misc/connman
	|| (
		net-dns/unbound
		net-dns/dnsmasq
	)
"


S="${WORKDIR}/connman-resolvconf-${PV}"

# Rust packages ignore CFLAGS and LDFLAGS so let's silence the QA warnings
QA_FLAGS_IGNORED="usr/sbin/connman-resolvconfd"

src_prepare() {
	# Stripping symbols should be the choice of the user.
	sed -i '/strip = "symbols"/d' Cargo.toml || die "Unable to patch out symbol stripping"

	eapply_user
}

src_configure() {
	myfeatures=(
	)

	cargo_src_configure
}

src_install() {
	dosbin target/release/connman-resolvconfd
	einstalldocs

	newconfd "${S}"/contrib/openrc/${PN}.confd ${PN}
	newinitd "${S}"/contrib/openrc/${PN}.initd ${PN}
	systemd_newunit "${S}"/contrib/systemd/${PN}.service ${PN}.service
}
