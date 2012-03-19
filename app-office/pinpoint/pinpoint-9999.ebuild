# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/pinpoint/pinpoint-0.1.4.ebuild,v 1.1 2011/12/01 17:57:06 leio Exp $

EAPI=4

inherit gnome.org git-2 eutils autotools python

DESCRIPTION="A tool for making hackers do excellent presentations"
HOMEPAGE="https://live.gnome.org/Pinpoint"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples +gstreamer +pdf"
SRC_URI=""
SCM=git-2
EGIT_BOOTSTRAP="./autogen.sh"
EGIT_REPO_URI="http://git.gnome.org/browse/pinpoint"

# rsvg is used for svg-in-pdf -- clubbing it under pdf for now
RDEPEND=">=media-libs/clutter-1.4:1.0
	>=dev-libs/glib-2.28:2
	>=x11-libs/cairo-1.9.4
	x11-libs/pango
	x11-libs/gdk-pixbuf:2
	gstreamer? ( >=media-libs/clutter-gst-1.3:1.0 )
	pdf? ( gnome-base/librsvg:2 )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"
pkg_setup() {
	G2CONF="${G2CONF}"
}

src_unpack(){
	git-2_src_unpack
#	unpack ${A}
	cd "${S}"
}
src_prepare(){
	gnome2_src_prepare
}
src_configure() {
	# dax support is disabled because we don't have it in tree yet and it's
	# experimental
	econf --disable-dax \
		$(use_enable gstreamer cluttergst) \
		$(use_enable pdf rsvg)
}

src_install() {
	default

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins introduction.pin bg.jpg bowls.jpg linus.jpg
	fi
}
