return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					markdown = {
						require("formatter.defaults.prettierd"),
					},
					javascript = {
						require("formatter.filetypes.javascript").prettierd,
					},
					javascriptreact = {
						require("formatter.filetypes.javascriptreact").prettierd,
					},
					typescript = {
						require("formatter.filetypes.typescript").prettierd,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
					go = {
						function()
							vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
						end,
						require("formatter.filetypes.go").gofumpt,
					},
					json = {
						require("formatter.filetypes.json").prettierd,
					},
					html = {
						require("formatter.filetypes.html").prettierd,
					},
					css = {
						require("formatter.filetypes.css").prettierd,
					},
					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},
					fish = {
						require("formatter.filetypes.fish").fishindent,
					},
					dart = {
						require("formatter.filetypes.dart").dartformat({
							line_length = 120,
						}),
					},
					yaml = {
						require("formatter.filetypes.yaml").prettierd,
					},
					terraform = {
						require("formatter.filetypes.terraform").terraformfmt(),
					},
					python = {
						require("formatter.filetypes.python").ruff,
					},
					toml = {
						require("formatter.filetypes.toml").taplo,
					},
					svelte = {
						require("formatter.filetypes.svelte").prettier,
					},
				},
			})

			local augroup = vim.api.nvim_create_augroup
			local FormatterGroup = augroup("Formatter", {})

			local autocmd = vim.api.nvim_create_autocmd

			autocmd({ "BufWritePost" }, {
				group = FormatterGroup,
				pattern = "*",
				command = [[FormatWrite]],
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
