local assets=
{
	Asset("ANIM", "anim/ccs_hat1.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_hat1.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_hat1.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ccs_hat1.xml",256),
}
local CCSUTL = require("utils/ccs_wanly_utils")
local CCSOWNER = require("utils/ccs_owner")

local function StopShield(inst)
    if inst._shieldtask ~= nil then
        inst._shieldtask:Cancel()
        inst._shieldtask = nil
    end
    inst:RemoveTag("forcefield")
    if inst._shieldfx ~= nil then
        inst._shieldfx:kill_fx()
        inst._shieldfx = nil
    end
    inst.components.armor:SetAbsorption(inst.ruinshat >= 2 and 0.8 or 0.2)
end

local function TryShield(inst, owner, data)
    if not owner:HasTag("ccs") or inst.ruinshat < 1 or (data and data.redirected)
        or GetTime() < (inst._nextshieldtime or 0) or math.random() >= 0.2 then
        return
    end
    inst._nextshieldtime = GetTime() + 10
    inst:AddTag("forcefield")
    inst.components.armor:SetAbsorption(1)
    inst._shieldfx = SpawnPrefab("forcefieldfx")
    inst._shieldfx.entity:SetParent(owner.entity)
    inst._shieldfx.Transform:SetPosition(0, 0.2, 0)
    inst._shieldtask = inst:DoTaskInTime(3, StopShield)
end

local function UpdateHat(inst)
    if inst.ruinshat >= 1 then inst:AddTag("hardarmor") end
    if not inst:HasTag("forcefield") then
        inst.components.armor:SetAbsorption(inst.ruinshat >= 2 and 0.8 or 0.2)
    end
    if inst.ccs_sakura1 >= 10 then
        inst:AddTag("gestaltprotection")
        inst:AddTag("ccs_block_freezable")
        local owner = inst._ccsowner
        if owner ~= nil and owner:HasTag("ccs") then
            owner.components.combat.externaldamagemultipliers:SetModifier(inst, 1.15, "ccs_hat")
            if owner.components.electricattacks == nil then owner:AddComponent("electricattacks") end
            owner.components.electricattacks:AddSource(inst)
            if inst._electricfn == nil then
                inst._electricfn = function(attacker, data)
                    if data.target ~= nil and data.target:IsValid() then
                        SpawnPrefab("electrichitsparks"):AlignToTarget(data.target, attacker, true)
                    end
                end
                inst:ListenForEvent("onhitother", inst._electricfn, owner)
                SpawnPrefab("electricchargedfx"):SetTarget(owner)
            end
        end
    end
end

local function RemoveHatEffects(inst, owner)
    if owner ~= nil then
        owner.components.combat.externaldamagemultipliers:RemoveModifier(inst, "ccs_hat")
        if owner.components.electricattacks ~= nil then owner.components.electricattacks:RemoveSource(inst) end
        if inst._electricfn ~= nil then
            inst:RemoveEventCallback("onhitother", inst._electricfn, owner)
            inst._electricfn = nil
        end
        if inst._shieldfn ~= nil then inst:RemoveEventCallback("attacked", inst._shieldfn, owner) end
    end
    inst._ccsowner = nil
    StopShield(inst)
end
-- local function Add_Sd(inst, target)
--     if target.components.electricattacks == nil then
--         target:AddComponent("electricattacks")
--     end
--     target.components.electricattacks:AddSource(inst)
--     if inst._onattackother == nil then
--         inst._onattackother = function(attacker, data)
--             if data.weapon ~= nil then
--                 if data.projectile == nil then
--                     --in combat, this is when we're just launching a projectile, so don't do FX yet
--                     if data.weapon.components.projectile ~= nil then
--                         return
--                     elseif data.weapon.components.complexprojectile ~= nil then
--                         return
--                     elseif data.weapon.components.weapon:CanRangedAttack() then
--                         return
--                     end
--                 end
--                 if data.weapon.components.weapon ~= nil and data.weapon.components.weapon.stimuli == "electric" then
--                     --weapon already has electric stimuli, so probably does its own FX
--                     return
--                 end
--             end
--             if data.target ~= nil and data.target:IsValid() and attacker:IsValid() then
--                 SpawnPrefab("electrichitsparks"):AlignToTarget(data.target, data.projectile ~= nil and data.projectile:IsValid() and data.projectile or attacker, true)
--             end
--         end
--         inst:ListenForEvent("onattackother", inst._onattackother, target)
--     end
--     SpawnPrefab("electricchargedfx"):SetTarget(target)
-- end

-- local function RemoveSd(inst,target)
--     SpawnPrefab("electricchargedfx"):SetTarget(target)
--     if target.components.electricattacks ~= nil then
--         target.components.electricattacks:RemoveSource(inst)
--     end
--     if inst._onattackother ~= nil then
--         inst:RemoveEventCallback("onattackother", inst._onattackother, target)
--         inst._onattackother = nil
--     end
-- end

local noshow = {
	["ccs_skins_madoka"] = true,
    ["ccs_skins_madoka1"] = true,
	["ccs_skins_chuqing"] = true,
	["ccs_skins_chuqing2"] = true,
	["ccs_skins_fhyy"] = true,
	["ccs_skins_hyly"] = true,
	["ccs_skins_zxyy"] = true,
	["ccs_skins_hlh"] = true,
	["ccs_skins_afu"] = true,
	["ccs_skin_yxxc"] = true,
}

local function onequip(inst,owner)
    if not owner:HasTag("ccs") then return end
    inst._ccsowner = owner
    inst._shieldfn = inst._shieldfn or function(player, data) TryShield(inst, player, data) end
    inst:ListenForEvent("attacked", inst._shieldfn, owner)
    UpdateHat(inst)
	local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
	if not noshow[owner_skin_build] then
		local skin_build = inst:GetSkinBuild()
		local skin_name = inst:GetSkinName()
		if skin_name == "ccs_hat_skins3" or skin_name == "ccs_hat_skin_star" or skin_name == "ccs_hat_skin_jgzw" then
			owner:PushEvent("equipskinneditem", inst:GetSkinName())
			owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Show("HAT_HAIR")
			owner.AnimState:Hide("HAIR_NOHAT")
		elseif skin_name == "ccs_hat_skins4" then
			if inst._front == nil then
				inst._front = SpawnPrefab("alterguardian_hat_equipped")
				inst._front.AnimState:SetBank(skin_build)
				inst._front:OnActivated(owner, true)
			end
			if skin_build then
				inst._front:SetSkin(skin_build, inst.GUID)
			end
		elseif skin_name == "ccs_hat_skins_dancecat" then
			inst.hat_fx = SpawnPrefab("dancecat_hat_bind")
			if inst.hat_fx ~= nil then
				inst.hat_fx:AttachToOwner(owner) 
			end
		elseif skin_name == "ccs_hat_skins5" then 
			if inst._front == nil then
				inst._front = SpawnPrefab("alterguardian_hat_equipped")
				inst._front:OnActivated(owner, true)
			end
			if inst._back == nil then
				inst._back = SpawnPrefab("alterguardian_hat_equipped")
				inst._back:OnActivated(owner, false)
			end
			if skin_build then
				inst._front:SetSkin("ccs_hat_skins4", inst.GUID)
				inst._back:SetSkin("ccs_hat_skins4", inst.GUID)
			end
		elseif skin_name == "ccs_hat_zr" then 
			owner.AnimState:Show("HAT")
			owner.AnimState:Show("HAT_HAIR")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:OverrideSymbol("swap_hat", skin_build, "swap_hat")
		elseif skin_name == "ccs_hat1_skins2_yx" then 
		else
			if skin_build ~= nil then
				owner.AnimState:AddOverrideBuild(skin_build)  
			else
				owner.AnimState:AddOverrideBuild("ccs_hat1")  
			end
		end
	end
	
	-- if inst.sakura >= 10 then 
	-- 	Add_Sd(inst,owner)
	-- end
end

local function onunequip(inst,owner)
    RemoveHatEffects(inst, owner)
	local skin_name = inst:GetSkinName()
	local skin_build = inst:GetSkinBuild()
	if skin_name == "ccs_hat1_skins1" then
		owner.AnimState:ClearOverrideBuild("ccs_hat1_skins1")  
	elseif skin_name == "ccs_hat_skins3" or skin_name == "ccs_hat_skin_star" or skin_name == "ccs_hat_zr" then
		owner.AnimState:Hide("HAT")
		owner.AnimState:Hide("HAT_HAIR")
		owner.AnimState:Show("HAIR_NOHAT")
	elseif skin_name == "ccs_hat_skins4" then
		if inst._back ~= nil then
			inst._back:OnDeactivated()
			inst._back = nil
		end
		if inst._front ~= nil then
			inst._front:OnDeactivated()
			inst._front = nil
		end
	elseif skin_name == "ccs_hat_skins_dancecat" then
		if inst.hat_fx ~= nil then
			inst.hat_fx:Remove()
		end
	elseif skin_name == "ccs_hat_skins5" then
		if inst._back ~= nil then
			inst._back:OnDeactivated()
			inst._back = nil
		end
		if inst._front ~= nil then
			inst._front:OnDeactivated()
			inst._front = nil
		end
	else
		if skin_build ~= nil then
			owner.AnimState:ClearOverrideBuild(skin_build)  
		else
			owner.AnimState:ClearOverrideBuild("ccs_hat1")  
		end
	end
	if skin_build ~= nil then
		owner:PushEvent("unequipskinneditem", inst:GetSkinName())
	end
	
	

	-- if inst.sakura >= 10 then 
	-- 	RemoveSd(inst,owner)
	-- end
end

local ITEM_CONFIGS = {
	["ccs_sakura1"] = {
		name = "紫樱花",
		max_count = 10,
		full_message = "樱花数量已满",
		on_full = function(inst, giver)
			giver.components.talker:Say("免疫冰冻、月灵伪装和攻击带电的效果已生效")
			inst:AddTag("gestaltprotection")   --防止月灵攻击
			inst:AddTag("ccs_block_freezable") --免疫冰冻
		end
	},
	["ruinshat"] = {
		name = "铥矿皇冠",
		max_count = 2,
		full_message = "铥矿皇冠数量已满",
		on_full = function(inst, giver)
			giver.components.talker:Say("防御已生效")
			if not inst.components.armor then
				inst:AddComponent("armor")
			end
			UpdateHat(inst)
		end
	},
	["eyebrellahat"] = {
		name = "眼球伞",
		max_count = 1, -- 布尔值表示是否拥有
		full_message = "眼球伞数量已满",
		on_receive = function(inst, giver)
			giver.components.talker:Say("防水防雷已生效")
			inst:AddComponent("waterproofer")
			inst.components.waterproofer:SetEffectiveness(1)
			inst.components.equippable.insulated = true
		end
	},
	["deserthat"] = {
		name = "沙漠护目镜",
		max_count = 1, -- 布尔值表示是否拥有
		full_message = "沙漠护目镜数量已满",
		on_receive = function(inst, giver)
			giver.components.talker:Say("防尘已生效")
			inst:AddTag("goggles")
		end
	}
}

local function AcceptTest(inst, item, giver)
    if giver == nil or not giver:HasTag("ccs") then return false end
	local config = ITEM_CONFIGS[item.prefab]
	if not config then return false end

	if item.prefab == "eyebrellahat" or item.prefab == "deserthat" then
		-- 对于布尔值类型的物品
		if inst[item.prefab] == false then
			return true
		else
			giver.components.talker:Say(config.full_message)
		end
	else
		-- 对于计数类型的物品
		if inst[item.prefab] < config.max_count then
			return true
		else
			giver.components.talker:Say(config.full_message)
		end
	end

	return false
end

local function onaccept(inst, giver, item)
	local config = ITEM_CONFIGS[item.prefab]
	if not config then return end

	if item.prefab == "eyebrellahat" or item.prefab == "deserthat" then
		-- 布尔值类型物品
		inst[item.prefab] = true
		if config.on_receive then
			config.on_receive(inst, giver)
		end
	else
		-- 计数类型物品
		inst[item.prefab] = inst[item.prefab] + 1
		giver.components.talker:Say("已给予" .. config.name .. "：" .. inst[item.prefab] .. "/" .. config.max_count)

		if inst[item.prefab] >= config.max_count and config.on_full then
			config.on_full(inst, giver)
		end
	end
    UpdateHat(inst)
end

--加载
local function onload(inst, data)
	if not data then return end

	for prefab, config in pairs(ITEM_CONFIGS) do
		if prefab == "eyebrellahat" or prefab == "deserthat" then
			inst[prefab] = data[prefab] or false
		else
			inst[prefab] = data[prefab] or 0
		end
	end

	if data.ccs_sakura1 and data.ccs_sakura1 >= 10 then
		inst:AddTag("gestaltprotection")   --防止月灵攻击
		inst:AddTag("ccs_block_freezable") --免疫冰冻
	end

	if data.ruinshat and data.ruinshat >= 2 then
		if not inst.components.armor then
			inst:AddComponent("armor")
		end
		inst.components.armor:InitIndestructible(0.8)
	end

	if data.eyebrellahat then
		if not inst.components.waterproofer then
			inst:AddComponent("waterproofer")
		end
		inst.components.waterproofer:SetEffectiveness(1)
		inst.components.equippable.insulated = true
	end

	if data.deserthat then
		inst:AddTag("goggles")
	end
    UpdateHat(inst)
end

--保存
local function onsave(inst, data)
	for prefab, _ in pairs(ITEM_CONFIGS) do
		data[prefab] = inst[prefab]
	end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()
	
	inst:AddTag("ccs_hat1")
	inst:AddTag("ccs_only_item")
	inst:AddTag("hide_percentage")
	
    MakeInventoryPhysics(inst)  
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_hat1")  
    inst.AnimState:SetBuild("ccs_hat1")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	CCSAPI.CcsItemInit(inst)
	inst.ccs_sakura1 = 0
	inst.ruinshat = 0
	inst.eyebrellahat = false
	inst.deserthat = false
    inst:AddComponent("inspectable") 
		
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_hat1.xml"

    inst:AddComponent("armor")
    inst.components.armor:InitIndestructible(0.2)
	
	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.1
	inst.components.equippable.dapperness = 9/60
	inst.components.equippable.restrictedtag = "ccs"
    CCSOWNER.RestrictToCcs(inst)
    inst:ListenForEvent("onremove", function() RemoveHatEffects(inst, inst._ccsowner) end)
	
	inst:AddComponent("trader")   --交易
	inst.components.trader:SetAcceptTest(AcceptTest)  --接收的道具
	inst.components.trader.onaccept = onaccept      --给予
	
	inst.OnSave = onsave
	inst.OnPreLoad = onload
	
	MakeHauntableLaunchAndPerish(inst) 
    return inst
end

return Prefab( "ccs_hat1", fn, assets, {"forcefieldfx", "electricchargedfx", "electrichitsparks"})
