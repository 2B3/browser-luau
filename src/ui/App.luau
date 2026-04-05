local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Iconbutton = require(ReplicatedStorage.UI.Components.Iconbutton)
local Browser = require(script.Parent.Apps.Browser)

local useState = React.useState

local function App()
	local enabled, setEnabled = useState(false)

	return React.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
		Browser = if enabled then React.createElement(Browser) else nil,

		Toggle = React.createElement(Iconbutton, {
			IconName = "server",

			Position = UDim2.new(1, -8, 0, 8),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.new(0, 0, 0, 32),

			OnClick = function()
				setEnabled(function(prev)
					return not prev
				end)
			end,
		}),
	})
end

return App
