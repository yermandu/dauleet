# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_P=ClanLib-${PV}
MY_V=2.0

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://clanlib.org/download/releases-${MY_V}/${MY_P}.tgz"

LICENSE="as-is"
SLOT="2.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gui ipv6 mikmod network opengl pcre sdl sqlite vorbis"

# opengl keyword does not drop the GL/GLU requirement.
# Autoconf files need to be fixed
RDEPEND="
	media-libs/libpng
	media-libs/jpeg
	media-libs/freetype
	opengl? (
		virtual/opengl
		virtual/glu
	)
	sdl? (
		media-libs/libsdl
		media-libs/sdl-gfx
	)
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXxf86vm
	media-libs/alsa-lib
	pcre? ( dev-libs/libpcre )
	sqlite? ( dev-db/sqlite )
	mikmod? ( media-libs/libmikmod )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"

S="${WORKDIR}"/${MY_P}

src_configure() {
	econf \
		--enable-dyn \
		--enable-clanNetwork \
		--disable-dependency-tracking \
		$(use_enable x86 asm386) \
		$(use_enable doc docs) \
		$(use_enable opengl clanGL) \
		$(use_enable sdl clanSDL) \
		$(use_enable vorbis clanVorbis) \
		$(use_enable mikmod clanMikMod) \
		$(use_enable pcre clanRegExp) \
		$(use_enable sqlite clanSqlite) \
		$(use_enable network clanNetwork) \
		$(use_enable gui clanGUI) \
		$(use_enable ipv6 getaddr)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc ; then
		dodir /usr/share/doc/${PF}/html || die "dodir failed"
		mv "${D}"/usr/share/doc/clanlib/* "${D}"/usr/share/doc/${PF}/html/ \
			|| die "mv failed"
		rm -rf "${D}"/usr/share/doc/clanlib
	fi

	#FIXME: What about the Resources subdirectory into tarball ?
	# it's not documentation or examples at all, but seems to be extras themes...
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Examples || die "dobin -r failed"
	fi

	dodoc CODING_STYLE CREDITS README* || die "dodoc failed"
}
