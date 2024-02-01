local Scandir = require("plenary.scandir")
local log = require("plan.dev").log

local M = {}

function M.cmd(args)
	log.trace("jump.cmd():", args)
	if #args < 2 then
		log.error("jump: No arguments provided")
		return
	end

	local time = args[1]
	local target = args[2]
	if not vim.tbl_contains({ "daily", "monthly", "yearly" }, time) then
		log.error("jump: Invalid time:", time)
	end
	if not vim.tbl_contains({ "active", "prev" }, target) then
		log.error("jump: Invalid target:", target)
	end

	local folder = PlanConfig.paths[time]

	local files = Scandir.scan_dir(folder)
	table.sort(files, function(a, b)
		return a > b
	end)
	if #files < 2 and target == "prev" then
		log.error("jump: No previous file")
		return
	end
	if #files == 0 then
		log.error("jump: No active file")
		return
	end
	if target == "active" then
		vim.cmd("e " .. folder .. "/" .. files[1])
	else
		vim.cmd("e " .. folder .. "/" .. files[2])
	end
	log.debug("jump.cmd(): files:", files)
end

function M.complete(arglead, cmdline)
	log.trace("jump.complete():", arglead, cmdline)

	local split = vim.split(cmdline, " ")
	if #split >= 5 then
		return {}
	end

	local time = split[3]
	if not time or not vim.tbl_contains({ "daily", "monthly", "yearly" }, time) then
		return vim.tbl_filter(function(s)
			return string.match(s, "^" .. arglead)
		end, { "daily", "monthly", "yearly" })
	end
	return vim.tbl_filter(function(s)
		return string.match(s, "^" .. arglead)
	end, { "active", "prev" })
end

return M
