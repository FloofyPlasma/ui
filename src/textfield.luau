local Color = require("./colors")
local LuminUI = require("../roblox_packages/ui")

local TextField = {}
TextField.__index = TextField

return function(FieldLabel: string, FieldPlaceholder: string?)
	local self = {
		FieldText = FieldLabel,
		FieldPlaceholder = FieldPlaceholder,
	}

	return setmetatable(self, TextField)
end
