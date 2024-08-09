return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup({
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"lspinfo",
					"packer",
					"checkhealth",
					"help",
					"",
					"alpha",
				},
			},
		})
	end,
}
