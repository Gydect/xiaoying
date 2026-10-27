local MODENV = env
GLOBAL.setfenv(1, GLOBAL)

--增加花瓣入锅
MODENV.AddIngredientValues({"petals"}, { 
    veggie = 0.5 
})

MODENV.AddIngredientValues({"petals_rose"}, { 
    veggie = 0.5 
})

MODENV.AddIngredientValues({"petals_orchid"}, { 
    veggie = 0.5 
})

MODENV.AddIngredientValues({"petals_lily"}, { 
    veggie = 0.5 
})

MODENV.AddIngredientValues({"ccs_sakura1"}, { 
    sakura = 1
})

MODENV.AddIngredientValues({"ccs_sakura2"}, { 
    sakura = 1
})

MODENV.AddIngredientValues({"ccs_sakura3"}, { 
    sakura = 1
})

MODENV.AddIngredientValues({"ccs_magic_water"}, { 
    magic = 1
})

MODENV.AddIngredientValues({"ccs_strawberry_food"}, { 
    fruit = 1
})

MODENV.AddIngredientValues({"saltrock"}, { 
    saltrock = 1
})

--cooktime ,0.1 = 2.5
Ccs_foods = {

	ccs_jelly = 
	{   
		--果冻
		name = "ccs_jelly",
		test = function(cooker, names, tags)
			local berry_count = (names.berries or 0) + (names.berries_juicy or 0)
			return berry_count == 2 and 
				(names.petals and names.petals == 2 or
				names.petals_rose and names.petals_rose == 2 or
				names.petals_orchid and names.petals_orchid == 2 or
				names.petals_lily and names.petals_lily == 2 )
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 15, 
		hunger = 15, 
		sanity = 15, 
		perishtime = 7200,
		cooktime = 0.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_jelly.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_jelly.xml",  

		tag = {"ccs_jelly"},
		no_cookpot = true,
		oneatenfn = function(inst,eater)
			if eater and eater.components.ccs_magic ~= nil then
				eater.components.ccs_magic:DoDelta(10)
			end
		end,
	},
	ccs_soda = 
	{   
		--气泡水
		name = "ccs_soda",
		test = function(cooker, names, tags)
			return tags.sakura and tags.sakura >= 1 and names.ice and names.ice >= 3
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 50, 
		hunger = 200, 
		sanity = 50, 
		perishtime = 7200,
		cooktime = 0.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_soda.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_soda.xml",  

		tag = {"ccs_soda"},
		oneatenfn = function(inst,eater)
			if eater and eater.components.ccs_magic ~= nil then
				eater.components.ccs_magic:DoDelta(200)
			end
			if eater and eater.userid then 
				eater:AddDebuff("ccs_soda_buff","ccs_soda_buff")
			end
		end,
	},
	ccs_yzs = 
	{   
		--玉子烧
		name = "ccs_yzs",
		test = function(cooker, names, tags)
			return names.corn and names.corn == 1 and 
				names.honey and names.honey == 1 and
				names.bird_egg and names.bird_egg == 2 
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 10, 
		hunger = 40, 
		sanity = 80, 
		perishtime = 7200,
		cooktime = 0.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_yzs.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_yzs.xml",  

		tag = {"ccs_yzs"},
		oneatenfn = function(inst,eater)
			if eater then
				if eater.components.ccs_magic then
					eater.components.ccs_magic:DoDelta(50)
				end
				-- 回复黑血
				if eater.components.health then
					eater.components.health:DoDelta(100)
				end
				eater.components.health:DeltaPenalty(-0.25)
			end
		end,
	},
	
	ccs_matcha_cake = 
	{   
		--抹茶蛋糕
		name = "ccs_matcha_cake",
		test = function(cooker, names, tags)
			return names.watermelon and names.potato and 
				names.bird_egg and tags.veggie
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 0, 
		hunger = 0, 
		sanity = 160, 
		perishtime = 7200,
		cooktime = 1,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_matcha_cake.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_matcha_cake.xml",  

		tag = {"ccs_matcha_cake"},
		oneatenfn = function(inst,eater)
			if eater and eater.components.ccs_magic ~= nil then
				eater.components.ccs_magic:DoDelta(35)
			end
		end,
	},

	ccs_strawberry_food1 = 
	{   
		--草莓双皮奶
		name = "ccs_strawberry_food1",
		test = function(cooker, names, tags)
			return names.ccs_strawberry_food and names.ccs_strawberry_food == 2 and names.goatmilk
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 80, 
		hunger = 80, 
		sanity = 80, 
		perishtime = 7200,
		cooktime = 1.6,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_strawberry_food1.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_strawberry_food1.xml",  

		tag = {"ccs_strawberry_food1"},
		oneatenfn = function(inst,eater)
			if eater and eater.components.ccs_magic ~= nil then
				eater.components.ccs_magic:DoDelta(100)
			end
		end,
	},
	ccs_strawberry_food2 = 
	{   
		--草莓大福
		name = "ccs_strawberry_food2",
		test = function(cooker, names, tags)
			return names.ccs_strawberry_food and names.goatmilk and names.honey and names.ccs_magic_water
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, 
		health = 30, 
		hunger = 30, 
		sanity = 30, 
		perishtime = 7200,
		cooktime = 2,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_strawberry_food2.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_strawberry_food2.xml",  

		tag = {"ccs_strawberry_food2"},
		oneatenfn = function(inst,eater)
			if eater and eater.components.ccs_magic ~= nil then
				eater.components.ccs_magic:DoDelta(30)
				eater:AddDebuff("ccs_strawberry_food2_buff","ccs_strawberry_food2_buff")
			end
		end,
	},
	ccs_strawberry_food3 = 
	{   
		--草莓果冻
		name = "ccs_strawberry_food3",
		test = function(cooker, names, tags)
			return names.ccs_strawberry_food and names.ccs_strawberry_food == 1 and ((names.kelp or 0) + (names.kelp_cooked or 0) + (names.kelp_dried or 0)) == 2 and names.butter
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES,
		health = 50, 
		hunger = 100, 
		sanity = 20, 
		perishtime = 7200,
		cooktime = 2.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_strawberry_food3.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_strawberry_food3.xml",  

		tag = {"ccs_strawberry_food3"},
		oneatenfn = function(inst,eater)

			if eater and eater.userid then 

				if eater:HasTag("css_nodrown_box") or eater:HasDebuff("ccs_card_fp_max") then return end
	
				if eater:HasDebuff("ccs_card_fp2") then eater:RemoveDebuff("ccs_card_fp2") end
	
				eater:AddDebuff("ccs_strawberry_food3_buff","ccs_strawberry_food3_buff")
			end
		end,
	},
	ccs_tea1 = 
	{   
		--魔法奶茶
		name = "ccs_tea1",
		test = function(cooker, names, tags)
			return names.goatmilk and names.goatmilk == 2 and names.ccs_magic_water and tags.sakura == 1
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES,
		health = 1, 
		hunger = 1, 
		sanity = 1, 
		perishtime = 7200,
		cooktime = 2.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_tea1.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_tea1.xml",  
		tag = {"ccs_tea1"},
		oneatenfn = function(inst,eater)
			if eater and eater.userid then 
				eater:AddDebuff("ccs_tea1_buff","ccs_tea1_buff")
			end
		end,
	},

	ccs_specificfood = 
	{   
		--特级秘制
		name = "ccs_specificfood",
		test = function(cooker, names, tags)
			return names.saltrock and names.monstermeat and names.eel and names.nightmarefuel and (cooker and cooker == "cookpot") and (TheWorld and TheWorld:HasTag("cave"))
		end,
		priority = 99, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES,
		health = -33, 
		hunger = 1, 
		sanity = 0, 
		perishtime = 7200,
		cooktime = 2.4,
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "ccs_specificfood.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/ccs_specificfood.xml",  
		tag = {"ccs_specificfood"},
		oneatenfn = function(inst,eater)
			if eater and eater.components.sanity then
				eater.ccs_sanlock = true
				eater.ccs_sanlocktask = eater:DoTaskInTime(480,function()
					eater.ccs_sanlock = false
				end)
			end
		end,
	},

}

for k, v in pairs(Ccs_foods) do
    v.name = k
    v.weight = v.weight or 1
    v.priority = v.priority or 0
	v.overridebuild = k

	v.cookbook_tex = v.cookbook_tex
	v.cookbook_atlas = v.cookbook_atlas

	v.potlevel = v.potlevel or "med"
	
	if v.no_cookpot == nil or v.no_cookpot == false then
		MODENV.AddCookerRecipe("cookpot", v) 
	end
	MODENV.AddCookerRecipe("portablecookpot", v) 
	RegisterInventoryItemAtlas(resolvefilepath("images/inventoryimages/"..v.name..".xml"), v.name..".tex")
end

GenerateSpicedFoods(Ccs_foods)  -- 香料
local spicedfoods = require("spicedfoods")
for k, v in pairs(spicedfoods) do
    if Ccs_foods[v.basename] then
        MODENV.AddCookerRecipe("portablespicer", v)
    end
end
