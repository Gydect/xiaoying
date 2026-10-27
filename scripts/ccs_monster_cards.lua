local ccs_monster_cards = 
{
	ccs_monster_card_1 = 		
	{
		chname = "暗影三兄弟牌",
		describe = "用魔法召唤暗影三兄弟",
		recipe_desc = "用魔法召唤暗影三兄弟",
		master = {"shadow_knight","shadow_rook","shadow_bishop"},
	},
	ccs_monster_card_2 = 		
	{
		chname = "暗影编织者牌",
		describe = "用魔法召唤暗影编织者",
		recipe_desc = "用魔法召唤暗影编织者",
		master = {"stalker_forest"},
		cave = {"stalker"},
	},
	ccs_monster_card_3 = 		
	{
		chname = "帝王蟹牌",
		describe = "用魔法召唤帝王蟹",
		recipe_desc = "用魔法召唤帝王蟹",
		master = {"crabking"},
	},
	ccs_monster_card_4 = 		
	{
		chname = "蜂后牌",
		describe = "用魔法召唤蜂后",
		recipe_desc = "用魔法召唤蜂后",
		master = {"beequeen"},
	},
	ccs_monster_card_5 = 		
	{
		chname = "巨鹿牌",
		describe = "用魔法召唤巨鹿",
		recipe_desc = "用魔法召唤巨鹿",
		master = {"deerclops"},
	},
	ccs_monster_card_6 = 		
	{
		chname = "克劳斯牌",
		describe = "用魔法召唤克劳斯",
		recipe_desc = "用魔法召唤克劳斯",
		master = {"klaus"},
	},
	ccs_monster_card_7 = 		
	{
		chname = "龙蝇牌",
		describe = "用魔法召唤龙蝇",
		recipe_desc = "用魔法召唤龙蝇",
		master = {"dragonfly"},
	},
	ccs_monster_card_8 = 		
	{
		chname = "鹿鸭牌",
		describe = "用魔法召唤鹿鸭",
		recipe_desc = "用魔法召唤鹿鸭",
		master = {"moose"},
	},
	ccs_monster_card_9 = 		
	{
		chname = "梦魇疯猪牌",
		describe = "用魔法召唤梦魇疯猪",
		recipe_desc = "用魔法召唤梦魇疯猪",
		master = {"daywalker"},
	},
	ccs_monster_card_10 = 		
	{
		chname = "天体英雄牌",
		describe = "用魔法召唤天体英雄",
		recipe_desc = "用魔法召唤天体英雄",
		master = {"alterguardian_phase3"},		
	},
	ccs_monster_card_11 = 		
	{
		chname = "犀牛牌",
		describe = "用魔法召唤犀牛",
		recipe_desc = "用魔法召唤犀牛",	
		master = {"minotaur"},	
	},
	ccs_monster_card_12 = 		
	{
		chname = "邪天翁牌",
		describe = "用魔法召唤邪天翁",
		recipe_desc = "用魔法召唤邪天翁",
		master = {"malbatross"},	
	},
	ccs_monster_card_13 = 		
	{
		chname = "蚁狮牌",
		describe = "用魔法召唤蚁狮",
		recipe_desc = "用魔法召唤蚁狮",
		master = {"antlion"},	
	},
	ccs_monster_card_14 = 		
	{
		chname = "蛤蟆牌",
		describe = "用魔法召唤蛤蟆",
		recipe_desc = "用魔法召唤蛤蟆",
		master = {"toadstool"},	
		cave = {"toadstool_dark"},
	},
	ccs_monster_card_15 = 		
	{
		chname = "果蝇王牌",
		describe = "用魔法召唤果蝇王",
		recipe_desc = "用魔法召唤果蝇王",
		master = {"lordfruitfly"},	
	},
	ccs_monster_card_16 = 		
	{
		chname = "发条主教牌",
		describe = "用魔法召唤发条主教牌",
		recipe_desc = "用魔法召唤发条主教牌",
		master = {"bishop"},	
	},
	ccs_monster_card_17 =
	{
		chname = "熊獾",
		describe = "用魔法召唤熊獾牌",
		recipe_desc = "用魔法召唤发熊獾牌",
		master = { "bearger" },
	},
}

for k, v in pairs(ccs_monster_cards) do
    v.name = k
	
	STRINGS.NAMES[string.upper(k)] = v.chname
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(k)] = v.describe
	STRINGS.RECIPE_DESC[string.upper(k)] = v.recipe_desc 
end

return ccs_monster_cards