local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SearchBoxStyle = require(ReplicatedStorage.UI.Styles.SearchBoxStyle)
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local Style = require(ReplicatedStorage.UI.Styles.Style)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local createRef = React.createRef
local useEffect = React.useEffect
local useState = React.useState

export type SearchBoxProps = {
	Url: string,

	OnTypedUrl: (string) -> (),
	OnSetUrl: (string) -> (),
	children: { any },
}

local function SearchBox(props: SearchBoxProps)
	local searchBoxRef = createRef()

	local hovering, setHovering = useState(false)
	local focused, setFocused = useState(false)
	local text, setText = useState("")

	local style, api = useSpring(function()
		return {
			StrokePixel = if focused then 2 elseif hovering then 1 else 0,
			Color = if focused then SearchBoxStyle.Cyan else SearchBoxStyle.ForegroundDark,
		}
	end)

	useEffect(function()
		api.start({
			StrokePixel = if focused then 2 elseif hovering then 1 else 0,
			Color = if focused then SearchBoxStyle.Cyan else SearchBoxStyle.ForegroundDark,
		})
	end, { hovering, focused })

	return createElement("TextBox", {
		ref = searchBoxRef,

		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.one * 0.5,
		Size = UDim2.new(0.6, 0, 0, 32),

		BackgroundColor3 = SearchBoxStyle.Background,
		ClearTextOnFocus = false,
		LayoutOrder = 15,

		FontFace = Style.FontFamily,
		TextScaled = true,

		TextColor3 = SearchBoxStyle.Foreground,

		PlaceholderText = "Search with Roogle or enter address",
		Text = props.Url,

		[React.Event.Focused] = function()
			setFocused(true)
		end,

		[React.Event.FocusLost] = function(rbx, enterPressed)
			setFocused(false)

			if enterPressed then
				props.OnSetUrl(rbx.Text)
			end
		end,

		[React.Event.MouseEnter] = function()
			setHovering(true)
		end,

		[React.Event.MouseLeave] = function()
			setHovering(false)
		end,

		[React.Change.Text] = function(rbx: TextBox)
			if rbx.TextBounds.X >= rbx.AbsoluteSize.X - 85 then
				rbx.Text = text
			else
				setText(rbx.Text)
			end

			props.OnTypedUrl(rbx.Text)
		end,
	}, {

		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),

		Stroke = createElement("UIStroke", {
			BorderStrokePosition = Enum.BorderStrokePosition.Inner,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = style.StrokePixel,
			Color = style.Color,
		}),

		SizeConstraint = createElement("UISizeConstraint", {
			MinSize = Vector2.new(200, 0),
			MaxSize = Vector2.new(600, math.huge),
		}),

		TextConstraint = createElement("UITextSizeConstraint", {
			MaxTextSize = 16,
			MinTextSize = 12,
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 3),
			PaddingRight = UDim.new(0, 3),
			PaddingLeft = UDim.new(0, 3),
			PaddingTop = UDim.new(0, 3),
		}),

		Childrens = createElement(React.Fragment, nil, props.children),
	})
end

return SearchBox
