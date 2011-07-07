# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

MY_PN="${PN/songwrite/Songwrite}"

DESCRIPTION="A music score and songbook editor written in python"
HOMEPAGE="http://home.gna.org/oomadness/en/songwrite/index.html"
SRC_URI="http://download.gna.org/songwrite/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="midi print"

DEPEND="media-libs/alsa-lib
	x11-libs/gtk+
	x11-libs/cairo
	midi? ( || ( media-sound/timidity++ media-sound/playmidi ) )
	print? ( media-sound/lilypond )
	dev-python/editobj2"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	app-text/ghostscript-gpl"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils_src_install

	newicon data/songwrite_about.png ${PN}.png || die
	make_desktop_entry ${PN} ${MY_PN} ${PN} 'GTK;AudioVideo;Audio;Education;Music' || die
}
