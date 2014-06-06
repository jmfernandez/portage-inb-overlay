# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils java-pkg-2

GP_REV=1715
MY_P=${PN/-bin}-${PV}-r${GP_REV}
DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart"
HOMEPAGE="http://www.ganttproject.biz/"
SRC_URI="http://ganttproject.googlecode.com/files/${MY_P}.zip"
SRC_URI="http://dl.ganttproject.biz/${PN/-bin}-${PV}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.6"
RDEPEND="virtual/jre"

S="${WORKDIR}/${MY_P}"

#PVBIN="${PV%.*}"
PVBIN="2.5"

src_install() {
	insinto /usr/share/${PN}
	doins -r eclipsito.jar plugins/ || die

	newbin "${FILESDIR}/${PVBIN}-${PN}" ${PN} || die

	insinto /usr/share/${PN}/examples
	doins *.gan || die

	doicon "${S}/plugins/net.sourceforge.ganttproject/data/resources/icons/ganttproject.png"
	make_desktop_entry ${PN} "GanttProject" ${PN/-bin} "Java;Office;ProjectManagement"
}
