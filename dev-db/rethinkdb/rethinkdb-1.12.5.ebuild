# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils multilib user bash-completion-r1 distutils-r1

DESCRIPTION="Open-source distributed database built with love"
HOMEPAGE="http://www.rethinkdb.com/"
SRC_URI="http://download.rethinkdb.com/dist/${PN}-${PV}.tgz"

LICENSE="AGPL-3 python? ( Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+precompiled-web python +tcmalloc"

RDEPEND="
	>=dev-libs/boost-1.40
	dev-libs/protobuf
	sys-libs/ncurses
	tcmalloc? ( dev-util/google-perftools[static-libs] )
	python? (
		${PYTHON_DEPS}
		dev-libs/protobuf[python]
	)
	>=net-libs/nodejs-0.10.13[npm]
	net-misc/curl
	sys-libs/libunwind
	sys-libs/libtermcap-compat
"
#	>=dev-nodejs/less-1.3.1
#	>=dev-nodejs/coffee-script-1.6.3
#	>=dev-nodejs/handlebars-1.0.12
#	>=dev-nodejs/browserify-3.19.1
#	>=dev-nodejs/protobufjs-2.0.3
DEPEND="${RDEPEND}
	dev-util/ctags
	sys-devel/make
	sys-devel/m4
	${PYTHON_DEPS}
	dev-libs/protobuf-c
	!precompiled-web? (
		>=net-libs/nodejs-0.10.0[npm]
		dev-python/pyyaml
	)
"

RETHINKDB="/usr/bin/rethinkdb"
RETHINKDB_CONFIG_PATH="/etc/${PN}/instances.d"
RETHINKDB_CONFIG_TEMPLATE="${RETHINKDB_CONFIG_PATH}/../default.conf.sample"
RETHINKDB_INSTANCES_PATH="/var/lib/${PN}/instances.d"

pkg_setup() {
	enewgroup rethinkdb
	enewuser rethinkdb -1 -1 /var/lib/${PN} rethinkdb
}

#src_prepare() {
#	epatch_user
#	sed -e 's/^\(\s*required_libs=".*\) termcap\(.*"\)$/\1 ncurses\2/' -i "./configure" || die "Couldn't replace termcap with ncurses lib"
#	sed -e 's/TERMCAP_LIBS/NCURSES_LIBS/' -i "src/build.mk" || die "Couldn't replace termcap with ncurses flags"
#	#if use ruby; then
#	#	sed -e 's/ruby-protoc/rprotoc/' -i drivers/ruby/Makefile \
#	#		|| die "Fixing ruby protobuf compiler failed"
#	#fi
#
#}

src_configure() {
	./configure \
		$(use_enable precompiled-web ) \
		$(use_with tcmalloc ) \
		--static=none \
		--prefix="${EPREFIX}"/usr \
		--sysconfdir="${EPREFIX}"/etc \
		--localstatedir="${EPREFIX}"/var/lib \
		--lib-path="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	emake VERBOSE=1
	pushd drivers &>/dev/null
	use python && emake VERBOSE=1 python-driver
	#if use ruby; then
	#	emake VERBOSE=1 ruby-driver
	#	pushd ruby &>/dev/null
	#	gem build rethinkdb.gemspec
	#	popd &>/dev/null
	#fi
	popd &>/dev/null
}

src_install() {
	emake STRIP_ON_INSTALL=0 VERBOSE=0 DESTDIR="${D}" install-binaries install-manpages install-web install-data install-config

	newbashcomp packaging/assets/scripts/rethinkdb.bash ${PN}
	newinitd packaging/assets/init/rethinkdb ${PN}
	dodoc COPYRIGHT NOTES README.md

	for x in /var/{lib,log}/${PN}; do
		keepdir "${x}"
		fowners rethinkdb:rethinkdb "${x}"
	done

	pushd drivers &>/dev/null
	if use python; then
		pushd python &>/dev/null
		distutils-r1_src_install
		popd &>/dev/null
	fi
	# TODO
	#if use ruby; then
	#	gem install ruby/rethinkdb-*.gem
	#fi
	popd &>/dev/null
}

pkg_config() {
	einfo "This will prepare a new RethinkDB instance. Press Control-C to abort."

	einfo "Enter the name for the new instance: "
	read instance_name
	[[ -z "${instance_name}" ]] && die "Invalid instance name"

	local instance_data="${RETHINKDB_INSTANCES_PATH}/${instance_name}"
	local instance_config="${RETHINKDB_CONFIG_PATH}/${instance_name}.conf"
	if [[ -e "${instance_data}" || -e "${instance_config}" ]]; then
		eerror "An instance with the same name already exists:"
		eerror "Check ${instance_data} or ${instance_config}."
		die "Instance already exists"
	fi

	"${RETHINKDB}" create -d "${instance_data}" &>/dev/null \
		|| die "Creating instance failed"
	chown -R rethinkdb:rethinkdb "${instance_data}" \
		|| die "Correcting permissions for instance failed"
	cp "${RETHINKDB_CONFIG_TEMPLATE}" "${instance_config}" \
		|| die "Creating configuration file failed"
	sed -e "s:^# \(directory=\).*$:\1${instance_data}:" \
		-i "${instance_config}" \
		|| die "Modifying configuration file failed"

	einfo "Successfully created the instance at ${instance_data}."
	einfo "To change the default settings edit the configuration file:"
	einfo "${instance_config}"
}
