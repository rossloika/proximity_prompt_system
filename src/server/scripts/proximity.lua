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

return proximity