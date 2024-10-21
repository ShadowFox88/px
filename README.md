# PX*
**P**ackage (manager) **X** is an tool that allows you to manage project dependencies/system packages using one simple, high-level interface - PX.

# Premise
Web development (don't click off just yet) has numerous package managers owning their own pros and cons, and I work in a lot of different projects that use various package managers - some old and some new. Having to remember the commands for different package managers when you're only used to one can cloud your thought process, or at least it does for me, so I wrote a number of Bash functions and aliased them to achieve something close to what this project does.

However, Bash has it's limits and isn't always the easiest to extend, plus if there's a new package manager that releases, I have to edit 10+ Bash functions. In short, I have a raging skill issue that I'd rather cure through the development of a QoL CLI tool that only benefits me or people like me. Kachow!

# Features
- [ ] Automatic package manager detection and usage for projects that pertain to:
    - [ ] Web development (`npm`, `yarn`, `pnpm`, `bun` for Javascript, `composer` for PHP)
    - [ ] Python projects (`pip`, `pipx`, `uv`)
    - Maybe more, [request one](https://github.com/cyrus01337/px/issues/new)
- [ ] Support system package managers (measures will be put in place to prevent accidental, unintended usage)
    - [ ] Debian/Debian-based
    - [ ] Fedora
    - [ ] Arch BTW
    - [ ] Solus
    - Maybe more, [request one](https://github.com/cyrus01337/px/issues/new)
- [ ] Configure the *style* of commands - use `px i` that derives from `npm i`, for all your projects
- [ ] Support various commands through PX sub-commands
    - [ ] **px init**
    - [ ] **px install**
    - [ ] **px add**
    - [ ] **px dev add**
    - [ ] **px remove**
