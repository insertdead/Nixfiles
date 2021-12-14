g = vim.g

-- Theme
g.nord_contrast = false
g.nord_borders = true
g.nord_disable_background = false
g.nord_cursorline_transparent = false
g.nord_enable_sidebar_background = false
g.nord_italic = true

-- Statusbar
local lualine = require("lualine")

local lualine_config = {
  options = {
    -- Theme
    theme = "nord",
    -- Separators
    -- section_separators = {"", ""},
    -- component_separators = "",
  },
}

lualine.setup(lualine_config)
