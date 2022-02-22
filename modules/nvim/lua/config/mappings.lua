local utils = require "config.utils"

local map = utils.map

local cmd = vim.cmd

local M = {}

M.base = function()

  --      Windows
  -- TODO: Replace quit mapping with one that goes to a title buffer if there are none left
  map('n', '<Leader>wn', ':vertical new<CR>')
  map('n', '<Leader>we', ':new<CR>')
  map('n', '<Leader>wc', ':BufDel<CR>')
  map('n', '<Leader>wh', '<C-w>h')
  map('n', '<Leader>wj', '<C-w>j')
  map('n', '<Leader>wk', '<C-w>k')
  map('n', '<Leader>wl', '<C-w>l')

  --      Tabs
  map('n', '<Leader>tn', ':tabe<CR>')
  map('n', '<Leader>th', ':tabp<CR>')
  map('n', '<Leader>tl', ':tabn<CR>')
  map('n', '<Leader>tc', ':q<CR>')

  -- Other
  map("n", "<M-x>", ":")
  map("n", "<Esc>", ":nohlsearch<CR>", {silent = true})
end

M.neogit = function()
  map("n", "<Leader>gs", ":Neogit status")
  map("n", "<Leader>gc", ":Neogit commit")
  map("n", "<Leader>gb", ":Neogit branch")
end

M.nvimtree = function()
  map("n", "<C-n>", ":NvimTreeToggle <CR>")
  map("n", "<Leader>e", ":NvimTreeFocus <CR>", {noremap = true})
end

M.telescope = function()

  -- Vanilla telescope finders
  map("n", "<Leader>fb", ":Telescope buffers <CR>")
  map("n", "<Leader>ff", ":Telescope find_files <CR>")
  map("n", "<Leader>fa", ":Telescope find_files hidden=true <CR>")
  map("n", "<Leader>fc", ":Telescope git_commits <CR>")
  map("n", "<Leader>fs", ":Telescope git_status <CR>")
  map("n", "<Leader>fh", ":Telescope help_tags <CR>")
  map("n", "<Leader>fw", ":Telescope live_grep <CR>")
  map("n", "<Leader>fo", ":Telescope oldfiles <CR>")

  -- File browser
  map("n", "<Leader>.", ":Telescope file_browser <CR>")

   -- Projects and Github
  map("n", "<Leader>fp", ":Telescope project <CR>")
  map("n", "<Leader>gi", ":Telescope gh issues <CR>")
  map("n", "<Leader>gp", ":Telescope gh pull_request <CR>")
  map("n", "<Leader>gg", ":Telescope gh gist <CR>")
  map("n", "<Leader>gr", ":Telescope gh run <CR>")

  -- TODO stuff
  map("n", "<Leader>ft", ":TodoTelescope <CR>")

   -- Redirect to help pages
   -- TODO: make a Telescope menu instead to list out help links
  map("n", "<Leader>fHH", ":AsyncRun xdg-open https://github.com/nvim-telescope/telescope.nvim <CR>")
  map("n", "<Leader>fHg", ":AsyncRun xdg-open https://github.com/nvim-telescope/telescope-github.nvim <CR>")
  map("n", "<Leader>fHp", ":AsyncRun xdg-open https://github.com/nvim-telescope/telescope-project.nvim <CR>")
  map("n", "<Leader>fHh", ":AsyncRun xdg-open https://github.com/nvim-telescope/telescope-hop.nvim <CR>")
end

-- Debugging and compilations
M.tasks = function()
  -- Base task-running mappings
  map("n", "<Leader>cc", ":AsyncRun ")
  map("n", "<Leader>cC", ":AsyncTask ")
  map("n", "<Leader>cr", ":AsyncTaskLast <CR>")
  -- Edit the tasks available to the project, or global ones
  map("n", "<Leader>ce", ":AsyncTaskEdit <CR>")
  map("n", "<Leader>cE", ":AsyncTaskEdit! <CR>")
  -- List local or global tasks
  map("n", "<Leader>cl", ":AsyncTaskList <CR>")
  -- Assume projects will have a build task with both profiles
  -- TODO: quick script that initializes a project, independent of language
  map("n", "<Leader>cp", ":AsyncTask build:debug")
  map("n", "<Leader>cP", ":AsyncTask build:release")
  -- Switch between profiles for building with windows as a target
  map("n", "<Leader>cs", ":AsyncTaskProfile windows linux")
  -- Bring up a telescope finder to list and run tasks
  map("n", "<Leader>cL", ":Telescope asynctasks all")

  -- Insert mode equivalents
  map("i", "<M-Leader>cc", "<Cmd> AsyncRun ")
  map("i", "<M-Leader>cC", "<Cmd> AsyncTask ")
  map("i", "<M-Leader>cr", "<Cmd> AsyncTaskLast <CR>")
  map("i", "<M-Leader>cl", "<Cmd> AsyncTaskList <CR>")
  map("i", "<M-Leader>cp", "<Cmd> AsyncTask build:debug")
  map("i", "<M-Leader>cP", "<Cmd> AsyncTask build:release")
  map("i", "<M-Leader>cL", "<Cmd> Telescope asynctasks all")
end

for _, mappings in pairs(M) do
  mappings()
end
