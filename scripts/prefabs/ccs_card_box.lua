local assets=
{
	Asset("ANIM", "anim/ccs_card_box.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_card_box.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_card_box_open.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box_open.xml"),
	Asset("ANIM", "anim/ccs_card_box_5x5.zip"),
	Asset("ANIM", "anim/ccs_card_box_fengyue_fx.zip"),
	Asset("ANIM", "anim/ccs_card_box_caomei_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_card_box_caomei_slot.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box_caomei_slot.xml"),
	Asset("ANIM", "anim/ccs_card_box_alxy_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_card_box_alxy_slot.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box_alxy_slot.xml"),
	Asset("ANIM", "anim/ccs_card_box_flxy_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_card_box_flxy_slot.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box_flxy_slot.xml"),
	Asset("ANIM", "anim/ccs_card_box_flxy2_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_card_box_flxy2_slot.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_card_box_flxy2_slot.xml"),
}

local CCSUTL = require("utils/ccs_wanly_utils")
local CARDSTATS = require("utils/ccs_card_stats")

local function picktwo(inst,data)
    if data.object and data.object.components.pickable and not data.object.components.trader then
        if data.object.plant_def and data.object.components.plantresearchable and data.object.components.pickable.use_lootdropper_for_product then
            local loot = {}
			for _, prefab in ipairs(data.object.components.lootdropper:GenerateLoot()) do
				table.insert(loot, data.object.components.lootdropper:SpawnLootPrefab(prefab))
			end
            for i, item in ipairs(loot) do
				if item.components.inventoryitem ~= nil then
	                inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
				end
            end
        elseif data.object.components.pickable.product and not inst:HasTag("css_magic_pick") then
            local item = SpawnPrefab(data.object.components.pickable.product)
            if item.components.stackable then
                item.components.stackable:SetStackSize(
                    data.object.components.pickable.numtoharvest)
            end
            inst.components.inventory:GiveItem(item, nil,
                                               data.object:GetPosition())
            if (data.object.prefab == "cactus" or data.object.prefab ==
                "oasis_cactus") and data.object.has_flower then
                local item2 = SpawnPrefab("cactus_flower")
                inst.components.inventory:GiveItem(item2, nil,
                                                   data.object:GetPosition())
            end
        end
    end
end

local function js(inst,data)
	local a = math.random(1,100)
	if a >= 20 and a <= 80 then
		if data.victim ~= nil and data.victim:IsValid() and not data.victim:HasTag("ccskilled") then
			if data.victim.components.lootdropper then
				data.victim.components.lootdropper:DropLoot()
				data.victim:AddTag("ccskilled")
			end
		end
	end
	if a > 80 then
		if data.victim ~= nil and data.victim:IsValid() and not data.victim:HasTag("ccskilled")  then
			if data.victim.components.lootdropper then
				data.victim.components.lootdropper:DropLoot()
				data.victim.components.lootdropper:DropLoot()
				data.victim:AddTag("ccskilled")
			end
		end
	end
end

local function ccs_cards_2_enble(inst,owner,card)
	if inst == nil then return end
	inst:AddTag("ccs_cards_2")
	if card.components.ccs_card_level:GetLevel() >= 2 then
		inst:AddTag("ccs_cards_2_level2")
	end
end

local function ccs_cards_2_close(inst,owner,card)
	if inst == nil then return end
	inst:RemoveTag("ccs_cards_2")
	inst:RemoveTag("ccs_cards_2_level2")
end

local function ccs_cards_7_enble(inst,owner,card)
	if inst == nil then return end
	inst:AddTag("ccs_cards_7_enble")
end

local function ccs_cards_7_close(inst,owner,card)
	if inst == nil then return end
	inst:RemoveTag("ccs_cards_7_enble")
end

local function ccs_cards_11_enble(inst,owner,card)
	if inst == nil then return end
	inst:AddTag("ccs_cards_11_enble")
end

local function ccs_cards_11_close(inst,owner,card)
	if inst == nil then return end
	inst:RemoveTag("ccs_cards_11_enble")
end

local function ccs_cards_17_enble(inst,owner,card)
	if inst == nil then return end
	inst:AddTag("ccs_cards_17_enble")
end

local function ccs_cards_17_close(inst,owner,card)
	if inst == nil then return end
	inst:RemoveTag("ccs_cards_17_enble")
end

local function ccs_cards_24_enble(inst,owner,card)
	if inst == nil or card == nil then return end
	if not inst:HasTag("ccs_cards_24") then
		inst:AddTag("ccs_cards_24")
	end
	if card.components.ccs_card_level:GetLevel() >= 2 then
		inst:AddTag("ccs_cards_24_level2")
	end
	if card.components.ccs_card_level:GetLevel() >= 3 then
		inst:AddTag("ccs_cards_24_level3")
	end
end

local function ccs_cards_24_close(inst,owner,card)
	if inst == nil or card == nil then return end
	inst:RemoveTag("ccs_cards_24")
	if card.components.ccs_card_level:GetLevel() >= 2 then
		inst:RemoveTag("ccs_cards_24_level2")
	end
	if card.components.ccs_card_level:GetLevel() >= 3 then
		inst:RemoveTag("ccs_cards_24_level3")
	end
end

local function ccs_cards_20_enble(inst,owner,card)
	if inst == nil or card == nil then return end
	if not inst:HasTag("ccs_cards_20_enble") then
		if card.components.ccs_card_level:IsMaxLevel() then
			inst:AddTag("ccs_cards_20_enble")
		end
	end
end

local function ccs_cards_20_close(inst,owner,card)
	if inst == nil or card == nil then return end
	inst:RemoveTag("ccs_cards_20_enble")
end

local function ccs_cards_27_enble(inst,owner,card)
	if inst == nil or card == nil then return end
	if not inst:HasTag("ccs_cards_27_enble") then
		if card.components.ccs_card_level:IsMaxLevel() then
			inst:AddTag("ccs_cards_27_enble")
			owner:AddTag("css_nodrown_box")
			local ccm = CCSUTL.ccsgetcm(owner)
               if ccm  then 
                ccm:ManageCounter("ccs_card_fp",1,function ()
                    CCSUTL.ttlSetTreadWaterCollides(owner,true)
                    ccm:SetInstanceProperty("ccs_no_drown",true)
                end,nil)
            end
		end
	end
end

local function ccs_cards_27_close(inst,owner,card)
	if inst == nil or card == nil then return end
	inst:RemoveTag("ccs_cards_27_enble")
	owner:RemoveTag("css_nodrown_box")
	local ccm = CCSUTL.ccsgetcm(owner)
	if ccm  then 
		 ccm:ManageCounter("ccs_card_fp",-1,nil,function ()
			 CCSUTL.ttlSetTreadWaterCollides(owner,false)
			 ccm:SetInstanceProperty("ccs_no_drown",nil)
		 end)
	end
end

local ccs_magic_wand_item = {
	{item = "ccs_cards_2",fn = ccs_cards_2_enble,fn2 = ccs_cards_2_close},	--冰牌
	{item = "ccs_cards_7",fn = ccs_cards_7_enble,fn2 = ccs_cards_7_close},	--工作牌
	{item = "ccs_cards_11",fn = ccs_cards_11_enble,fn2 = ccs_cards_11_close},	--火牌
	{item = "ccs_cards_17",fn = ccs_cards_17_enble,fn2 = ccs_cards_17_close},	--双牌
	{item = "ccs_cards_24",fn = ccs_cards_24_enble,fn2 = ccs_cards_24_close},	--移牌
	{item = "ccs_cards_20",fn = ccs_cards_20_enble,fn2 = ccs_cards_20_close},	--甜牌
	{item = "ccs_cards_27",fn = ccs_cards_27_enble,fn2 = ccs_cards_27_close},	--浮牌

}

-- local function DuplicationCard(inst,item)
-- 	if inst.components.container:Has(item.prefab,2) then
-- 		return true
-- 	end
-- 	return false
-- end


-- --获得卡牌盒计算卡牌盒增益属性
-- local function CalculationBoxProperties(box,owner,card)
-- 	--如果卡牌没满级就跳过以下操作
-- 	if not card.components.ccs_card_level:IsMaxLevel() then
-- 		return
-- 	end
-- 	--如果卡牌盒持有者的id与放入的卡牌绑定者id对不上那也跳过以下操作
-- 	if card.components.ccs_card_level.masterid ~= owner.userid then
-- 		return
-- 	end
-- 	--获得卡牌盒中所有卡牌
-- 	local cards = box.components.container:GetItemsWithTag("ccs_card")
-- 	--计算有效卡牌数量
-- 	local valid_card = 0
-- 	for k,v in pairs(cards) do
-- 		if v.components.ccs_card_level:IsMaxLevel() then
-- 			--绑定的主人为持有者，并且卡牌满级，计算有效数量加一
-- 			if v.components.ccs_card_level.masterid ~= nil then
-- 				if v.components.ccs_card_level.masterid == owner.userid then
-- 					valid_card = valid_card + 1
-- 				end
-- 			end
-- 		end
-- 	end

-- 	--攻击加成
-- 	local atk_jc =  0.01
-- 	--防御加成
-- 	local def_jc = 0.01
-- 	--魔法加成
-- 	local magic_jc = 5
	
-- 	owner.components.combat.damagemultiplier = owner.components.combat.damagemultiplier + atk_jc
-- 	owner.components.locomotor:SetExternalSpeedMultiplier(owner, "ccs_card_box_jc", 1 + valid_card*0.01)
-- 	owner.components.health:SetAbsorptionAmount(owner.components.health.absorb + def_jc)
-- 	owner.components.ccs_magic:SetMax(owner.components.ccs_magic.max + magic_jc)
	
-- 	if valid_card >= 5 and box._level5 == false then
-- 		box._level5 = true
-- 		owner:ListenForEvent("picksomething",picktwo)
-- 	end
-- 	if valid_card >= 15 and box._level15 == false then
-- 		box._level15 = true
-- 		owner.components.builder.ingredientmod = .5 
-- 	end
-- 	if valid_card >= 25 and box._level25 == false then
-- 		box._level25 = true
-- 		owner:ListenForEvent("killed",js)
-- 	end

-- end

--卸下卡牌盒删除增益属性，不管卡牌盒是不是你的，非主人也会扣
local function RemoveCalculationBoxProperties(box,owner)
	
	owner.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_box")
	owner.components.locomotor:RemoveExternalSpeedMultiplier(owner, "ccs_card_box")
	owner.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_box")
	owner.components.ccs_magic:SetCardBonus(0, false)

	-- 移除攻速加成
	if owner ~= nil and owner:HasTag("ccs") then
		owner:RemoveModifier_common_atkspeedmodifier(
			box,
			"ccs_card_box_atkspeed"
		)
	end
	
	if box._level5 == true then
		box._level5 = false
		owner:RemoveTag("ccs_picktwo")
		owner:RemoveEventCallback("picksomething", picktwo)
	end
	if box._level15 == true then
		box._level15 = false
		owner.components.builder.ingredientmod = 1
	end
	if box._level25 == true then
		box._level25 = false
		owner:RemoveEventCallback("killed",js)
	end
	for k,v in pairs(box.components.container.slots) do
		if v then
			for a,b in pairs(ccs_magic_wand_item) do
				if v.prefab == b.item then
					b.fn2(box,owner,v)
				end
			end
		end
	end
end

--装备卡牌盒增加增益属性
local function AddCalculationBoxProperties(box,owner)
    local cards = CARDSTATS.GetValidCards(box, owner)
    local valid_card = CARDSTATS.GetMaxLevelCount(box, owner)
	--攻击加成
	local atk_jc = 0.10 * valid_card
	--防御加成
	local def_jc = 0.01 * valid_card
	
	owner.components.combat.externaldamagemultipliers:SetModifier("ccs_card_box", 1 + atk_jc)
	owner.components.locomotor:SetExternalSpeedMultiplier(owner, "ccs_card_box", 1 + valid_card*0.01)
	owner.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_box", 1 - def_jc)
	owner.components.ccs_magic:SetCardBonus(valid_card, cards.ccs_cards_13 ~= nil)

	-- 攻速加成：每张满级牌 +0.02，最多 +1（即 100%）
	if owner:HasTag("ccs") then
		owner:Modifier_common_atkspeedmodifier(
			box,                                 -- src 用卡牌盒，方便同 key 覆盖/移除
			math.min(1, valid_card * 0.02),      -- 每张满级牌 +0.02
			"ccs_card_box_atkspeed"              -- 专用 key
		)
	end
	
	if valid_card >= 5 and box._level5 == false then
		box._level5 = true
		owner:AddTag("ccs_picktwo")
		owner:ListenForEvent("picksomething",picktwo)
	elseif valid_card < 5 and box._level5 then
        box._level5 = false
        owner:RemoveTag("ccs_picktwo")
        owner:RemoveEventCallback("picksomething", picktwo)
	end
	if valid_card >= 15 and box._level15 == false then
		box._level15 = true
		owner.components.builder.ingredientmod = .5 
	elseif valid_card < 15 and box._level15 then
        box._level15 = false
        owner.components.builder.ingredientmod = 1
	end
	if valid_card >= 25 and box._level25 == false then
		box._level25 = true
		owner:ListenForEvent("killed",js)
	elseif valid_card < 25 and box._level25 then
        box._level25 = false
        owner:RemoveEventCallback("killed", js)
	end
	for k,v in pairs(box.components.container.slots) do
		if v then
			for a,b in pairs(ccs_magic_wand_item) do
				if v.prefab == b.item and v.components.ccs_card_level.masterid == owner.userid then
					b.fn(box,owner,v)
				end
			end
		end
	end
end

local function AcceptPaper(inst, item, giver)
    return item.prefab == "ccs_paper" and giver ~= nil and giver:HasTag("ccs")
        and giver.components.ccs_magic ~= nil
        and inst.components.inventoryitem:GetGrandOwner() == giver
        and CARDSTATS.GetCardCount(inst, giver) >= 15
end

local function AbsorbPaper(inst, giver, item, count)
    local magic = giver.components.ccs_magic
    magic:AbsorbPaper(count or 1)
    if giver.components.talker ~= nil then
        giver.components.talker:Say("魔法纸成长：" .. magic.paper_growth .. "，当前进度：" .. magic.paper_count .. "/3")
    end
end

local function itemget(inst,data)
	inst:DoTaskInTime(0,function()
		local owner = inst.components.inventoryitem.owner
		--如果卡牌盒有相同卡牌就弹出卡牌
		local card = 0
		local cards = inst.components.container:GetItemsWithTag("ccs_card")
		for k,v in pairs(cards) do
			if v.prefab == data.item.prefab then
				card = card + 1
				if card > 1 then
					if data.item.components.stackable then
						if data.item.components.stackable:IsStack() then
							inst.components.container:DropItemBySlot(data.slot)
						else
							inst.components.container:DropItem(data.item)	
						end
					else
						inst.components.container:DropItem(data.item)	
					end
					data.item:AddTag("no_ksx")
					if owner then
						if owner.components and owner.components.talker then
							owner.components.talker:Say("卡牌盒已有相同卡牌，无法放入卡牌盒")
						end
					end
					return
				end
			end
		end
		if not inst.components.equippable:IsEquipped() then return end
		--如果卡牌没有主人就弹出卡牌
		if data.item.components.ccs_card_level.masterid == nil then
			data.item:AddTag("no_ksx")			--不扣属性
			inst.components.container:DropItem(data.item)
			if owner then
				if owner.components and owner.components.talker then
					owner.components.talker:Say("该卡牌未绑定，无法放入卡牌盒")
				end
			end
			return
		end
		if owner then
			if owner:HasTag("player") and owner:HasTag("ccs") then
				AddCalculationBoxProperties(inst, owner)
			end
		end

	end)
end

--失去卡牌计算增益属性
-- local function RemoveBoxProperties(box,owner,loseitem)
-- 	--特殊原因弹出的卡牌不扣属性
-- 	if loseitem:HasTag("no_ksx") then
-- 		loseitem:RemoveTag("no_ksx")
-- 		return
-- 	end

-- 	--获得卡牌盒中所有卡牌
-- 	local cards = box.components.container:GetItemsWithTag("ccs_card")
-- 	--计算有效卡牌数量
-- 	local valid_card = 0
-- 	for k,v in pairs(cards) do
-- 		if v.components.ccs_card_level:IsMaxLevel() then
-- 			--绑定的主人为持有者，并且卡牌满级，计算有效数量加一
-- 			if v.components.ccs_card_level.masterid ~= nil then
-- 				if v.components.ccs_card_level.masterid == owner.userid then
-- 					valid_card = valid_card + 1
-- 				end
-- 			end
-- 		end
-- 	end
-- 	if loseitem.components.ccs_card_level:IsMaxLevel() then
-- 		if loseitem.components.ccs_card_level.masterid ~= nil then
-- 			if loseitem.components.ccs_card_level.masterid == owner.userid then
-- 				owner.components.combat.damagemultiplier = owner.components.combat.damagemultiplier - 0.01
-- 				owner.components.locomotor:SetExternalSpeedMultiplier(owner, "ccs_card_box_jc", 1 + valid_card*0.01)
-- 				owner.components.health:SetAbsorptionAmount(owner.components.health.absorb - 0.01)
-- 				owner.components.ccs_magic:SetMax(owner.components.ccs_magic.max - 5)
-- 			end
-- 		end
-- 	end
-- 	if valid_card <= 5 and box._level5 == true then
-- 		box._level5 = false
-- 		owner:RemoveEventCallback("picksomething", picktwo)
-- 	end
-- 	if valid_card <= 15 and box._level15 == true then
-- 		box._level15 = false
-- 		owner.components.builder.ingredientmod = 1
-- 	end
-- 	if valid_card <= 25 and box._level25 == true then
-- 		box._level25 = false
-- 		owner:RemoveEventCallback("killed",js)
-- 	end
-- end

local function itemlose(inst,data)
	inst:DoTaskInTime(0,function()
		--先搜索卡牌盒持有者，如果卡牌盒持有者不是玩家就查询卡牌盒持有者的持有者是否是玩家，这里一般特指背包，还不是玩家就略过
		if not inst.components.equippable:IsEquipped() then return end
		local owner = inst.components.inventoryitem.owner
		for k,v in pairs(ccs_magic_wand_item) do
			if data.prev_item.prefab == v.item then
				v.fn2(inst,owner,data.prev_item)
			end
		end
		if owner then
			if owner:HasTag("player") and owner:HasTag("ccs") then
				AddCalculationBoxProperties(inst, owner)
			else
				local owner2 = owner.components.inventoryitem and owner.components.inventoryitem.owner
				if owner2 then
					if owner2:HasTag("player") and owner2:HasTag("ccs") then
						AddCalculationBoxProperties(inst, owner)
					end
				end
			end
		end
	end)
end

local function CreateLight(owner)
	--检查是否已经存在光源实例
	if owner and not owner._ccs_light2 then
		--生成光源
		local light = SpawnPrefab("ccs_light1")
		--将光源添加到owner下面作为子节点
		owner:AddChild(light)
		--设置光源位置,局部坐标不偏移
		light.Transform:SetPosition(0, 0, 0)
		--将光源实例存储在owner中
		owner._ccs_light2 = light
	end
end

local function SpawnFengyueFx(inst, owner)
    if not TheWorld.ismastersim or owner == nil then
        return
    end
    if inst._vfx_fx_inst ~= nil and not inst._vfx_fx_inst:IsValid() then
        inst._vfx_fx_inst = nil
    end
    if inst._vfx_fx_inst == nil then
        inst._vfx_fx_inst = SpawnPrefab("ccs_card_box_fengyue_fx")
    end
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst.item = inst
        inst._vfx_fx_inst.Transform:SetPosition(owner.Transform:GetWorldPosition())
        if inst._vfx_fx_inst.components.ccsfollewer ~= nil then
            inst._vfx_fx_inst.components.ccsfollewer:Init(owner)
        end
    end
end

local function RemoveFengyueFx(inst)
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
end

local function onequip(inst, owner) --装备	
	if inst.isequip then
		return
	end
	if not owner:HasTag("ccs") then
		return
	end
	inst.isequip = true
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
	AddCalculationBoxProperties(inst,owner)
	local skin = inst:GetSkinBuild()
	if skin then
		if skin == 'ccs_card_box_fluff' then
			CreateLight(owner)
		elseif skin == "ccs_card_box_caomei" then
			if inst._vfx_fx_inst == nil then
				inst._vfx_fx_inst = SpawnPrefab('ccs_lizifx_wvictorian')
				inst._vfx_fx_inst.entity:AddFollower()
			end
			inst._vfx_fx_inst.entity:SetParent(owner.entity)
			inst._vfx_fx_inst.Transform:SetPosition(0, 0.5, 0)
        elseif skin == "ccs_card_box_fengyue" then
            SpawnFengyueFx(inst, owner)
		end
	end
end

local function onunequip(inst, owner) 
	if not owner:HasTag("ccs") then
		return
	end
	inst.isequip = false
	if inst.components.container ~= nil then
		inst.components.container:Close()
	end
	--取消所有加成
	RemoveCalculationBoxProperties(inst,owner)
	--检查是否存在光源实例
	if owner._ccs_light2 then
		--移除光源
		owner._ccs_light2:Remove()
		owner._ccs_light2 = nil
	end
	if inst._vfx_fx_inst ~= nil then
		inst._vfx_fx_inst:Remove()
		inst._vfx_fx_inst = nil
	end
end

local function OnRemoveBox(inst)
    local owner = inst.components.inventoryitem.owner
    if inst.isequip and owner ~= nil and owner:HasTag("ccs") then
        onunequip(inst, owner)
    end
    RemoveFengyueFx(inst)
end

local function onopen(inst)
	local skin_build = inst:GetSkinBuild()
	if skin_build then
		if inst.components.inventoryitem then
            inst.components.inventoryitem:ChangeImageName(skin_build == "ccs_card_box_fengyue" and skin_build or skin_build .. "_open")
		end
	else
		if inst.components.inventoryitem then
			inst.components.inventoryitem:ChangeImageName("ccs_card_box_open")
		end
	end
end

local function onclose(inst)
	local skin_build = inst:GetSkinBuild()
	if skin_build then
		if inst.components.inventoryitem then
			inst.components.inventoryitem:ChangeImageName(skin_build)
		end
	else
		if inst.components.inventoryitem then
			inst.components.inventoryitem:ChangeImageName("ccs_card_box")
		end
	end
end
local function OnDropped(inst)
	if inst then
		local skin = inst:GetSkinBuild()
		if skin and skin == "ccs_card_box_caomei" then
			if inst.Light then
				inst.Light:Enable(true)
			end
		else
			if inst.Light then
				inst.Light:Enable(false)
			end
		end
	end
end
local function oncontainer_change(inst)
	local num = inst._state:value()
	if num == 2 then
		inst.replica.container:WidgetSetup("ccs_card_box_caomei_ui")
	elseif num == 3 then
		inst.replica.container:WidgetSetup("ccs_card_box_alxy_ui")
	elseif num == 4 then
		inst.replica.container:WidgetSetup("ccs_card_box_flxy_ui")
	elseif num == 5 then
		inst.replica.container:WidgetSetup("ccs_card_box_flxy2_ui")
	elseif num == 1 then
		inst.replica.container:WidgetSetup("ccs_card_box")
	end
end

local get_skill_cd = {
	"bramble_resistant",
	"healing_block",
	"lock_blood",
	"lock_blood_full",
	"stun",
	--"armor_break",
	"dodge",
	"critical",
	"shadow_cage",
}

local function OnCooldownEnd(inst, key)
    if (key == "lock_blood_full" or key == "lock_blood") and inst.components.inventoryitem then
        local owner =  inst.components.inventoryitem:GetGrandOwner()
        if owner and owner.userid then 
			local str 
			if key == "lock_blood_full" then 
				str = "卡牌盒技能锁血回满冷却结束"
			else
				str = "卡牌盒技能锁1血冷却结束"
			end

            CCSWHISPER(owner, {
                sender_name = "卡牌盒",
                s_colour    = {1, 0.8, 0.2, 1},
                m_colour    = {1, 1, 0, 1},
                message     = str,
                icondata    = "profileflair_rose"
            })

        end
    end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)  
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_card_box")  
    inst.AnimState:SetBuild("ccs_card_box")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("ccs_card_box")
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst.entity:AddLight()
	inst.Light:SetRadius(.6)
	inst.Light:SetFalloff(1)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(235 / 255, 165 / 255, 12 / 255)
	inst.Light:Enable(false)
	
	
    inst.entity:SetPristine()
	inst._state = net_smallbyte(inst.GUID, "ccs_card_box._state", "container_change")
    if not TheWorld.ismastersim then
	    inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_card_box")
        end
		inst:ListenForEvent("container_change", oncontainer_change)
        return inst
    end
	inst._state:set(1)
	CCSAPI.CcsItemInit(inst)
    inst.SpawnFengyueFx = SpawnFengyueFx
    inst.RemoveFengyueFx = RemoveFengyueFx
	inst._level5 = false
	inst._level15 = false
	inst._level25 = false
	
    inst:AddComponent("inspectable") 
		
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_card_box")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose
      
	inst:ListenForEvent("itemget", itemget)
	inst:ListenForEvent("itemlose", itemlose)

	inst:AddComponent("ccs_cardbox_skill")
	inst:AddComponent("ccs_timer")
	
	for k, v in pairs(get_skill_cd) do 
		inst.components.ccs_timer:Configure("get_"..v, 10, false)
	end
	
	inst.components.ccs_timer:Configure("lock_blood", 960, false)
	inst.components.ccs_timer:SetOnCooldownEnd("lock_blood", OnCooldownEnd,true)
	inst.components.ccs_timer:Configure("lock_blood_full", 480, false)
	inst.components.ccs_timer:SetOnCooldownEnd("lock_blood_full", OnCooldownEnd,true)

	inst:AddComponent("equippable") 
	inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.restrictedtag = "ccs"

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader:SetAcceptStacks()
    inst.components.trader:SetAcceptTest(AcceptPaper)
    inst.components.trader.onaccept = AbsorbPaper
	
	inst:AddComponent("ccs_card_level")
	inst:ListenForEvent("ondropped", OnDropped)
    inst:ListenForEvent("onremove", OnRemoveBox)
	--inst.OnSave = onsave
	--inst.OnPreLoad = onload
	
	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 
    
return Prefab( "ccs_card_box", fn, assets)
