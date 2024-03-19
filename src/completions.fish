function detect_aur_helper
    if type -q paru
        set -g AUR_HELPER paru
    else if type -q yay
        set -g AUR_HELPER yay
    else
        set -g AUR_HELPER ""
    end
end

function pac_installable_packages
    pacman -Slq 2>/dev/null
end

function pac_installable_packages_aur
    set cache_ttl 86400
    set cache_file "$HOME/.cache/pac_aur_package_list"
    detect_aur_helper

    if test -z "$AUR_HELPER"
        echo "No AUR helper found."
        return 1
    end

    if not test -f "$cache_file"
        set file_age (math (date +%s) - (stat -c '%Y' "$cache_file" 2>/dev/null; or stat -f '%m' "$cache_file"))
        if test "$file_age" -gt "$cache_ttl"
            switch $AUR_HELPER
                case paru
                    paru -Slq >| "$cache_file" &
                case yay
                    yay -Slqa >| "$cache_file" &
            end
        end
    end

    cat "$cache_file"
end

function pac_installed_packages
    pacman -Qq 2>/dev/null
end

function pac_manual_packages
    pacman -Qqet 2>/dev/null
end

function pac_upgradeable_packages
    pacman -Quq 2>/dev/null
end

function pac_all_packages
    echo (pac_installed_packages)
    echo (pac_installable_packages)
end

function pac_local_install_files
    echo *.pkg.tar.zst
end

complete -c pac -f -n '__fish_seen_subcommand_from install' -a '(pac_installable_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from search depends rdepends' -a '(pac_installable_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from remove show' -a '(pac_installed_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from list --manual' -a '(pac_manual_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from list --upgradable' -a '(pac_upgradeable_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from list --installed' -a '(pac_installed_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from list --all' -a '(pac_all_packages)'
complete -c pac -f -n '__fish_seen_subcommand_from aur; and string match -q "install" -- (commandline -opc)[3]' -a '(pac_installable_packages_aur)'
complete -c pac -f -n '__fish_seen_subcommand_from aur; and string match -q "search" -- (commandline -opc)[3]' -a '(pac_installable_packages_aur)'
complete -c pac -f -n '__fish_seen_subcommand_from aur' -a 'install upgrade search' -d 'AUR operations' 
complete -c pac -f -n '__fish_seen_subcommand_from local-install' -a '(pac_local_install_files)'
complete -c pac -f -n '__fish_use_subcommand' -a 'upgrade' -d 'Upgrade all installed packages' 
complete -c pac -f -n '__fish_use_subcommand' -a 'install' -d 'Install a new package' 
complete -c pac -f -n '__fish_use_subcommand' -a 'remove' -d 'Remove an installed package' 
complete -c pac -f -n '__fish_use_subcommand' -a 'list' -d 'List packages'
complete -c pac -f -n '__fish_use_subcommand' -a 'search' -d 'Search the package database'
complete -c pac -f -n '__fish_use_subcommand' -a 'show' -d 'Show detailed package information'
complete -c pac -f -n '__fish_use_subcommand' -a 'find' -d 'Find a package by contents'
complete -c pac -f -n '__fish_use_subcommand' -a 'clean' -d 'Clean the package cache'
complete -c pac -f -n '__fish_use_subcommand' -a 'autoremove' -d 'Remove unneeded packages'
complete -c pac -f -n '__fish_use_subcommand' -a 'autoclean' -d 'Remove old versions of installed packages'
complete -c pac -f -n '__fish_use_subcommand' -a 'depends' -d 'Show a list of dependencies for a package'
complete -c pac -f -n '__fish_use_subcommand' -a 'rdepends' -d 'Show a list of packages that depend on a package'
complete -c pac -f -n '__fish_use_subcommand' -a 'local-install' -d 'Install a local package file (.pkg.tar.zst)'
complete -c pac -f -n '__fish_use_subcommand' -a 'aur' -d 'Access AUR (Arch User Repository) commands'
