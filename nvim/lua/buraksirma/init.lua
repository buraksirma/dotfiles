require("buraksirma.set")
require("buraksirma.remap")

require("buraksirma.lazy_init")

local augroup = vim.api.nvim_create_augroup
local BurakSirmaGroup = augroup("BurakSirma", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	group = BurakSirmaGroup,
	callback = function(e)
		local opts = { buffer = e.buf, noremap = true, silent = true }
		local set = vim.keymap.set

		set("n", "gD", '<cmd>lua require "telescope.builtin".lsp_type_definitions()<CR>', opts)
		set("n", "gd", '<cmd>lua require "telescope.builtin".lsp_definitions()<CR>', opts)
		set("n", "gi", '<cmd>lua require "telescope.builtin".lsp_implementations()<CR>', opts)
		set("n", "gr", '<cmd>lua require "telescope.builtin".lsp_references()<CR>', opts)
		set("n", "ge", '<cmd>lua require "telescope.builtin".diagnostics()<CR>', opts)

		set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
		set("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
		set("x", "gx", "<cmd>Lspsaga code_action<cr>", opts)
		set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
		set("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
		set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
		set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	end,
})

autocmd("CursorHold", {
	group = BurakSirmaGroup,
	pattern = "*",
	command = [[Lspsaga show_cursor_diagnostics ++unfocus]],
})

autocmd("FileType", {
	group = BurakSirmaGroup,
	pattern = {
		"go",
		"html",
		"markdown",
		"text",
		"fish",
		"lua",
	},
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})

autocmd("FileType", {
	group = BurakSirmaGroup,
	pattern = {
		"kotlin",
		"python",
		"sql",
	},
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	update_in_insert = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
