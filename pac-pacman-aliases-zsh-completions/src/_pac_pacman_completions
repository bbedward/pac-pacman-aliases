#compdef pac

# Function to detect and set the AUR helper
_detect_aur_helper() {
    if command -v paru > /dev/null; then
        AUR_HELPER="paru"
    elif command -v yay > /dev/null; then
        AUR_HELPER="yay"
    else
        AUR_HELPER=""
    fi
}

# Get all installable packages
_pac_installable_packages() {
    local -a packages
    # Use pacman to get the list of installable packages
    packages=("${(@f)$(pacman -Slq 2>/dev/null)}")
    _describe 'packages' packages
}

# Get all installable packages (AUR only)
# Cache the package list for performance
_pac_installable_packages_aur() {
    local cache_ttl=86400 # 24 hours in seconds
    local cache_file="$HOME/.cache/pac_aur_package_list"
    _detect_aur_helper

    # Ensure cache directory exists
    mkdir -p "${cache_file:h}"

    if [[ -z "$AUR_HELPER" ]]; then
        _message "No AUR helper found."
        return 1
    fi

    # Use the cache if it exists to provide immediate completions
    if [[ -f "$cache_file" ]]; then
        local -a packages
        packages=("${(@f)$(<"$cache_file")}")
        _describe 'AUR packages' packages
    fi

    # Update the cache in the background if it's missing or stale
    if [[ ! -f "$cache_file" || $(( $(date +%s) - $(stat -c '%Y' "$cache_file" 2>/dev/null || stat -f '%m' "$cache_file") )) -gt $cache_ttl ]]; then
        # Asynchronously update the cache without blocking the current shell
        case "$AUR_HELPER" in
            paru)
                (paru -Slq >| "$cache_file" &)
                ;;
            yay)
                (yay -Slqa >| "$cache_file" &)
                ;;
        esac
    fi
}

# Get all installed packages
_pac_installed_packages() {
    local -a packages
    # Use pacman to get the list of installed packages
    packages=("${(@f)$(pacman -Qq 2>/dev/null)}")
    _describe 'installed packages' packages
}

# Get manually installed packages
_pac_manual_packages() {
    local -a packages
    # Use pacman to get the list of explicitly installed packages
    packages=("${(@f)$(pacman -Qqet 2>/dev/null)}")
    _describe 'manually installed packages' packages
}

# Get upgradeable packages
_pac_upgradeable_packages() {
    local -a packages
    # Use pacman to get the list of upgradeable packages
    packages=("${(@f)$(pacman -Quq 2>/dev/null)}")
    _describe 'upgradeable packages' packages
}

# Get all packages, including installed and available for installation
_pac_all_packages() {
    _pac_installed_packages
    _pac_installable_packages
}

_pac() {
     local -a cmds
    local curcontext="$curcontext" state line
    typeset -A opt_args

    _arguments -C \
        '1: :->level1' \
        '*:: :->args'

    case $state in
    level1)
        cmds=(
            'upgrade:Upgrade all installed packages'
            'install:Install a new package'
            'remove:Remove an installed package'
            'list:List packages'
            'search:Search the package database'
            'show:Show detailed package information'
            'find:Find a package by contents'
            'clean:Clean the package cache'
            'autoremove:Remove unneeded packages'
            'autoclean:Remove old versions of installed packages'
            'depends:Show a list of dependencies for a package'
            'rdepends:Show a list of packages that depend on a package'
            'aur:Access AUR (Arch User Repository) commands'
        )
        _describe -t commands 'Pac Commands' cmds -o nosort && ret=0
        ;;
    esac

    case $line[1] in
    list)
        if (( CURRENT == 2 )); then
            local -a list_options
            list_options=(
                '--installed:List all installed packages'
                '--manual:List manually installed packages'
                '--upgradable:List upgradable packages'
                '--all:List all packages, including those in AUR'
            )
            _describe -t listopts 'List Options' list_options -o nosort && ret=0
        fi
        ;;
    aur)
        if (( CURRENT == 2 )); then
            local -a aur_options
            aur_options=(
                'search:Search in the AUR'
                'install:Install a package from the AUR'
                'upgrade:Upgrade AUR packages'
            )
            _describe -t aurops 'AUR Options' aur_options -o nosort && ret=0
        fi
        ;;
    esac

    case $words[1] in
        install|search|depends|rdepends)
            _pac_installable_packages
            ;;
        remove|show)
            _pac_installed_packages
            ;;
        list)
            case $words[2] in
                --manual)
                    _pac_manual_packages
                    ;;
                --upgradable)
                    _pac_upgradeable_packages
                    ;;
                --installed)
                    _pac_installed_packages
                    ;;
                --all)
                    _pac_all_packages
                    ;;
                *)
                    if [[ -z "$line[2]" ]]; then
                        _arguments '2: :(--installed --manual --upgradeable --all)'
                    else
                        _message "Specify an option for list"
                    fi
                    ;;
            esac
            ;;
        aur)
            if [[ $words[2] == install || $words[2] == search ]]; then
                _pac_installable_packages_aur
            else
                _message "Specify a valid AUR command"
            fi
            ;;
    esac
}

_pac "$@"
