local Color = require("./colors")
local LuminUI = require("../roblox_packages/ui")

local View = {}
View.__index = View

function View:_render()
	local ViewFrame = LuminUI.New("Frame") {
        Position = UDim2.fromScale(0.25, 0.25),
        Size = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1,
        ClipsDescendants = true,

        LuminUI.New "UIAspectRatioConstraint" {
            AspectRatio = 1.8,
        }
    }

    for _, Instance in self.Body do
        Instance:_render().Parent = ViewFrame
    end

	return ViewFrame
end

return function(Body: { any })
	local self = {
		Body = Body,
	}

	return setmetatable(self, View)
end
