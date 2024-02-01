return {
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})

		vim.keymap.set("", "<leader>n", "<cmd>Oil<cr>", { noremap = true })
	end,
}
