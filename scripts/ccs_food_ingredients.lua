local Ccs_foods_ingredients = {

	ccs_magic_water = 
	{   
		--魔法水
		name = "ccs_magic_water",
		name_string = "魔法水",
		des_string = "魔法水",
		foodtype = FOODTYPE.GOODIES, 
		health = 0, 
		hunger = 0, 
		sanity = 0, 
		perishtime = 7200,
		tag = {"ccs_magic_water"},
		oneatenfn = function(inst,eater)
		end,
	},
	ccs_strawberry_food = 
	{   
		name = "ccs_strawberry_food",
		name_string = "草莓",
		des_string = "好甜的草莓",
		foodtype = FOODTYPE.GOODIES, 
		health = 5, 
		hunger = 5, 
		sanity = 5, 
		perishtime = 7200,
		tag = {"ccs_strawberry_food"},
		oneatenfn = function(inst,eater)
		end,
	},
}

for k, v in pairs(Ccs_foods_ingredients) do
	RegisterInventoryItemAtlas(resolvefilepath("images/inventoryimages/"..v.name..".xml"), v.name..".tex")
	
	if v.name then
		STRINGS.NAMES[string.upper(k)] = v.name_string
		STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(k)] = v.des_string
	end
	
	if v.recipe then
		STRINGS.RECIPE_DESC[string.upper(v.name)] = v.recipe_string
	end
end

return Ccs_foods_ingredients