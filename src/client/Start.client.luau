local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ModuleLoader = require(ReplicatedStorage.Packages.ModuleLoader)

ModuleLoader.ChangeSettings({
	FOLDER_SEARCH_DEPTH = 3,
	VERBOSE_LOADING = true,
})

ModuleLoader.Start(script.Parent.Modules)
