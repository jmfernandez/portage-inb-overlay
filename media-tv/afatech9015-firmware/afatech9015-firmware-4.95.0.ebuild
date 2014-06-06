# Based on afatech9005-firmware.ebuild from sabayon
# ==========================================================================
# This ebuild come from sabayon repository. Zugaina.org only host a copy.
# For more info go to http://gentoo.zugaina.org/
# ************************ General Portage Overlay ************************
# ==========================================================================
# Copyright 2006 SabayonLinux
# Distributed under the terms of the GNU General Public License v2

BC_REVISION="1"
DESCRIPTION="Firmware for the Afatech 9015/9016 DVB-T device"
HOMEPAGE="http://www.linuxtv.org/"
SRC_URI="http://www.otit.fi/~crope/v4l-dvb/af9015/af9015_firmware_cutter/firmware_files/${PV}/dvb-usb-af9015.fw"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

IUSE=""
RDEPEND=">=sys-apps/hotplug-20040923"

src_unpack()
{
	cp ${DISTDIR}/dvb-usb-af9015.fw ${WORKDIR}/
}

src_install() {
	cd ${WORKDIR}/
	insinto /lib/firmware
	doins *.fw
}
