return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("", "<leader>gb", "<cmd>Git blame<cr>")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
}
