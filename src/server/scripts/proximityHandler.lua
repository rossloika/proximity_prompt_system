local ProximityHandler = {}

ProximityHandler.proximityActions = {}

function ProximityHandler.registerProximityAction(proximityActionFile)
    local ProximityAction = require(proximityActionFile)

    ProximityHandler.proximityActions[#ProximityHandler.proximityActions+1] = ProximityAction
end

return ProximityHandler