# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: npm-alt.eclass
# @MAINTAINER:
# José María Fernández
# @BLURB: Eclass for NodeJS packages available through the npm registry.
# @DESCRIPTION:
# This eclass contains various functions that may be useful when
# dealing with packages from the npm registry, for NodeJS.
# Requires EAPI=2 or later.

case ${EAPI} in
    2|3|4|5) : ;;
    *)     die "npm.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

inherit multilib

# @ECLASS-VARIABLE: NPM_MODULE
# @DESCRIPTION:
# Name of the resulting NodeJS/npm module. 
# The Default value for NPM_MODULE is ${PN}
#
# Example: NPM_MODULE="${MY_PN}"
NPM_MODULE="${PN}"

# @ECLASS-VARIABLE: NPM_FILES
# @INTERNAL
# @DESCRIPTION:
# Files and directories that usually come in a standard
# NodeJS/npm module.
NPM_FILES="lib package.json index.js"

# @ECLASS-VARIABLE: NPM_DOCS
# @INTERNAL
# @DESCRIPTION:
# Document files that usually come in a standard
# NodeJS/npm module.
NPM_DOCS="README* LICENSE HISTORY*"

# @ECLASS-VARIABLE: NPM_EXTRA_FILES
# @DESCRIPTION:
# If additional dist files are present in the NodeJS/npm module
# that are not listed in NPM_FILES, then this is the place to put them in.
# Can be either files, or directories.
# Example: NPM_EXTRA_FILES="rigger.js modules"

# @ECLASS-VARIABLE: NPM_EXTRA_DOCS
# @DESCRIPTION:
# Variable for additional document files that are not listed
# in NPM_DOCS
# Example: NPM_EXTRA_DOCS="docs index.html"

HOMEPAGE="https://www.npmjs.org/package/${PN}"
SRC_URI="http://registry.npmjs.org/${PN}/-/${P}.tgz"

# @FUNCTION: npm-src_unpack
# @DESCRIPTION:
# Default src_unpack function for NodeJS/npm packages. This funtions
# unpacks the source code, then renames the 'package' dir to $S

npm-alt_src_unpack() {
    unpack "${A}"
    mv "${WORKDIR}/package" ${S}
}

# @FUNCTION: npm-src_compile
# @DESCRIPTION:
# This function does nothing.

npm-alt_src_compile() {
    true
}

# @FUNCTION: npm-src_install
# @DESCRIPTION:
# This function installs the NodeJS/npm module to an appropriate location,
# also taking care of NPM_FILES, NPM_EXTRA_FILES, NPM_DOCS and NPM_EXTRA_DOCS

npm-alt_src_install() {
    local npm_files="${NPM_FILES} ${NPM_EXTRA_FILES}"
	local node_base="${D}/usr"
    local node_modules="${node_base}/$(get_libdir)/node_modules/${NPM_MODULE}"

    mkdir -p ${node_base} || die "Could not create DEST folder"

	npm install -g --production --prefix "${node_base}"
	
	# Fixing arches
	if [ $(get_libdir) != 'lib' ] ; then
		mv "${node_base}/lib" "${node_base}/$(get_libdir)"
		# And relative symlinks
		if [ -d "${node_base}/bin" ] ; then
			ln -s "${node_base}/$(get_libdir)" "${node_base}/lib"
			for relbina in "${node_base}/bin"/* ; do
				ln -sf "$(realpath --relative-to "${node_base}/bin" "$relbina")" "$relbina"
			done
			rm "${node_base}/lib"
		fi
	fi

    if has doc ${USE}; then
        local npm_docs="${NPM_DOCS} ${NPM_EXTRA_DOCS}"

        for f in $npm_docs
        do
            if [[ -e "${S}/$f" ]]; then
                dodoc -r "${S}/$f"
            fi
        done
    fi
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
