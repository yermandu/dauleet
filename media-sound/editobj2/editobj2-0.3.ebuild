# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Information : http://bugs.gentoo.org/show_bug.cgi?id=358125

EAPI="2"

inherit

DESCRIPTION="A dialog box generator for Python objects"
HOMEPAGE="http://home.gna.org/oomadness/en/songwrite"
SRC_URI="http://download.gna.org/songwrite/EditObj2-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="timidity"

RDEPEND="media-libs/alsa-lib
	x11-libs/gtk+
	x11-libs/cairo
	dev-python/pygtk
	dev-python/pycairo
	media-sound/timidity++"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/ghostscript-gpl"

src_install() {
	python setup.py install || die "Install failed see bug 358125 "
}


