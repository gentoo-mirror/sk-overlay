# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="nondescript"
HOMEPAGE="https://www.zerotier.com/"
SRC_URI="https://github.com/zerotier/ZeroTierOne/archive/${PV}.tar.gz -> zerotier-one-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	controller
	installer
"

DEPEND=""
RDEPEND="
	${DEPEND}
	controller? ( =dev-db/sqlite-3* )
"

src_unpack() {
	unpack ${A}

	mv "${WORKDIR}/ZeroTierOne-${PV}" "${WORKDIR}/zerotier-one-${PV}"
}

src_compile() {
	local make_controller=0

	if use "controller"
	then
		make_controller=1
	fi

	make \
		ZT_ENABLE_NETWORK_CONTROLLER=${make_controller} \
		|| die "make failed"

	if use "installer"
	then
		make \
			ZT_ENABLE_NETWORK_CONTROLLER=${make_controller} \
			installer \
			|| die "make installer failed"
	fi
}

src_install() {
	dobin "${S}/zerotier-one"
	newbin "${S}/zerotier-one" "zerotier-cli"

	if use "installer"
	then
		newbin "${S}/ZeroTierOneInstaller-linux-x64-${PV//./_}" "zerotier-installer"
	fi
}
