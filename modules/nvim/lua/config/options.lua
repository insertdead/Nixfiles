-- Set options from default config, override if set otherwise in user config
local opt, cmd, g = vim.opt, vim.cmd, vim.g
local safereq = require("config.utils").saferequire

-- UI and keyboard
opt.title = true
opt.showcmd = true
opt.clipboard = "unnamedplus"
opt.signcolumn = "yes"
g.mapleader = " "
opt.cul = true

-- Windows
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400

-- Indentline
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- Lines
opt.number = true
opt.relativenumber = true

-- Syntax
g.c_syntax_for_h = true

-- Search and history
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.history = 5000

-- Theme
cmd("set termguicolors")
require("nord").set()

-- Misc
opt.updatetime = 250
opt.undofile = true

-- GUI (Neovide)
--  Window options
g.neovide_refresh_rate = 140
g.neovide_transparency = 0.95
g.neovide_remember_window_size = true
-- Animations
g.neovide_cursor_trail_length = 0.05
g.neovide_cursor_animation_length = 0.10
-- Non-specific GUI config
opt.guifont = "Iosevka Nerd Font,Noto Color Emoji:h10"


-- Plugins
safereq("plugins")

-- LSP configuration
safereq("config.lsp")

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
