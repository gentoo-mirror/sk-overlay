# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A C/C++ implementation of a Sass compiler."
HOMEPAGE="http://libsass.org"
SRC_URI="https://github.com/sass/libsass/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
	+shared
	static
"

DEPEND="
	sys-devel/automake
"
RDEPEND="
	sys-devel/libtool
"

src_configure() {
	autoreconf --force --install

	econf \
		$(use_enable shared) \
		$(use_enable static)
}
