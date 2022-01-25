{self, config, pkgs, lib, utils, ... }:
let
  vars = import ../vars.nix;

  nixpkgs = import (builtins.fetchTarball https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz);

  # Credits: https://github.com/pinpox/nixos
  # Helper function to add plugins directly from GitHub if they are not
  # packaged in nixpkgs yet
  plugin = name: repo: branch: sha256:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "vim-plugin-${name}";
      version = "git";
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = branch;
        rev = sha256;
      };
    };


  # Enable dictionaries in Neovim
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
  };

  nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.sug";
    sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
  };

  nvim-spell-fr-latin1-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.latin1.spl";
    sha256 = "086ccda0891594c93eab143aa83ffbbd25d013c1b82866bbb48bb1cb788cc2ff";
  };

  nvim-spell-fr-latin1-suggestions = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/fr.latin1.sug";
    sha256 = "5cb2c97901b9ca81bf765532099c0329e2223c139baa764058822debd2e0d22a";
};
in {

  home.packages = with pkgs; [
    nodePackages.pyright                      # Python server
    nodePackages.yaml-language-server         # YAML server
    nodePackages.json-server                  # JSON server
    tree-sitter                               # to compile grammars in nvim-treesitter
    ccls                                      # C/C++ server
    sumneko-lua-language-server               # Lua server
    bear                                      # Generate compilation database for clangd
    texlab                                    # LaTeX server
    universal-ctags                           # continuation of ctags
    nodePackages.vscode-langservers-extracted # JSON, HTML, and CSS servers
    github-cli
  ];

  xdg = {
    enable = true;
    
    configFile = {

      nvim_init = {
        target = "nvim/init.lua";
        source = ./lua/init.lua;
      };

      nvim_lua_config = {
        target = "nvim/lua/config";
        source = ./lua/config;
      };

      nvim_lua_plugins = {
        target = "nvim/lua/plugins";
        source = ./lua/plugins;
      };

    };

    dataFile = {

      nvim_friendly_snippets = {
        target = "nvim/site/snippets";
        source = builtins.fetchGit {
          url = "https://github.com/rafamadriz/friendly-snippets";
          ref = "main";
          rev = "1614c0a1fb29aaf4762ce43c594cb33963650af1";
        } + /snippets;
      };
    };
  
  };

  programs.neovim = {
    enable = false;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraConfig = ''
    lua << EOF
    require('config')
    EOF
    '';

    plugins = with pkgs.vimPlugins; [

      cmp-buffer
      cmp-nvim-lsp
      cmp_luasnip
      cmp-spell
      gitsigns-nvim
      colorbuddy-nvim
      committia-vim
      (plugin "lspkind" "onsails/lspkind-nvim" "master"
        "0f7851772ebdd5cb67a04b3d3cda5281a1eb83c1")
      luasnip
      lualine-nvim
      nord-nvim
      nvim-autopairs
      nvim-bufdel
      (plugin "nvim-cmp" "hrsh7th/nvim-cmp" "main"
        "881ca573dbbf39ebef6b15d3e3b484484aec53b3")
      nvim-lspconfig
      nvim-ts-rainbow
      nvim-tree-lua
      nvim-treesitter
      nvim-web-devicons
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-project-nvim
      vim-gutentags
      vim-nix
      vim-sandwich
      vim-fugitive
      vim-commentary
      (plugin "vim-visual-multi" "mg979/vim-visual-multi" "master"
        "e20908963d9b0114e5da1eacbc516e4b09cf5803")
      vimtex
    ];
  };

  # Spelling
  home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = nvim-spell-fr-utf8-suggestions;
  home.file."${config.xdg.configHome}/nvim/spell/fr.latin1.spl".source = nvim-spell-fr-latin1-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/fr.latin1.sug".source = nvim-spell-fr-latin1-suggestions;
}
