name = "魔法少女小樱"  
description = [[
小樱bug反馈交流群：729203571
禁止上传本mod自用，及二次发布
]] 
author = "路Albert,欢" 
version = "2.31050" 

forumthread = ""

api_version = 10

dst_compatible = true 

dont_starve_compatible = false 
reign_of_giants_compatible = false 

all_clients_require_mod = true 

icon_atlas = "modicon.xml" 
icon = "modicon.tex"

server_filter_tags = {  --服务器标签
	"小樱"
}


configuration_options =
{
	{
		name = "ccs_card_24_enble",
		label = "大牌是否破坏建筑",
		hover = "大牌是否破坏建筑",
		options =	
		{
			{description = "是", data = true},
			{description = "否", data = false},
		},

		default = true,
	},

	{
		name = "ccs_card_collection_difficulty",
		label = "卡牌收集难度",
		hover = "卡牌收集难度",
		options =	
		{
			{description = "咸鱼", data = 1},
			{description = "肝帝", data = 2},
		},

		default = 2,
	},
	{
		name = "ccs_san_del",
		label = "受到攻击扣减san值",
		hover = "受到攻击扣减san值",
		options =	
		{
			{description = "不扣", data = 1},
			{description = "扣除1点", data = 2},
			{description = "扣除2点", data = 3},
		},

		default = 3,
	},
	--[[{
		name = "ccs_amor_def",
		label = "小樱的衣服护甲上限",
		hover = "小樱的衣服护甲上限",
		options =	
		{
			{description = "护甲上限90%", data = 1},
			{description = "护甲上限95%", data = 2},
		},

		default = 1,
	},--]]
	{
		name = "ccs_card_14_enble",
		label = "时停卡牌启用(请开启关联mod否则不要开启)",
		options = 
		{
			{description = "启用",data = true,hover = "需要开启其他mod：libTimeStopper，id:2576514266"},
			{description = "禁用",data = false,hover = "需要开启其他mod：libTimeStopper，id:2576514266"}
		},
		default = false
	}, 
	{
		name = "ccs_pack_pz1",
		label = "扩展打包纸，允许打包落水洞等建筑，\n但是请不要带这些东西跳世界",
		options = 
		{
			{description = "允许",data = true,hover = "允许打包更多物品"},
			{description = "不允许",data = false,hover = "只能打包部分物品"}
		},
		
		default = false
	}, 
	{
		name = "ccs_pack_pz2",
		label = "扩展打包纸，允许打包怪物、boss等",
		options =
		{
			{description = "允许",data = true,hover = "允许打包怪物、boss"}, 
			{description = "不允许",data = false,hover = "只能打包部分生物"}
		},
		default = false
	},
	{
		name = "ccs_light3_enble_fw",
		label = "樱花灯吸收物品范围",
		options = 
		{
			{description = "全图",data = true,hover = "全图"},
			{description = "默认",data = false,hover = "默认"}
		},
		default = false
	}, 
	{
		name = "ccs_bunny_fluorescen_enable",
		label = "是否启用制作月光花",
		options = 
		{
			{description = "启用",data = true},
			{description = "关闭",data = false}
		},
		default = true
	}, 
	{
		name = "allowed_other",
		label = "禁止别人打开自己的斯比和小可",
		options = 
		{
			{description = "启用",data = true},
			{description = "关闭",data = false}
		},
		default = true
	}, 
	{
		name = "ccs_miniboatsg",
		label = "水灯行走模式",
		options = 
		{
			{description = "自由扩散",data = true},
			{description = "直线运动",data = false}
		},
		default = true
	}, 
}

--[[mod_dependencies = {
	{
        workshop = "workshop-2576514266", 
    }
}--]]