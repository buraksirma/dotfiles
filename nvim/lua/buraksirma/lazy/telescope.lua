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
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"--type",
						"f",
						"--color=never",
						"--hidden",
						"--follow",
						"-E",
						".git/*",
					},
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
					"--glob",
					"!.git/",
				},
			},
		})

		require("telescope").load_extension("fzf")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, { noremap = true })
		vim.keymap.set("v", "<C-p>", function()
			local text = getVisualSelection()
			builtin.find_files({ default_text = text })
		end, { noremap = true })

		vim.keymap.set("n", "<C-g>", builtin.live_grep, { noremap = true })
		vim.keymap.set("v", "<C-g>", function()
			local text = getVisualSelection()
			builtin.live_grep({ default_text = text })
		end, { noremap = true })
	end,
}
