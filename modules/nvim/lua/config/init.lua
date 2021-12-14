-- Files heavily inspired from NvChad
local config_modules = {
  "config.options",
  "config.mappings",
}

local safereq = require("config.utils").saferequire

for _, module in ipairs(config_modules) do
  safereq(module)
end
