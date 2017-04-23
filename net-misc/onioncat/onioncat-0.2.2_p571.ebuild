# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_P=${P/_p/.r}
DESCRIPTION="An IP-Transparent Tor Hidden Service Connector"
HOMEPAGE="http://www.cypherpunk.at/onioncat"
SRC_URI="https://www.cypherpunk.at/ocat/download/Source/current/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-vpn/tor"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e '/CFLAGS=/s#-O2##g' \
		-e '/CFLAGS=/s#-g##g' \
		configure || die
}

src_install() {
	default
	newinitd "${FILESDIR}"/onioncat.initd-r1 onioncat
	newconfd "${FILESDIR}"/onioncat.confd onioncat
	insinto /var/lib/tor
	doins glob_id.txt hosts.onioncat
}

pkg_postinst() {
	einfo "See https://www.onioncat.org/configuration/"
	einfo "for configuration guide."
}
