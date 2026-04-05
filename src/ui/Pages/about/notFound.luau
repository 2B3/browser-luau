local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SearchBoxStyle = require(ReplicatedStorage.UI.Styles.SearchBoxStyle)
local Style = require(ReplicatedStorage.UI.Styles.Style)
local React = require(ReplicatedStorage.Packages.React)
local createElement = React.createElement

local function Page()
	return createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {

		Body = createElement("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,

			TextColor3 = SearchBoxStyle.Foreground,
			FontFace = Style.FontFamily,

			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextWrapped = true,
			TextSize = 18,

			Text = "Not Found",
		}, {

			Padding = createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 8),
			}),
		}),
	})
end

return Page
