local ts = require'nvim-treesitter.configs'.setup

ts {
  highlight = {enable = true},
  ensure_installed = "maintained",
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#e06c75",
      "#98c379",
      "#d19a66",
      "#61afef",
      "#c768dd",
      "#56b6c2",
    },
  }
}
