# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Smart Battery System for Linux"
HOMEPAGE="http://sourceforge.net/projects/sbs-linux/"
SRC_URI="mirror://sourceforge/sbs-linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="tm4xxx tm32xx"

DEPEND="sys-devel/acpica-unix"

#src_unpack () {
#	unpack ${A}
#	
#}

pkg_setup () {
	einfo "You are running:- `uname -r`"
	check_KV || die "Cannot find kernel in /usr/src/linux"
	einfo "Using kernel in /usr/src/linux:- ${KV}"

	echo ${KV} | grep -q 2.6.11
	if [ $? == 1 ]; then
		echo
		einfo "We don't have an EC patch for ${KV} kernel"
		echo
		ewarn "You shoud install either 2.6.10 or 2.6.11 kernel"
	fi

	if [ "${KV}" != "`uname -r`" ]; then
		ewarn "WARNING:- kernels do not match!"
	fi
	
	if useq tm32xx ; then
		einfo "Acer Travelmate 32xx support selected"
	elif useq tm4xxx ; then
		einfo "Acer Travelmate 4xxx support selected"
	else
		die "You must set either tm32xx or tm4xxx keyword"
	fi
}

src_compile () {

	# Real compilation
	cat /proc/acpi/dsdt > dsdt.dat
	iasl -d dsdt.dat
	if useq tm32xx ; then
		patch < acer-tm32xx-sbs-cm.diff
	else
		patch < acer-tm4xxx-sbs-cm.diff
	fi
	iasl dsdt.dsl
}

src_install () {
	dodir /etc/dsdt
	insinto /etc/dsdt
	doins DSDT.aml
}
