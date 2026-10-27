--参考了梧生的添加科技站
local TechTree = require("techtree")

STRINGS.UI.CRAFTING_FILTERS.CCS_PIANO_TECH = "魔法钢琴"
STRINGS.UI.CRAFTING_STATION_FILTERS.CCS_PIANO_TECH = "魔法钢琴"

AddPrototyperDef("ccs_piano", { --第一个参数是指玩家靠近时会解锁科技的prefab名
	icon_atlas = "images/inventoryimages/ccs_piano2.xml", icon_image = "ccs_piano2.tex",
	is_crafting_station = false,
	filter_text = "小樱的钢琴"
})

AddRecipeFilter({	--添加制作栏
	name = "CCS_PIANO_TECH",
	atlas = "images/inventoryimages/ccs_piano.xml", image = "ccs_piano.tex",
	custom_pos = false
})

table.insert(TechTree.AVAILABLE_TECH, "CCS_PIANO")	--其实就是加个自己的科技树名称

--[[ 制作等级中加入自己的部分 ]]
TECH.NONE.CCS_PIANO = 0
TECH.CCS_PIANO_ONE = { CCS_PIANO = 2}
TECH.CCS_PIANO_TWO = { CCS_PIANO = 4}

--[[ 解锁等级中加入自己的部分 ]]
for k,v in pairs(TUNING.PROTOTYPER_TREES) do
    v.CCS_PIANO = 0
end
TUNING.PROTOTYPER_TREES.CCS_PIANO_ONE = TechTree.Create({CCS_PIANO = 2})
TUNING.PROTOTYPER_TREES.CCS_PIANO_TWO = TechTree.Create({CCS_PIANO = 4})

--[[ 修改全部制作配方，对缺失的值进行补充 ]]
for i, v in pairs(AllRecipes) do
	if v.level.CCS_PIANO == nil then
		v.level.CCS_PIANO = 0
	end
end