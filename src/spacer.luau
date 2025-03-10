local LuminUI = require("../roblox_packages/ui")

local Spacer = {}
Spacer.__index = Spacer

function Spacer:_render()
    return LuminUI.New "Frame" {
        Size = UDim2.fromScale(0, 0),
        BackgroundTransparency = 1,

        LuminUI.New "UIFlexItem" {
            FlexMode = Enum.UIFlexMode.Grow,
        }
    }
end

return function()
    local self = {

    }

    return setmetatable(self, Spacer)
end
