local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = require(ReplicatedStorage.ui.src)

local Test = UI.View({
    UI.VStack("Center", 5, {
        UI.Text("Hello, world!"):bold():italic(),
        UI.Spacer(),
        UI.Text("This is another text"):underline(),
    })
})

local RenderUI = Instance.new("ScreenGui")
Test:_render().Parent = RenderUI
RenderUI.Parent = PlayerGui

