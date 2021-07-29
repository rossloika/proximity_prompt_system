-- Local Roblox Services
local Players = game:GetService("Players")
-- Local Paths
local server = script.Parent.Parent
local scriptsFolder = server.scripts

-- Local Requires
local proximity = require(scriptsFolder.proximity)

-- Main Code
return proximity.new({
	name = "test",
	executor = function(args)
        warn(args)
       -- Command Code
       -- Send Logs and Notifications
    end,
})