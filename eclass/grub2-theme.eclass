# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: grub2-theme.eclass
# @MAINTAINER:
# José María Fernández <jose.m.fernandez@bsc.es>
# @AUTHOR:
# Sebastian Pipping <sebastian@pipping.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: 
# @DESCRIPTION:

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_GRUB2_THEME_ECLASS} ]]; then
_GRUB2_THEME_ECLASS=1
GRUB2_THEME_DIR=/usr/share/grub/themes
fi
