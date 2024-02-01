local Path = require("plenary.path")
local log = require("plan.dev").log

local M = {}

function M.cmd(args)
	log.trace("new.cmd():", args)
	if #args == 0 then
		log.error("new: No arguments provided")
		return
	end

	local time = args[1]
	if not vim.tbl_contains({ "daily", "monthly", "yearly" }, time) then
		log.error("list: Invalid time:", time)
	end

	local targets = {
		daily = {
			path = PlanConfig.paths.daily,
			file = os.date("%Y-%m-%d") .. PlanConfig.options.file_suffix,
		},
		monthly = {
			path = PlanConfig.paths.monthly,
			file = os.date("%Y-%m") .. PlanConfig.options.file_suffix,
		},
		yearly = {
			path = PlanConfig.paths.yearly,
			file = os.date("%Y") .. PlanConfig.options.file_suffix,
		},
	}
	time = targets[time]
	time.file = Path:new(time.path .. "/" .. time.file)

	Path:new(time.path):mkdir({ parents = true })
	if not time.file:exists() then
		time.file:touch()
	end
	if not vim.tbl_contains(args, "++nojump") then
		vim.cmd("e " .. time.file:expand())
	end
end

function M.complete(arglead, cmdline)
	log.trace("new.complete():", arglead, cmdline)

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
