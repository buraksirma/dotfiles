return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- adapters
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
				require("neotest-jest"),
			},
		})
	end,
	keys = {
		{
			"<leader>tc",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run tests in current file",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run last test",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Open test output",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle output panel",
		},
		{
			"<leader>tx",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop test run",
		},
		{
			"<leader>tn",
			function()
				require("neotest").jump.next()
			end,
			desc = "Jump to next test",
		},
		{
			"<leader>tb",
			function()
				require("neotest").jump.prev()
			end,
			desc = "Jump to previous test",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "Attach to nearest test",
		},
	},
}
