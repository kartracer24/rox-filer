# Maintainer: jun7 <jun7@hush.com>
# Contributor: tobias <tobias@archlinux.org>
# Contributor: Jochem Kossen <j.kossen@home.nl>

pkgname=rox-filer
pkgver=2.11.h.2542.a0065347
pkgrel=1
branch=master
pkgdesc="A fork of rox-filer having 64 - 512px icons"
arch=('i686' 'x86_64')
conflicts=('rox')
provides=('rox')
license=('GPL')
url="https://github.com/kartracer24/rox-filer"
depends=('sh' 'libsm' 'gtk2')
makedepends=('libxslt' 'git')
source=("git+https://github.com/kartracer24/rox-filer.git#branch=$branch")
md5sums=('SKIP')

pkgver(){
  cd "$srcdir/rox-filer"
  printf "2.11.h.%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
  cd "$srcdir/rox-filer"
  git pull --rebase origin $branch
}

build() {
  cd "$srcdir/rox-filer"
  # build.sh handles the GCC 14+ -Wincompatible-pointer-types fix and
  # forwards extra arguments to configure.
  ./build.sh LIBS="-ldl -lm"
}

package() {
  cd "$srcdir/rox-filer"
  install -d "$pkgdir/usr/share/Choices/MIME-types"
  install -m755 Choices/MIME-types/* "$pkgdir/usr/share/Choices/MIME-types/"
  cp -rp ROX-Filer "$pkgdir/usr/share/"
  rm -fr "$pkgdir"/usr/share/ROX-Filer/{src,build}

  # AppRun sets APP_DIR and execs the binary; use it as the system launcher
  install -Dm755 "$srcdir/rox-filer/rox.sh" "$pkgdir/usr/bin/rox"
  install -Dm644 "$srcdir/rox-filer/rox.desktop" "$pkgdir/usr/share/applications/rox.desktop"
  install -Dm644 "$srcdir/rox-filer/ROX-Filer/.DirIcon" "$pkgdir/usr/share/pixmaps/rox.png"
}
