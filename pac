#!/bin/bash



prompt_for_sudo() {
    if [[ $(id -u) -ne 0 ]]; then
       SUDO="sudo"
        echo "This action requires root privileges. Do you want to proceed? (y/n)"
        read -r answer
       case "${answer,,}" in
            y|yes)
                if ! sudo -v; then
                    echo "Failed to obtain sudo privileges."
                    exit 1
                fi
                ;;
            *)
                echo "Operation cancelled."
                exit 1
                ;;
        esac
    else
      SUDO=""
    fi
}

help() {
        cat <<EOF
Usage: pac <command> [options]

Commands:
    update          Update package database
    upgrade         Upgrade all installed packages
    install         Install a new package
    remove          Remove an installed package
    autoremove      Remove unneeded packages
    clean           Clean the package cache
    autoclean       Remove old versions of installed packages
    list-installed  List all installed packages
    search          Search the package database
    show            Show detailed package information
    find            Find a package by binary name
    aur-search      Search in the AUR
    aur-install     Install a package from the AUR

For more information on a specific command, type 'pac <command> --help'
EOF
}

if [[ "$1" == "--help" ]]; then
    help
    exit 0
fi

case "$1" in
    update)
        prompt_for_sudo
        $SUDO pacman -Sy
    ;;
    upgrade)
        prompt_for_sudo
        $SUDO pacman -Syu
    ;;
    install)
        shift
        prompt_for_sudo
        $SUDO pacman -S "$@"
    ;;
    remove)
        shift
        prompt_for_sudo
        $SUDO pacman -R "$@"
    ;;
    autoremove)
        prompt_for_sudo
        $SUDO pacman -Rs $(pacman -Qtdq)
    ;;
    clean)
        prompt_for_sudo
        $SUDO pacman -Scc
    ;;
    autoclean)
        prompt_for_sudo
        $SUDO pacman -Rns $(pacman -Qtdq)
    ;;
    list-installed)
        pacman -Q
    ;;
    search)
        shift
        local pattern=$(echo "$@" | sed 's/\*/.*/g;s/\?/./g')
        pacman -Ss "$pattern"
    ;;
    show)
        shift
        pacman -Si "$@"
    ;;
    find)
        shift
        pacman -F "$@"
    ;;
    aur-search)
        shift
        yay -Ssa "$@"
    ;;
    aur-install)
        shift
        yay -S "$@"
    ;;
    *)
        help
        exit 1
esac
