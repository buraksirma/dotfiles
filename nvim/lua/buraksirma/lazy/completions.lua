return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"SirVer/ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"honza/vim-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

			require("copilot_cmp").setup()

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
							ultisnips = "[UltiSnips]",
						},
					}),
				},
				snippet = {
					expand = function(args)
						vim.fn["UltiSnips#Anon"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
							vim.fn["UltiSnips#JumpForwards"]()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
							vim.fn["UltiSnips#JumpBackwards"]()
						else
							fallback()
						end
					end,
				}),
				sources = {
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "ultisnips" },
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = true },
			})
		end,
	},
}
