local commands = {}

local subcommands = {
	new = function(args)
		require("plan.new").cmd(args)
	end,
	jump = function(args)
		require("plan.jump").cmd(args)
	end,
	list = function(args)
		require("plan.list").cmd(args)
	end,
}

function commands.command_list()
	return vim.tbl_keys(subcommands)
end

function commands.load_command(cmd, arg)
	subcommands[cmd](arg)
end

return commands
