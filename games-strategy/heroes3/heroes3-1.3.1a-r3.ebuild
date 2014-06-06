# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/heroes3/heroes3-1.3.1a-r2.ebuild,v 1.12 2009/04/14 07:31:38 mr_bones_ Exp $

#	[x] Base Install Required (+4 MB)
#	[x] Scenarios (+7 MB)
#	[x] Sounds and Graphics (+118 MB)
#	[x] Music (+65 MB)
#	[x] Videos (+147 MB)
#	--------------------
#	Total 341 MB

LANGS="en de es fr it pl ru"
LANGPACKPREFIX="babelize-${PN}"
LANGPACKBASE="https://babelize.org/download/"
LANGPACKPATHPREFIX="${LANGPACKBASE}/${LANGPACKPREFIX}/${LANGPACKPREFIX}"
LANGPACKVERSION=1.0.0

inherit eutils games

DESCRIPTION="Heroes of Might and Magic III : The Restoration of Erathia - turn-based 2-D medieval combat"
HOMEPAGE="http://www.lokigames.com/products/heroes3/"

# Since I do not have a PPC machine to test with, I will leave the PPC stuff in
# here so someone else can stabilize loki_setupdb and loki_patch for PPC and
# then KEYWORD this appropriately.
SRC_URI="x86? ( mirror://lokigames/${PN}/${P}-cdrom-x86.run )
	amd64? ( mirror://lokigames/${PN}/${P}-cdrom-x86.run )
	ppc? ( mirror://lokigames/${PN}/${P}-ppc.run
		http://mirrors.dotsrc.org/lokigames/patches/${PN}/${PN}-1.3.1-ppc.run )
"

IUSE="dynamic nocd maps music sounds videos"

for lang in $LANGS ; do
	if [ "$lang" != 'en' ] ; then 
		SRC_URI="${SRC_URI}
	linguas_${lang}? ( ${LANGPACKPATHPREFIX}-${lang}-${LANGPACKVERSION}.tar.bz2 )
"
	fi
	IUSE="${IUSE} linguas_${lang}"
done

#		${LANGPACKBASE}/${PN}-localize-${LANGPACKVERSION}.run

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
RESTRICT="strip"
PROPERTIES="interactive"

DEPEND="=dev-util/xdelta-1*
	games-util/loki_patch"
RDEPEND="!ppc? ( sys-libs/lib-compat-loki )
	dynamic? (
		x86? (
			media-libs/libsdl
			media-libs/sdl-mixer
			media-libs/smjpeg
			x11-libs/libXext
			x11-libs/libX11
		)
		amd64? (
			app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-xlibs
			app-emulation/emul-linux-x86-sdl
		)
	)
"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	strip-linguas ${LANGS}

	use nocd && fullinstall=1
	use sounds && use videos && use maps && fullinstall=1

	[[ ${fullinstall} -eq 1 ]] \
		&& ewarn "The full installation takes about 341 MB of space!"

	if [[ -n "${fullinstall}" ]]
	then
		langcount=0
		for i in ${LINGUAS}
		do
			i="${i/_/-}"
			if [[ ${i} != "en" ]]
			then
				let $((++langcount))
				if [[ $langcount = 2 ]]
				then
					eerror "Heroes3 only supports one localization at once!"
					die "Localization is only supported when Heroes3 is in a single language!"
				fi
			fi
		done
	else
		for i in ${LINGUAS}
		do
			i="${i/_/-}"
			if [[ ${i} != "en" ]]
			then
				eerror "Full installation (nocd flag or data + video + maps flags) is needed for ${i} language!"
				die "Localization is only supported when Heroes3 is fully locally installed!"
			fi
		done
	fi
}

src_unpack() {
	cdrom_get_cds hiscore.tar.gz
	if use ppc ; then
		unpack_makeself ${P}-ppc.run
		unpack_makeself ${PN}-1.3.1-ppc.run
	else # x86,amd64
		unpack_makeself ${P}-cdrom-x86.run
	fi

	for i in ${LINGUAS}
	do
		i="${i/_/-}"
		if [[ ${i} != "en" ]]
		then
			mkdir -p localize/tmp
			cd localize/tmp
			unpack ${LANGPACKPREFIX}-${i}-${LANGPACKVERSION}.tar.bz2
			cd ..
			unpack ./tmp/${LANGPACKPREFIX}-${i}-${LANGPACKVERSION}/share/babelize/langpacks/${PN}-lang-${i}.tar.gz
			break
		fi
	done
}

src_install() {
	exeinto "${dir}"
	insinto "${dir}"
	einfo "Copying files... this may take a while..."

	# On PPC the 1.3.1a patch works only on the 1.3.1 patched version!
	if use ppc
	then
		xdelta patch heroes3.ppc "${CDROM_ROOT}"/bin/x86/${PN} heroes3
		doexe heroes3
	else
		doexe "${CDROM_ROOT}"/bin/x86/${PN}
	fi

	doins "${CDROM_ROOT}"/{Heroes_III_Tutorial.pdf,README,icon.{bmp,xpm}}

	if use nocd
	then
		doins -r "${CDROM_ROOT}"/{data,maps,mp3} || die "copying data"
	else
		if use maps
		then
			doins -r "${CDROM_ROOT}"/maps
		fi
		if use music
		then
			doins -r "${CDROM_ROOT}"/mp3
		fi
		if use sounds
		then
			insinto "${dir}"/data
			doins "${CDROM_ROOT}"/data/{*.lod,*.snd}
		fi
		if use videos
		then
			doins -r "${CDROM_ROOT}"/data/video
		fi
	fi

	if [[ -n "${fullinstall}" ]]
	then
		for i in ${LINGUAS}
		do
			i="${i/_/-}"
			if [[ ${i} != "en" ]]
			then
				einfo "Applying l10n: ${i} ..."
				find "${S}/localize/${i}" -type f | while read xfile
				do
					local file=$(echo "${xfile}" | \
						sed "s#^${S}/localize/${i}/##;s#\.1\.xdelta\$##")
					ebegin "Localizing ${file}"
					xdelta patch "${xfile}" "${Ddir}/${file}" "${Ddir}/${file}.xdp"
					local retval=$?
					if [[ $retval = 0 ]]
					then
						mv -f  "${Ddir}/${file}.xdp" "${Ddir}/${file}"
					else
						rm -f "${Ddir}/${file}.xdp"
					fi
					eend $retval "File $file could not be localized/patched! Original english version untouched..."
				done
				break
			fi
		done
	fi

	tar zxf "${CDROM_ROOT}"/hiscore.tar.gz -C "${Ddir}" || die "unpacking hiscore"

	cd "${S}"
	loki_patch --verify patch.dat
	loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find "${Ddir}" -exec touch '{}' \;

	newicon "${CDROM_ROOT}"/icon.xpm heroes3.xpm

	prepgamesdirs
	make_desktop_entry heroes3 "Heroes of Might and Magic III" "heroes3"
	if use dynamic ; then
		make_desktop_entry heroes3-dynamic "Heroes of Might and Magic III (dynamic)" "heroes3"
	fi

	if ! use ppc
	then
		einfo "Linking libs provided by 'sys-libs/lib-compat-loki' to '${dir}'."
		dosym /usr/lib/loki_libsmpeg-0.4.so.0 "${dir}"/libsmpeg-0.4.so.0 \
			|| die "dosym failed"
	fi

	if [ -r "${dir}/data/hiscore.dat" ] ; then
		elog "Keeping previous hiscore.dat file"
		cp "${dir}/data/hiscore.dat" "${Ddir}/data"
	fi

	elog "Changing 'hiscore.dat' to be writeable for group 'games'."
	fperms g+w "${dir}/data/hiscore.dat" || die "fperms failed"

	# in order to play campaign games, put this wrapper in place.
	# it changes CWD to a user-writeable directory before executing heroes3.
	# (fixes bug #93604)
	einfo "Preparing wrappers."

	cp "${FILESDIR}"/heroes3-wrapper.sh "${T}"/heroes3 || \
		die "copying static wrapper failed"
	sed -i -e "s:GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" "${T}"/heroes3 ||
		die "sed failed"
	dogamesbin "${T}"/heroes3 || die "doexe failed"
	
	if use dynamic ; then
		cp "${FILESDIR}"/heroes3-wrapper-dynamic.sh "${T}"/heroes3-dynamic || \
			die "copying dynamic wrapper failed"
		sed -i -e "s:GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" "${T}"/heroes3-dynamic ||
			die "sed failed"
		dogamesbin "${T}"/heroes3-dynamic || die "doexe failed"
	fi
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " heroes3"
	elog "for the statically linked version"
	if use dynamic ; then
		elog "For the dynamically linked one you must run:"
		elog " heroes3-dynamic"
	fi
}
