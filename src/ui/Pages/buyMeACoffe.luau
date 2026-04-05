local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local BuyMeACoffeData = require(ReplicatedStorage.UI.Data.BuyMeACoffeData)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local React = require(ReplicatedStorage.Packages.React)
local map = require(ReplicatedStorage.UI.Utils.map)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

local normalFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local boldFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

local text2xl = 22
local textmd = 16
local textsm = 15

local cups = {
	{ Amount = 1, Id = 3554173774 },
	{ Amount = 3, Id = 3554174476 },
	{ Amount = 5, Id = 3554175003 },
	{ Amount = 10, Id = 3554175192 },
}

type ContentProps = {
	children: { any },
}

type InputProps = {
	TextYAlignment: Enum.TextYAlignment,
	TextWrapped: boolean,
	LayoutOrder: number,
	MinY: number,

	PlaceholderText: string,
}

local function Content(props: ContentProps)
	local children = {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 36),
		}),

		Layout = createElement("UIListLayout", {
			Padding = UDim.new(0, 16),

			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 24),
			PaddingRight = UDim.new(0, 32),
			PaddingLeft = UDim.new(0, 32),
			PaddingTop = UDim.new(0, 24),
		}),

		Stroke = createElement("UIStroke", {
			BorderStrokePosition = Enum.BorderStrokePosition.Center,
			Color = Color3.fromHex("#f7f7f7"),
			Thickness = 2,
		}),
	}

	for i, v in props.children do
		children[i] = v
	end

	return createElement("Frame", {
		BackgroundColor3 = Color3.fromHex("ffffff"),
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(0, 386, 0, 0),
		BorderSizePixel = 0,
	}, children)
end

local function Input(props: InputProps)
	local hovering, setHovering = useState(false)
	local focused, setFocused = useState(false)

	local styles = useSpring({
		BackgroundTransparency = if focused then 1 elseif hovering then 0.9 else 0.95,
		StrokeTransparency = if focused then 0 else 1,
		Thickness = if focused then 2 else 0,
	})

	return createElement("TextBox", {
		BackgroundTransparency = styles.BackgroundTransparency,

		BackgroundColor3 = Color3.fromHex("222222"),
		Size = UDim2.new(1, 0, 0, props.MinY),
		ClearTextOnFocus = false,

		TextTruncate = Enum.TextTruncate.SplitWord,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutomaticSize = Enum.AutomaticSize.Y,

		TextYAlignment = props.TextYAlignment,
		LayoutOrder = props.LayoutOrder,
		TextWrapped = props.TextWrapped,

		FontFace = normalFace,
		TextSize = textmd,

		PlaceholderText = props.PlaceholderText,
		Text = "",

		[React.Event.MouseEnter] = function()
			setHovering(true)
		end,

		[React.Event.MouseLeave] = function()
			setHovering(false)
		end,

		[React.Event.Focused] = function()
			setFocused(true)
		end,

		[React.Event.FocusLost] = function()
			setFocused(false)
		end,
	}, {

		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		Stroke = createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromHex("d8573f"),

			Transparency = styles.StrokeTransparency,
			Thickness = styles.Thickness,
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 16),
			PaddingRight = UDim.new(0, 16),
			PaddingLeft = UDim.new(0, 16),
			PaddingTop = UDim.new(0, 16),
		}),
	})
end

local function RecentSupporter(props: {
	SupporterId: number,
})
	local playerThumnail =
		Players:GetUserThumbnailAsync(props.SupporterId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

	return createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 65),
		BackgroundTransparency = 1,
	}, {

		Layout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 12),
		}),

		Icon = createElement("ImageLabel", {
			BackgroundColor3 = Color3.fromHex("ffd9d0"),
			Size = UDim2.fromOffset(40, 40),

			Image = playerThumnail,

			LayoutOrder = 1,
		}, {

			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1),
			}),
		}),

		Content = createElement("Frame", {
			Size = UDim2.new(0, 224, 1, 0),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
		}, {

			Layout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			}),

			Name = createElement("TextBox", {
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = normalFace,
				TextSize = textsm,

				ClearTextOnFocus = false,
				RichText = true,

				Text = "<b>Cadles_YT</b> bought a coffe",

				LayoutOrder = 1,
			}),

			Message = createElement("TextBox", {
				BackgroundColor3 = Color3.fromHex("3b82f6"),
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 0.85,
				FontFace = normalFace,
				BorderSizePixel = 0,
				TextSize = textsm,

				ClearTextOnFocus = false,

				Text = "Que si diego que si.",

				LayoutOrder = 2,
			}, {

				Padding = createElement("UIPadding", {
					PaddingBottom = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 12),
					PaddingLeft = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 8),
				}),

				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),
		}),
	})
end

local function BuyMeACoffe()
	local counter, setCounter = useState(cups[1])

	local function purchare()
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, counter.Id)
	end

	return createElement("Frame", {
		BackgroundColor3 = Color3.fromHex("f5f5f5"),
		Size = UDim2.fromScale(1, 1),
	}, {

		Scroll = createElement("ScrollingFrame", {
			CanvasSize = UDim2.fromScale(1, 0),
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(1, 0, 1, -75),
			AnchorPoint = Vector2.yAxis,

			ScrollingDirection = Enum.ScrollingDirection.Y,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,

			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 100,
		}, {

			Content = createElement("Frame", {
				AutomaticSize = Enum.AutomaticSize.XY,
				Position = UDim2.fromScale(0.5, 0),
				AnchorPoint = Vector2.xAxis * 0.5,
				BackgroundTransparency = 1,
			}, {

				Padding = createElement("UIPadding", {
					PaddingBottom = UDim.new(0, 16),
					PaddingRight = UDim.new(0, 16),
					PaddingLeft = UDim.new(0, 16),
					PaddingTop = UDim.new(0, 16),
				}),

				Layout = createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 12),
				}),

				Right = createElement(Content, nil, {
					Title = createElement("TextLabel", {
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						FontFace = boldFace,
						TextSize = text2xl,

						Text = "Buy 2b3 a coffe",

						LayoutOrder = 1,
					}),

					Cups = createElement("Frame", {
						BackgroundColor3 = Color3.fromHex("d8573f"),
						Size = UDim2.new(1, 0, 0, 74),
						BackgroundTransparency = 0.9,

						LayoutOrder = 2,
					}, {

						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(0, 8),
						}),

						Stroke = createElement("UIStroke", {
							BorderStrokePosition = Enum.BorderStrokePosition.Center,
							Color = Color3.fromHex("d8573f"),
							Transparency = 0.7,
						}),

						Layout = createElement("UIListLayout", {
							Padding = UDim.new(0, 9),

							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),

						["☕"] = createElement("TextLabel", {
							Size = UDim2.fromOffset(40, 60),
							BackgroundTransparency = 1,
							TextScaled = true,

							Text = "☕",
							LayoutOrder = 1,
						}),

						["X"] = createElement("TextLabel", {
							TextColor3 = Color3.fromHex("222222"),

							AutomaticSize = Enum.AutomaticSize.XY,

							BackgroundTransparency = 1,
							TextTransparency = 0.5,
							FontFace = boldFace,
							TextSize = text2xl,

							Text = "x",
							LayoutOrder = 2,
						}),

						Counters = map(cups, function(child: { Amount: number, Id: string, default: boolean? }, index)
							local hovering, setHovering = useState(false)

							local isSelected = child == counter

							local styles = useSpring({
								BackgroundColor3 = if isSelected
									then Color3.fromHex("d8573f")
									else Color3.fromHex("ffffff"),
								TextColor3 = if isSelected then Color3.fromHex("ffffff") else Color3.fromHex("d8573f"),
								StrokeTransparency = if isSelected or hovering then 0 else 0.7,
							})

							return createElement("TextButton", {
								BackgroundColor3 = styles.BackgroundColor3,
								Size = UDim2.fromOffset(40, 40),
								AutoButtonColor = false,
								BorderSizePixel = 0,

								TextColor3 = styles.TextColor3,
								FontFace = boldFace,
								TextSize = textmd,

								Text = child.Amount,

								LayoutOrder = 2 + index,
								key = index,

								[React.Event.MouseEnter] = function()
									setHovering(true)
								end,

								[React.Event.MouseLeave] = function()
									setHovering(false)
								end,

								[React.Event.Activated] = function()
									if isSelected then
										return
									end

									setCounter(child)
								end,
							}, {

								Corner = createElement("UICorner", {
									CornerRadius = UDim.new(1),
								}),

								Stroke = createElement("UIStroke", {
									BorderStrokePosition = Enum.BorderStrokePosition.Center,
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Transparency = styles.StrokeTransparency,
									Color = Color3.fromHex("d8573f"),
								}),
							})
						end),
					}),

					UserInput = createElement(Input, {
						TextYAlignment = Enum.TextYAlignment.Center,
						MinY = 52,

						LayoutOrder = 3,
						PlaceholderText = "Name or @yoursocial",
					}),

					MessageInput = createElement(Input, {
						TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true,
						MinY = 124,

						LayoutOrder = 3,
						PlaceholderText = "Say something nice...",
					}),

					Send = createElement("TextButton", {
						BackgroundColor3 = Color3.fromHex("d8573f"),
						TextColor3 = Color3.fromHex("ffffff"),
						Size = UDim2.new(1, 0, 0, 45),

						FontFace = boldFace,
						TextSize = textsm,

						Text = "Support " .. utf8.char(0xE002) .. counter.Amount * 50,
						LayoutOrder = 4,

						[React.Event.Activated] = function()
							purchare()
						end,
					}, {

						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(1),
						}),
					}),
				}),

				Left = createElement(Content, nil, {
					Title = createElement("TextBox", {
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						FontFace = boldFace,
						TextSize = textsm,

						ClearTextOnFocus = false,
						Text = "About 2b3",

						LayoutOrder = 1,
					}),

					About = createElement("TextBox", {
						TextXAlignment = Enum.TextXAlignment.Left,
						AutomaticSize = Enum.AutomaticSize.Y,

						Size = UDim2.fromScale(1, 0),
						BackgroundTransparency = 1,

						ClearTextOnFocus = false,
						TextEditable = false,
						TextWrapped = true,

						Text = BuyMeACoffeData.About,
						FontFace = normalFace,
						TextSize = textsm,

						LayoutOrder = 2,
					}),

					Line = createElement("Frame", {
						BackgroundColor3 = Color3.fromHex("e4e4e4"),
						Size = UDim2.new(1, 0, 0, 1),

						BorderSizePixel = 0,
						LayoutOrder = 3,
					}),

					RecentSupportTitle = createElement("TextBox", {
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						FontFace = boldFace,
						TextSize = textsm,

						ClearTextOnFocus = false,
						Text = "Recent supporters",

						LayoutOrder = 3,
					}),

					RecentSupporters = createElement("Frame", {
						AutomaticSize = Enum.AutomaticSize.Y,
						Size = UDim2.fromScale(1, 0),
						BackgroundTransparency = 1,
						LayoutOrder = 4,
					}, {
						Layout = createElement("UIListLayout", {
							Padding = UDim.new(0, 4),

							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),

						[1] = createElement(RecentSupporter, {
							SupporterId = 2896870549,
						}),
					}),
				}),
			}),
		}),

		Background2 = createElement("Frame", {
			BackgroundColor3 = Color3.fromHex("eff2ff"),
			Size = UDim2.new(1, 0, 0, 180),
			BorderSizePixel = 0,
		}),

		Navbar = createElement("Frame", {
			BackgroundColor3 = Color3.fromHex("ffffff"),
			Size = UDim2.new(1, 0, 0, 75),
			ZIndex = 1000,
		}, {

			Stroke = createElement("UIStroke", {
				Color = Color3.fromHex("ebedf4"),
			}),

			Layout = createElement("UIListLayout", {
				Padding = UDim.new(0, 12),

				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			Padding = createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 36),
				PaddingLeft = UDim.new(0, 36),
				PaddingTop = UDim.new(0, 12),
			}),

			Icon = createElement("ImageLabel", {
				Image = "rbxassetid://117051078659249",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,

				LayoutOrder = 1,
			}, {

				AspectRatio = createElement("UIAspectRatioConstraint", {}),

				Corner = createElement("UICorner", {}),
			}),

			Content = createElement("Frame", {
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.fromScale(0, 1),
				BackgroundTransparency = 1,
				LayoutOrder = 2,
			}, {

				Layout = createElement("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 6),
				}),

				Name = createElement("TextLabel", {
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,

					Text = "Buy 2b3 a coffe",
					FontFace = boldFace,
					TextSize = textmd,

					LayoutOrder = 1,
				}),

				Supporters = createElement("TextLabel", {
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,

					TextColor3 = Color3.fromHex("717171"),
					Text = "1 Supporters",

					FontFace = normalFace,
					TextSize = textsm,

					LayoutOrder = 1,
				}),
			}),
		}),
	})
end

return BuyMeACoffe
