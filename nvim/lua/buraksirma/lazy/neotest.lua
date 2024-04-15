return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- adapters
		"nvim-neotest/neotest-go",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
			},
		})
	end,
	keys = {
		{
			"<leader>tc",
			function()
				require("neotest").run.run()
			end,
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
		},
	},
}
