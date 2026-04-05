local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SearchBoxStyle = require(ReplicatedStorage.UI.Styles.SearchBoxStyle)
local Iconbutton = require(ReplicatedStorage.UI.Components.Iconbutton)
local SearchBox = require(ReplicatedStorage.UI.Components.SearchBox)
local Container = require(ReplicatedStorage.UI.Components.Container)
local NavbarStyle = require(ReplicatedStorage.UI.Styles.NavbarStyle)
local Tab = require(ReplicatedStorage.UI.Components.Tab)
local React = require(ReplicatedStorage.Packages.React)

local createElement = React.createElement

export type NavbarProps = {
	Pages: { any },
	ActivePageId: string?,

	OnNewTab: (string) -> (),
	OnCloseTab: (string) -> (),
	OnSelectTab: (string) -> (),

	Url: string,
	OnSetUrl: (string) -> (),
	OnTypedUrl: (string) -> (),
}

local function Navbar(props: NavbarProps)
	local tabs = {}

	for _, page in ipairs(props.Pages) do
		tabs[page.Id] = createElement(Tab, {

			key = page.Id,

			Id = page.Id,
			Name = page.Name,
			Image = page.Icon,

			Pages = props.Pages,
			ActivePageId = props.ActivePageId,

			OnClose = props.OnCloseTab,

			OnSelect = props.OnSelectTab,
		})
	end

	return createElement("Frame", {
		BackgroundColor3 = NavbarStyle.Background,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.fromScale(1, 0),
		BorderSizePixel = 0,
		ZIndex = 20,
	}, {

		Layout = createElement("UIListLayout", {}),

		Navigation = createElement("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, {

			SearchBox = createElement(SearchBox, {
				OnTypedUrl = props.OnTypedUrl,
				OnSetUrl = props.OnSetUrl,
				Url = props.Url,
			}, {
				Reload = createElement(Iconbutton, {
					IconName = "info",
					Position = UDim2.fromScale(0, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
				}),
			}),

			Padding = createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 12),
			}),

			Left = createElement(Container, {
				AutomaticSize = Enum.AutomaticSize.X,
				Position = UDim2.fromScale(0, 0.5),
				AnchorPoint = Vector2.yAxis * 0.5,
				Size = UDim2.new(0, 0, 0, 32),

				Layout = {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4),
				},
			}, {

				Left = createElement(Iconbutton, {
					IconName = "chevron-left",
					LayoutOrder = 10,
				}),

				Right = createElement(Iconbutton, {
					IconName = "chevron-right",
					LayoutOrder = 11,
				}),

				Reload = createElement(Iconbutton, {
					IconName = "rotate-cw",
					LayoutOrder = 50,
				}),
			}),

			Right = createElement(Container, {
				AutomaticSize = Enum.AutomaticSize.X,
				Position = UDim2.fromScale(1, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 0, 0, 32),

				Layout = {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4),
				},
			}, {

				Extensions = createElement(Iconbutton, {
					IconName = "blocks",
					LayoutOrder = 10,
				}),

				Menu = createElement(Iconbutton, {
					IconName = "menu",
					LayoutOrder = 11,
				}),
			}),
		}),

		Tabs = createElement(Container, {
			BackgroundColor3 = SearchBoxStyle.ForegroundDark,
			Size = UDim2.new(1, 0, 0, 28),
			BackgroundTransparency = 1,
		}, {

			Content = createElement("Frame", {
				Size = UDim2.new(1, -40, 1, 0),
				BackgroundTransparency = 1,
			}, tabs),

			More = createElement(Iconbutton, {
				IconName = "plus",
				Position = UDim2.new(1, -2, 0, 0),
				AnchorPoint = Vector2.new(1, 0),
				OnClick = function()
					props.OnNewTab("about:home")
				end,
			}),
		}),
	})
end

return Navbar
