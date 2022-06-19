-- Local Roblox Services
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")

-- Local Paths
local server = script.Parent.Parent
local scriptsFolder = server.scripts

-- Local Requires
local Proximity = require(scriptsFolder.proximityCore)
local Logger = require(scriptsFolder.Logger)
local ProximitySettings = require(scriptsFolder.proximitySettings)

---------------------------------------------------------------

local function permissions(proximityName, permissionType, player)
	if not ProximitySettings[proximityName].permissions.enabled then return true end

	if permissionType == "userNames" then
		for _, userName in ipairs(ProximitySettings[proximityName].permissions.userNames) do
			if player.Name == userName then return true end
		end
	end
	if permissionType == "userIds" then
		for _, userId in ipairs(ProximitySettings[proximityName].permissions.userIds) do
			if player.UserId == userId then return true end
		end
	end

	if permissionType == "gamepassIds" then
		for _, gamepassId in ipairs(ProximitySettings[proximityName].permissions.gamepassIds) do
			local success, userOwnsGamepass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
			end)

			if success and userOwnsGamepass then return true end
		end
	end

	if permissionType == "groups" then
		local userGroups = GroupService:GetGroupsAsync(player.UserId)
		for _, groupConfig in ipairs(ProximitySettings[proximityName].permissions.groups) do
			for _, userGroup in ipairs(userGroups) do
				if userGroup.Id == groupConfig.groupId then
					local userRankIdInGroup = player:GetRankInGroup(userGroup.Id)

					if not groupConfig.useRankIds then return true end

					for _, groupConfigRankId in ipairs(groupConfig.rankIds) do
						if groupConfigRankId == userRankIdInGroup then return true end
					end
				end
			end
		end
	end

	return false
end

---------------------------------------------------------------

-- Main Code
local proximityName = "proximityExample"

return Proximity.proximity.new({
	name = proximityName,
	executor = function(args)

		-- Logging
		if ProximitySettings[proximityName].log.enabled then
			Logger.sendLog(args.player, proximityName, args)
		end

		-- Permissions
		if permissions(proximityName, "userNames", args.player) then
			print(args.player, "has permission to use proximity", proximityName)
		elseif permissions(proximityName, "userIds", args.player) then
			print(args.player, "has permission to use proximity", proximityName)
		elseif permissions(proximityName, "gamepassIds", args.player) then
			print(args.player, "has permission to use proximity", proximityName)
		elseif permissions(proximityName, "groups", args.player) then
			print(args.player, "has permission to use proximity", proximityName)
		else
			print(args.player, "does not have permission to use proximity", proximityName)
			return
		end

		-- MAIN CODE GOES HERE

		warn("yolo im boss")
	end,
})