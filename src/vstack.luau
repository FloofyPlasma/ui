local VStack = {}
VStack.__index = VStack

local Types = require("./types")
local LuminUI = require("../roblox_packages/ui")
local Spacer = require("./spacer")

function VStack:_render()
    local StackFrame = LuminUI.New "Frame" {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),

        LuminUI.New "UIListLayout" {
            Padding = UDim.new(0, self.Spacing),
            HorizontalAlignment = self.Alignment,
        }
    }

    Spacer():_render().Parent = StackFrame

    for _, Instance in self.Body do
        Instance:_render().Parent = StackFrame
    end

    Spacer():_render().Parent = StackFrame

    return StackFrame
end

local function AlignmentToEnum(Alignment: Types.HorizontalAlignment): EnumItem
    if Alignment == "Leading" then
        return Enum.HorizontalAlignment.Left
    elseif Alignment == "Center" then
        return Enum.HorizontalAlignment.Center
    else
        return Enum.HorizontalAlignment.Right
    end
end

return function(Alignment: Types.HorizontalAlignment, Spacing: number, Body: {any})
    local self = {
        Alignment = AlignmentToEnum(Alignment),
        Spacing = Spacing > 0 and Spacing or 5,
        Body = Body,
    }

    return setmetatable(self, VStack)
end
