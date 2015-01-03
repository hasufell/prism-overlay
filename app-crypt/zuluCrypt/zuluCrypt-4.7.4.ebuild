# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib cmake-utils

DESCRIPTION="Front end to cryptsetup"
HOMEPAGE="https://github.com/mhogomchungu/zuluCrypt https://code.google.com/p/zulucrypt"
SRC_URI="https://github.com/mhogomchungu/zuluCrypt/releases/download/${PV}/zuluCrypt-${PV}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome kde udev"

RDEPEND="
	dev-libs/libgcrypt:0
	dev-libs/libpwquality
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-apps/util-linux
	sys-fs/cryptsetup
	gnome? ( app-crypt/libsecret )
	kde? (
		kde-base/kdelibs:4
		kde-base/kwalletd:4
	)
	udev? ( virtual/udev )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${P}-build-switches.patch
	"${FILESDIR}"/${P}-qt-build.patch
)

src_configure() {
	local mycmakeargs=(
		-DUDEVSUPPORT="$(usex udev "true" "false")"
		-DWITH_TCPLAY=FALSE
		-DWITH_PWQUALITY=TRUE
		-DLIB_SUFFIX="$(get_libdir)"
		$(cmake-utils_use !gnome NOGNOME)
		$(cmake-utils_use !kde NOKDE)
	)

	cmake-utils_src_configure
}
