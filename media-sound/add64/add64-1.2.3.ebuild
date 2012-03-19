# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools eutils

DESCRIPTION="Add64 is an additive synthesizer. It is based on QT and uses the
JACK Audio Connection Kit for platform independent audio/midi I/O."
HOMEPAGE="http://add64.sourceforge.net"
SRC_URI="http://sourceforge.net/projects/add64/files/Add64-$PV.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jack"

DEPEND=""
RDEPEND="${DEPEND}"

