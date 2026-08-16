.DEFAULT_GOAL := help
.NOTPARALLEL:
.PHONY: all help homebrew rosetta brew dotfiles defaults system

all: rosetta brew dotfiles defaults system

homebrew:
	./steps/homebrew

rosetta:
	./steps/rosetta

brew: homebrew
	HOMEBREW_CASK_OPTS=--force brew bundle || true

dotfiles:
	./steps/dotfiles

defaults:
	./steps/macos-defaults

system:
	./steps/macos-system

help:
	@echo "Provision this Mac. Targets may be combined, e.g. 'make brew dotfiles'."
	@echo ""
	@echo "  all        rosetta, brew, dotfiles, defaults, system - in that order"
	@echo "  homebrew   install Homebrew (and the Command Line Tools) if absent"
	@echo "  rosetta    install Rosetta 2 on Apple silicon"
	@echo "  brew       install everything in the Brewfile"
	@echo "  dotfiles   clone ~/dotfiles and symlink it into \$$HOME"
	@echo "  defaults   write the per-user macOS defaults"
	@echo "  system     firewall, timezone and other operations needing sudo"
	@echo "  help       this message (the default target)"
	@echo ""
	@echo "Dry runs:"
	@echo "  make -n all       show which steps would run"
	@echo "  DRY_RUN=1 make all  show the individual commands each step would run"
