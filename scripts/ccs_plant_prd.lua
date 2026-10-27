--根种下去的树的表
local ccs_plant_prd = {

	ccs_strawberry_seeds = 
	{   
		--草莓
		name = "ccs_strawberry_seeds",
		name_string = "魔法草莓树",
		des_string = "草莓树！？",
		time = 1440,
		prd = "ccs_strawberry_food",
	},
}

for k, v in pairs(ccs_plant_prd) do
	RegisterInventoryItemAtlas(resolvefilepath("images/inventoryimages/"..v.name..".xml"), v.name..".tex")
	
	if v.name then
		STRINGS.NAMES[string.upper(k)] = v.name_string
		STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(k)] = v.des_string
	end
	
	if v.recipe then
		STRINGS.RECIPE_DESC[string.upper(v.name)] = v.recipe_string
	end
end

return ccs_plant_prd