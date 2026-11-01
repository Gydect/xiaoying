local smart = require "utils/ccssmartfilter"
local function Ccs_RecTab(name, des, img, sxml, stex)
    local xml = sxml or "images/inventoryimages/" .. img .. ".xml"
    local tex = stex or img .. ".tex"
    AddRecipeFilter({
        name = name,
        atlas = xml,
        image = tex
    })
    STRINGS.UI.CRAFTING_FILTERS[name:upper()] = des
    smart(name, "ccs")
    return name:upper()
end

ccs_tab1 = Ccs_RecTab("ccs_tab1", "小樱", "ccs_sakura1")
ccs_tab2 = Ccs_RecTab("ccs_tab2", "生活", "ccs_tab2")
ccs_tab3 = Ccs_RecTab("ccs_tab3", "战斗", "ccs_tab3")
ccs_tab4 = Ccs_RecTab("ccs_tab4", "魔法", "ccs_tab4")
local cards = require("ccs_cards")

local ccs_tab = 
{
	"ccs_magic_wand1",
	"ccs_magic_wand2",
	"ccs_magic_wand3",
	"ccs_hat1",
	"ccs_jt",
	--"ccs_chest",
	"ccs_chest2",
	"ccs_chest3",
	"ccs_skirt1",
	"ccs_amulet",
	"ccs_light",
	"ccs_tent",
	"ccs_cards_7",
	"ccs_xk_item",
	"ccs_sb_item",
	"ccs_ice_box",
	"ccs_broom",
	"ccs_bag2",
	"ccs_oven",
	"ccs_piano",
	"ccs_trash",
	"ccs_fountain",
	"ccs_street_lamp",
	"ccs_light3",
	"ccs_sakura_tree",
	"ccs_guard",
	"wall_ccs_wall1",
	"wall_ccs_wall2",
	"ccs_miniboatlantern",
	"ccs_frog_yf",
	"ccs_butterfly",
	"ccs_beebox",
	"ccs_crystallization1",
	"ccs_crystallization2",
	"ccs_crystallization3",
	--"ccs_sakura_tree3",
	--"ccs_crystal_tree",
}

for i = 1, 16 do
	table.insert(ccs_tab,"ccs_monster_card_"..i)
end

--[[for k,v in pairs(cards) do
	table.insert(ccs_tab,v.name.."magic")
end--]]

for k,v in pairs(ccs_tab) do
	if string.sub(v,1,11) == "ccs_monster" then
		RegisterInventoryItemAtlas("images/inventoryimages/ccs_monster_cards/"..v..".xml", v..".tex")
	elseif string.sub(v,1,9) == "ccs_cards" then
		RegisterInventoryItemAtlas("images/inventoryimages/ccs_cards/"..v..".xml", v..".tex")
	else
		RegisterInventoryItemAtlas("images/inventoryimages/"..v..".xml", v..".tex")
	end
end


for k,v in pairs(cards) do
	if v.column then
		if v.column == "ccs_tab2" then
			AddRecipe2(v.name.."magic", {},TECH.NONE, {builder_tag = "ccs",no_deconstruction = true,atlas = "images/inventoryimages/ccs_cards/"..v.name..".xml",image = v.name..".tex",sg_state = "attack"},{ccs_tab2})
		end
		if v.column == "ccs_tab3" then
			AddRecipe2(v.name.."magic", {},TECH.NONE, {builder_tag = "ccs",no_deconstruction = true,atlas = "images/inventoryimages/ccs_cards/"..v.name..".xml",image = v.name..".tex",sg_state = "attack"},{ccs_tab3})
		end
		if v.column == "ccs_tab4" then
			AddRecipe2(v.name.."magic", {},TECH.NONE, {builder_tag = "ccs",no_deconstruction = true,atlas = "images/inventoryimages/ccs_cards/"..v.name..".xml",image = v.name..".tex",sg_state = "attack"},{ccs_tab4})
		end
	end
end
	
--钢琴的配方

--[[STRINGS.NAMES.CCS_PIANO = "魔法"
STRINGS.UI.CRAFTING_FILTERS[string.upper("小樱的钢琴")]=STRINGS.NAMES.CCS_PIANO
STRINGS.UI.CRAFTING_STATION_FILTERS[string.upper("小樱的钢琴")]=STRINGS.NAMES.CCS_PIANO

AddPrototyperDef("ccs_piano", { --第一个参数是指玩家靠近时会解锁科技的prefab名
	icon_atlas = "images/inventoryimages/ccs_piano2.xml", icon_image = "ccs_piano2.tex",
	is_crafting_station = false,
})

AddRecipeFilter({	--添加制作栏
	name = "小樱的钢琴",
	atlas = "images/inventoryimages/ccs_piano.xml", image = "ccs_piano.tex",
	--custom_pos = true
})--]]

local piano_tech = {
	"ccs_magic_wand1_piano",
	"ccs_chest_piano",
	"ccs_ice_box_piano",
	"ccs_chest2_piano",
	"ccs_chest3",
	"ccs_oven",
	"ccs_tent",
	"ccs_trash",
	"ccs_fountain",
	"dug_ccs_strawberry_seeds",
	"ccs_street_lamp",
	"ccs_light3",
	"ccs_sakura_tree",
	"wall_ccs_wall1_item",
	"wall_ccs_wall2_item",
	"fence_ccsstrawberry_item",
	"ccs_throne",
	"ccs_throne2",
	"ccs_throne_flower",
	"ccs_spbox",
	"ccs_miniboatlantern",
	"ccs_frog_yf",
	"ccs_butterfly",
	"ccs_beebox",
	"ccs_crystallization1",
	"ccs_crystallization2",
	"ccs_crystallization3",
	--"ccs_sakura_tree3",
	--"ccs_crystal_tree",
	"ccs_treasurechest",
	"ccs_flowerpot",
	"ccs_chair",
	"brc_swing",
	"brc_swing_double",
	"ccs_shipwrecked",
	"ccs_bunny_fluorescen2",
	"turf_ccs_red",
	"turf_ccs_green",
	"turf_ccs_shuangyu",
	"ccs_balloon",
	"ccs_mushroomgreen_item",
	"ccs_mushroompurple_item",
	"ccs_mushroomorange_item",
	"ccs_mushroomred_item",
	"ccs_mushroomgreen_stump",
	"ccs_mushroompurple_stump",
	"ccs_mushroomred_stump",
	"ccs_shroomcake",
	"ccs_archway1",
	"ccs_archway2",
	"ccs_door1_item",
	"ccs_huazhalan_item",
	"ccs_huazhalan2_item",
	"ccs_huazhalan3_item",
	"ccs_huazhalan4_item",
	"ccs_huazhalan5_item",
	"ccs_huazhalan6_item",
	"ccs_huazhalan7_item",
	"ccs_huazhalan8_item",
	"ccs_plantflower_fhh",
	"ccs_plantflower_jzj",
	"ccs_plantflower_ss",
	"ccs_plantflower_www",
	"ccs_mubanlu",
	"ccs_liushuhuatan",
	"ccs_magic_rocking_chair",
}

for k,v in pairs(piano_tech) do
	AddRecipeToFilter(v,"CCS_PIANO_TECH")
end

--钢琴配方
AddRecipe2("ccs_magic_wand1_piano", {Ingredient("golden_farm_hoe",2),Ingredient("goldenshovel",2),Ingredient("hammer",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,product = "ccs_magic_wand1"})

AddRecipe2("ccs_shroomcake", {Ingredient("ccs_mushroomred_picked",1),Ingredient("ccs_mushroompurple_picked",1),Ingredient("ccs_mushroomgreen_picked",1),Ingredient("ccs_mushroomorange_picked",1)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,product = "shroomcake"})

AddRecipe2("ccs_miniboatlantern", {Ingredient("papyrus",4),Ingredient("fireflies",1),},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

AddRecipe2("ccs_frog_yf", {Ingredient("tentaclespots",1),Ingredient("papyrus",5),Ingredient("rope",5),},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

AddRecipe2("ccs_crystallization1", {Ingredient("orangegem",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

AddRecipe2("ccs_crystallization2", {Ingredient("bluegem",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

AddRecipe2("ccs_crystallization3", {Ingredient("purplegem",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

AddRecipe2("ccs_beebox", {Ingredient("honeycomb",2),Ingredient("bee",8),Ingredient("petals",20)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_beebox_placer"})

AddRecipe2("ccs_butterfly", {Ingredient("butterflywings",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

--[[AddRecipe2("ccs_sakura_tree3", {Ingredient("log",15),Ingredient("livinglog",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_sakura_tree3_placer", min_spacing=1})--]]

--[[AddRecipe2("ccs_crystal_tree", {Ingredient("log",15),Ingredient("livinglog",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_crystal_tree_placer", min_spacing=1})--]]

AddRecipe2("dug_ccs_strawberry_seeds", {Ingredient("dug_grass",10),Ingredient("petals",30)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,
image = "ccs_strawberry_seeds.tex",atlas = "images/inventoryimages/ccs_strawberry_seeds.xml",numtogive = 5})

-- AddRecipe2("ccs_chest_piano", {Ingredient("nightsword",2),Ingredient("orangegem",1),Ingredient("boards",15)},  
-- TECH.CCS_PIANO_ONE, {nounlock = false,product = "ccs_chest",no_deconstruction = true,placer = "ccs_chest_placer", min_spacing=1})

AddRecipe2("ccs_street_lamp", {Ingredient("fireflies",5),Ingredient("cutstone",3),Ingredient("petals",3)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_street_lamp_placer", min_spacing=2})

AddRecipe2("ccs_sakura_tree", {Ingredient("redgem",5),Ingredient("yellowgem",3),Ingredient("boards",20),Ingredient("transistor",10)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_sakura_tree_placer", min_spacing=2})

AddRecipe2("ccs_light3", {Ingredient("cutstone",5),Ingredient("boards",5),Ingredient("goldnugget",10)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_light3_placer", min_spacing=2})

AddRecipe2("ccs_ice_box_piano", {Ingredient("bluemooneye",1),Ingredient("boards",3)},  
TECH.CCS_PIANO_ONE, {nounlock = false,product = "ccs_ice_box", no_deconstruction = true},{"CRAFTING_STATION"})

AddRecipe2("ccs_chest2_piano", {Ingredient("bluegem",1),Ingredient("transistor",5),Ingredient("boards",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_chest2_placer",product = "ccs_chest2", min_spacing=1})

AddRecipe2("ccs_chest3", {Ingredient("redgem",1),Ingredient("livinglog",2),Ingredient("nightmarefuel",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_chest3_placer", min_spacing=1})

AddRecipe2("ccs_oven", {Ingredient("yellowstaff",1),Ingredient("opalstaff",1),Ingredient("boards",10),Ingredient("cutstone",10)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_oven_placer", min_spacing=1})

AddRecipe2("ccs_tent", {Ingredient("purplegem", 1),Ingredient("boards",10),Ingredient("silk",20)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_tent_placer", min_spacing=3})

AddRecipe2("ccs_trash", {Ingredient("cutstone", 2 ),Ingredient("boards",2)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_trash_placer", min_spacing=3})    

AddRecipe2("ccs_fountain", {Ingredient("opalpreciousgem",1),Ingredient("transistor",10),Ingredient("boards",10),Ingredient("cutstone",10)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_fountain_placer", min_spacing=3})  

AddRecipe2("wall_ccs_wall1_item", {Ingredient("marble",3),Ingredient("petals",1)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,numtogive = 3,atlas = "images/inventoryimages/wall_ccs_wall1.xml", image = "wall_ccs_wall1.tex",})

AddRecipe2("wall_ccs_wall2_item", { Ingredient("marble", 3), Ingredient("petals", 1) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, numtogive = 3, atlas = "images/inventoryimages/wall_ccs_wall2.xml", image =
	"wall_ccs_wall2.tex", })


-- 魔法摇椅
RegisterInventoryItemAtlas("images/inventoryimages/ccs_magic_rocking_chair.xml", "ccs_magic_rocking_chair.tex")
AddRecipe2("ccs_magic_rocking_chair", 
    { Ingredient("boards", 3), Ingredient("ccs_sakura3", 16)},  -- 材料可自定
    TECH.CCS_PIANO_ONE, 
    { nounlock = false, no_deconstruction = true, placer = "ccs_magic_rocking_chair_placer", min_spacing = 2 }
)

--栅栏
RegisterInventoryItemAtlas("images/inventoryimages/fence_ccsstrawberry_item.xml","fence_ccsstrawberry_item.tex")
AddRecipe2("fence_ccsstrawberry_item", {Ingredient("ccs_strawberry_food",2),Ingredient("boards",1),Ingredient("petals",1)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,numtogive = 4,atlas = "images/inventoryimages/fence_ccsstrawberry_item.xml", image = "fence_ccsstrawberry_item.tex",})

--地皮
RegisterInventoryItemAtlas("images/inventoryimages/ccs_turf_red.xml","ccs_turf_red.tex")
AddRecipe2("turf_ccs_red", {Ingredient("petals",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,numtogive = 4,atlas = "images/inventoryimages/ccs_turf_red.xml", image = "ccs_turf_red.tex",})

RegisterInventoryItemAtlas("images/inventoryimages/ccs_turf_green.xml","ccs_turf_green.tex")
AddRecipe2("turf_ccs_green", {Ingredient("petals",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,numtogive = 4,atlas = "images/inventoryimages/ccs_turf_green.xml", image = "ccs_turf_green.tex",})

RegisterInventoryItemAtlas("images/inventoryimages/ccs_turf_shuangyu.xml", "ccs_turf_shuangyu.tex")
AddRecipe2("turf_ccs_shuangyu", { Ingredient("petals", 5) },
	TECH.CCS_PIANO_ONE,
	{
		nounlock = false,
		no_deconstruction = true,
		numtogive = 4,
		atlas = "images/inventoryimages/ccs_turf_shuangyu.xml",
		image = "ccs_turf_shuangyu.tex",
	})

--地毯
RegisterInventoryItemAtlas("images/inventoryimages/ccs_throne.xml","ccs_throne.tex")
AddRecipe2("ccs_throne", {Ingredient("beefalowool",1),Ingredient("petals",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_throne_placer",min_spacing=1,atlas = "images/inventoryimages/ccs_throne.xml", image = "ccs_throne.tex",})
RegisterInventoryItemAtlas("images/inventoryimages/ccs_throne2.xml", "ccs_throne2.tex")
AddRecipe2("ccs_throne2", { Ingredient("beefalowool", 1), Ingredient("petals", 5) },
	TECH.CCS_PIANO_ONE,
	{
		nounlock = false,
		no_deconstruction = true,
		placer = "ccs_throne2_placer",
		min_spacing = 1,
		atlas =
		"images/inventoryimages/ccs_throne2.xml",
		image = "ccs_throne2.tex",
	})
-- 盒子
RegisterInventoryItemAtlas("images/inventoryimages/ccs_spbox.xml", "ccs_spbox.tex")
AddRecipe2("ccs_spbox",
	{ Ingredient("boards", 5), Ingredient("purplegem", 2) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, placer = "ccs_spbox_placer", min_spacing = 1 })

RegisterInventoryItemAtlas("images/inventoryimages/ccs_throne_flower.xml","ccs_throne_flower.tex")
AddRecipe2("ccs_throne_flower", {Ingredient("beefalowool",1),Ingredient("petals",5)},  
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true,placer = "ccs_throne_flower_placer",min_spacing=1,atlas = "images/inventoryimages/ccs_throne_flower.xml", image = "ccs_throne_flower.tex",})

--箱子
RegisterInventoryItemAtlas("images/inventoryimages/ccs_treasurechest.xml","ccs_treasurechest.tex")
AddRecipe2("ccs_treasurechest", {Ingredient("boards", 5)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_treasurechest_placer", min_spacing=1.5})

--花盆
RegisterInventoryItemAtlas("images/inventoryimages/ccs_flowerpot.xml","ccs_flowerpot.tex")
AddRecipe2("ccs_flowerpot", {Ingredient("cutstone", 2), Ingredient("petals", 10)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_flowerpot_placer", min_spacing=1.5})

--月亮椅子
RegisterInventoryItemAtlas("images/inventoryimages/ccs_chair.xml","ccs_chair.tex")
AddRecipe2("ccs_chair", {Ingredient("boards", 10), Ingredient("beefalowool", 5), Ingredient("moonglass", 10)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_chair_placer", min_spacing=2})

--秋千
RegisterInventoryItemAtlas("images/inventoryimages/brc_swing.xml","brc_swing.tex")
AddRecipe2("brc_swing", {Ingredient("boards", 10), Ingredient("manrabbit_tail", 5), Ingredient("rope", 10)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "brc_swing_placer", min_spacing=2.5})

--双人秋千
RegisterInventoryItemAtlas("images/inventoryimages/brc_swing_double.xml","brc_swing_double.tex")
AddRecipe2("brc_swing_double", {Ingredient("boards", 20), Ingredient("slurtle_shellpieces", 3), Ingredient("rope", 10)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "brc_swing_double_placer", min_spacing=2.5})

--红色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomred_item.xml", "ccs_mushroomred_item.tex")
AddRecipe2("ccs_mushroomred_item", { Ingredient("red_cap", 3), Ingredient("petals", 20) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true})

--橙色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomorange_item.xml", "ccs_mushroomorange_item.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomorange_picked.xml", "ccs_mushroomorange_picked.tex")
AddRecipe2("ccs_mushroomorange_item", { Ingredient("moon_cap", 3), Ingredient("petals", 20) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true})

--紫色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroompurple_item.xml", "ccs_mushroompurple_item.tex")
AddRecipe2("ccs_mushroompurple_item", { Ingredient("blue_cap", 3), Ingredient("petals", 20) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true})

--绿色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomgreen_item.xml", "ccs_mushroomgreen_item.tex")
AddRecipe2("ccs_mushroomgreen_item", { Ingredient("green_cap", 3), Ingredient("petals", 20) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true})

--红色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomred_stump.xml", "ccs_mushroomred_stump.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomred_picked.xml", "ccs_mushroomred_picked.tex")
AddRecipe2("ccs_mushroomred_stump", { Ingredient("ccs_mushroomred_picked", 3), Ingredient("boards", 2) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_mushroomred_stump_placer", min_spacing=2.5})

--紫色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroompurple_stump.xml", "ccs_mushroompurple_stump.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroompurple_picked.xml", "ccs_mushroompurple_picked.tex")
AddRecipe2("ccs_mushroompurple_stump", { Ingredient("ccs_mushroompurple_picked", 3), Ingredient("boards", 2) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_mushroompurple_stump_placer", min_spacing=2.5})

--绿色蘑菇
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomgreen_stump.xml", "ccs_mushroomgreen_stump.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mushroomgreen_picked.xml", "ccs_mushroomgreen_picked.tex")
AddRecipe2("ccs_mushroomgreen_stump", { Ingredient("ccs_mushroomgreen_picked", 3), Ingredient("boards", 2) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_mushroomgreen_stump_placer", min_spacing=2.5})


--栅栏
local huazhalan_items = {
	{ name = "ccs_huazhalan_item",  atlas_path = "images/inventoryimages/ccs_huazhalan_item.xml",  atlas_tex = "ccs_huazhalan_item.tex" },
	{ name = "ccs_huazhalan2_item", atlas_path = "images/inventoryimages/ccs_huazhalan2_item.xml", atlas_tex = "ccs_huazhalan2_item.tex" },
	{ name = "ccs_huazhalan3_item", atlas_path = "images/inventoryimages/ccs_huazhalan3_item.xml", atlas_tex = "ccs_huazhalan3_item.tex" },
	{ name = "ccs_huazhalan4_item", atlas_path = "images/inventoryimages/ccs_huazhalan4_item.xml", atlas_tex = "ccs_huazhalan4_item.tex" },
	{ name = "ccs_huazhalan5_item", atlas_path = "images/inventoryimages/ccs_huazhalan5_item.xml", atlas_tex = "ccs_huazhalan5_item.tex" },
	{ name = "ccs_huazhalan6_item", atlas_path = "images/inventoryimages/ccs_huazhalan6_item.xml", atlas_tex = "ccs_huazhalan6_item.tex" },
	{ name = "ccs_huazhalan7_item", atlas_path = "images/inventoryimages/ccs_huazhalan7_item.xml", atlas_tex = "ccs_huazhalan7_item.tex" },
	{ name = "ccs_huazhalan8_item", atlas_path = "images/inventoryimages/ccs_huazhalan8_item.xml", atlas_tex = "ccs_huazhalan8_item.tex" },
}
for _, item in ipairs(huazhalan_items) do
	RegisterInventoryItemAtlas(item.atlas_path, item.atlas_tex)
	AddRecipe2(item.name, { Ingredient("boards", 1), Ingredient("petals", 2) },
		TECH.CCS_PIANO_ONE, { nounlock = false, no_deconstruction = true, numtogive = 4 })
end

--拱门
RegisterInventoryItemAtlas("images/inventoryimages/ccs_archway1.xml", "ccs_archway1.tex")
AddRecipe2("ccs_archway1", { Ingredient("boards", 5), Ingredient("petals", 10) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_archway1_placer",min_spacing = 0 })

RegisterInventoryItemAtlas("images/inventoryimages/ccs_archway2.xml", "ccs_archway2.tex")
AddRecipe2("ccs_archway2", { Ingredient("boards", 5), Ingredient("petals", 10) },
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_archway2_placer",min_spacing = 0 })

--木门
RegisterInventoryItemAtlas("images/inventoryimages/ccs_door1_item.xml", "ccs_door1_item.tex")
AddRecipe2("ccs_door1_item",
	{ Ingredient("boards", 2), Ingredient("petals", 5) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, numtogive = 2 })

-- 木板路
RegisterInventoryItemAtlas("images/inventoryimages/ccs_mubanlu.xml", "ccs_mubanlu.tex")
AddRecipe2("ccs_mubanlu", { Ingredient("boards", 1) },
	TECH.CCS_PIANO_ONE, { nounlock = false, no_deconstruction = true, placer = "ccs_mubanlu_placer", min_spacing = 1 })

-- 流苏地毯
RegisterInventoryItemAtlas("images/inventoryimages/ccs_liushuhuatan.xml", "ccs_liushuhuatan.tex")
AddRecipe2("ccs_liushuhuatan", { Ingredient("beefalowool", 1), Ingredient("petals", 5) },
	TECH.CCS_PIANO_ONE, { nounlock = false, no_deconstruction = true, placer = "ccs_liushuhuatan_placer", min_spacing = 2 })

--气球
RegisterInventoryItemAtlas("images/inventoryimages/ccs_balloon.xml", "ccs_balloon.tex")
AddRecipe2("ccs_balloon", { Ingredient("rope", 2), Ingredient("twigs", 4) },
TECH.CCS_PIANO_ONE, {nounlock = false,no_deconstruction = true})

--摇摇车
RegisterInventoryItemAtlas("images/inventoryimages/ccs_shipwrecked.xml","ccs_shipwrecked.tex")
AddRecipe2("ccs_shipwrecked", {Ingredient("boards", 10), Ingredient("manrabbit_tail", 5), Ingredient("rope", 10)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true, placer = "ccs_shipwrecked_placer", min_spacing=2})

--花
RegisterInventoryItemAtlas("images/inventoryimages/ccs_plantflower_fhh.xml", "ccs_plantflower_fhh.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_butterfly.xml", "ccs_butterfly.tex")
AddRecipe2("ccs_plantflower_fhh", { Ingredient("ccs_butterfly", 1)},
	TECH.CCS_PIANO_ONE, { nounlock = false, no_deconstruction = true, placer = "ccs_plantflower_fhh_placer", min_spacing = 2 })
RegisterInventoryItemAtlas("images/inventoryimages/ccs_plantflower_jzj.xml", "ccs_plantflower_jzj.tex")
AddRecipe2("ccs_plantflower_jzj", { Ingredient("ccs_butterfly", 1) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, placer = "ccs_plantflower_jzj_placer", min_spacing = 2 })
RegisterInventoryItemAtlas("images/inventoryimages/ccs_plantflower_ss.xml", "ccs_plantflower_ss.tex")
AddRecipe2("ccs_plantflower_ss", { Ingredient("ccs_butterfly", 1) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, placer = "ccs_plantflower_ss_placer", min_spacing = 2 })
RegisterInventoryItemAtlas("images/inventoryimages/ccs_plantflower_www.xml", "ccs_plantflower_www.tex")
AddRecipe2("ccs_plantflower_www", { Ingredient("ccs_butterfly", 1) },
	TECH.CCS_PIANO_ONE,
	{ nounlock = false, no_deconstruction = true, placer = "ccs_plantflower_www_placer", min_spacing = 2 })

--水中花（装饰）
RegisterInventoryItemAtlas("images/inventoryimages/ccs_bunny_fluorescen2.xml","ccs_bunny_fluorescen2.tex")
AddRecipe2("ccs_bunny_fluorescen2", {Ingredient("moonglass", 3), Ingredient("petals", 5)},
TECH.CCS_PIANO_ONE, {nounlock = false, no_deconstruction = true,atlas = 'images/inventoryimages/ccs_bunny_fluorescen2.xml',image = 'ccs_bunny_fluorescen2_0.tex', build_mode = BUILDMODE.WATER, build_distance = 20, placer = "ccs_bunny_fluorescen2_placer", min_spacing=2})

---
---
---
---
AddRecipe2("reskin_tool_ccs", { Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 20, "images/inventoryimages/ccs_magic.xml") },
TECH.NONE, { builder_tag = "ccs", no_deconstruction = true, product = "reskin_tool" }, { ccs_tab1 })

AddRecipe2("ccs_magic_wand1", {Ingredient("golden_farm_hoe",2),Ingredient("goldenshovel",2),Ingredient("hammer",2)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_magic_wand2", {Ingredient("goldenaxe",2),Ingredient("goldenpickaxe",2),
	Ingredient("golden_farm_hoe",2),Ingredient("goldenshovel",2),Ingredient("purplegem",1),Ingredient("orangegem",1),Ingredient("yellowgem",1)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,},{ccs_tab1})

--星星法杖
RegisterInventoryItemAtlas("images/inventoryimages/ccs_starstaff.xml","ccs_starstaff.tex")
AddRecipe2("ccs_starstaff", {Ingredient("firestaff",3),Ingredient("yellowstaff",5),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 150 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,},{ccs_tab1})

--魔法木牌
RegisterInventoryItemAtlas("images/inventoryimages/ccs_homesign.xml", "ccs_homesign.tex")
AddRecipe2("ccs_homesign", { Ingredient("ccs_magic_water", 10), Ingredient("ccs_sakura3", 10), Ingredient("boards", 1) },
	TECH.SCIENCE_ONE, { builder_tag = "ccs", no_deconstruction = true, placer = "ccs_homesign_placer" }, { ccs_tab1 })

--生命法杖
RegisterInventoryItemAtlas("images/inventoryimages/ccs_lifestaff.xml","ccs_lifestaff.tex")
AddRecipe2("ccs_lifestaff", {Ingredient("livinglog",5),Ingredient("goldnugget",5),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 100 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,},{ccs_tab1})

--温泉
RegisterInventoryItemAtlas("images/inventoryimages/brc_hotspring.xml","brc_hotspring.tex")
AddRecipe2("brc_hotspring", {Ingredient("ccs_sakura3",10),Ingredient("ccs_sakura1",10),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 130 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,placer = "brc_hotspring_placer", min_spacing=2.5},{ccs_tab1})

--专属锅
RegisterInventoryItemAtlas("images/inventoryimages/ccs_cookpot.xml","ccs_cookpot.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_sakura1.xml","ccs_sakura1.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_sakura3.xml","ccs_sakura3.tex")
AddRecipe2("ccs_cookpot_item", {Ingredient("petals",10),Ingredient("charcoal",10),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 30 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {atlas = 'images/inventoryimages/ccs_cookpot.xml',image = "ccs_cookpot.tex",builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

--专属锅2
RegisterInventoryItemAtlas("images/inventoryimages/ccs_cookpot2.xml","ccs_cookpot2.tex")
AddRecipe2("ccs_cookpot2", {Ingredient("ccs_cards_20",4,"images/inventoryimages/ccs_cards/ccs_cards_20.xml"),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 100 ,"images/inventoryimages/ccs_magic.xml")},
TECH.SCIENCE_ONE, {atlas = 'images/inventoryimages/ccs_cookpot2.xml',image = "ccs_cookpot2.tex",builder_tag= "ccs",no_deconstruction = true,placer = "ccs_cookpot2_placer", min_spacing=2},{ccs_tab1})

if TUNING.CCS_BUNNY_FLUORESCEN_ENABLE == true then
	--水中花
	RegisterInventoryItemAtlas("images/inventoryimages/ccs_bunny_fluorescen_seed.xml", "ccs_bunny_fluorescen_seed.tex")
	AddRecipe2("ccs_bunny_fluorescen_seed", {Ingredient("purebrilliance", 10), Ingredient("moon_tree_blossom", 10), Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 150 ,"images/inventoryimages/ccs_magic.xml")},
	TECH.SCIENCE_ONE, {builder_tag= "ccs", no_deconstruction = true,
		canbuild = function(recipe, builder, pt, rotation, station, skin) --只有月圆之夜才能制作
			return TheWorld.state.isfullmoon, "CCS_NOT_FULLMOON"
		end},{ccs_tab1})
	
end



AddRecipe2("ccs_guard", {Ingredient("opalpreciousgem",9)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs_cards_28_level3",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_hat1", {Ingredient("deserthat",1),Ingredient("ruinshat",2),Ingredient("eyebrellahat",1)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_jt", {Ingredient("ice",10),Ingredient("bluemooneye",1),
	Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 100 ,"images/inventoryimages/ccs_magic.xml")},
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,placer = "ccs_jt_placer", min_spacing=3},{ccs_tab1})

-- AddRecipe2("ccs_chest", {Ingredient("nightsword",2),Ingredient("orangegem",1),Ingredient("boards",15)},  
-- TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,placer = "ccs_chest_placer", min_spacing=1},{ccs_tab1})

AddRecipe2("ccs_moonroock", {Ingredient("goldnugget",15)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",numtogive = 5, product = "moonrocknugget"},{ccs_tab1})

AddRecipe2("ccs_szs", {Ingredient("moonrocknugget",10)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs", numtogive = 5, product = "townportaltalisman"},{ccs_tab1})

AddRecipe2("ccs_thulecite_pieces", {Ingredient("goldnugget",20)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs", numtogive = 6, product = "thulecite_pieces"},{ccs_tab1})

AddRecipe2("ccs_pocketwatch_revive", {Ingredient("ccs_cards_7",3)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs", product = "pocketwatch_revive"},{ccs_tab1})

AddRecipe2("ccs_skirt1", {Ingredient("armorruins",2),Ingredient("ruins_bat",1),Ingredient("armordragonfly",1),Ingredient("armormarble",1),Ingredient("armor_sanity",1)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_amulet", {Ingredient("glommerflower",3),Ingredient("lavae_egg",1),Ingredient("yellowgem",5)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})
        
--[[AddRecipe2("ccs_light", {Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 100 ,"images/inventoryimages/ccs_magic.xml"),Ingredient("ccs_cards_7",5,"images/inventoryimages/ccs_cards/ccs_cards_7.xml"),Ingredient("boards",10),Ingredient("goldnugget",20)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,placer = "ccs_light_placer", min_spacing=3},{ccs_tab1})  --]]

CONSTRUCTION_PLANS["ccs_light"] = {Ingredient("ccs_cards_7",3,"images/inventoryimages/ccs_cards/ccs_cards_7.xml"),Ingredient("boards",10),Ingredient("goldnugget",20)}
CONSTRUCTION_PLANS["ccs_sakura_tree"] = {Ingredient("ccs_sakura1",20,"images/inventoryimages/ccs_sakura1.xml"),Ingredient("ccs_sakura3",20,"images/inventoryimages/ccs_sakura3.xml"),Ingredient("livinglog",20)}

AddRecipe2("ccs_cards_7", {Ingredient("ccs_paper",3,"images/inventoryimages/ccs_paper.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})  

RegisterInventoryItemAtlas("images/inventoryimages/ccs_paper.xml", "ccs_paper.tex")
AddRecipe2("ccs_paper", {Ingredient("papyrus", 1), Ingredient("ccs_magic_water", 1)},
TECH.NONE, {builder_tag = "ccs_cards_3_enble_2", nounlock = true, no_deconstruction = true}, {ccs_tab1})

AddRecipe2("ccs_portabletent_item", {Ingredient("bedroll_straw",1),Ingredient("twigs",4),Ingredient("rope",4)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs", product = "portabletent_item"},{ccs_tab1})

AddRecipe2("ccs_ice_box", {Ingredient("bluemooneye",1),Ingredient("boards",3)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs", no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_piano", {Ingredient("cutstone", 5 ),Ingredient("boards",5),Ingredient("goldnugget",5)},  
TECH.SCIENCE_ONE, {no_deconstruction = true,placer = "ccs_piano_placer", min_spacing=3},{"CHARACTER"})  

local ccs_monster_cards = {
	{card = "ccs_monster_card_1", num = 5},
	{card = "ccs_monster_card_2", num = 3}, 
	{card = "ccs_monster_card_3", num = 3},
	{card = "ccs_monster_card_4", num = 3},
	{card = "ccs_monster_card_5", num = 3},
	{card = "ccs_monster_card_6", num = 3},
	{card = "ccs_monster_card_7", num = 3},
	{card = "ccs_monster_card_8", num = 3},
	{card = "ccs_monster_card_9", num = 3},
	{card = "ccs_monster_card_10", num = 8},
	{card = "ccs_monster_card_11", num = 5},
	{card = "ccs_monster_card_12", num = 3},	
	{card = "ccs_monster_card_13", num = 3},
	{card = "ccs_monster_card_14", num = 3},
	{card = "ccs_monster_card_15", num = 3},
	{ card = "ccs_monster_card_17", num = 3 },
}


for k,v in pairs(ccs_monster_cards) do
	AddRecipe2(v.card,
	{
		Ingredient("ccs_cards_7",v.num,"images/inventoryimages/ccs_cards/ccs_cards_7.xml"),
		Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 50 ,"images/inventoryimages/ccs_magic.xml")
	},
	TECH.SCIENCE_ONE, 
	{
		builder_tag= "ccs_cards_3_enble",
		no_deconstruction = true
	},
	{ccs_tab1})
end

AddRecipe2("ccs_monster_card_16",{Ingredient("trinket_6",2),Ingredient("transistor",2)},  
TECH.SCIENCE_ONE, {builder_tag= "ccs_cards_3_enble",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_bag2",{Ingredient("goldnugget",3),Ingredient("silk",3),Ingredient("rope",3),Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 20 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_broom",{Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 20 ,"images/inventoryimages/ccs_magic.xml")},  
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

AddRecipe2("ccs_lavae_egg", { Ingredient("dragon_scales",3),Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 120, "images/inventoryimages/ccs_magic.xml") },
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true,product = "lavae_egg"},{ccs_tab1})

RegisterInventoryItemAtlas("images/inventoryimages/ccs_monster_cards/ccs_monster_card_17.xml", "ccs_monster_card_17.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_cards/ccs_cards_29.xml", "ccs_cards_29.tex")
AddRecipe2("ccs_cards_29", { Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 200, "images/inventoryimages/ccs_magic.xml") },
TECH.SCIENCE_ONE, {builder_tag= "ccs",no_deconstruction = true},{ccs_tab1})

RegisterInventoryItemAtlas("images/inventoryimages/ccs_cards/ccs_cards_4.xml", "ccs_cards_4.tex")
RegisterInventoryItemAtlas("images/inventoryimages/ccs_cards/ccs_cards_23.xml", "ccs_cards_23.tex")
AddRecipe2("ccs_cards_4",
{ Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 50, "images/inventoryimages/ccs_magic.xml"), Ingredient("ccs_cards_23",1) },
	TECH.SCIENCE_ONE, { builder_tag = "ccs_cards_3_enble", no_deconstruction = true }, { ccs_tab1 })
AddRecipe2("ccs_cards_23",
	{ Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 50, "images/inventoryimages/ccs_magic.xml"), Ingredient("ccs_cards_4", 1) },
	TECH.SCIENCE_ONE, { builder_tag = "ccs_cards_3_enble", no_deconstruction = true }, { ccs_tab1 })
	
if IsModEnable("1392778117") then
	local r = AddRecipe2("ccs_siving_derivant_item", {Ingredient("ccs_cards_7",2,"images/inventoryimages/ccs_cards/ccs_cards_7.xml"),Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 30 ,"images/inventoryimages/ccs_magic.xml")},  
	TECH.SCIENCE_ONE, {builder_tag= "ccs", product = "siving_derivant_item"},{ccs_tab1})
	r.image = "siving_derivant_item.tex"
	r.atlas = "images/inventoryimages/siving_derivant_item.xml"
end

AddRecipe2("ccs_xk_item", {Ingredient("fireflies",5),Ingredient("ccs_jelly",1,"images/inventoryimages/ccs_jelly.xml"),Ingredient("trailmix", 2 )},
TECH.SCIENCE_ONE, {builder_tag = "ccs",no_deconstruction = true},{"CHARACTER"})

AddRecipe2("ccs_sb_item", {Ingredient("fireflies",5),Ingredient("moonrocknugget",2),Ingredient("butterflymuffin", 2)},
TECH.SCIENCE_ONE, {no_deconstruction = true},{"CHARACTER"})


AddRecipe2("ccs_horrorfuel", {Ingredient("nightmarefuel",5),Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 10 ,"images/inventoryimages/ccs_magic.xml")},
TECH.SCIENCE_ONE, {builder_tag= "ccs_cards_3_enble_2",numtogive = 2,product = "horrorfuel"},{ccs_tab1})

AddRecipe2("ccs_purebrilliance", {Ingredient("moonrocknugget",15),Ingredient(CHARACTER_INGREDIENT.CCS_MAGIC, 10 ,"images/inventoryimages/ccs_magic.xml")},
TECH.SCIENCE_ONE, {builder_tag= "ccs_cards_3_enble_2",numtogive = 2,product = "purebrilliance"},{ccs_tab1})


AddRecipe2("ccs_opalpreciousgem", {Ingredient("yellowgem",1),Ingredient("redgem",1),Ingredient("bluegem",1),Ingredient("greengem",1),Ingredient("orangegem",1),Ingredient("purplegem",1)},
TECH.SCIENCE_ONE, {builder_tag= "ccs_cards_3_enble_2",product = "opalpreciousgem"},{ccs_tab1})
