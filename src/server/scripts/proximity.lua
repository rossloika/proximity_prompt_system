local Proximity = {}
Proximity.__index = Proximity

Proximity.new = function(opts)
	local self = {
        name = opts.name,
        executor = opts.executor,
	}
	return setmetatable(self, Proximity)
end

function Proximity:execute(args)
	print("args", args)
	self.executor(args)
end

return Proximity