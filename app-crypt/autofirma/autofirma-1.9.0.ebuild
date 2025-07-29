# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-utils-2 rpm xdg

DESCRIPTION="Spanish government's electronic signature application for online procedures"
HOMEPAGE="
	https://administracionelectronica.gob.es/ctt/clienteafirma
	https://github.com/ctt-gob-es/clienteafirma
"
# Upstream blocks wget, so we need a fallback option
# https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma$(ver_rs 1- '' $(ver_cut 1-2))/Autofirma_Linux_Fedora.zip
SRC_URI="https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma$(ver_rs 1- '' $(ver_cut 1-2))/Autofirma_Linux_Fedora.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="|| ( GPL-2 EUPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jre:11"
BDEPEND="app-arch/unzip"

#pkg_nofetch() {
#	einfo "Please download:"
#	einfo " https://estaticos.redsara.es/comunes/autofirma/$(ver_rs 1- /)/AutoFirma_Linux_Fedora.zip"
#	einfo "and move it to ${PORTAGE_ACTUAL_DISTDIR}/${PF}.zip."
#}

src_unpack() {
	default
	rpm_unpack "./${PN}-$(ver_cut 1-2)-1.noarch_FEDORA.rpm"
}

src_install() {
	java-pkg_dojar "usr/lib64/${PN}/${PN}.jar"
	java-pkg_dolauncher
	java-pkg_dojar "usr/lib64/${PN}/${PN}Configurador.jar"
	java-pkg_dolauncher ${PN}Configurador \
		--jar ${PN}Configurador.jar
	doicon "usr/lib64/${PN}/${PN}.png"
	make_desktop_entry \
		"${PN} %u" AutoFirma "${PN}" "Utility" \
		"Comment[es]=Aplicación de firma electrónica de la FNMT\nMimeType=x-scheme-handler/afirma"
	make_desktop_entry \
		"${PN}Configurador %u" "Configurador AutoFirma" "${PN}" "Utility" \
		"Comment[es]=Configurador de la aplicación de firma electrónica de la FNMT\nMimeType=x-scheme-handler/afirma"
}
