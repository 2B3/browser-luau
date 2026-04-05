local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local Browser = require(ReplicatedStorage.UI.Apps.Browser)
local React = require(ReplicatedStorage.Packages.React)

local story = {
	react = React,
	reactRoblox = ReactRoblox,
	controls = nil,
	story = function()
		local component = React.createElement(Browser)
		return component
	end,
}

return story
