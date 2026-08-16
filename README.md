# Mac Bootstrap

Set up a Mac workstation: Homebrew packages and casks, dotfile symlinks, macOS defaults and a
handful of system settings. A `Makefile` orchestrates a `Brewfile` and the shell scripts in
`steps/`.

## Pre-requisites

Grant **Full Disk Access** to the terminal you run this from (System Settings → Privacy & Security
→ Full Disk Access). Without it, the Safari preferences and `tmutil disable` will warn and be
skipped - everything else still applies.

1Password needs to be installed and unlocked before git will let you commit, as the dotfiles set
`commit.gpgsign` with `op-ssh-sign` as the signer.

## Running

You either bootstrap it via `curl`, or clone the repo and run it locally.

### Bootstrap

This installs Homebrew - and with it the Command Line Tools, which is where `git` and `make` come
from on a bare machine - then clones this repo to `~/Projects/mac-bootstrap` and runs `make all`.

``` bash
curl -L -H 'accept: application/vnd.github.v3.raw' "https://api.github.com/repos/jshiell/mac-bootstrap/contents/bootstrap" | bash
```

### Cloning and running locally

```bash
git clone https://github.com/jshiell/mac-bootstrap.git
cd mac-bootstrap
make all
```

Alternately you can run just the parts you want, in any combination:

```bash
make brew dotfiles
```

`make help` lists the targets. A bare `make` prints that help and changes nothing - `make all` is
the explicit way to provision.

### Dry runs

```bash
make -n all         # which steps would run, and in what order
DRY_RUN=1 make all  # the individual commands each step would run
```

## What it does

| Target | |
| --- | --- |
| `homebrew` | installs Homebrew, and the Command Line Tools with it, if absent |
| `rosetta` | installs Rosetta 2 on Apple silicon - before `brew`, as some casks are Intel-only |
| `brew` | installs everything in the `Brewfile` |
| `dotfiles` | clones `jshiell/dotfiles` to `~/dotfiles`, then runs that repo's own `make install` |
| `defaults` | writes the per-user macOS defaults, then restarts Dock, Finder and SystemUIServer |
| `system` | firewall, software update, login window and timezone - each via its own `sudo` |

The timezone defaults to `Europe/London`; override it with `TIMEZONE=... make system`.

Git configuration lives in the dotfiles repo now, as `gitconfig` symlinked to `~/.gitconfig`, rather
than being applied from here.

Which dotfiles exist and where they are linked is decided by the dotfiles repo, not here. This repo
only clones it and calls `make install`. Anything already in `$HOME` as a real file or directory is
left alone rather than replaced; the `make status` run at the end of the step names those, and
clearing them is yours to do.

The firewall is enabled with `socketfilterfw`. Apple has said that isn't a supported API; it is the
only available path, and writing the preference file directly no longer works.

`brew bundle` does not run `brew update` first, so package versions only move when you update
Homebrew yourself. It also never uninstalls: removing a line from the `Brewfile` leaves the package
in place on machines that already have it.

## Credits

Very much inspired and influenced by
[geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook/).
