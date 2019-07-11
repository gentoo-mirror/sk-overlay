# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="SHell Compatibility Tester"
HOMEPAGE="https://gitlab.com/tyil/shct"
SRC_URI="https://gitlab.com/tyil/${PN}/-/archive/master/${PN}-master.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpack "${A}"
	mv -- "${PN}-master" "${P}"
}

src_prepare() {
	eapply_user

	sed 's@%%PATCH_THIS_FOR_YOUR_OS%%@/usr/share/shct@' \
		< bin/shct > "${T}/shct"

	cp "${T}/shct" bin/shct
}

src_install() {
	dobin bin/shct

	mkdir -p "${D}/usr/share/shct"
	cp install-cmds/* "${D}/usr/share/shct/"
}
