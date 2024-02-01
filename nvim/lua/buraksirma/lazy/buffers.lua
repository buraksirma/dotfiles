return {
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("bufjump").setup({
				forward = "<M-i>",
				backward = "<M-o>",
				on_success = nil,
			})
		end,
	},
	{
		"famiu/bufdelete.nvim",
	},
}
