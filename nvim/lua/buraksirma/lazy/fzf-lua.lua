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
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["alt-q"] = actions.file_sel_to_qf,
					["alt-Q"] = actions.file_sel_to_ll,
					["alt-i"] = actions.toggle_ignore,
					["alt-h"] = actions.toggle_hidden,
					["alt-f"] = actions.toggle_follow,
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

		-- "FzF buffers"
		vim.keymap.set("n", "<leader>fb", fzf.buffers)

		-- "FzF command history"
		vim.keymap.set("n", "<leader>fc", fzf.command_history)

		-- "FzF Git branches"
		vim.keymap.set("n", "<leader>fgb", fzf.git_branches)

		-- "FzF git commits"
		vim.keymap.set("n", "<leader>fgc", fzf.git_commits)

		-- "FzF git commits in buffer"
		vim.keymap.set("n", "<leader>fgC", fzf.git_bcommits)

		-- "FzF git status"
		vim.keymap.set("n", "<leader>fgs", fzf.git_status)

		-- "FzF git tags"
		vim.keymap.set("n", "<leader>fgt", fzf.git_tags)

		-- "FzF resume the previous window"
		vim.keymap.set("n", "<leader>fR", fzf.resume)

		-- "FzF search history"
		vim.keymap.set("n", "<leader>fs", fzf.search_history)

		-- "FzF help"
		vim.keymap.set("n", "<leader>fh", fzf.help_tags)
	end,
}
