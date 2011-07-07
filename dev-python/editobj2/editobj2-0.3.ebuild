# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

MY_PN="${PN/editobj/EditObj}"

DESCRIPTION="EditObj2 can create a dialog box to edit ANY Python object."
HOMEPAGE="http://home.gna.org/oomadness/en/editobj/index.html"
SRC_URI="http://download.gna.org/songwrite/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE="examples gtk tk qt4"

DEPEND="dev-python/pycairo
	gtk? ( dev-python/pygtk )
	qt4? ( dev-python/PyQt4 )
	tk?	 ( dev-lang/tk		)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	use examples && (doins -r examples || die)
}

