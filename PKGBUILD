pkgname=pac-pacman-aliases
pkgver=master
pkgrel=1
pkgdesc="Add pac with apt-like pacman aliases, completions, and  globbing search pattern support"
arch=('any')
url="https://github.com/bbedward/pac-pacman-aliases"
license=('MIT')
source=("https://github.com/bbedward/pac-pacman-aliases/archive/refs/heads/master.zip")
sha256sums=('SKIP')
conflicts=('pac-wrapper')

package() {
  install -Dm755 "$srcdir/pac" "$pkgdir/usr/local/bin/pac"
  install -Dm644 "$srcdir/completions.bash" "$pkgdir/usr/share/bash-completion/completions/pac"
  install -Dm644 "$srcdir/completions.zsh" "$pkgdir/usr/share/zsh/site-functions/_pac_pacman_completions"
  install -Dm644 "$srcdir/completions.fish" "$pkgdir/usr/share/fish/completions/pac.fish"
}
