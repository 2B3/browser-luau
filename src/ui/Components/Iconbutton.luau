local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lucide = require(ReplicatedStorage.Packages.Lucide)
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

local RESOLUTION = 256

export type IconButtonProps = {
	IconName: string,
	LayoutOrder: number?,

	AnchorPoint: Vector2,
	Position: UDim2,
	Size: UDim2,

	Rotation: number?,
	ZIndex: number?,

	OnClick: (() -> ())?,
}

local function IconButton(props: IconButtonProps)
	local asset = Lucide.GetAsset(props.IconName, RESOLUTION)

	local hovering, setHovering = useState(false)
	local heldDown, setHeldDown = useState(false)

	local styles = useSpring({
		Transparency = if heldDown and hovering then 0.85 elseif hovering then 0.9 else 1,
		config = { tension = 400, friction = 30, mass = 0.1 },
	})

	return createElement("TextButton", {
		BackgroundColor3 = Color3.fromHex("ffffff"),
		BackgroundTransparency = styles.Transparency,
		Size = props.Size or UDim2.fromScale(0, 1),
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = props.LayoutOrder,
		AutoButtonColor = false,
		ZIndex = props.ZIndex,
		Text = "",

		AnchorPoint = props.AnchorPoint,
		Position = props.Position,

		[React.Event.MouseButton1Down] = function()
			setHeldDown(true)
		end,

		[React.Event.MouseButton1Up] = function()
			setHeldDown(false)
		end,

		[React.Event.MouseEnter] = function()
			setHovering(true)
		end,

		[React.Event.MouseLeave] = function()
			setHovering(false)
		end,

		[React.Event.Activated] = props.OnClick,
	}, {

		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 7),
			PaddingRight = UDim.new(0, 14),
			PaddingLeft = UDim.new(0, 14),
			PaddingTop = UDim.new(0, 7),
		}),

		Icon = createElement("ImageLabel", {
			ScaleType = Enum.ScaleType.Fit,
			Size = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,

			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.one * 0.5,
			Rotation = props.Rotation,

			ImageRectOffset = asset.ImageRectOffset,
			ImageRectSize = asset.ImageRectSize,
			Image = asset.Url,
		}, {

			AspectRatio = createElement("UIAspectRatioConstraint", {}),
		}),
	})
end

return IconButton
