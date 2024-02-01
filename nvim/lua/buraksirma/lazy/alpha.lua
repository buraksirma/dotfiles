local hlGroups = {
	String = "String",
	Identifier = "Identifier",
	Keyword = "Keyword",
	Number = "Number",
	Constant = "Constant",
	AlphaFooter = "AlphaFooter",
	Typedef = "Typedef",
}

return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local function button(sc, txt, keybind, keybind_opts)
			local b = dashboard.button(sc, txt, keybind, keybind_opts)
			b.opts.hl = hlGroups.Identifier
			b.opts.hl_shortcut = hlGroups.Identifier
			return b
		end

		dashboard.section.buttons.val = {
			button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			button("f", "  Find File", ":Telescope find_files<CR>"),
			button("w", "  Find Word", ":Telescope live_grep<CR>"),
			button("r", "  Recents", ":Telescope oldfiles<CR>"),
			button("u", "  Update Plugins", ":PackerUpdate<CR>"),
			button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
			button("q", "  Exit", ":qa<CR>"),
		}

		dashboard.section.header.val = {
			"",
			"",
			"",
			"",
			"            :h-                                  Nhy`               ",
			"           -mh.                           h.    `Ndho               ",
			"           hmh+                          oNm.   oNdhh               ",
			"          `Nmhd`                        /NNmd  /NNhhd               ",
			"          -NNhhy                      `hMNmmm`+NNdhhh               ",
			"          .NNmhhs              ```....`..-:/./mNdhhh+               ",
			"           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
			"           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
			"      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
			" .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
			" h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
			" hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
			" /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
			"  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
			"   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
			"     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
			"       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
			"       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
			"       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
			"       //+++//++++++////+++///::--                 .::::-------::   ",
			"       :/++++///////////++++//////.                -:/:----::../-   ",
			"       -/++++//++///+//////////////               .::::---:::-.+`   ",
			"       `////////////////////////////:.            --::-----...-/    ",
			"        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
			"         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
			"           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
			"            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
			"           s-`::--:::------:////----:---.-:::...-.....`./:          ",
			"          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
			"         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
			"        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
			"                        .-:mNdhh:.......--::::-`                    ",
			"                           yNh/..------..`                          ",
			"                                                                    ",
			"                              N E O V I M                           ",
		}

		dashboard.section.footer.val = {
			"",
			"Welcome!",
		}

		dashboard.section.header.opts.hl = hlGroups.Keyword
		dashboard.section.footer.opts.hl = hlGroups.Keyword

		alpha.setup(dashboard.opts)

		-- dashboard.section.footer.opts.hl = hlGroups.AlphaFooter
		-- local attrsOfIdentifier    = vim.fn.hlID(hlGroups.Keyword)
		-- local transIdentifier      = vim.fn.synIDtrans(attrsOfIdentifier)
		-- local hexColorOfIdentifier = vim.fn.synIDattr(transIdentifier, "fg#")

		-- vim.cmd('highlight '.. hlGroups.AlphaFooter .. ' cterm=italic gui=italic guifg=' .. hexColorOfIdentifier)
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
