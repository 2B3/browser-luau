local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SearchBoxStyle = require(ReplicatedStorage.UI.Styles.SearchBoxStyle)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local TabStyle = require(ReplicatedStorage.UI.Styles.TabStyle)
local findById = require(ReplicatedStorage.UI.Utils.findById)
local Lucide = require(ReplicatedStorage.Packages.Lucide)
local Style = require(ReplicatedStorage.UI.Styles.Style)
local React = require(ReplicatedStorage.Packages.React)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

export type TabProps = {
	Image: string,
	Name: string,
	Id: string,

	ActivePageId: string?,
	Pages: { any },

	OnClose: (id: string) -> (),
	OnSelect: () -> (),
}

local function Tab(props: TabProps)
	local hovering, setHovering = useState(false)
	local heldDown, setHeldDown = useState(false)

	local tabCount = #props.Pages
	local tabIndex = findById(props.Pages, props.Id)

	local isSelected = tostring(props.ActivePageId) == tostring(props.Id)

	local styles = useSpring({
		from = {
			Size = UDim2.fromOffset(1 / tabCount * 1.25, 1),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.one * 0.5,
		},

		to = {
			Position = UDim2.fromScale((tabIndex - 1) / tabCount, 0),
			Size = UDim2.fromScale(1 / tabCount, 1),
			AnchorPoint = Vector2.zero,
		},
	})

	local style = useSpring({
		Transparency = if hovering and #props.Pages ~= 1 then 0 else 1,

		Color = if heldDown and hovering
			then TabStyle.BackgroundHeldDown
			elseif hovering then TabStyle.BackgroundHovering
			elseif isSelected then TabStyle.BackgroundSelected
			else TabStyle.BackgroundDisabled,
	})

	local closeAsset = Lucide.GetAsset("x", 256)

	local contentChildren = {

		Layout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 4),
		}),

		Name = createElement("TextLabel", {
			TextColor3 = SearchBoxStyle.Foreground,
			AutomaticSize = Enum.AutomaticSize.XY,
			FontFace = Style.FontFamily,
			BackgroundTransparency = 1,
			Text = props.Name,
			LayoutOrder = 10,
			TextSize = 15,
		}),

		Gradient = createElement("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.6, 0),
				NumberSequenceKeypoint.new(1, 1),
			}),
		}),
	}

	if props.Image:match("rbxassetid://") then
		contentChildren["Icon"] = createElement("ImageLabel", {
			Size = UDim2.fromOffset(16, 16),
			ScaleType = Enum.ScaleType.Fit,
			BackgroundTransparency = 1,
			Image = props.Image,
		}, {

			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})
	end

	return createElement("TextButton", {
		BackgroundColor3 = style.Color,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Text = "",

		AnchorPoint = styles.AnchorPoint,
		Position = styles.Position,
		ZIndex = tabIndex,
		Size = styles.Size,

		[React.Event.MouseEnter] = function()
			setHovering(true)
		end,

		[React.Event.MouseLeave] = function()
			setHovering(false)
		end,

		[React.Event.MouseButton1Down] = function()
			setHeldDown(true)
		end,

		[React.Event.MouseButton1Up] = function()
			setHeldDown(false)
		end,

		[React.Event.Activated] = props.OnSelect,
	}, {

		Content = createElement("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, contentChildren),

		Close = createElement("ImageButton", {
			ImageColor3 = SearchBoxStyle.ForegroundDark,
			Position = UDim2.new(1, -8, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,

			ImageRectOffset = closeAsset.ImageRectOffset,
			ImageRectSize = closeAsset.ImageRectSize,
			ImageTransparency = style.Transparency,
			Image = closeAsset.Url,

			[React.Event.Activated] = function()
				props.OnClose(props.Id)
			end,
		}),
	})
end

return Tab
