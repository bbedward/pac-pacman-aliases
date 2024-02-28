# Define completion function
_pac_bash_completion() {
    local cur prev words cword
    _init_completion -n : || return

    # Call the function to detect the AUR helper and set it in a variable
    _detect_aur_helper() {
        if command -v paru > /dev/null; then
            AUR_HELPER="paru"
        elif command -v yay > /dev/null; then
            AUR_HELPER="yay"
        else
            AUR_HELPER=""
        fi
    }

    _detect_aur_helper

    local subcommands="upgrade install remove autoremove clean autoclean list search show find"
    local aur_subcommands="aur_search aur_install aur_upgrade"

    if [[ ${cur} == aur_* ]]; then
        if [[ -n ${AUR_HELPER} ]]; then
            COMPREPLY=($(compgen -W "${aur_subcommands}" -- ${cur}))
        fi
        return 0
    fi

    if [[ ${cur} == list ]]; then
        COMPREPLY=($(compgen -W "--installed" -- ${cur}))
        return 0
    fi

    # Main command completion
    if [[ ${cword} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${subcommands}" -- ${cur}))
        return 0
    fi

    # Placeholder for handling dynamic completion, e.g., for packages
    # This part is simplified. Bash does not support functions like _describe directly.
    case ${prev} in
        install|search|remove|show)
            # This is a placeholder where you would add your logic for package completions
            ;;
        aur)
            COMPREPLY=($(compgen -W "search install upgrade" -- ${cur}))
            ;;
        *)
            ;;
    esac
}

# Register the completion function for the `pac` command
complete -F _pac_bash_completion pac
