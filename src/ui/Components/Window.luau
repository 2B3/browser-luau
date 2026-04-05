local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NavbarStyle = require(ReplicatedStorage.UI.Styles.NavbarStyle)
local WindowStyle = require(ReplicatedStorage.UI.Styles.WindowStyle)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local React = require(ReplicatedStorage.Packages.React)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring

export type WindowProps = {
	children: {
		Navbar: any?,
		Content: any?,
	}?,
}

local function Window(props: WindowProps)
	local styles = useSpring({
		from = {
			Transparency = 1,
			Position = UDim2.fromScale(0.5, 0.8),
		},

		to = {
			Transparency = 0,
			Position = UDim2.fromScale(0.5, 0.5),
		},
	})

	return createElement("CanvasGroup", {
		Size = UDim2.fromScale(0.9, 0.9),
		AnchorPoint = Vector2.one * 0.5,

		BackgroundColor3 = WindowStyle.background,
		GroupTransparency = styles.Transparency,
		Position = styles.Position,
	}, {

		Aspect = createElement("UIAspectRatioConstraint", { AspectRatio = 1.633 }),

		Corner = createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),

		Stroke = createElement("UIStroke", {
			Color = NavbarStyle.Background,
			Transparency = styles.Transparency,
		}),

		Navbar = props.children and props.children.Navbar,

		Content = props.children and props.children.Content,
	})
end

return Window
