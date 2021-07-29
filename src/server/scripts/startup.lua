function main()

end

local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")

local proximityActions = script.Parent.Parent.proximityActions
local scriptsFolder = script.Parent

-- Local Requires
local proximity = require(scriptsFolder.proximity)
local proximityHandler = require(scriptsFolder.proximityHandler)

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
    proximityHandler.registerProximityAction(proximityActionFile)
end

-- Detect when prompt is triggered
ProximityPromptService.PromptTriggered:Connect(function(promptObject, player)

    local proximityName = promptObject.Name

    local proximity = table_find(proximityHandler.proximityActions, function(proximity) 
        return proximity.name == proximityName
    end)

    warn(proximityName, proximityHandler.proximityActions, proximity)

    if not proximity then return end

    print(proximityName, proximity)

    proximity:execute({
		name = proximityName,
        player = player,
        promptObject = promptObject,
	})
end)

return main