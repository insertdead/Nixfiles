-- TODO
local function get_projects()
  -- Require utils from telescope-project.nvim, and return root of current project (if any)
  local proj = require("telescope._extensions.project.utils")
end


-- Configure telescope
require'telescope'.setup {
  extensions = {
    -- File browser
    file_browser = {
      -- TODO: Mapping to go to project root
      theme = "ivy",
    },

    -- Intelligent prioritization from files in editing history
    frecency = {
      ignore_patterns = { "*.git/*", "*/tmp/*", "*.vscode/*" },
      workspaces = {
        ["conf"] = "/home/insertdead/.config",
        ["data"] = "/home/insertdead/.local/share",
        ["git"] = "/home/insertdead/git",
        ["nix"] = "/home/insertdead/.config/nixpkgs",
      }
    },

    hop = {
      -- TODO: Once hop.nvim is configured
    },

    -- Media files Extension
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf"}
    },

    -- Projects
    project = {
      base_dirs = {{"~/git", max_depth=2}},
      hidden_files = true
    }
  }
}

-- Load extensions
require('telescope').load_extension('project')
require('telescope').load_extension('media_files')
require('telescope').load_extension('gh')
require("telescope").load_extension("file_browser")
require("telescope").load_extension("hop")
require("telescope").load_extension("asynctasks")
