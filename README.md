# pac-pacman-aliases

Apt-like pacman aliases for pacman. Including zsh-completions.

[AUR - pac-pacman-aliases](https://aur.archlinux.org/packages/pac-pacman-aliases)
[AUR - pac-pacman-aliases-zsh-completions](https://aur.archlinux.org/packages/pac-pacman-aliases-zsh-completions)

## About

A very simple wrapper for [pacman](https://wiki.archlinux.org/title/pacman), [yay](https://github.com/Jguer/yay), and [paru](https://github.com/Morganamilo/paru).

The point is that I maintain a lot of debian-based systems, but use arch on my personal machine. Instead of accidentally typing pacman commands on debian or accidentally trying apt commands on arch I took the lazy approach to not re-train my brain and just make a wrapper.

You can put `alias apt="pac"` in `~/.zshrc` or `~/.bashrc` to make it a synonym for apt.

## Glob pattern search

I prefer glob pattern search to instead of regex searching the search feature takes globs.

e.g. `pac search 'nvidia*'` instead of `pacman -Ss 'nvidia.*'`


## Argument Translation

Passing `-y` translated into `--noconfirm` for pacman/paru/yay. This makes `pac install -y nano` equivalent to `apt install -y nano`

## Equivalent Table

| Operation          | pac                           | pacman                  | apt                     |
|--------------------|-------------------------------|-------------------------|-------------------------|
| Update Database    | Not directly supported (use `upgrade`) | `pacman -Sy`            | `apt update`            |
| Upgrade Packages   | `pac upgrade`                 | `pacman -Syu`           | `apt upgrade`           |
| Install Package    | `pac install <pkg>`           | `pacman -S <pkg>`       | `apt install <pkg>`     |
| Remove Package     | `pac remove <pkg>`            | `pacman -R <pkg>`       | `apt remove <pkg>`      |
| Autoremove Packages| `pac autoremove`              | `pacman -Rs $(pacman -Qdtq)` | `apt autoremove`     |
| Clean Cache        | `pac clean`                   | `pacman -Scc`           | `apt clean`             |
| Autoclean Cache    | `pac autoclean`               | `pacman -Rns $(pacman -Qtdq)`  | `apt autoclean`         |
| List Installed     | `pac list --installed`          | `pacman -Q`             | `apt list --installed`  |
| Search Packages    | `pac search <query>`          | `pacman -Ss <query>`    | `apt search <query>`    |
| Show Package Info  | `pac show <pkg>`              | `pacman -Si <pkg>`      | `apt show <pkg>`        |
| Find Package by File | `pac find <file>`            | `pacman -F <file>`      | `apt-file find <file>`|

## AUR

If paru or yay is installed, aur features are enabled. The equivalence table is below:

| Operation      | pac                       | apt | paru                   | yay                   |
|----------------|---------------------------|-----|------------------------|-----------------------|
| AUR Search     | `pac aur search <query>`  | N/A | `paru -Ssa <query>`     | `yay -Ssa <query>`     |
| AUR Install    | `pac aur install <pkg>`   | N/A | `paru -S <pkg>`        | `yay -S <pkg>`        |
| AUR Upgrade    | `pac aur upgrade`         | N/A | `paru -Sua`  | `yay`  |


