-- Paq setup
require "paq" {
  -- Let paq manage itself
  "savq/paq-nvim";

  -- Completion
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-nvim-lsp";
  {"f3fora/cmp-spell", opt=true};
  "saadparwaiz1/cmp_luasnip";
  "onsails/lspkind-nvim";

  -- VCS and Project management
  "tpope/vim-fugitive";
  "lewis6991/gitsigns.nvim";
  "nvim-telescope/telescope-project.nvim";
  "kyazdani42/nvim-tree.lua";

  -- Colours & Ricing
  "tjdevries/colorbuddy.nvim";
  "nvim-lualine/lualine.nvim";
  "shaunsingh/nord.nvim";
  "nvim-treesitter/nvim-treesitter";
  "p00f/nvim-ts-rainbow";
  "nvim-lua/popup.nvim";
  "nvim-lua/plenary.nvim";
  "kyazdani42/nvim-web-devicons";

  -- Syntax
  {"LnL7/vim-nix", opt=true};
  {"lervag/vimtex", opt=true};

  -- Telescope - A highly extensible fuzzy finder
  "nvim-telescope/telescope.nvim";
  "nvim-telescope/telescope-frecency.nvim";
  "nvim-telescope/telescope-file-browser.nvim";
  "nvim-telescope/telescope-github.nvim";
  "nvim-telescope/telescope-media-files.nvim";

  -- QoL
  "L3MON4D3/luasnip";
  "windwp/nvim-autopairs";
  "ojroques/nvim-bufdel";
  "neovim/nvim-lspconfig";
  "ludovicchabant/vim-gutentags";
  "machakann/vim-sandwich";
  "tpope/vim-commentary";
}

-- Config
require "config"
require "plugins"
