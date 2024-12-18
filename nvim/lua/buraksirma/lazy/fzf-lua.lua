local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		local fzf = require("fzf-lua")
		local actions = fzf.actions

		fzf.setup({
			lsp = {
				jump_to_single_result = true,
				jump_to_single_result_action = actions.file_edit,
			},
			keymap = {
				builtin = {
					true,
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					true,
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
					["ctrl-q"] = "select-all+accept",
				},
			},
			actions = {
				files = {
					["enter"] = actions.file_edit_or_qf,
					["ctrl-x"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["alt-q"] = actions.file_sel_to_qf,
				},
			},
		})

		vim.keymap.set("n", "<C-p>", fzf.files, { noremap = true })
		vim.keymap.set("v", "<C-p>", function()
			local text = getVisualSelection()
			fzf.files({ query = text })
		end, { noremap = true })

		vim.keymap.set("n", "<C-g>", fzf.live_grep, { noremap = true })
		vim.keymap.set("v", "<C-g>", function()
			local text = getVisualSelection()
			fzf.live_grep({ query = text })
		end, { noremap = true })
	end,
}
