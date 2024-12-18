__default:
    just --list

check:
    nix flake check

package profile="default":
    nix build --json --no-link --print-build-logs ".#{{ profile }}"

run:
    nix run .#neovim

update:
    nix flake update
