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
			local autocmd = vim.api.nvim_create_autocmd

			local FormatterGroup = augroup("Formatter", {})

			autocmd("BufWritePre", {
				group = FormatterGroup,
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
					for _, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
							else
								vim.lsp.buf.execute_command(r.command)
							end
						end
					end

					vim.lsp.buf.format()
				end,
			})

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
