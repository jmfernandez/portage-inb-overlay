# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Acer Travelmate 4001 ACPI fixes (CPU frequency table, optimizations)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-power/iasl-20050513"
RDEPEND=""

DSDTFILE="dsdt"
DSDTDIR="/usr/share/acpi-dsdt"

src_unpack()
{
	mkdir -p "${S}"
	cd "${S}"
	cat /proc/acpi/dsdt > ${DSDTFILE}.dat || die "ACPI support is not loaded! Unable to patch DSDT!"
	iasl -d ${DSDTFILE}.dat
	epatch ${FILESDIR}/travelmate-4001.patch || die "Error while patching DSDT"
}

src_compile()
{
	iasl -tc ${DSDTFILE}.dsl || die "Error while compiling patched DSDT"
	cp ${DSDTFILE}.hex ${PN}.hex
}

src_install()
{
	insinto ${DSDTDIR}
	doins ${PN}.hex
	doins ${FILESDIR}/travelmate-4001.patch
}

