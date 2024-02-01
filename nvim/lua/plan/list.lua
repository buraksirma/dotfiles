local Path = require("plenary.path")
local log = require("plan.dev").log

local M = {}

function M.cmd(args)
	if #args < 1 then
		log.error("list: No arguments provided")
		return
	end

	local time = args[1]
	if not vim.tbl_contains({ "daily", "monthly", "yearly" }, time) then
		log.error("list: Invalid time:", time)
	end

	local folder = PlanConfig.paths[time]

	require("telescope.builtin").find_files({ search_dirs = { folder } })
end

function M.complete(arglead, cmdline)
	log.trace("list.complete():", arglead, cmdline)

	local split = vim.split(cmdline, " ")
	if #split >= 4 then
		return {}
	end

	local time = split[3]
	if not time or not vim.tbl_contains({ "daily", "monthly", "yearly" }, time) then
		return vim.tbl_filter(function(s)
			return string.match(s, "^" .. arglead)
		end, { "daily", "monthly", "yearly" })
	end
	return {}
end

return M
