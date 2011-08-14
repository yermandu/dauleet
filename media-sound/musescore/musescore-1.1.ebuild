# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils eutils font

MY_P=mscore-${PV}

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/project/mscore/mscore/MuseScore-${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="X jack"

RDEPEND="sys-libs/zlib
	media-libs/alsa-lib
	media-sound/fluidsynth
	media-sound/jack-audio-connection-kit
	media-libs/portaudio
	>=x11-libs/qt-core-4.6.3-r1
	>=x11-libs/qt-script-4.6.3
	>=x11-libs/qt-qt3support-4.6.3
	>=x11-libs/qt-gui-4.6.3-r2
	>=x11-libs/qt-svg-4.6.3
 	>=x11-libs/qtscriptgenerator-0.1.0
	dev-texlive/texlive-context"

DEPEND="${RDEPEND}
	app-doc/doxygen
	dev-util/pkgconfig"

S=${WORKDIR}/mscore-${PV}/mscore
VARTEXFONTS=${T}/fonts
FONT_SUFFIX=ttf
FONT_S=${S}/mscore/fonts

# When compile fails i try this:
#MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	cmake-utils_src_make lupdate
	cmake-utils_src_make lrelease
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
	font_src_install
	dodoc ChangeLog NEWS README
	doman packaging/mscore.1
}

src_unpack() {
	unpack ${A}
	cd "${S}"
 epatch "${FILESDIR}"/musescore-1.0-no-scriptgen.patch
}


