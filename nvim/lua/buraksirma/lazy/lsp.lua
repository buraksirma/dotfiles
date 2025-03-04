return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local nvim_lsp = require("lspconfig")
		local servers = {
			"cssls",
			"gopls",
			"jsonls",
			-- "kotlin_language_server",
			"ruff",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"svelte",
			"taplo",
			"terraformls",
			"ts_ls",
			"html",
			"yamlls",
			"zls",
			"volar",
			"eslint",
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
			ts_ls = function(lsp_settings)
				local handle = io.popen("npm root -g")
				local global_npm_path = ""
				if handle == nil then
					print("Can't get path for globally installed npm packages. Some lsps might not work.")
				else
					global_npm_path = handle:read("*a")
					handle:close()
				end
				global_npm_path = string.gsub(global_npm_path, "\n", "")
				lsp_settings["init_options"] = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = string.format("%s/@vue/typescript-plugin", global_npm_path),
							languages = { "javascript", "typescript", "vue" },
						},
					},
					preferences = {
						disableSuggestions = true,
					},
				}
				lsp_settings["filetypes"] = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				}
			end,
			zls = function(lsp_settings)
				lsp_settings["cmd"] = { "/home/burak/projects/github/zls/zig-out/bin/zls" }
			end,
			eslint = function(lsp_settings)
				---@diagnostic disable-next-line: unused-local
				lsp_settings["on_attach"] = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
								return
							end
							vim.cmd("EslintFixAll")
						end,
					})
				end
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
