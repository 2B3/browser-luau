local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

local createElement = React.createElement

type ContainerProps = {
	AnchorPoint: Vector2?,
	Position: UDim2?,
	Size: UDim2?,

	BackgroundTransparency: number?,
	BackgroundColor3: Color3,

	AutomaticSize: Enum.AutomaticSize?,

	Layout: {
		HorizontalAlignment: Enum.HorizontalAlignment?,
		VerticalAlignment: Enum.VerticalAlignment?,
		HorizontalFlex: Enum.UIFlexAlignment?,
		VerticalFlex: Enum.UIFlexAlignment?,
		FillDirection: Enum.FillDirection?,
		SortOrder: Enum.SortOrder?,
		Wraps: boolean?,
		Padding: UDim?,
	}?,

	ref: typeof(React.createRef())?,
	children: { any }?,
	key: number?,
}

local function Container(props: ContainerProps)
	local childrens = {}

	if props.Layout then
		childrens.Layout = createElement("UIListLayout", {
			HorizontalAlignment = props.Layout.HorizontalAlignment,
			VerticalAlignment = props.Layout.VerticalAlignment,
			HorizontalFlex = props.Layout.HorizontalFlex,
			FillDirection = props.Layout.FillDirection,
			VerticalFlex = props.Layout.VerticalFlex,
			SortOrder = props.Layout.SortOrder,
			Padding = props.Layout.Padding,
			Wraps = props.Layout.Wraps,
		})
	end

	if props.children then
		for i, v in props.children do
			childrens[i] = v
		end
	end

	return createElement("Frame", {
		AutomaticSize = props.AutomaticSize,

		AnchorPoint = props.AnchorPoint,
		Position = props.Position,
		Size = props.Size,

		BackgroundTransparency = props.BackgroundTransparency or 1,
		BackgroundColor3 = props.BackgroundColor3,
		BorderSizePixel = 0,

		ref = props.ref,
		key = props.key,
	}, childrens)
end

return Container
