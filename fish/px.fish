#!/usr/bin/env fish
# https://medium.com/@chantastic/p-525e68f17e56
set FILE (status --current-filename)
set P_DIRECTORY (dirname $FILE)
set PROJECT_LANGUAGE ""
set P_PACKAGE_MANAGER ""
set PX_COMMAND ""
set SUPPORTED_LANGUAGES "javascript"
# TODO: Replace package manager names with respective OS names
set SUPPORTED_SYSTEM_PACKAGE_MANAGERS "apt-get" "dnf"

function naively_find_system_package_manager
    for system_package_manager in $SUPPORTED_SYSTEM_PACKAGE_MANAGERS
        if which $system_package_manager &> /dev/null
            echo $system_package_manager

            return 0
        end
    end

    return 127
end

function auto_detect_package_manager
    for language in $SUPPORTED_LANGUAGES
        set loader_found "detect_$language"

        source "$P_DIRECTORY/loaders/$language.fish"

        set cached_status $status
        set executables ($loader_found)

        if [ $cached_status = 0 ]
            set PROJECT_LANGUAGE $language
            set P_PACKAGE_MANAGER "$executables[1]"
            set PX_COMMAND "$executables[2]"

            break
        end
    end

    if [ $P_PACKAGE_MANAGER = "" ]; and [ $PX_COMMAND = "" ]
        set P_PACKAGE_MANAGER (naively_find_system_package_manager)
    end
end

function p
    set subcommand $argv[1]
    set arguments $argv[2..]

    if [ $subcommand = "query" ]
        echo $P_PACKAGE_MANAGER $arguments
    else
        command $P_PACKAGE_MANAGER $arguments
    end
end

function px
    set subcommand $argv[1]
    set arguments $argv[2..]

    if [ $subcommand = "query" ]
        echo $PX_COMMAND $arguments
    else
        command $PX_COMMAND $arguments
    end
end

function on_pwd_change --on-variable PWD
    auto_detect_package_manager
end

auto_detect_package_manager
