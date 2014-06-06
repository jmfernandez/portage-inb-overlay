#!/bin/sh

DIR="${HOME}/.loki/heroes3"

if [ ! -d "${DIR}" ]; then
    echo "* Creating '${DIR}'"
    mkdir -p "${DIR}"
fi

# fixes bug #93604
cd "${DIR}"

# Fixes Xinerama
if [ -z "$SDL_VIDEO_FULLSCREEN_HEAD" ] ; then
	SDL_VIDEO_FULLSCREEN_HEAD=0
fi

LD_LIBRARY_PATH="GAMES_PREFIX_OPT/heroes3:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH
exec GAMES_PREFIX_OPT/heroes3/heroes3.dynamic "${@}"
