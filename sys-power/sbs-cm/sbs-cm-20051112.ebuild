# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Smart Battery System Control Method for Acer Laptops"
HOMEPAGE="http://sourceforge.net/projects/sbs-linux"
SRC_URI="mirror://sourceforge/sbs-linux/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="tm32xx tm4xxx"

DEPEND=">=sys-power/iasl-20050513
tm4xxx? ( sys-power/travelmate4001-acpi-patch )"
RDEPEND=""

DSDTFILE="dsdt"
DSDTDIR="/usr/share/acpi-dsdt"

pkg_setup() {
	use tm4xxx || use tm32xx || die "This package needs either tm4xxx or tm32xx flag!"
}

src_unpack() {
	unpack ${A}
	mkdir -p "${S}"
	cd "${S}"
	cat /proc/acpi/dsdt > ${DSDTFILE}.dat || die "ACPI support is not loaded! Unable to patch DSDT!"
	iasl -d ${DSDTFILE}.dat
	if grep -q SBMUS01 ${DSDTFILE}.dsl ; then
		die "Current ACPI DSDT table is already patched! Boot with an unpatched kernel"
	fi
	if use tm4xxx ; then
		epatch ${DSDTDIR}/travelmate-4001.patch
		epatch acer-tm4xxx-sbs-cm.diff
		if use tm32xx ; then
			ewarn "You have set both tm4xxx and tm32xx. Ignoring this last one..."
		fi
	elif use tm32xx ; then
		epatch acer-tm32xx-sbs-cm.diff
	fi
}

src_compile() {
	iasl -tc ${DSDTFILE}.dsl || die "Error while compiling patched DSDT"
	cp ${DSDTFILE}.hex ${PN}.hex
}

src_install() {
	insinto ${DSDTDIR}
	doins ${PN}.hex
}
