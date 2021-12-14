# Nixfiles
> My dotfiles, but NixOS edition!

## Structure
- `./home.nix`: The main `home-manager` configuration; imports all other modules
- `modules/`: Where all the modules live (they are not modules in the functional sense, just in more of a semantic way)
- `modules/nvim/`: Main Neovim configuration
- `modules/xmonad/`: Haskell-based window manager
- `modules/shell`: Shell configuration - self-explanatory
