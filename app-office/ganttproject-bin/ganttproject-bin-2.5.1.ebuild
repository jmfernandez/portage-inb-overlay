# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-pkg-2

GP_REV=1054
MY_P=${PN/-bin}-${PV}-r${GP_REV}
DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart"
HOMEPAGE="http://www.ganttproject.biz/"
SRC_URI="http://ganttproject.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.6"
RDEPEND="virtual/jre"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/${PN}
	doins -r eclipsito.jar plugins/ || die

	newbin "${FILESDIR}/${PV%.*}-${PN}" ${PN} || die

	insinto /usr/share/${PN}/examples
	doins *.gan || die

	doicon "${S}/plugins/net.sourceforge.ganttproject/data/resources/icons/ganttproject.png"
	make_desktop_entry ${PN} "GanttProject" ${PN/-bin} "Java;Office;ProjectManagement"
}
