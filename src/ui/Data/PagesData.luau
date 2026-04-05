local ReplicatedStorage = game:GetService("ReplicatedStorage")

local pages = ReplicatedStorage.UI.Pages

local buyMeACoffe = require(ReplicatedStorage.UI.Pages.buyMeACoffe)
local notFound = require(pages.about.notFound)
local home = require(pages.about.home)

export type PageData = {
	Name: string,
	Image: string,

	Url: string,
	Page: () -> (),
}

local PagesData = table.freeze({
	["about:home"] = {
		Name = "NewTab",
		Image = "rbxassetid://121486721984997",
		Url = "about:home",
		Page = home,
	},

	["about:notFound"] = {
		Name = "NotFound",
		Image = "",
		Url = "about:notFound",
		Page = notFound,
	},

	["https://buymeacoffe.com"] = {
		Name = "Buy me a coffe",
		Image = "rbxassetid://130362271372782",
		Url = "buymecoffe.com",
		Page = buyMeACoffe,
	},
})

return PagesData
