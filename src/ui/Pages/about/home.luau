local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SearchBoxStyle = require(ReplicatedStorage.UI.Styles.SearchBoxStyle)
local Style = require(ReplicatedStorage.UI.Styles.Style)
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local Iconbutton = require(ReplicatedStorage.UI.Components.Iconbutton)

local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

local function markToXml(markdownText: string): string
	markdownText = markdownText:gsub("### ([^\n]+)\n?", '<font size="26">%1</font>\n')
	markdownText = markdownText:gsub("## ([^\n]+)\n?", '<font size="30">%1</font>\n')
	markdownText = markdownText:gsub("# ([^\n]+)\n?", '<font size="34">%1</font>\n')

	markdownText = markdownText:gsub(
		"%.%.%.%* ([^\n]+\n?)",
		`<stroke color="#{SearchBoxStyle.Foreground:ToHex()}"><font transparency="1">•</font></stroke>   %1`
	)

	markdownText = markdownText:gsub(
		"%.%.%* ([^\n]+\n?)",
		`<stroke color="#{SearchBoxStyle.Foreground:ToHex()}"><font transparency="1">•</font></stroke>  %1`
	)

	markdownText = markdownText:gsub(
		"%.%* ([^\n]+\n?)",
		`<stroke color="#{SearchBoxStyle.Foreground:ToHex()}"><font transparency="1">•</font></stroke> %1`
	)

	markdownText = markdownText:gsub("%.%.%. ([^\n]+\n?)", "•   %1")
	markdownText = markdownText:gsub("%.%. ([^\n]+\n?)", "•    %1")
	markdownText = markdownText:gsub("%. ([^\n]+\n?)", "•  %1")

	markdownText = markdownText:gsub("%*(.-)%*", "<b>%1</b>")

	markdownText = markdownText:gsub("_(.-)_", "<i>%1</i>")

	return markdownText
end

local TEXT = "# H1\n## H2\n### H3\nnormal\n. A\n..* A\n_Italic_\n*Bold*"

local function Page()
	local markdown, setMarkdown = useState(true)
	local text, setText = useState(TEXT)
	local bodyRef = React.createRef()

	local styles = useSpring({
		Rotation = if markdown then 0 else 45,
	})

	local function toggleMarkdown()
		setMarkdown(function(prev)
			return not prev
		end)
	end

	return createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {

		Body = createElement("TextBox", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,

			TextColor3 = SearchBoxStyle.Foreground,
			FontFace = Style.FontFamily,

			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			TextEditable = markdown,
			TextWrapped = true,
			MultiLine = true,
			RichText = true,
			TextSize = 18,

			ref = bodyRef,

			Text = if markdown then text else markToXml(text),

			[React.Change.Text] = function(rbx)
				if markdown then
					setText(rbx.Text)
				end
			end,

			[React.Event.Focused] = function(rbx: TextBox)
				if not markdown then
					rbx:ReleaseFocus()
				end
			end,
		}, {

			Padding = createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 8),
			}),

			Toggle = createElement(Iconbutton, {
				Position = UDim2.fromScale(1, 0),
				AnchorPoint = Vector2.new(1, 0),
				Size = UDim2.new(0, 0, 0, 32),
				Rotation = styles.Rotation,
				IconName = "plus",
				ZIndex = 25,

				OnClick = function()
					toggleMarkdown()
					bodyRef.current:ReleaseFocus()
				end,
			}),
		}),
	})
end

return Page
