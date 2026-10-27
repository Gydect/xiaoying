local MakePlayerCharacter = require "prefabs/player_common"
local CcsFlowerOver = require("widgets/ccsflowerover")
local CARDSTATS = require("utils/ccs_card_stats")

local function RefreshCarriedCardTags(inst)
    local levels = CARDSTATS.GetCarriedCardLevels(inst)
    local tags = {
        ccs_cards_3_enble = (levels.ccs_cards_3 or 0) >= 1,
        ccs_cards_3_enble_2 = (levels.ccs_cards_3 or 0) >= 2,
        ccs_cards_28_level3 = (levels.ccs_cards_28 or 0) >= 3,
    }
    for tag, enabled in pairs(tags) do
        if enabled then inst:AddTag(tag) else inst:RemoveTag(tag) end
    end
end

local function ScheduleCarriedCardTags(inst)
    if inst._cardtagtask == nil then
        inst._cardtagtask = inst:DoTaskInTime(0, function()
            inst._cardtagtask = nil
            RefreshCarriedCardTags(inst)
        end)
    end
end
local ccs_card_collection = TUNING.CCS_CARD_COLLECTION
local gl = 0.008
local gl2 = 0.001
if ccs_card_collection == 1 then
	gl = gl * 10
	gl2 = gl2 * 10
end

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/ccs.zip" ),
	Asset("ANIM", "anim/ccs_fly.zip"),
	Asset("ANIM", "anim/ccsflyrun.zip"),
	Asset( "ANIM", "anim/ccs_skins1.zip" ),
	-- Asset( "ANIM", "anim/ccs_skins2.zip" ),
	Asset( "ANIM", "anim/ccs_skins3.zip" ),
	Asset( "ANIM", "anim/ccs_skins4.zip" ),
	Asset( "ANIM", "anim/ccs_skins5.zip" ),
	Asset( "ANIM", "anim/ccs_skins6.zip" ),
	Asset( "ANIM", "anim/ccs_skins7.zip" ),
	Asset( "ANIM", "anim/ccs_skins8.zip" ),
	Asset( "ANIM", "anim/ccs_skins_spring.zip" ),
	Asset( "ANIM", "anim/ccs_skins_marinn.zip" ),
	Asset( "ANIM", "anim/ccs_skins_madoka.zip" ),
	Asset( "ANIM", "anim/ccs_skins_madoka1.zip" ),
	Asset( "ANIM", "anim/ccs_skins_qqj.zip" ),
	Asset( "ANIM", "anim/ccs_skins_catear.zip" ),
	Asset( "ANIM", "anim/ccs_skins_alice.zip" ),
	Asset( "ANIM", "anim/ccs_skins_kioku.zip" ),
	Asset( "ANIM", "anim/zhishi.zip" ),
	Asset( "ANIM", "anim/ccs_skins_pinkcollege.zip" ), --粉色学院
	Asset( "ANIM", "anim/ccs_skins_haiyu.zip" ),
	Asset( "ANIM", "anim/shiranui.zip" ),
	Asset( "ANIM", "anim/daji.zip" ),
	Asset( "ANIM", "anim/ccs_skins_bronya.zip" ),
	Asset( "ANIM", "anim/ccs_skins_cn.zip" ),
	Asset( "ANIM", "anim/ccs_skins_limao.zip" ),
	Asset( "ANIM", "anim/ccs_skins_chuqing.zip" ),
	Asset( "ANIM", "anim/ccs_skins_chuqing2.zip" ),
	Asset("ANIM", "anim/ccs_skins_afu.zip"),
	Asset( "ANIM", "anim/ccs_skins_white.zip" ),
	Asset( "ANIM", "anim/ccs_skins_lotus.zip" ),
	Asset( "ANIM", "anim/ccs_skins_sea.zip" ),
	Asset("ANIM", "anim/ccs_skins_xhqj.zip"),
	Asset("ANIM", "anim/ccs_skins_fhyy.zip"),
	Asset("ANIM", "anim/ccs_skins_hyly.zip"),
	Asset("ANIM", "anim/ccs_skins_cbgy.zip"),
	Asset("ANIM", "anim/ccs_skins_gjzx.zip"), 
	Asset("ANIM", "anim/ccs_skins_xd.zip"),
	Asset("ANIM", "anim/ccs_skins_qfqx.zip"),
	Asset("ANIM", "anim/ccs_skins_bsem.zip"),
	Asset("ANIM", "anim/ccs_skins_xgm.zip"),
	Asset("ANIM", "anim/ccs_skins_fbhl.zip"),
	Asset("ANIM", "anim/ccs_skins_zxyy.zip"),
	Asset("ANIM", "anim/ccs_skins_mm.zip"),
	Asset("ANIM", "anim/ccs_skins_mls.zip"), 
	Asset("ANIM", "anim/ccs_skins_bs.zip"), 
	Asset("ANIM", "anim/ccs_skins_kq.zip"),
	Asset("ANIM", "anim/ccs_skins_ylxm.zip"),
	Asset("ANIM", "anim/ccs_skins_sdyy.zip"),
	Asset("ANIM", "anim/ccs_skins_rb.zip"),
	Asset("ANIM", "anim/ccs_skins_hlh.zip"),
	Asset("ANIM", "anim/ccs_skins_hj.zip"),
	Asset( "ANIM", "anim/ghost_ccs_build.zip" ),
	Asset( "ANIM", "anim/ghost_shiranui_build.zip" ),
	Asset( "ANIM", "anim/ghost_bronya_build.zip" ),
	Asset( "ANIM", "anim/ccs_spell_anim.zip" ),
	Asset("DYNAMIC_ANIM", "anim/moyuxuanli_xjlw.zip"),
	Asset("PKGREF", "anim/moyuxuanli_xjlw.dyn"),
}

local prefabs = {}
local start_inv = { "ccs_bag", "ccs_hat1", "ccs_magic_wand3" }

if TUNING.GAMEMODE_STARTING_ITEMS then
    if TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT then
		TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.CCS = { "ccs_bag", "ccs_hat1", "ccs_magic_wand3" }
	end
	TUNING.STARTING_ITEM_IMAGE_OVERRIDE.ccs_bag =  {atlas = "images/inventoryimages/ccs_bag.xml", image = "ccs_bag.tex" }

	TUNING.CCS_HEALTH = 200
	TUNING.CCS_HUNGER = 150
	TUNING.CCS_SANITY = 150
end

STRINGS.CHARACTER_TITLES.ccs = "小樱"
STRINGS.CHARACTER_NAMES.ccs = "小樱"
STRINGS.CHARACTER_DESCRIPTIONS.ccs = "木之本樱"
STRINGS.CHARACTER_SURVIVABILITY.ccs = "收服卡牌的道路总有艰辛"
STRINGS.NAMES.CCS = "小樱"
local speech = require "speech_Ccs" 
local speech2 = require "speech_Ccs2"
STRINGS.CHARACTERS.CCS = speech
STRINGS.CHARACTERS.CCSSKIN1 = speech2
-- 当人物复活的时
local function onbecamehuman(inst)
end
--当人物死亡的时
local function onbecameghost(inst)
end

-- 重载游戏或者生成一个玩家的时候
local function onload(inst)
    ScheduleCarriedCardTags(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function OnBondLevelDirty(inst)
	if inst.HUD ~= nil then
		if not inst:HasTag("playerghost") then
			if inst.HUD.ccsflowerover ~= nil then
				inst.HUD.ccsflowerover:Play(3)
			end
		end
	end
end

local function OnPlayerDeactivated(inst)
	inst:RemoveEventCallback("onremove", OnPlayerDeactivated)
	if not TheWorld.ismastersim then
		inst:RemoveEventCallback("_ccsbondleveldirty", OnBondLevelDirty)
	end
end

local function OnPlayerActivated(inst)
	if inst == ThePlayer then
		if inst.HUD.ccsflowerover == nil then
			inst.HUD.ccsflowerover = inst.HUD.overlayroot:AddChild(CcsFlowerOver(inst))
			-- inst.HUD.ccsflowerover:SetSkin(skinname)
			inst.HUD.ccsflowerover:MoveToBack()
		end
		inst:ListenForEvent("onremove", OnPlayerDeactivated)
		if not TheWorld.ismastersim then
			inst:ListenForEvent("_ccsbondleveldirty", OnBondLevelDirty)
		end
	end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "ccs.tex" )
	inst:AddTag("masterchef")         
	inst:AddTag("professionalchef") 
	inst:AddTag("fastpicker")  
	inst:AddTag("fastpick")  
	inst:AddTag("ccs")
	inst:AddTag("reader")
	inst:AddTag("bookbuilder")
	inst:DoTaskInTime(0,function()
		if inst.replica.builder then   
			local old_HasCharacterIngredient = inst.replica.builder.HasCharacterIngredient  
			inst.replica.builder.HasCharacterIngredient = function(self,ingredient,...)  
				if ingredient.type == CHARACTER_INGREDIENT.CCS_MAGIC then  
					if self.inst.replica.ccs_magic.current ~= nil then
						local current = math.ceil(self.inst.replica.ccs_magic.current:value())
						return (self.classified.isfreebuildmode:value() and 0) or current >= ingredient.amount,current  
					end
				end
				return old_HasCharacterIngredient(self,ingredient,...)
            end 
        end 
    end)
	inst._ccsbondlevel = net_bool(inst.GUID, "ccs._ccsbondlevel", "_ccsbondleveldirty")
	inst:ListenForEvent("playeractivated", OnPlayerActivated)
	inst:ListenForEvent("playerdeactivated", OnPlayerDeactivated)
	
end

local function ontechtreechange(inst,data)
	local magic = data.level.MAGIC 
	if magic >= 5 then
		inst.components.builder.accessible_tech_trees.ANCIENT = 4
		inst.ccs_ancient4 = true
	else
		if inst.ccs_ancient4 then
			inst.ccs_ancient4 = false
			inst.components.builder.accessible_tech_trees.ANCIENT = 0
		end
	end
end

local function ccs_cookitem(inst, data)
	if inst.ccs_ccs_cards_20_bd == nil then
		inst.ccs_ccs_cards_20_bd = 0
	end
	inst.ccs_ccs_cards_20_bd = inst.ccs_ccs_cards_20_bd + 1
	local potgl = gl
	if data.cookpot and data.cookpot.prefab == "ccs_cookpot" then
		potgl = potgl + 0.01
	end
	if inst.ccs_ccs_cards_20_bd >= 300 or math.random() <= potgl then
		inst.ccs_ccs_cards_20_bd = 0
		local card = SpawnPrefab("ccs_cards_20")
		card.components.ccs_card_level:SetMaster(inst.name,inst.userid)
		inst.components.inventory:GiveItem(card)
	end
end

local function picksomething(inst,data)
	inst.components.ccs_valid.hp_bd = inst.components.ccs_valid.hp_bd + 1
	if data and (data.loot or data.ccsloot) then
		
		local prod_type
		if data.ccsloot then
			prod_type = data.ccsloot[1]
		elseif data.loot and data.loot.prefab then
			prod_type = data.loot.prefab
		end

		if prod_type == "petals" or prod_type == "petals_rose" or prod_type == "petals_orchid" or prod_type == "petals_lily" or prod_type == "tbat_food_valorbush" then
			if math.random() <= gl or inst.components.ccs_valid.hp_bd >= 200 then
				inst.components.ccs_valid.hp_bd = 0
				local card = SpawnPrefab("ccs_cards_9")
				card.components.ccs_card_level:SetMaster(inst.name, inst.userid)
				inst.components.inventory:GiveItem(card)
			end
			if math.random() <= 0.002 then
				local petals = SpawnPrefab("ccs_sakura1")
				inst.components.inventory:GiveItem(petals)
			end
		end
	end
	if math.random() <= gl2 then
		local card = SpawnPrefab("ccs_cards_3")
		card.components.ccs_card_level:SetMaster(inst.name,inst.userid)
		inst.components.inventory:GiveItem(card)
	end
	if math.random() <= gl2 then
		local card = SpawnPrefab("ccs_cards_17")
		card.components.ccs_card_level:SetMaster(inst.name,inst.userid)
		inst.components.inventory:GiveItem(card)
	end
end

local function itemget(inst,data)
	if data and data.item then
		if data.item and data.item.prefab == "ccs_cards_3" then
			inst:AddTag("ccs_cards_3_enble")
			if data.item.components.ccs_card_level:GetLevel() >= 2 then
				inst:AddTag("ccs_cards_3_enble_2")
			end
		end
		-- if data.item and data.item.prefab == "cursed_monkey_token" then
		-- 	inst.components.cursable:RemoveCurse("MONKEY",99)
		-- end
		if data.item and data.item.components.ccs_card_level and data.item.components.ccs_card_level.masterid == nil then
			data.item.components.ccs_card_level:SetMaster(inst.name,inst.userid)
		end
		if data.item and data.item.prefab == "ccs_cards_28" then
			if data.item.components.ccs_card_level:GetLevel() >= 3 then
				inst:AddTag("ccs_cards_28_level3")
			end
		end
	end
    ScheduleCarriedCardTags(inst)
end

local function itemlose(inst,data)
	if data and data.prev_item and data.prev_item.prefab == "ccs_cards_3" then
		inst:RemoveTag("ccs_cards_3_enble")
		inst:RemoveTag("ccs_cards_3_enble_2")
	end
    ScheduleCarriedCardTags(inst)
	if data and data.prev_item and data.prev_item.prefab == "ccs_cards_28" then
		inst:RemoveTag("ccs_cards_28_level3")
	end
end

local function onnewstate(inst,data)
	local isfly = inst.components.ccs_flying.isfly
	local action = inst.components.ccs_flying.action
	if isfly then
		local enble = table.contains(action,data.statename)
		if enble == false then
			inst.components.ccs_flying:Land()
		end
	end
end

local function death(inst)
	inst.components.ccs_magic:DoDelta(-99999)
end

local num = 2
if TUNING.CCS_SAN_DEL == 1 then
	num = 0
elseif TUNING.CCS_SAN_DEL == 2 then
	num = 1
end

local function attacked(inst)
	inst.components.sanity:DoDelta(-num)
end

local skin_equip_rules = {
    ["ccs_skins_madoka"] = true,
    ["ccs_skins_madoka1"] = true,
	["ccs_skins_chuqing"] = true,
	["ccs_skins_chuqing2"] = true,
	["ccs_skins_sea"] = true,
	["ccs_skins_fhyy"] = true,
	["ccs_skins_hyly"] = true,
	["ccs_skins_cbgy"] = true,
	["ccs_skins_zxyy"] = true,
	["ccs_skins_xd"] = true,
	["ccs_skins_hlh"] = true,
	["ccs_skins_xxcb"] = true,
	["ccs_skins_maho"] = true,
	["ccs_skin_yxxc"] = true,
	["ccs_skin_yl"] = true,
	["ccs_skins_xin"] = true,
	["ccs_skins_afu"] = true,
}

local function onequip(inst, data)
    local skin_name = inst.components.skinner and inst.components.skinner.skin_name
    if not skin_name then
        return
    end
    
    if skin_equip_rules[skin_name] then
        if data.eslot == EQUIPSLOTS.HEAD then
            inst.AnimState:Hide('HEAD')
            inst.AnimState:Show('HEAD_HAT')
            inst.AnimState:ClearOverrideSymbol('swap_hat')
        elseif (data.eslot == EQUIPSLOTS.BODY or data.eslot == EQUIPSLOTS.BACK or data.eslot == EQUIPSLOTS.NECK) and not data.item:HasTag('heavy') then
            inst.AnimState:ClearOverrideSymbol('swap_body')
            inst.AnimState:ClearOverrideSymbol('swap_body_tall')
        end
    end
end

local function unequip(inst, data)
    local skin_name = inst.components.skinner and inst.components.skinner.skin_name
    if not skin_name then
        return
    end
    
    if skin_equip_rules[skin_name] then
        if data.eslot == EQUIPSLOTS.HEAD then
            inst.AnimState:Show('HEAD')
            inst.AnimState:Hide('HEAD_HAT')
        end
    end
end



local master_postinit = function(inst)
    inst:ListenForEvent("ccs_carried_cards_changed", ScheduleCarriedCardTags)
    ScheduleCarriedCardTags(inst)
	inst:ListenForEvent("techtreechange",ontechtreechange)
	inst:ListenForEvent("ccs_cookitem",ccs_cookitem)
	inst:ListenForEvent("picksomething",picksomething)
	inst:ListenForEvent("itemget",itemget)
	inst:ListenForEvent("itemlose",itemlose)
	inst:ListenForEvent("newstate",onnewstate)
	inst:ListenForEvent("death", death)		
	inst:ListenForEvent("attacked",attacked)	
	inst:ListenForEvent('equip', onequip)
    inst:ListenForEvent('unequip', unequip)
	
	
	-- 人物音效
	inst.soundsname = "wendy"

	inst.components.health:SetMaxHealth(TUNING.CCS_HEALTH)
	inst.components.hunger:SetMax(TUNING.CCS_HUNGER)
	inst.components.sanity:SetMax(TUNING.CCS_SANITY)
	
	inst.components.combat.damagemultiplier = 0.9
	inst.components.health:SetAbsorptionAmount(0.1)
	inst.components.health:SetMaxDamageTakenPerHit(50)
	
	inst.components.builder.science_bonus = 1
	inst.components.builder.magic_bonus = 2	
	
	inst:AddComponent("ccs_magic")
	inst.components.ccs_magic:SetMax(100)
	inst.components.ccs_magic:SetMagicRecovery(5/60)

    local health = inst.components.health
    local old_delta_modifier = health.deltamodifierfn
    health.deltamodifierfn = function(player, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
        if old_delta_modifier ~= nil then
            amount = old_delta_modifier(player, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
        end
        if amount < 0 and not health._ignore_maxdamagetakenperhit then
            amount = math.max(amount, -50)
            local magic = player.components.ccs_magic
            if magic.current >= 50 then
                local cost = math.min(-amount / 2, magic.current)
                magic:DoDelta(-cost, "ccs_damage_shield")
                amount = amount + cost * 2
            end
        end
        return amount
    end
	
	inst:AddComponent("ccs_flying") 
	
	--inst.components.petleash:SetMaxPets(3)
	
	inst:AddComponent("reader")
	local old_Read = inst.components.reader.Read   
	inst.components.reader.Read = function(self,book,...) 
		if book.components.book then
			self.inst.components.sanity:DoDelta(-10)
		end
		return old_Read(self,book,...) 
	end  

	
	--制作解锁	  
	local old_HasCharacterIngredient = inst.components.builder.HasCharacterIngredient   
		inst.components.builder.HasCharacterIngredient = function(self,ingredient,...) 
			if ingredient.type == CHARACTER_INGREDIENT.CCS_MAGIC then  
				if self.inst.components.ccs_magic ~= nil then	
					return (self.freebuildmode and 0) or 
					math.ceil(self.inst.components.ccs_magic.current) >= ingredient.amount, self.inst.components.ccs_magic.current
				end 
            end
		return old_HasCharacterIngredient(self,ingredient,...)
	end  

	--扣魔法
	local old_RemoveIngredients = inst.components.builder.RemoveIngredients
	inst.components.builder.RemoveIngredients = function(self,ingredients,recname)
		local recipe = AllRecipes[recname]
		if recipe then
			for k,v in pairs(recipe.character_ingredients) do
				if v.type == CHARACTER_INGREDIENT.CCS_MAGIC then 
					local current = math.ceil(self.inst.components.ccs_magic.current)
					if current >= v.amount then  
						inst.components.ccs_magic:DoDelta(-v.amount)  
					end
				end
			end
		end
		return old_RemoveIngredients(self,ingredients,recname)   
	end	
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

local function MakeCcsSkin(name, data, notemp)
    local d = {}
    d.rarity = "木之本樱"
    d.rarityorder = 2
	d.raritycorlor = { 0/255, 255/255, 249/255, 1 }
    d.release_group = -1001
    d.skin_tags = {"BASE", "ccs", "CHARACTER"}
    d.skins = {
        normal_skin = name,
        ghost_skin = "ghost_hina_build"
    }
    d.checkfn = CCSAPI.CcsSkinCheckFn
    d.checkclientfn = CCSAPI.CcsSkinCheckClientFn
    d.share_bigportrait_name = "css"
    d.FrameSymbol = "Reward"
    for k, v in pairs(data) do
        d[k] = v
    end
    CCSAPI.MakeCharacterSkin("ccs", name, d)
    -- if not notemp then
    --     local d2 = shallowcopy(d)
    --     d2.rarity = "限时体验"
    --     d2.rarityorder = 80
    --     d2.raritycorlor = {0.957, 0.769, 0.188, 1}
    --     d2.FrameSymbol = "heirloom"
    --     d2.name = data.name .. "(限时)"
    --     CCSAPI.MakeCharacterSkin("ccs", name .. "_tmp", d2)
    -- end
end

local function MakeCcsSkin2(name, data, notemp)
    local d = {}
    d.rarity = "木之本樱"
    d.rarityorder = 2
	d.raritycorlor = { 0/255, 255/255, 249/255, 1 }
    d.release_group = -1001
    d.skin_tags = {"BASE", "ccs", "CHARACTER"}
    d.skins = {
        normal_skin = name,
        ghost_skin = "ghost_hina_build"
    }
    d.share_bigportrait_name = "css"
    d.FrameSymbol = "Reward"
    for k, v in pairs(data) do
        d[k] = v
    end
    CCSAPI.MakeCharacterSkin("ccs", name, d)
    -- if not notemp then
    --     local d2 = shallowcopy(d)
    --     d2.rarity = "限时体验"
    --     d2.rarityorder = 80
    --     d2.raritycorlor = {0.957, 0.769, 0.188, 1}
    --     d2.FrameSymbol = "heirloom"
    --     d2.name = data.name .. "(限时)"
    --     CCSAPI.MakeCharacterSkin("ccs", name .. "_tmp", d2)
    -- end
end

MakeCcsSkin("ccs_none",{
    name = "友枝学校校服",
    des = "很乖的学生",
    quotes = "木之本樱",
    rarity = "经典",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})
	
--[[MakeCcsSkin("ccs_skins1",{
	name = "知世做的衣服",
    des = "有点奇怪但很好看",
    quotes = "木之本樱",
    rarity = "稀有",
	rarityorder = 2,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins1", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs_skins1",
	share_bigportrait_name = "ccs_skins1",
})	--]]

-- MakeCcsSkin2("ccs_skins2",{
-- 	name = "知世的力量",
--     des = "魔女战斗服",
--     quotes = "木之本樱",
--     rarity = "稀有",
-- 	rarityorder = 2,
-- 	raritycorlor = { 0/255, 255/255, 249/255, 1 },
--     skins = {normal_skin = "ccs_skins2", ghost_skin = "ghost_ccs_build"},
--     build_name_override = "ccs_skins2",
-- 	share_bigportrait_name = "ccs_skins2", 
-- })

MakeCcsSkin("ccs_skins3",{
	name = "知世的礼物",
    des = "送给每个玩家的生日礼物",
    quotes = "送给每个玩家的生日礼物",
    rarity = "生日限定",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins3", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs_skins3",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins4",{
	name = "红桃礼服",
    des = "红桃礼服",
    quotes = "红桃礼服",
    rarity = "红桃礼服",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins4", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs", 
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins5",{
	name = "星星礼服",
    des = "星星礼服",
    quotes = "星星礼服",
    rarity = "星星礼服",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins5", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins6",{
	name = "花嫁小樱",
    des = "花嫁小樱",
    quotes = "花嫁小樱",
    rarity = "花嫁小樱",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins6", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins7",{
	name = "玉桂狗小樱",
    des = "玉桂狗小樱",
    quotes = "玉桂狗小樱",
    rarity = "玉桂狗小樱",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins7", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins8",{
	name = "玉桂狗小樱2",
    des = "玉桂狗小樱2",
    quotes = "玉桂狗小樱2",
    rarity = "玉桂狗小樱2",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins8", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin("ccs_skins_spring",{
	name = "春之樱",
    des = "春之樱",
    quotes = "春之樱",
    rarity = "春之樱",
	rarityorder = 3,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins_spring", ghost_skin = "ghost_ccs_build"},
    build_name_override = "ccs",
	share_bigportrait_name = "ccs_none", 
})

MakeCcsSkin2("ccs_skins_marinn",{
    name = "梦梦",
    des = "梦梦",
    quotes = "梦梦",
    rarity = "梦梦",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_marinn", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_skins_madoka",{
    name = "圆环之理（长发）",
    des = "圆环之理",
    quotes = "圆环之理",
    rarity = "圆环之理",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_madoka", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_madoka",
	share_bigportrait_name = "ccs_none",
	clear_fn = function (inst)
		inst:RemoveTag("ccs_flyrun")
	end,
	init_fn = function (inst)
		inst:AddTag("ccs_flyrun")
	end
})

MakeCcsSkin("ccs_skins_madoka1",{
    name = "圆环之理（短发）",
    des = "圆环之理",
    quotes = "圆环之理",
    rarity = "圆环之理",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_madoka1", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_madoka1",
	share_bigportrait_name = "ccs_none",
	clear_fn = function (inst)
		inst:RemoveTag("ccs_flyrun")
	end,
	init_fn = function (inst)
		inst:AddTag("ccs_flyrun")
	end
})

MakeCcsSkin("ccs_skins_sea",{
    name = "定制：海的女儿",
    des = "定制：海的女儿",
    quotes = "定制：海的女儿",
    rarity = "定制：海的女儿",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_sea", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_sea",
	share_bigportrait_name = "ccs_none",
	clear_fn = function (inst)
		inst:RemoveTag("ccs_flyrun")
	end,
	init_fn = function (inst)
		inst:AddTag("ccs_flyrun")
	end
})

MakeCcsSkin("ccs_skins_cn",{
    name = "中华娘",
    des = "中华娘",
    quotes = "中华娘",
    rarity = "中华娘",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_cn", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_skins_limao",{
    name = "陌上红樱",
    des = "陌上红樱",
    quotes = "陌上红樱",
    rarity = "陌上红樱",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_limao", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

CCSAPI.MakeCharacterSkin("ccs","shiranui",{
    name = "定制：不知火",
    des = "定制：不知火",
    quotes = "定制：不知火",
    rarity = "定制：不知火",
	rarityorder = 2,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "shiranui", ghost_skin = "ghost_shiranui_build"},
    skin_tags = {"shiranui", "ccs", "CHARACTER"},
	build_name_override = "ccs",
	FrameSymbol = "Reward",
	clear_fn = function (inst)
		inst.MiniMapEntity:SetIcon( "ccs.tex" )
	end,
	init_fn = function (inst)
		inst.MiniMapEntity:SetIcon( "shiranui.tex" )
	end,
    checkfn = CCSAPI.CcsSkinCheckFn,
    checkclientfn = CCSAPI.CcsSkinCheckClientFn
})

CCSAPI.MakeCharacterSkin("ccs","ccs_skins_bronya",{
    name = "定制：Bronya Zaychik",
    des = "定制：Bronya Zaychik",
    quotes = "定制：Bronya Zaychik",
    rarity = "定制：Bronya Zaychik",
	rarityorder = 2,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "ccs_skins_bronya", ghost_skin = "ghost_bronya_build"},
    skin_tags = {"ccs_skins_bronya", "ccs", "CHARACTER"},
	build_name_override = "ccs",
	FrameSymbol = "Reward",
	clear_fn = function (inst)
		inst.MiniMapEntity:SetIcon( "ccs.tex" )
	end,
	init_fn = function (inst)
		inst.MiniMapEntity:SetIcon( "ccs_skins_bronya.tex" )
	end,
    checkfn = CCSAPI.CcsSkinCheckFn,
    checkclientfn = CCSAPI.CcsSkinCheckClientFn
})

CCSAPI.MakeCharacterSkin("ccs","daji",{
    name = "定制：九尾",
    des = "定制：九尾",
    quotes = "定制：九尾",
    rarity = "定制：九尾",
	rarityorder = 2,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "daji", ghost_skin = "ghost_ccs_build"},
    skin_tags = {"daji", "ccs", "CHARACTER"},
	build_name_override = "ccs",
	FrameSymbol = "Reward",
    checkfn = CCSAPI.CcsSkinCheckFn,
    checkclientfn = CCSAPI.CcsSkinCheckClientFn
})

MakeCcsSkin("ccs_skins_qqj",{
    name = "定制：千千绝",
    des = "定制：千千绝",
    quotes = "定制：千千绝",
    rarity = "定制：千千绝",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_qqj", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.MakeCharacterSkin("ccs","zhishi",{
    name = "定制：小樱cos知世",
    des = "定制：小樱cos知世",
    quotes = "定制：小樱cos知世",
    rarity = "定制：小樱cos知世",
	rarityorder = 2,
	raritycorlor = { 0/255, 255/255, 249/255, 1 },
    skins = {normal_skin = "zhishi", ghost_skin = "ghost_ccs_build"},
    skin_tags = {"zhishi", "ccs", "CHARACTER"},
	build_name_override = "ccs",
	FrameSymbol = "Reward",
    checkfn = CCSAPI.CcsSkinCheckFn,
    checkclientfn = CCSAPI.CcsSkinCheckClientFn
})


MakeCcsSkin("ccs_skins_haiyu",{
    name = "定制：叱咤月海鱼鱼猫",
    des = "定制：叱咤月海鱼鱼猫",
    quotes = "定制：叱咤月海鱼鱼猫",
    rarity = "定制：叱咤月海鱼鱼猫",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_haiyu", ghost_skin = "ghost_ccs_build"},
	share_bigportrait_name = "ccs_none",
	build_name_override = "ccs_skins_haiyu",
})

MakeCcsSkin("ccs_skins_alice",{
    name = "爱丽丝",
    des = "爱丽丝",
    quotes = "爱丽丝",
    rarity = "爱丽丝",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_alice", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_skins_catear",{
    name = "粉色猫耳",
    des = "粉色猫耳",
    quotes = "粉色猫耳",
    rarity = "粉色猫耳",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_catear", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_skins_chuqing",{
    name = "定制：初晴",
    des = "定制：初晴",
    quotes = "定制：初晴",
    rarity = "定制：初晴",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_chuqing", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_chuqing",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_chuqing2",{
    name = "定制：素晴",
    des = "定制：素晴",
    quotes = "定制：素晴",
    rarity = "定制：素晴",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_chuqing2", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_chuqing2",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_afu", {
	name = "定制：阿芙",
	des = "定制：阿芙",
	quotes = "定制：阿芙",
	rarity = "定制：阿芙",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_afu", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs_skins_afu",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_skins_xiyacha", {
	name = "定制：希娅-茶会",
	des = "定制：希娅-茶会",
	quotes = "定制：希娅-茶会",
	rarity = "定制：希娅-茶会",
	-- rarityoverride_build = "ccs_framebg",
	-- rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_xiyacha", ghost_skin = "ghost_ccsxiaoen_build"},
	build_name_override = "ccs_skins_xiyacha",
	share_bigportrait_name = "ccs_skins_xiyacha",
	-- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, k)
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, k)
    --     return true
    -- end,
})

MakeCcsSkin("ccs_skins_xiyadai", {
	name = "定制：希娅·戴·阿尔杰·奥亚",
	des = "定制：希娅·戴·阿尔杰·奥亚",
	quotes = "定制：希娅·戴·阿尔杰·奥亚",
	rarity = "定制：希娅·戴·阿尔杰·奥亚",
	-- rarityoverride_build = "ccs_framebg",
	-- rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_xiyadai", ghost_skin = "ghost_ccsxiaoen_build"},
	build_name_override = "ccs_skins_xiyadai",
	share_bigportrait_name = "ccs_skins_xiyacha",
	-- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, k)
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, k)
    --     return true
    -- end,
})

MakeCcsSkin("ccs_skins_white",{
    name = "透明翼",
    des = "透明翼",
    quotes = "透明翼",
    rarity = "透明翼",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_white", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_lotus",{
    name = "荷花旗袍",
    des = "荷花旗袍",
    quotes = "荷花旗袍",
    rarity = "荷花旗袍",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_lotus", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_kinomoto",{
    name = "定制：Kinomoto",
    des = "定制：Kinomoto",
    quotes = "定制：Kinomoto",
    rarity = "定制：Kinomoto",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_kinomoto", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_naxida1",{
    name = "定制：纳西妲1",
    des = "定制：纳西妲1",
    quotes = "定制：纳西妲1",
    rarity = "定制：纳西妲1",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_naxida1", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})

MakeCcsSkin("ccs_naxida2",{
    name = "定制：纳西妲2",
    des = "定制：纳西妲2",
    quotes = "定制：纳西妲2",
    rarity = "定制：纳西妲2",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_naxida2", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_pinkcollege",{
    name = "粉色学院",
    des = "粉色学院",
    quotes = "粉色学院",
    rarity = "粉色学院",
	rarityorder = 1,
    raritycorlor = {255 / 255, 215 / 255, 0 / 255, 1},
    skins = {normal_skin = "ccs_skins_pinkcollege", ghost_skin = "ghost_ccs_build"},
	build_name_override = "ccs",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.MakeCharacterSkin("ccs", "ccs_skins_xhqj", {
	name = "定制：雪华绮晶",
	des = "定制：雪华绮晶",
	quotes = "定制：雪华绮晶",
	rarity = "定制：雪华绮晶",
	rarityoverride_build = "ccs_framebg",
	rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 2,
	raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 },
	skins = { normal_skin = "ccs_skins_xhqj", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_xhqj",
	share_bigportrait_name = "ccs_skins_xhqj",
	checkfn = CCSAPI.CcsSkinCheckFn,
	checkclientfn = CCSAPI.CcsSkinCheckClientFn
})
MakeCcsSkin("ccs_skins_fhyya", {
	name = "定制：花铃",
	des = "定制：花铃",
	quotes = "定制：花铃",
	rarity = "定制：花铃",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_fhyy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_fhyy",
	clear_fn = function(inst)
		if TheWorld.ismastersim then
			if inst.walkfxtask then
				inst.walkfxtask:Cancel()
				inst.walkfxtask = nil
			end
			if inst.ccs_walkfx then
				inst.ccs_walkfx:Remove()
				inst.ccs_walkfx = nil
			end
		end
	end,
	init_fn = function(inst)
		if TheWorld.ismastersim then
			inst.walkfxtask = inst:DoTaskInTime(0.5,function ()
				if not inst.ccs_walkfx then
					inst.ccs_walkfx = SpawnPrefab("ccs_lizifx_yellowpetal")
					inst.ccs_walkfx.entity:AddFollower()
					inst.ccs_walkfx.entity:SetParent(inst.entity)
					inst.ccs_walkfx.Follower:FollowSymbol(inst.GUID, 'swap_body', 0, -30, 0)
				end
			end)
		end
	end
})
MakeCcsSkin("ccs_skins_hyly", {
	name = "定制：幻樱灵语",
	des = "定制：幻樱灵语",
	quotes = "定制：幻樱灵语",
	rarity = "定制：幻樱灵语",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_hyly", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_hyly",
	share_bigportrait_name = "ccs_skins_hyly",
	clear_fn = function(inst)
		if TheWorld.ismastersim then
			if inst.walkfxtask then
				inst.walkfxtask:Cancel()
				inst.walkfxtask = nil
			end
			if inst.ccs_walkfx then
				inst.ccs_walkfx:Remove()
				inst.ccs_walkfx = nil
			end
		end
	end,
	init_fn = function(inst)
		if TheWorld.ismastersim then
			inst.walkfxtask = inst:DoTaskInTime(0.5, function()
				if not inst.ccs_walkfx then
					inst.ccs_walkfx = SpawnPrefab("cane_rose_fx")
					inst.ccs_walkfx.entity:AddFollower()
					inst.ccs_walkfx.entity:SetParent(inst.entity)
					inst.ccs_walkfx.Follower:FollowSymbol(inst.GUID, 'swap_body', 0, -30, 0)
				end
			end)
		end
	end
})
MakeCcsSkin("ccs_skins_cbgy", {
	name = "定制：纯白歌谣",
	des = "定制：纯白歌谣",
	quotes = "定制：纯白歌谣",
	rarity = "定制：纯白歌谣",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_cbgy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_cbgy",
	share_bigportrait_name = "ccs_none",
	clear_fn = function(inst)
		inst:RemoveTag("ccs_flyrun")
	end,
	init_fn = function(inst)
		inst:AddTag("ccs_flyrun")
	end
})
MakeCcsSkin("ccs_skins_gjzx", {
	name = "定制：柑橘之夏",
	des = "定制：柑橘之夏",
	quotes = "定制：柑橘之夏",
	rarity = "定制：柑橘之夏",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_gjzx", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_gjzx",
	share_bigportrait_name = "ccs_skins_gjzx",
})
MakeCcsSkin("ccs_skins_xd2", {
	name = "定制：遐蝶",
	des = "定制：遐蝶",
	quotes = "定制：遐蝶",
	rarity = "定制：遐蝶",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_xd", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_xd",
	share_bigportrait_name = "ccs_skins_xd",
})
MakeCcsSkin("ccs_skins_qfqx", {
	name = "定制：琼芳青雪",
	des = "定制：琼芳青雪",
	quotes = "定制：琼芳青雪",
	rarity = "定制：琼芳青雪",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_qfqx", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_qfqx",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_bsem", {
	name = "定制：白色恶魔",
	des = "定制：白色恶魔",
	quotes = "定制：白色恶魔",
	rarity = "定制：白色恶魔",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_bsem", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_bsem",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.MakeCharacterSkin("ccs", "ccs_skins_kioku", {
	name = "定制：小小回忆",
	des = "定制：小小回忆",
	quotes = "定制：小小回忆",
	rarity = "定制：小小回忆",
	rarityoverride_build = "ccs_framebg",
	rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 2,
	raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 },
	skins = { normal_skin = "ccs_skins_kioku", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_kioku",
	share_bigportrait_name = "ccs_none",
	checkfn = CCSAPI.CcsSkinCheckFn,
	checkclientfn = CCSAPI.CcsSkinCheckClientFn
})
CCSAPI.MakeCharacterSkin("ccs", "ccs_skins_xgm", {
	name = "定制：星宫莓",
	des = "定制：星宫莓",
	quotes = "定制：星宫莓",
	rarity = "定制：星宫莓",
	rarityoverride_build = "ccs_framebg",
	rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 2,
	raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 },
	skins = { normal_skin = "ccs_skins_xgm", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_xgm",
	share_bigportrait_name = "ccs_none",
	checkfn = CCSAPI.CcsSkinCheckFn,
	checkclientfn = CCSAPI.CcsSkinCheckClientFn
})
MakeCcsSkin("ccs_skins_fbhl", {
	name = "定制：粉白狐莉",
	des = "定制：粉白狐莉",
	quotes = "定制：粉白狐莉",
	rarity = "定制：粉白狐莉",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_fbhl", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_fbhl",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_zxyy", {
	name = "定制：真夏夜夜",
	des = "定制：真夏夜夜",
	quotes = "定制：真夏夜夜",
	rarity = "定制：真夏夜夜",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_zxyy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_zxyy",
	share_bigportrait_name = "ccs_none",
	clear_fn = function(inst)
		if TheWorld.ismastersim then
			if inst.walkfxtask then
				inst.walkfxtask:Cancel()
				inst.walkfxtask = nil
			end
			if inst.ccs_walkfx then
				inst.ccs_walkfx:Remove()
				inst.ccs_walkfx = nil
			end
		end
		if inst.talkchangetask then
			inst.talkchangetask:Cancel()
			inst.talkchangetask = nil
		end
		inst.components.talker.speechproxy = nil
	end,
	init_fn = function(inst)
		if TheWorld.ismastersim then
			inst.walkfxtask = inst:DoTaskInTime(0.5, function()
				if not inst.ccs_walkfx then
					inst.ccs_walkfx = SpawnPrefab("cane_candy_fx")
					inst.ccs_walkfx.entity:AddFollower()
					inst.ccs_walkfx.entity:SetParent(inst.entity)
					inst.ccs_walkfx.Follower:FollowSymbol(inst.GUID, 'swap_body', 0, -30, 0)
				end
			end)
		end
		inst.talkchangetask = inst:DoTaskInTime(1, function()
			inst.components.talker.speechproxy = "ccsskin1"
		end)
	end
})
MakeCcsSkin("ccs_skins_mm", {
	name = "定制：兔emo",
	des = "定制：兔emo",
	quotes = "定制：兔emo",
	rarity = "定制：兔emo",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_mm", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_mm",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_mls", {
	name = "定制：码丽丝-睡鼠",
	des = "定制：码丽丝-睡鼠",
	quotes = "定制：码丽丝-睡鼠",
	rarity = "定制：码丽丝-睡鼠",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_mls", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_mls",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_bs", {
	name = "定制：浮梦冰华·寒烟",
	des = "定制：浮梦冰华·寒烟",
	quotes = "定制：浮梦冰华·寒烟",
	rarity = "定制：浮梦冰华·寒烟",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_bs", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_bs",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_kq", {
	name = "定制：鸾鸟空青",
	des = "定制：鸾鸟空青",
	quotes = "定制：鸾鸟空青",
	rarity = "定制：鸾鸟空青",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_kq", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_kq",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_rb", {
	name = "定制：桂花兔兔",
	des = "定制：桂花兔兔",
	quotes = "定制：桂花兔兔",
	rarity = "定制：桂花兔兔",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_rb", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_rb",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.MakeCharacterSkin("ccs", "ccs_skins_ylxm", {
	name = "定制：雨落星芒",
	des = "定制：雨落星芒",
	quotes = "定制：雨落星芒",
	rarity = "定制：雨落星芒",
	rarityoverride_build = "ccs_framebg",
	rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 2,
	raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 },
	skins = { normal_skin = "ccs_skins_ylxm", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_ylxm",
	share_bigportrait_name = "ccs_none",
	checkfn = CCSAPI.CcsSkinCheckFn,
	checkclientfn = CCSAPI.CcsSkinCheckClientFn
})
MakeCcsSkin("ccs_skins_sdyy", {
	name = "圣诞游园",
	des = "圣诞游园",
	quotes = "圣诞游园",
	rarity = "圣诞游园",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_sdyy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_sdyy",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_skins_hlh", {
	name = "定制：红里惠",
	des = "定制：红里惠",
	quotes = "定制：红里惠",
	rarity = "定制：红里惠",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_hlh", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_hlh",
	share_bigportrait_name = "ccs_skins_hlh",
})
MakeCcsSkin("ccs_skins_hj", {
	name = "定制：花嫁",
	des = "定制：花嫁",
	quotes = "定制：花嫁",
	rarity = "定制：花嫁",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_hj", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_hj",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_byb")
MakeCcsSkin("ccs_skins_byb", {
	name = "定制：入梦白云边",
	des = "定制：入梦白云边",
	quotes = "定制：入梦白云边",
	rarity = "定制：入梦白云边",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_byb", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_byb",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_hqfa")
MakeCcsSkin("ccs_skins_hqfa", {
	name = "定制：和泉妃爱",
	des = "定制：和泉妃爱",
	quotes = "定制：和泉妃爱",
	rarity = "定制：和泉妃爱",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_hqfa", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_hqfa",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_dzm")
CCSAPI.MakeCharacterSkin("ccs", "ccs_skins_dzm", {
	name = "定制：蝶之梦",
	des = "定制：蝶之梦",
	quotes = "定制：蝶之梦",
	rarity = "定制：蝶之梦",
	rarityoverride_build = "ccs_framebg",
	rarityoverride_symbol = "ccs_rainbow",
	rarityorder = 2,
	raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 },
	skins = { normal_skin = "ccs_skins_dzm", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_dzm",
	share_bigportrait_name = "ccs_none",
	checkfn = CCSAPI.CcsSkinCheckFn,
	checkclientfn = CCSAPI.CcsSkinCheckClientFn
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skin_cgm")
MakeCcsSkin("ccs_skin_cgm", {
	name = "定制：崇宫澪",
	des = "定制：崇宫澪",
	quotes = "定制：崇宫澪",
	rarity = "定制：崇宫澪",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_cgm", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_cgm",
	share_bigportrait_name = "ccs_none",
	clear_fn = function(inst)
		inst:RemoveTag("ccs_cgl")
	end,
	init_fn = function(inst)
		inst:AddTag("ccs_cgl")
	end,
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skin_msnzs")
MakeCcsSkin("ccs_skin_msnzs", {
	name = "定制：童年回忆",
	des = "定制：童年回忆",
	quotes = "定制：童年回忆",
	rarity = "定制：童年回忆",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_msnzs", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_msnzs",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skin_yxxc")
MakeCcsSkin("ccs_skin_yxxc", {
	name = "定制-樱见星川",
	des = "定制-樱见星川",
	quotes = "定制-樱见星川",
	rarity = "定制-樱见星川",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_yxxc", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_yxxc",
	share_bigportrait_name = "ccs_none",
	clear_fn = function(inst)
		if TheWorld.ismastersim then
			if inst.walkfxtask then
				inst.walkfxtask:Cancel()
				inst.walkfxtask = nil
			end
			if inst.ccs_walkfx then
				inst.ccs_walkfx:Remove()
				inst.ccs_walkfx = nil
			end
		end
	end,
	init_fn = function(inst)
		if TheWorld.ismastersim then
			inst.walkfxtask = inst:DoTaskInTime(0.5, function()
				if not inst.ccs_walkfx then
					inst.ccs_walkfx = SpawnPrefab("ccs_lizifx_pinkpetal")
					inst.ccs_walkfx.entity:AddFollower()
					inst.ccs_walkfx.entity:SetParent(inst.entity)
					inst.ccs_walkfx.Follower:FollowSymbol(inst.GUID, 'swap_body', 0, -30, 0)
				end
			end)
		end
	end
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skin_chwy")
MakeCcsSkin("ccs_skin_chwy", {
	name = "春和物语",
	des = "春和物语",
	quotes = "春和物语",
	rarity = "春和物语",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_chwy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_chwy",
	share_bigportrait_name = "ccs_none",
})
MakeCcsSkin("ccs_moyuxuanli_xjlw", {
	name = "定制：境墟",
	des = "定制：境墟",
	quotes = "定制：境墟",
	rarity = "定制：境墟",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "moyuxuanli_xjlw", ghost_skin = "ghost_ccs_build" },
	build_name_override = "moyuxuanli_xjlw",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skin_xnylh")
MakeCcsSkin("ccs_skin_xnylh", {
	name = "定制：小鸟游六花",
	des = "定制：小鸟游六花",
	quotes = "定制：小鸟游六花",
	rarity = "定制：小鸟游六花",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_xnylh", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_xnylh",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_adastra")
MakeCcsSkin("ccs_skins_adastra", {
	name = "定制：adastra",
	des = "定制：adastra",
	quotes = "定制：adastra",
	rarity = "定制：adastra",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_adastra", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_adastra",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_mika")
MakeCcsSkin("ccs_skins_mika", {
	name = "定制：圣园未花",
	des = "定制：圣园未花",
	quotes = "定制：圣园未花",
	rarity = "定制：圣园未花",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_mika", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_mika",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_maho")
MakeCcsSkin("ccs_skins_maho", {
	name = "定制：姬宫真步",
	des = "定制：姬宫真步",
	quotes = "定制：姬宫真步",
	rarity = "定制：姬宫真步",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_maho", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_maho",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_alxy")
MakeCcsSkin("ccs_skins_alxy", {
	name = "定制：爱莉希雅",
	des = "定制：爱莉希雅",
	quotes = "定制：爱莉希雅",
	rarity = "定制：爱莉希雅",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_alxy", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_alxy",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_cbem")
MakeCcsSkin("ccs_skins_cbem", {
	name = "定制：纯白恶魔",
	des = "定制：纯白恶魔",
	quotes = "定制：纯白恶魔",
	rarity = "定制：纯白恶魔",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_cbem", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_cbem",
	share_bigportrait_name = "ccs_none",
})
CCSAPI.CcsCharacterAssets(assets, "ccs_skins_xin")
MakeCcsSkin("ccs_skins_xin", {
	name = "定制：杏",
	des = "定制：杏",
	quotes = "定制：杏",
	rarity = "定制：杏",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skins_xin", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skins_xin",
	share_bigportrait_name = "ccs_none",
})

CCSAPI.CcsCharacterAssets(assets, "ccs_skin_xuechuyin", false, "ghost_ccs_skin_xuechuyin_build")
MakeCcsSkin("ccs_skin_xuechuyin", {
	name = "定制：雪初音",
	des = "定制：雪初音",
	quotes = "定制：雪初音",
	rarity = "定制：雪初音",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_xuechuyin", ghost_skin = "ghost_ccs_skin_xuechuyin_build" },
	build_name_override = "ccs_skin_xuechuyin",
	share_bigportrait_name = "ccs_none",
})

CCSAPI.CcsCharacterAssets(assets, "ccs_skin_glby")
MakeCcsSkin("ccs_skin_glby", {
	name = "定制：哥伦比亚",
	des = "定制：哥伦比亚",
	quotes = "定制：哥伦比亚",
	rarity = "定制：哥伦比亚",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_glby", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_glby",
	share_bigportrait_name = "ccs_none",
})

CCSAPI.CcsCharacterAssets(assets, "ccs_skin_mlby")
MakeCcsSkin("ccs_skin_mlby", {
	name = "定制：鸣濑白羽",
	des = "定制：鸣濑白羽",
	quotes = "定制：鸣濑白羽",
	rarity = "定制：鸣濑白羽",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_mlby", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_mlby",
	share_bigportrait_name = "ccs_skin_bylf",
})

CCSAPI.CcsCharacterAssets(assets, "ccs_skin_bylf")
MakeCcsSkin("ccs_skin_bylf", {
	name = "定制：白羽礼服",
	des = "定制：白羽礼服",
	quotes = "定制：白羽礼服",
	rarity = "定制：白羽礼服",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_bylf", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_bylf",
	share_bigportrait_name = "ccs_skin_bylf",
})

CCSAPI.CcsCharacterAssets(assets, "ccs_skin_aiyfl")
MakeCcsSkin("ccs_skin_aiyfl", {
	name = "艾雅法拉",
	des = "艾雅法拉",
	quotes = "艾雅法拉",
	rarity = "艾雅法拉",
	rarityorder = 1,
	raritycorlor = { 255 / 255, 215 / 255, 0 / 255, 1 },
	skins = { normal_skin = "ccs_skin_aiyfl", ghost_skin = "ghost_ccs_build" },
	build_name_override = "ccs_skin_aiyfl",
	share_bigportrait_name = "ccs_skin_aiyfl",
})
return MakePlayerCharacter("ccs", prefabs, assets, common_postinit, master_postinit, start_inv)
