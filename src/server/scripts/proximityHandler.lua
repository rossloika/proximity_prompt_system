local ProximityHandler = {}

ProximityHandler.ProximityActions = {}

function ProximityHandler.registerProximityAction(proximityActionsFile)
    local ProximityAction = require(proximityActionsFile)

    ProximityHandler.ProximityActions[#ProximityHandler.ProximityActions+1] = ProximityAction
end

return ProximityHandler