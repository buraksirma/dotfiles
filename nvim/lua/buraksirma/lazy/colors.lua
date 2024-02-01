return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = false,
			transparent_background = true,
			integrations = {
				indent_blankline = {
					enabled = true,
					colored_indent_levels = true,
				},
				lsp_saga = true,
			},
			color_overrides = {
				mocha = {
					base = "#050508",
					mantle = "#050508",
					crust = "#050508",
				},
			},
			highlight_overrides = {
				mocha = function(colors)
					return {
						NvimTreeNormal = { bg = colors.base },
					}
				end,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
