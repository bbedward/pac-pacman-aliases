pkgname=pac-pacman-aliases
pkgver=1.3
pkgrel=1
pkgdesc="Add pac with apt-like pacman aliases and bash globbing pattern search instead of regex."
arch=('any')
url="https://github.com/bbedward/pac-pacman-aliases"
license=('MIT')
depends=('zsh')
source=("https://github.com/bbedward/pac-pacman-aliases/archive/refs/tags/v1.3.zip")
sha256sums=('SKIP')

package() {
  install -Dm755 "$srcdir/pac" "$pkgdir/usr/local/bin/pac"
  install -Dm755 "$srcdir/_pac_pacman_completions" "$pkgdir/usr/share/zsh/site-functions/_pac_pacman_completions"
}