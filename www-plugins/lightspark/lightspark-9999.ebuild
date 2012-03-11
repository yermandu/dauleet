# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit multilib cmake-utils git

DESCRIPTION="High performance flash player designed from scratch to be efficient on modern hardware"
HOMEPAGE="https://launchpad.net/lightspark"
SRC_URI=""
EGIT_REPO_URI="git://github.com/lightspark/lightspark.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa nsplugin openal pulseaudio sdl"

RDEPEND="dev-libs/libpcre[cxx]
        media-fonts/liberation-fonts
        media-video/ffmpeg
        media-libs/fontconfig
        media-libs/ftgl
        >=media-libs/glew-1.5.3
        media-libs/libsdl
        alsa? (
                media-sound/alsa-utils
        )
        openal? (
                media-libs/openal
        )
		sdl? (
				media-libs/sdl-sound 
		)
        pulseaudio? (
                media-sound/pulseaudio
        )
        net-misc/curl
        >=sys-devel/gcc-4.4
        >=sys-devel/llvm-2.8-r2
        virtual/ffmpeg
		virtual/opengl
        nsplugin? (
                dev-libs/nspr
                net-libs/xulrunner
                x11-libs/gtk+:2
                x11-libs/gtkglext
        )
        x11-libs/libX11
		dev-cpp/libxmlpp
		dev-libs/libdbusmenu"

DEPEND="${RDEPEND}
        dev-lang/nasm
        dev-util/pkgconfig"

src_configure() {
        local mycmakeargs="$(cmake-utils_use nsplugin COMPILE_PLUGIN)
                -DPLUGIN_DIRECTORY=/usr/$(get_libdir)/nsbrowser/plugins"

# Default order: pulseaudio, openal, alsa , sdl
        if use pulseaudio; then
            local mycmakeargs="${mycmakeargs} -DAUDIO_BACKEND=pulseaudio"
        else if use openal; then
            local mycmakeargs="${mycmakeargs} -DAUDIO_BACKEND=openal"
        else if use alsa; then
                local mycmakeargs="${mycmakeargs} -DAUDIO_BACKEND=alsa"
        else if use sdl; then
			local mycmakeargs="${mycmakeargs} -DAUDIO_BACKEND=sdl"
		fi
		fi
		fi
		fi
		
        if ! use alsa && ! use openal && ! use pulseaudio && ! use sdl; then
                local mycmakeargs="${mycmakeargs}
                        -DAUDIO_BACKEND=none"
        fi
        cmake-utils_src_configure
}

pkg_postinst() {
        if use nsplugin && ! has_version www-plugins/gnash; then
                elog "Lightspark now supports gnash fallback for its browser plugin."
                elog "Install www-plugins/gnash to take advantage of it."
        fi
        if use nsplugin && has_version www-plugins/gnash[nsplugin]; then
                elog "Having two plugins installed for the same MIME type may confuse"
                elog "Mozilla based browsers. It is recommended to disable the nsplugin"
                elog "USE flag for either gnash or lightspark. For details, see"
                elog "https://bugzilla.mozilla.org/show_bug.cgi?id=581848"
        fi
		elog    ""
		elog	"You can switch your backend audio in file:"
		elog	"/etc/xdg/lightspark.conf"
}

# :wq
