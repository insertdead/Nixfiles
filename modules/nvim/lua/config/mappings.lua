local utils = require "config.utils"

local map = utils.map

local cmd = vim.cmd

local M = {}

M.base = function()

  --      Windows
  map('n', '<Leader>wn', ':vertical new<CR>')
  map('n', '<Leader>we', ':new<CR>')
  map('n', '<Leader>wc', ':BufDel<CR>')
  map('n', '<Leader>wh', '<C-w>h')
  map('n', '<Leader>wj', '<C-w>j')
  map('n', '<Leader>wk', '<C-w>k')
  map('n', '<Leader>wl', '<C-w>l')
  map('n', 'ZQ', ':BufDel<CR>')
  map('n', 'ZZ', ':w<CR>:BufDel<CR>')

  --      Tabs
  map('n', '<Leader>tn', ':tabe<CR>')
  map('n', '<Leader>th', ':tabp<CR>')
  map('n', '<Leader>tl', ':tabn<CR>')
  map('n', '<Leader>tc', ':q<CR>')

  -- Other
  map("n", "<M-x>", ":")
  map("n", "<Esc>", ":nohlsearch<CR>", {silent = true})
end

M.nvimtree = function()
  map("n", "<C-n>", ":NvimTreeToggle <CR>")
  map("n", "<Leader>e", ":NvimTreeFocus <CR>")
end

M.telescope = function()

   map("n", "<Leader>fb", ":Telescope buffers <CR>")
   map("n", "<Leader>ff", ":Telescope find_files <CR>")
   map("n", "<Leader>fa", ":Telescope find_files hidden=true <CR>")
   map("n", "<Leader>cm", ":Telescope git_commits <CR>")
   map("n", "<Leader>gt", ":Telescope git_status <CR>")
   map("n", "<Leader>fh", ":Telescope help_tags <CR>")
   map("n", "<Leader>fw", ":Telescope live_grep <CR>")
   map("n", "<Leader>fo", ":Telescope oldfiles <CR>")
end

for _, mappings in pairs(M) do
  mappings()
end
