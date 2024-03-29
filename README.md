# pac-pacman-aliases

Apt-like pacman aliases for pacman. Inclduing zsh and bash completions.

[AUR - pac-pacman-aliases](https://aur.archlinux.org/packages/pac-pacman-aliases)

## About

A very simple wrapper for [pacman](https://wiki.archlinux.org/title/pacman), [yay](https://github.com/Jguer/yay), and [paru](https://github.com/Morganamilo/paru).

The point is that I maintain a lot of debian-based systems, but use arch on my personal machine. Instead of accidentally typing pacman commands on debian or accidentally trying apt commands on arch I took the lazy approach to not re-train my brain and just make a wrapper.

You can put `alias apt="pac"` in `~/.zshrc` or `~/.bashrc` to make it a synonym for apt.

## Glob pattern search

In addition to the pacman regex searching, `pac` supports shell globbing patterns.

e.g. `pac search 'nvidia*'` instead of `pacman -Ss 'nvidia.*'`

It does this by detecting regex and doing a no-op, if regex is not detected then globbing patterns get converted to regex automatically.

## Argument Translation

Passing `-y` translated into `--noconfirm` for pacman/paru/yay. This makes `pac install -y nano` equivalent to `apt install -y nano`

## Equivalent Table

| Operation             | pac                                 | pacman                           | apt                             |
|-----------------------|-------------------------------------|----------------------------------|---------------------------------|
| Update Database       | Not directly supported (use `upgrade`) | `pacman -Sy`                  | `apt update`                  |
| Upgrade Packages      | `pac upgrade`                       | `pacman -Syu`                 | `apt upgrade`                 |
| Install Package       | `pac install <pkg>`                 | `pacman -S <pkg>`             | `apt install <pkg>`           |
| Remove Package        | `pac remove <pkg>`                  | `pacman -R <pkg>`              | `apt remove <pkg>`            |
| Autoremove Packages   | `pac autoremove`                    | `pacman -Rs $(pacman -Qdtq)`   | `apt autoremove`              |
| Clean Cache           | `pac clean`                         | `pacman -Scc`                  | `apt clean`                   |
| Autoclean Cache       | `pac autoclean`                     | `pacman -Rns $(pacman -Qtdq)`  | `apt autoclean`               |
| List Installed        | `pac list --installed`              | `pacman -Q`                    | `apt list --installed`        |
| List Manually Installed | `pac list --manual`               | `pacman -Qm`                   | `apt-mark showmanual`         |
| List Upgradable       | `pac list --upgradable`             | `pacman -Qu`                   | `apt list --upgradable`       |
| List All              | `pac list --all`                    | `pacman -Sl`                   | `apt list`                     |
| Search Packages       | `pac search <query>`                | `pacman -Ss <query>`           | `apt search <query>`          |
| Show Package Info     | `pac show <pkg>`                    | `pacman -Si <pkg>`             | `apt show <pkg>`              |
| Find Package by File  | `pac find <file>`                   | `pacman -F <file>`             | `apt-file find <file>`        |
| Depends               | `pac depends <pkg>`                 | `pactree -s -d1 -o1 <pkg>`     | `apt-cache depends <pkg>`     |
| Rdepends              | `pac rdepends <pkg>`                | `pactree -r -s -d1 -o1 <pkg>`  | `apt-cache rdepends <pkg>`    |

## AUR

If paru or yay is installed, aur features are enabled. The equivalence table is below:

| Operation      | pac                       | apt | paru                   | yay                   |
|----------------|---------------------------|-----|------------------------|-----------------------|
| AUR Search     | `pac aur search <query>`  | N/A | `paru -Ssa <query>`     | `yay -Ssa <query>`     |
| AUR Install    | `pac aur install <pkg>`   | N/A | `paru -S <pkg>`        | `yay -S <pkg>`        |
| AUR Upgrade    | `pac aur upgrade`         | N/A | `paru -Sua`  | `yay`  |


