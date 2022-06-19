local proximity = {}
proximity.__index = proximity

proximity.new = function(opts)
	local self = {
        name = opts.name,
		-- player = opts.player,
		-- promptObject = opts.promptObject,
        executor = opts.executor,
	}
	return setmetatable(self, proximity)
end

function proximity:execute(args)
	print("args", args)
	self.executor(args)
end

local ProximityHandler = {}

ProximityHandler.proximityActions = {}

function ProximityHandler.registerProximityAction(proximityActionFile)
    local ProximityAction = require(proximityActionFile)

    ProximityHandler.proximityActions[#ProximityHandler.proximityActions+1] = ProximityAction
end

return {
	["proximity"] = proximity,
	["ProximityHandler"] = ProximityHandler,
}