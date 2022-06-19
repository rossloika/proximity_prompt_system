-- Local Roblox Services
local HttpService = game:GetService("HttpService")
local placeID = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

-- Local Paths
local scriptsFolder = script.Parent

-- Local Requires
local ProximitySettings = require(scriptsFolder.proximitySettings)

local Log = {}

function Log.sendLog(player, proximityName, args)
	local DT = DateTime.now()
	local unixTimestamp = string.format("<t:%s:F> (<t:%s:R>)", DT.UnixTimestamp, DT.UnixTimestamp)

	local success, response = pcall(function()
		return HttpService:RequestAsync({
			Url = ProximitySettings[proximityName].log.url,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",

			},
			Body = HttpService:JSONEncode({
				["embeds"] = {
					{
						["fields"] = {
							{
								["name"] = 'Player',
								["value"] = tostring(player.Name)
							},
							{
								["name"] = "Proximity Clicked",
								["value"] = proximityName
							},
							{
								["name"] = "Time",
								["value"] = unixTimestamp
							},
						},
						["footer"] = {
							["text"] = "Location: " .. tostring(placeID.Name) .. " | Place ID: " .. tostring(placeID.AssetId)
						},
						["color"] = 40447,
					},
				},
			})
		})
	end)
	warn(success, response,  ProximitySettings[proximityName].log.url)
	return response
end

return Log