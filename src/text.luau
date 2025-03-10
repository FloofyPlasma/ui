local Color = require("./colors")
local LuminUI = require("../roblox_packages/ui")

local Text = {}
Text.__index = Text
Text.__add = function(self, add)
	if add.Text then self.Text = `{self.Text}{add.Text}` end

	return self
end

local function renderText(self)
	local renderedText = self.Text
	local styles = {}

	if self.Bold then table.insert(styles, "b") end

	if self.Italic then table.insert(styles, "i") end

	if self.Strikethrough then table.insert(styles, "s") end

	if self.Underline then table.insert(styles, "u") end

	for _, style in styles do
		renderedText = string.format("<%s>%s</%s>", style, renderedText, style)
	end

	return renderedText
end

function Text:foregroundColor(color: Color3)
	self.ForegroundColor = color

	return self
end

function Text:bold(bold: boolean?)
	self.Bold = bold or true

	return self
end

function Text:italic(italic: boolean?)
	self.Italic = italic or true

	return self
end

function Text:strikethrough(strikethrough: boolean?)
	self.Strikethrough = strikethrough or true

	return self
end

function Text:underline(underline: boolean?)
	self.Underline = underline or true

	return self
end

function Text:monospaced(monospaced: boolean?)
	self.Monospaced = monospaced or true

	return self
end

function Text:_render()
	return LuminUI.New("TextLabel") {
		BackgroundTransparency = 1,
		TextColor3 = self.ForegroundColor :: Color3,
		Text = renderText(self),
		AnchorPoint = Vector2.one / 2,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(36, 36),
		TextSize = 36,
		RichText = true,
		FontFace = Font.fromName(self.Monospaced and "BuilderMono" or "BuilderSans"),
	}
end

return function(DisplayedText: string)
	local self = {
		Text = DisplayedText,
		ForegroundColor = Color.dark.lightText,
		Bold = false,
		Italic = false,
		Strikethrough = false,
		Underline = false,
		Monospaced = false,
	}

	return setmetatable(self, Text)
end
