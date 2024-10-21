#!/usr/bin/env zsh
P_PACKAGE_MANAGER=""
PX_COMMAND=""

detect_javascript() {
    if [[ -f "package-lock.json" ]]; then
        P_PACKAGE_MANAGER="npm"
        PX_COMMAND="npx"
    elif [[ -f "yarn.lock" ]]; then
        P_PACKAGE_MANAGER="yarn"
        PX_COMMAND="yarn dlx"
    elif [[ -f "pnpm-lock.yaml" ]]; then
        P_PACKAGE_MANAGER="pnpm"
        PX_COMMAND="pnpx"
    elif [[ -f "deno.lock" ]]; then
        P_PACKAGE_MANAGER="deno"
        sPX_COMMAND="deno run"
    elif [[ -f "bun.lockb" ]]; then
        P_PACKAGE_MANAGER="bun"
        PX_COMMAND="bunx"
    fi

    if [[ ! $P_PACKAGE_MANAGER && ! $PX_COMMAND ]]; then
        echo $P_PACKAGE_MANAGER
        echo $PX_COMMAND

        return 0
    fi

    return 127
}
