--根的表,根种下去树的表，产品表
local Ccs_plantables = {

	ccs_strawberry_seeds = 
	{   
		--草莓种子
		name = "ccs_strawberry_seeds",
		name_string = "草莓树种", 
		recipe_string = "魔法草莓树种", 
		des_string = "草莓树！？",
        mediumspacing = true,
        floater = {"large", 0.1, 0.55},
	},
}

for k, v in pairs(Ccs_plantables) do
	RegisterInventoryItemAtlas(resolvefilepath("images/inventoryimages/"..v.name..".xml"), v.name..".tex")

	if v.name then
		STRINGS.NAMES[string.upper("dug_"..v.name)] = v.name_string
		STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(k)] = v.des_string
	end
	
	if v.recipe_string then
		STRINGS.RECIPE_DESC[string.upper("dug_"..v.name)] = v.recipe_string
	end
end

return Ccs_plantables