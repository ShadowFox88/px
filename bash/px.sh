#!/usr/bin/env bash
FILE="${(%):-%x}"
P_DIRECTORY=$(dirname $FILE)
PROJECT_LANGUAGE=""
P_PACKAGE_MANAGER=""
PX_COMMAND=""
SUPPORTED_LANGUAGES=(
    "javascript"
)
# TODO: Replace package manager names with respective OS names
SUPPORTED_SYSTEM_PACKAGE_MANAGERS="apt-get" "dnf"

auto_loaded_hook=false
cached_directory=""

naively_find_system_package_manager() {
    for system_package_manager in $SUPPORTED_SYSTEM_PACKAGE_MANAGERS; do
        if which $system_package_manager &> /dev/null; then
            echo $system_package_manager

            return 0
        fi
    done

    return 127
}

auto_detect_package_manager() {
    # This check exists to prevent additional re-runs that may impact invocation
    # performance, by caching the PWD and only running when it has changed
    if [[ $cached_directory == "$PWD" ]]; then
        return 0
    fi

    for language in $SUPPORTED_LANGUAGES; do
        local loader_found="detect_${language}"

        . "$P_DIRECTORY/loaders/${language}.zsh"

        local cached_status=$?
        local executables=($($loader_found))

        if [[ $cached_status == 0 ]]; then
            PROJECT_LANGUAGE=$language
            # Despite arrays in Zsh being zero-indexed, the 0th element refuses
            # to exist for reasons I am humanly fucking incapable of
            # understanding - if someone knows why, please reach out as this
            # feels like a reach in itself
            P_PACKAGE_MANAGER="${executables[1]}"
            PX_COMMAND="${executables[2]}"

            break
        fi
    done

    if [[ ! $P_PACKAGE_MANAGER && ! $PX_COMMAND ]]; then
        P_PACKAGE_MANAGER=$(naively_find_system_package_manager)
    fi

    cached_directory="$PWD"
}

p() {
    local subcommand="$1"
    local arguments=${@[@]:1}

    auto_detect_package_manager

    if [[ $subcommand == "query" ]]; then
        echo $P_PACKAGE_MANAGER $arguments
    else
        command $P_PACKAGE_MANAGER $arguments
    fi
}

px() {
    local subcommand="$1"
    local arguments=${@[@]:1}

    auto_detect_package_manager

    if [[ $subcommand == "query" ]]; then
        echo $PX_COMMAND $arguments
    else
        command $PX_COMMAND $arguments
    fi
}
