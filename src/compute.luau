-- Variables
local Types = require("./types")
local Debugger = require("../roblox_packages/debugger")
local Is = require("./is")

local Class = {}
Class.__index = Class

-- Functions

local function Listener(self: Types.Compute<any>)
	return function()
		self._Value = self._Processor() -- Set the value of the computed state to the new processed value

		if self._Instances ~= nil then
			for prop, instance in self._Instances do
				(instance :: any)[prop] = self._Value
			end
		end

		-- Run all listeners when the value is changed
		for _, fn in self._Listeners do
			task.spawn(fn, self._Value)
		end
	end
end

function Class._Bind(self: Types.Compute<any>, prop: string, instance: Instance)
	(self._Instances :: {})[prop] = instance;
	(instance :: any)[prop] = self._Value
end

--[=[
	Gets the current value of the compute object.

	[Open Documentation](https://lumin-org.github.io/ui/api/compute/#get)
]=]
function Class.Get(self: Types.Compute<any>): any
	return self._Value
end

--[=[
	Listens to changes of state within the object.

	[Open Documentation](https://lumin-org.github.io/ui/api/compute/#listen)
]=]
function Class.Listen(self: Types.Compute<any>, listener: (new: any) -> ()): () -> ()
	table.insert(self._Listeners, listener) -- Add listener
	return function() -- Disconnect the listener
		local Listener = table.find(self._Listeners, listener)
		if Listener then
			table.remove(self._Listeners, Listener)
		end
	end
end

--[=[
	Destroys the compute object, but not the state dependencies.

	[Open Documentation](https://lumin-org.github.io/ui/api/compute/#destroy)
]=]
function Class.Destroy(self: Types.Compute<any>)
	table.clear(self :: any)
	setmetatable(self :: any, nil)
end

-- Module

--[=[
	Creates a new computed value, which changes the final value when a dependency is changed.

	[Open Documentation](https://lumin-org.github.io/ui/api/#compute)
]=]
return function(processor: () -> (), dependencies: { Types.State<any> }?): Types.Compute<any>
	local self = setmetatable({}, Class)

	self._Processor = processor
	self._Value = processor()
	self._Listeners = {}
	self._Instances = {}
	self._Dependencies = {} :: any
	self._Type = "Compute"

	if dependencies then
		Debugger.assert(type(dependencies) == "table", "InvalidType", "table", type(dependencies))
		for _, dependency in dependencies do
			if Is(dependency) == "State" then
				(self._Dependencies :: any)[dependency] = (dependency :: any):Listen(Listener(self :: any))
			else
				Debugger.fatal("InvalidType", "state", type(dependency))
			end
		end
	end

	return self :: any
end
