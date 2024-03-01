# Bash completion for pac

_pac_completion() {
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    # Main pac commands
    local commands="upgrade install remove list search show find clean autoremove autoclean depends rdepends local-install aur"

    # List and AUR subcommands
    local list_subcommands="--installed --manual --upgradable --all"
    local aur_subcommands="search install upgrade"

    case "${prev}" in
        list)
            COMPREPLY=($(compgen -W "${list_subcommands}" -- "${cur}"))
            return 0
            ;;
        aur)
            COMPREPLY=($(compgen -W "${aur_subcommands}" -- "${cur}"))
            return 0
            ;;
        install|depends|rdepends)
            # Suggest packages from the official repositories
            COMPREPLY=($(compgen -W "$(pacman -Slq 2>/dev/null)" -- "${cur}"))
            return 0
            ;;
        show|remove)
            # Suggest only installed packages
            COMPREPLY=($(compgen -W "$(pacman -Qq 2>/dev/null)" -- "${cur}"))
            return 0
            ;;
        local-install)
            # Suggest .pkg.tar.zst files in the current directory
            COMPREPLY=($(compgen -f -X '!*.pkg.tar.zst' -- "${cur}"))
            return 0
            ;;
    esac

    # Complete the arguments to some of the basic commands.
    if [[ ${cur} == -* ]] ; then
        return 0
    fi

    COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
}

complete -F _pac_completion pac
