local plugin_modules = {
  "plugins.ui",
  "plugins.treesitter",
  "plugins.snippets",
  "plugins.completion",
  "plugins.misc",
  "plugins.telescope",
}

for _, module in pairs(plugin_modules) do
  -- local safereq = require("config.utils").saferequire
  require(module)
end
