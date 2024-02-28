#compdef pac

_pac() {
    local -a commands
    commands=(
        'update:Update package database'
        'upgrade:Upgrade all installed packages'
        'install:Install a new package'
        'remove:Remove an installed package'
        'search:Search the package database'
        'show:Show detailed package information'
        'list-installed:List all installed packages'
        'autoremove:Remove unneeded packages'
        'clean:Clean the package cache'
        'autoclean:Remove old versions of installed packages'
        'find:Find a package by binary name'
        'aur-search:Search in the AUR'
        'aur-install:Install a package from the AUR'
    )
    _describe 'command' commands -o nosort
}

case "$service" in
    pac)
        _pac
        ;;
esac