-- Paq setup
if vim.fn.exists("g:vscode") == 0 then
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
    "timuntersberger/neogit";
    "lewis6991/gitsigns.nvim";
    "nvim-telescope/telescope-project.nvim";
    "kyazdani42/nvim-tree.lua";

    -- Build/Run system
    "puremourning/vimspector";
    "skywind3000/asyncrun.vim";
    "skywind3000/asynctasks.vim";

    -- Colours & Ricing
    "tjdevries/colorbuddy.nvim";
    "nvim-lualine/lualine.nvim";
    "shaunsingh/nord.nvim";
    "nvim-treesitter/nvim-treesitter";
    "p00f/nvim-ts-rainbow";
    "nvim-lua/popup.nvim";
    "kyazdani42/nvim-web-devicons";
    {"norcalli/nvim-colorizer.lua", opt=true};

    -- Syntax
    {"LnL7/vim-nix", opt=true};
    {"lervag/vimtex", opt=true};
    "folke/todo-comments.nvim";

    -- Telescope - A highly extensible fuzzy finder
    "nvim-telescope/telescope.nvim";
    "nvim-telescope/telescope-frecency.nvim";
    "nvim-telescope/telescope-file-browser.nvim";
    "nvim-telescope/telescope-github.nvim";
    "nvim-telescope/telescope-media-files.nvim";
    "nvim-telescope/telescope-hop.nvim";
    "nvim-telescope/telescope-frecency.nvim";
    "GustavoKatel/telescope-asynctasks.nvim";

    -- QoL
    "L3MON4D3/luasnip";
    "windwp/nvim-autopairs";
    "ojroques/nvim-bufdel";
    "neovim/nvim-lspconfig";
    "ludovicchabant/vim-gutentags";
    "machakann/vim-sandwich";
    "tpope/vim-commentary";

    -- Misc
    "nathom/filetype.nvim";
    "lukas-reineke/indent-blankline.nvim";
    "nvim-lua/plenary.nvim";
    "phaazon/hop.nvim";
  }
  -- Config
  require "config"
  require "plugins"
end
