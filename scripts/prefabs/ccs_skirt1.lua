local assets =
{
	Asset("ANIM", "anim/ccs_skirt_skin_hlh_swap.zip"),
    Asset("ANIM", "anim/ccs_skirt1.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_skirt1.xml"), 
    Asset("IMAGE", "images/inventoryimages/ccs_skirt1.tex"),
}
local CCSOWNER = require("utils/ccs_owner")

local function UpdateAttackBonus(inst)
    local owner = inst._ccsowner
    if owner ~= nil and owner:HasTag("ccs") then
        if inst.ccs_sakura1 >= 15 then
            owner.components.combat.externaldamagemultipliers:SetModifier(inst, 1.2, "ccs_skirt")
        else
            owner.components.combat.externaldamagemultipliers:RemoveModifier(inst, "ccs_skirt")
        end
    end
end

--内置cd
local function OnCooldown(inst)
    inst._cdtask = nil
end

local function lunge(inst, target, owner)
	local damage = (target.components.health.currenthealth or 0) * 0.01
	local newnums = math.random(4,6)
	local roa_little = math.random()*math.pi - math.random()*2*math.pi	
	local sleeptime = math.min(0.1,0.4/newnums)
	local rad = 4.5
	inst:StartThread(function()
		for roa = roa_little,2*math.pi + roa_little,2*math.pi/newnums  do
			local pos = target:GetPosition()
			local offset = Vector3(math.cos(roa)*rad,0,math.sin(roa)*rad)
			local shadow = SpawnPrefab("ccs_striker")
			shadow:SetPlayer(owner)
			shadow:SetPosition(pos,offset)
			shadow:SetDamage(damage)
			shadow:SetTarget(target)
			local skin = "ccs"
			local name = inst:GetSkinName()
			local ownerskin = owner.components.skinner and owner.components.skinner.skin_name
			if name then
				if name == "ccs_skirt_skin_xigewen" then
					skin = "ccs_skins_chuqing"
				elseif name == "ccs_skirt_skin_qzm" then
					skin = "ccs_skins_hyly"
				elseif name == "ccs_skirt_skin_llf" then
					skin = "ccs_skins_zxyy"
				elseif name == "ccs_skirt_skin_hlh" then
					skin = "ccs_skins_hlh"
				end
			end
			if ownerskin then
				if ownerskin == "ccs_skins_xhqj" then
					skin = "ccs_skins_xhqj"
				elseif ownerskin == "ccs_skins_xgm" then
					skin = "ccs_skins_xgm"
				end
			end
			shadow:Ccs_InitAnim(skin)
			Sleep(sleeptime)
		end
	end)
end

local function onhitother(owner,data,inst)
	if not owner:HasTag("ccs") or data == nil or data.target == nil
        or not data.target:IsValid() or data.target.components.health == nil
        or data.target.components.health:IsDead() then return end
	if math.random() <= 0.5 and inst.ccs_sakura1 and inst.ccs_sakura1 >= 15 and inst:HasTag("is_atk_xt") and inst._cdtask == nil then 
		inst._cdtask = inst:DoTaskInTime(0.3, OnCooldown)
		lunge(inst, data.target, owner)
	end
end

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
local function onequip(inst, owner) --装备
	if not owner:HasTag("ccs") then return end
	if inst.isequip then
		return
	end
	inst.isequip = true
	inst._ccsowner = owner
    UpdateAttackBonus(inst)
	
	owner:DoTaskInTime(.1, function()
        if not inst:IsValid() or inst._ccsowner ~= owner or not inst.isequip or not owner:HasTag("ccs") then return end
		local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
		local name = inst:GetSkinName()
		if name == "ccs_skirt_skin_madoka" then
			if name then 
				owner.AnimState:AddOverrideBuild(name)
			end
		else
			if not noshow[owner_skin_build] then
				if name then 
					owner.AnimState:AddOverrideBuild(name)
				end
			end
		end
	end)
	inst:ListenForEvent("onhitother", inst.onhitother, owner)	
end



local function onunequip(inst, owner)  --脱下
	inst.isequip = false
    owner.components.combat.externaldamagemultipliers:RemoveModifier(inst, "ccs_skirt")
    inst._ccsowner = nil
	local name = inst:GetSkinName()
	if name then 
		owner.AnimState:ClearOverrideBuild(name)
	end
	
	inst:RemoveEventCallback("onhitother",inst.onhitother,owner) 	
end

local function AcceptTest(inst, item, giver)
    if giver == nil or not giver:HasTag("ccs") or not inst.components.equippable:IsEquipped() then return false end
	if item.prefab == "ccs_sakura3"  and inst.ccs_sakura3 < 15 then
		return true
	end
	if item.prefab == "ccs_sakura1"  and inst.ccs_sakura1 < 15 then
		return true
	end
	return false
end

local function GiveSakura(inst,giver,item)
	if item.prefab == "ccs_sakura3" then
		if inst.components.equippable:IsEquipped() then
			inst.ccs_sakura3 = inst.ccs_sakura3 + 1
			giver.components.talker:Say("当前给予粉樱花数量："..inst.ccs_sakura3.."/15")
			if not inst:HasTag("is_atk_xt") then
				if inst.ccs_sakura3 < 15 then
					inst.components.armor:InitIndestructible(0.65 + 0.02 * inst.ccs_sakura3)
				else
					inst.components.armor:InitIndestructible(0.95)
					inst:AddComponent("planardefense")
					inst.components.planardefense:SetBaseDefense(TUNING.ARMOR_LUNARPLANT_HAT_PLANAR_DEF)
				end	
			end
		else
			giver.components.talker:Say("要在装备时给予樱花，这个樱花没收了！")	
		end	
	end
	if item.prefab == "ccs_sakura1" then
		if inst.components.equippable:IsEquipped() then
			inst.ccs_sakura1 = inst.ccs_sakura1 + 1
			giver.components.talker:Say("当前给予紫樱花数量："..inst.ccs_sakura1.."/15")	
		else
			giver.components.talker:Say("要在装备时给予樱花，这个樱花没收了！")	
		end	
	end
    UpdateAttackBonus(inst)
end

local function onuse(inst)
	local owner = inst.components.inventoryitem.owner
	if owner and owner:HasTag("ccs") and inst.components.equippable:IsEquipped() then
		if inst.ccs_sakura1 < 15 then
			owner.components.talker:Say("紫樱花还没喂满，不能切换形态")
			return false
		end
		if not inst:HasTag("is_atk_xt") then
			inst.components.armor:InitIndestructible(0.5)
			owner.components.talker:Say("裙子现在可以触发攻击特效了")
			inst:AddTag("is_atk_xt")
		else
			inst.components.armor:InitIndestructible(0.65 + 0.02 * inst.ccs_sakura3)
			owner.components.talker:Say("裙子现在不能触发攻击特效了")
			inst:RemoveTag("is_atk_xt")
		end
	end
	return false
end

--加载
local function onload(inst, data)
	if data then
		inst.ccs_sakura3 = data.ccs_sakura3 or 0
		inst.ccs_sakura1 = data.ccs_sakura1 or 0
		if data.attack_form then inst:AddTag("is_atk_xt") end
	end
    inst.components.armor:SetAbsorption(inst:HasTag("is_atk_xt") and 0.5 or (0.65 + 0.02 * inst.ccs_sakura3))
    UpdateAttackBonus(inst)
end

--保存
local function onsave(inst, data)
	data.ccs_sakura3 = inst.ccs_sakura3
	data.ccs_sakura1 = inst.ccs_sakura1
    data.attack_form = inst:HasTag("is_atk_xt")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ccs_skirt1") 
    inst.AnimState:SetBuild("ccs_skirt1")
    inst.AnimState:PlayAnimation("idle")	
	
	inst:AddTag("ccs_no_huo")
	inst:AddTag("ccs_only_item")
	inst:AddTag("hide_percentage")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	CCSAPI.CcsItemInit(inst)
    inst:AddComponent("inspectable") 

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_skirt1.xml" 
    
    inst:AddComponent("equippable") 
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY 
	inst.components.equippable.walkspeedmult =  1.1
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    CCSOWNER.RestrictToCcs(inst)
    inst:ListenForEvent("onremove", function()
        if inst._ccsowner ~= nil then onunequip(inst, inst._ccsowner) end
    end)
	
	inst.ccs_sakura3 = 0
	inst.ccs_sakura1 = 0
	
	inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.65)
	inst:DoTaskInTime(0,function()
		if inst.ccs_sakura3 < 15 then
			inst.components.armor:InitIndestructible(0.65 + 0.02 * inst.ccs_sakura3)
		else
			inst.components.armor:InitIndestructible(0.95)
			inst:AddComponent("planardefense")
			inst.components.planardefense:SetBaseDefense(TUNING.ARMOR_LUNARPLANT_HAT_PLANAR_DEF)
		end		
        if inst:HasTag("is_atk_xt") then inst.components.armor:SetAbsorption(0.5) end
        UpdateAttackBonus(inst)
	end)
	
	inst:AddComponent("trader")   
	inst.components.trader:SetAcceptTest(AcceptTest)  
	inst.components.trader.onaccept = GiveSakura   

	inst:AddComponent("useableitem")  	
	inst.components.useableitem:SetOnUseFn(onuse) 	

	inst.onhitother = function(owner,data) onhitother(owner,data,inst) end
	
	inst.OnSave = onsave
	inst.OnLoad = onload
	
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ccs_skirt1", fn, assets)
