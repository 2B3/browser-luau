local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local React = require(ReplicatedStorage.Packages.React)
local Window = require(ReplicatedStorage.UI.Components.Window)
local PagesData = require(ReplicatedStorage.UI.Data.PagesData)
local Navbar = require(ReplicatedStorage.UI.Layout.Navbar)
local map = require(ReplicatedStorage.UI.Utils.map)

local createElement = React.createElement
local useEffect = React.useEffect
local useState = React.useState

local function Browser()
	local activePageId, setActivePageId = useState(nil)
	local typedUrl, setTypedUrl = useState({})
	local pages, setPages = useState({})
	local url, setUrl = useState("")

	useEffect(function()
		if not activePageId and #pages > 0 then
			setActivePageId(pages[#pages].Id)
		end
	end, { pages })

	useEffect(function()
		setPages(function(prev)
			local pageData = PagesData[url] or PagesData["about:notFound"]
			local t = {}

			for _, page in ipairs(prev) do
				if tostring(page.Id) == tostring(activePageId) then
					table.insert(t, {
						Id = page.Id,
						Icon = pageData.Image,
						Name = pageData.Name,
						Page = pageData.Page,
					})
				else
					table.insert(t, page)
				end
			end

			return t
		end)
	end, { url })

	local function closeTab(id: string)
		setPages(function(prev)
			local t = {}

			for _, page in ipairs(prev) do
				if page.Id ~= id then
					table.insert(t, page)
				end
			end

			if tostring(activePageId) == tostring(id) then
				setActivePageId(t[#t] and t[#t].Id or nil)
			end

			return t
		end)
	end

	local function typedUrlChanged(text: string)
		setTypedUrl(function(prev)
			local t = table.clone(prev)
			t[tostring(activePageId)] = text
			return t
		end)
	end

	local function selectTab(id)
		setActivePageId(id)
	end

	local function newTab(pageUrl: string?)
		local pageData = PagesData[pageUrl] or PagesData["about:notFound"]
		local id = HttpService:GenerateGUID(false)

		setTypedUrl(function(prev)
			prev[id] = pageData.Url
			return prev
		end)

		setPages(function(prev)
			local t = { unpack(prev) }

			table.insert(t, {
				Id = id,
				Icon = pageData.Image,
				Name = pageData.Name,

				Page = pageData.Page,

				Url = typedUrl[tostring(id)],
			})

			return t
		end)

		setActivePageId(id)
	end

	useEffect(function()
		-- newTab("about:home")
		newTab("https://buymeacoffe.com")
	end, {})

	return createElement(Window, nil, {

		Navbar = createElement(Navbar, {
			ActivePageId = activePageId,
			Pages = pages,

			OnNewTab = newTab,
			OnCloseTab = closeTab,
			OnSelectTab = selectTab,

			Url = typedUrl[tostring(activePageId)],
			OnTypedUrl = typedUrlChanged,
			OnSetUrl = setUrl,
		}),

		Content = createElement(
			"Frame",
			{
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1),
				Size = UDim2.new(1, 0, 1, -68),
				BackgroundTransparency = 1,
			},
			map(pages, function(page)
				local visible = tostring(page.Id) == tostring(activePageId)

				return createElement(
					React.Suspense,
					{
						fallback = createElement("TextLabel", {
							AutomaticSize = Enum.AutomaticSize.XY,
							Text = "Loading...",
						}),
					},
					createElement("Frame", {
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						Visible = visible,
						key = page.Id,
					}, {

						Content = createElement(page.Page),
					})
				)
			end)
		),
	})
end

return Browser
