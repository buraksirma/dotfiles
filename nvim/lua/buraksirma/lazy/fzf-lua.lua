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
		fzf.setup({})

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
