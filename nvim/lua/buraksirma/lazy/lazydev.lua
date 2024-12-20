return {
	"folke/lazydev.nvim",
	ft = "lua",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv", "vim%.loop" } },
		},
	},
}