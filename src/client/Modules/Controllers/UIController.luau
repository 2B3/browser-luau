local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local packages = ReplicatedStorage.Packages

local ReactRoblox = require(packages.ReactRoblox)
local App = require(ReplicatedStorage.UI.App)
local React = require(packages.React)

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer.PlayerGui

local UIController = {}

type Root = typeof(ReactRoblox.createRoot(Instance.new("ScreenGui")))

local function createRoot(): Root
	local rootScreen = Instance.new("ScreenGui")
	rootScreen.Name = "ReactRootScreen"
	rootScreen.Parent = playerGui

	rootScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	rootScreen.ClipToDeviceSafeArea = false
	rootScreen.IgnoreGuiInset = true
	rootScreen.ResetOnSpawn = false

	return ReactRoblox.createRoot(rootScreen)
end

function UIController:RenderApp()
	local app = React.createElement(App)
	local root = createRoot()

	root:render(app)
end

function UIController:Start()
	self:RenderApp()
end

return UIController
