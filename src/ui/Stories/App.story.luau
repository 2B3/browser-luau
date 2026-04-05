local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local React = require(ReplicatedStorage.Packages.React)
local App = require(ReplicatedStorage.UI.App)

local story = {
	react = React,
	reactRoblox = ReactRoblox,
	controls = nil,
	story = function()
		local component = React.createElement(App)
		return component
	end,
}

return story
