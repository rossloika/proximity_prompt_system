function main()

end

local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")

local proximityActions = script.Parent.Parent.proximityActions
local scriptsFolder = script.Parent

-- Local Requires
local proximity = require(scriptsFolder.proximity)
local proximityHandler = require(scriptsFolder.proximityHandler)

for _, proximityActionsFile in ipairs(proximityActions:GetChildren()) do
    proximityHandler.registerProximityAction(proximityActionsFile)
end


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


-- Detect when prompt is triggered
ProximityPromptService.PromptTriggered:Connect(function(promptObject, player)

    local proximityName = nil

    local proximity = table_find(proximityHandler.ProximityActions, function(proximity) 
        return proximity.name == proximityName
    end)

    if not proximity then return end

    print(proximityName, proximity)

    proximity:execute({
		player = player,
        typeOfPrompt = "PromptTriggered",
        name = proximityName,
        promptObject = promptObject,
	})
end)

return main