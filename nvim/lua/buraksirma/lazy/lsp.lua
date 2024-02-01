return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local nvim_lsp = require("lspconfig")
		local servers = {
			"cssls",
			"dartls",
			"gopls",
			"jsonls",
			-- "kotlin_language_server",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"svelte",
			"taplo",
			"terraformls",
			"tsserver",
			"html",
			"tailwindcss",
			"yamlls",
		}

		local custom_lsp_confs = {
			lua_ls = function(lsp_settings)
				lsp_settings["on_init"] = function(client)
					local path = client.workspace_folders[1].name
					if
						not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
					then
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						})

						client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					end
					return true
				end
			end,
			gopls = function(lsp_settings)
				lsp_settings["flags"] = { debounce_text_changes = 200 }
				lsp_settings["settings"] = {
					gopls = {
						usePlaceholders = true,
						gofumpt = true,
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						experimentalPostfixCompletions = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-node_modules" },
						semanticTokens = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				}
			end,
			tsserver = function(lsp_settings)
				lsp_settings["init_options"] = {
					preferences = {
						disableSuggestions = true,
					},
				}
			end,
		}

		for _, lsp in ipairs(servers) do
			local lsp_settings = {
				capabilities = capabilities,
			}
			if custom_lsp_confs[lsp] then
				custom_lsp_confs[lsp](lsp_settings)
			end
			nvim_lsp[lsp].setup(lsp_settings)
		end

		require("lspsaga").setup({
			lightbulb = {
				sign = false,
			},
			scroll_preview = {
				scroll_down = "<C-d>",
				scroll_up = "<C-u>",
			},
		})
	end,
}
