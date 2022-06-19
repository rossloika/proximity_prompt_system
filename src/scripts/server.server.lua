local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")

local proximityActions = script.Parent.Parent.proximityActions
local scriptsFolder = script.Parent

-- Local Requires
local proximityCore = require(scriptsFolder.proximityCore)

function table_find(tbl, callback)
    local matched = nil

    for key, value in pairs(tbl) do
        if callback(value, key, tbl) then
            matched = value
            break
        end
    end

    return matched
end

for _, proximityActionFile in ipairs(proximityActions:GetChildren()) do
    proximityCore.ProximityHandler.registerProximityAction(proximityActionFile)
end

-- Detect when prompt is triggered
ProximityPromptService.PromptTriggered:Connect(function(promptObject, player)

    local proximityName = promptObject.Name

    local proximity = table_find( proximityCore.ProximityHandler.proximityActions, function(proximity)
        return proximity.name == proximityName
    end)

    -- warn(proximityName,  proximityCore.ProximityHandler.proximityActions, proximity)

    if not proximity then return end

    -- print(proximityName, proximity)

    proximity:execute({
		name = proximityName,
        player = player,
        promptObject = promptObject,
	})
end)