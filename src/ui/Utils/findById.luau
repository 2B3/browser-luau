local function findById(list, id)
	for index, item in ipairs(list) do
		if item.Id == id then
			return index
		end
	end

	return nil
end

return findById
