local Path = require("plenary.path")
local Dev = require("plan.dev")

local log = Dev.log

local M = {}

local function merge_table_impl(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k]) == "table" then
				merge_table_impl(t1[k], v)
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
end

local function merge_tables(...)
	log.trace("_merge_tables()")
	local out = {}
	for i = 1, select("#", ...) do
		merge_table_impl(out, select(i, ...))
	end
	return out
end

local function complete_command(executor, argLead, cmdLine, cursorPos)
	log.trace("complete_command()")
	return require("plan." .. executor).complete(argLead, cmdLine, cursorPos)
end

local function setup_cli()
	log.trace("setup_cli()")
	vim.api.nvim_create_user_command("Plan", function(args)
		require("plan.commands").load_command(args.fargs[1], vim.list_slice(args.fargs, 2))
	end, {
		range = true,
		nargs = "+",
		complete = function(argLead, cmdLine, cursorPos)
			local list = require("plan.commands").command_list()
			local split = vim.split(cmdLine, " ")
			local executor = split[2]
			local matched = vim.tbl_filter(function(s)
				return string.match(s, "^" .. executor)
			end, list)
			local _, c = cmdLine:gsub(" ", "")
			if c == 1 then
				return matched
			end
			local ok, matches = pcall(complete_command, executor, argLead, cmdLine, cursorPos)
			if ok then
				return matches
			else
				return {}
			end
		end,
	})
end

function M.setup(config)
	log.trace("setup(): Setting up...")

	if not config then
		config = {}
	end

	if not config.options.path then
		log.error("setup(): config.path is required")
	end

	local complete_config = merge_tables({
		options = {
			["file_suffix"] = ".md",
		},
	}, config)

	PlanConfig = complete_config
	PlanConfig.paths = {}
	PlanConfig.paths.root = Path:new(PlanConfig.options.path):expand()
	PlanConfig.paths.daily = PlanConfig.paths.root .. "/daily"
	PlanConfig.paths.monthly = PlanConfig.paths.root .. "/monthly"
	PlanConfig.paths.yearly = PlanConfig.paths.root .. "/yearly"

	Path:new(PlanConfig.paths.root):mkdir({ parents = true })
	setup_cli()
	log.debug("setup(): Ensured the folders exists")

	log.debug("setup(): Complete config", PlanConfig)
	log.trace("setup(): log_key", Dev.get_log_key())
end

return M
