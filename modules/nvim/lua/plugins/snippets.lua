local types = require("luasnip.util.types")

require'luasnip'.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "GruvboxOrange"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "GruvboxBlue"}}
			}
		}
	},
})

require"luasnip/loaders/from_vscode".load({ path = "~/.local/share/nvim/snippets/" })
