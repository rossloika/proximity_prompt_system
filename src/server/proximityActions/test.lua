-- Local Roblox Services
local Players = game:GetService("Players")
-- Local Paths
local server = script.Parent.Parent
local scriptsFolder = server.scripts

-- Local Requires
local proximityAction = require(scriptsFolder.proximity)

-- Main Code
return proximityAction.new({
	name = "test",
	executor = function(args)
        print("TEST Function works")
       -- Command Code
       -- Send Logs and Notifications
    end,
})
