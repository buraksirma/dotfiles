require("buffline").setup()
require("dashboard").setup()
require("gitsigns").setup({})
require("lspsaga").setup({})
require("nvim-autopairs").setup({})
require("nvim-tree").setup({})
require("statusline")
require("bufjump").setup({
	forward = "<M-i>",
	backward = "<M-o>",
	on_success = nil,
})
require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = false,
	filetype_exclude = {
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"",
		"alpha",
	},
})
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
	},
})
require("telescope").load_extension("fzf")
require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
				},
			},
		},
		["core.integrations.nvim-cmp"] = {},
		["core.norg.journal"] = {},
		["core.norg.concealer"] = {
			config = {
				icon_preset = "basic", -- basic | varied | diamond
			},
		},
	},
})

-- LSP settings
local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	local setKey = vim.api.nvim_buf_set_keymap
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	setKey(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	setKey(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	setKey(bufnr, "n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
	setKey(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	setKey(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	setKey(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	setKey(bufnr, "n", "gD", '<cmd>lua require "telescope.builtin".lsp_type_definitions()<CR>', opts)
	setKey(bufnr, "n", "gd", '<cmd>lua require "telescope.builtin".lsp_definitions()<CR>', opts)
	setKey(bufnr, "n", "gi", '<cmd>lua require "telescope.builtin".lsp_implementations()<CR>', opts)
	setKey(bufnr, "n", "gr", '<cmd>lua require "telescope.builtin".lsp_references()<CR>', opts)
	setKey(bufnr, "n", "ge", '<cmd>lua require "telescope.builtin".diagnostics()<CR>', opts)

	-- LSP SAGA HOTKEYS
	setKey(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
	setKey(bufnr, "n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
	setKey(bufnr, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
	setKey(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
	setKey(bufnr, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	setKey(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	setKey(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	setKey(bufnr, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
	setKey(bufnr, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
	-- LSP FORMATTING
	-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- CMP
local cmp = require("cmp")
local lspkind = require("lspkind")

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
		["<C-Space>"] = cmp.mapping.complete(),
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
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
	},
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local nvim_lsp = require("lspconfig")
local servers = { "tsserver", "jsonls", "sumneko_lua", "gopls", "rust_analyzer", "terraformls" }

for _, lsp in ipairs(servers) do
	local lsp_settings = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	if lsp == "sumneko_lua" then
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")
		lsp_settings["settings"] = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		}
	end
	nvim_lsp[lsp].setup(lsp_settings)
end

-- TREE Sitter - Language servers
require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	ensure_installed = {
		"css",
		"fish",
		"go",
		"gomod",
		"hcl",
		"html",
		"javascript",
		"json",
		"norg",
		"rust",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"yaml",
	},
})
-- Diagnostics
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()]])

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	update_in_insert = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- NvimTree autoclose
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
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
	},
})

-- Go format imports via lsp instead of using goimports
function OrgImports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

vim.cmd([[autocmd BufWritePre *.go lua OrgImports(1000)]])
