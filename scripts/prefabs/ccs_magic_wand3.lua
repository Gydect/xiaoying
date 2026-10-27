local CCSUTL = require("utils/ccs_wanly_utils")
local assets=
{
	Asset("ANIM", "anim/ccs_magic_wand3.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_magic_wand3.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_magic_wand3.xml"),
	
	Asset("ANIM", "anim/ccs_sword.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_sword.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_sword.xml"),
	
	Asset("ANIM", "anim/ccs_bow.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_bow.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_bow.xml"),

	Asset("ANIM", "anim/player_actions_sovo_bow_attack.zip"),
}

local assets2 = {
    Asset("ANIM", "anim/lavaarena_fire_fx.zip"),
	Asset("ANIM", "anim/lavaarena_firestaff_meteor.zip"),
}

local assets3 = {
    Asset("ANIM", "anim/ccs_sword_skins3.zip"),

}

local cards = {}

local function CheckCardompatibility(inst,card,owner)
	for k,v in pairs(inst.components.container.slots) do
		if card.prefab == "ccs_cards_12" then
			if v.prefab == "ccs_cards_15" then
				inst.components.container:DropItem(v)
				owner.components.talker:Say("剑牌不兼容矢牌，矢牌已自动弹出")
			end
		end
		if card.prefab == "ccs_cards_15" then
			if v.prefab == "ccs_cards_12" then
				inst.components.container:DropItem(v)
				owner.components.talker:Say("矢牌不兼容剑牌，剑牌已自动弹出")
			end
		end
	end
end

local dynamicweapon_skin_data = {
	ccs_sword_skins3 = true,
	ccs_magic_wand3_skin_yueguitu = true,
	ccs_magic_wand3_skin_hyjl = true,
	ccs_magic_wand3_skin_xyym = true,
	ccs_magic_wand3_skin_goldwing = true,
}

local dynamicweapon_fx_map = {
    ccs_magic_wand3_skin_goldwing = "ccs_magic_wand3_skin_goldwing_fx",
}

local skin_bank = {}

local bow_projectile_skin = {
    ccs_bow_skin_mwml = "ccs_bow_skin_mwml_prj",
}

local function GetSkinBank(skin_build)
    return skin_bank[skin_build] or skin_build
end

local function GetBowProjectile(skin_build)
    return bow_projectile_skin[skin_build] or "ccs_bow_prj"
end

local function SetFxOwner(inst, owner, fx)
	-- if inst.blade1 then
	-- 	inst.blade1:Remove()
	-- 	inst.blade1 = nil
	-- end
	-- if inst.blade2 then
	-- 	inst.blade2:Remove()
	-- 	inst.blade2 = nil
	-- end
    if inst.blade1 == nil and fx then
        inst.blade1 = SpawnPrefab(fx)
    end
	if inst.blade2 == nil and fx then
        inst.blade2 = SpawnPrefab(fx)
    end

    if owner ~= nil then
		if inst.blade1 and inst.blade2 then
			inst.blade1.entity:SetParent(owner.entity)
        	inst.blade2.entity:SetParent(owner.entity)
        	inst.blade1.Follower:FollowSymbol(owner.GUID, "swap_object", nil, nil, nil, true, nil, 0, 3)
        	inst.blade2.Follower:FollowSymbol(owner.GUID, "swap_object", nil, nil, nil, true, nil, 5, 8)
        	inst.blade1.components.highlightchild:SetOwner(owner)
        	inst.blade2.components.highlightchild:SetOwner(owner)
		end
		

    else
        if inst.blade1 then
            inst.blade1:Remove()
            inst.blade1 = nil
        end
		if inst.blade2 then
            inst.blade2:Remove()
            inst.blade2 = nil
        end

    end
end

local function SpawnGoldwingHitFx(target, anim)
    if target == nil or not target:IsValid() then
        return
    end
    local fx = SpawnPrefab("ccs_magic_wand3_skin_goldwing_atkfx")
    if fx ~= nil then
        fx.AnimState:PlayAnimation(anim or "hit2", false)
        fx.Transform:SetPosition(target.Transform:GetWorldPosition())
        local x, y, z = fx.Transform:GetWorldPosition()
        fx.Transform:SetPosition(x, y + 1.5, z)
    end
end

local function isdeath(inst,owner,target)
	if target.components.health:IsDead() then	--推送死亡事件。击杀者为装备者
		owner:PushEvent("killed", { victim = target })
		if target.components.combat ~= nil and target.components.combat.onkilledbyother ~= nil then
			target.components.combat.onkilledbyother(target, owner)
		end		
	end	
end

local function atk(inst,owner,target)
	local skin = inst:GetSkinBuild()
	if target and skin and skin == "ccs_magic_wand3_skin_hyjl" then
		SpawnPrefab("ccs_lavaarena_player_teleport").Transform:SetPosition(target:GetPosition():Get())
	elseif target and skin == "ccs_magic_wand3_skin_goldwing" then
		SpawnGoldwingHitFx(target, "hit2")
	end
	-- local mul = CCSUTL.TTgetentityMultiplier(owner,target)
	-- if inst:HasTag("ccs_bow") then
	-- 	mul = mul * 0.45
	-- end
	-- local damage = 51 * mul
	-- target:PushEvent("attacked", { attacker = owner, damage = damage, weapon = inst })
	-- CCSUTL.ttlrealhealth(owner,target,-damage,owner.prefab,owner)

	for k,v in pairs(inst.components.container.slots) do
        if v then
			if v.prefab == "ccs_cards_11" then
				local x, y, z = target:GetPosition():Get()
				local fx = SpawnPrefab("ccs_meteor")
				fx:AttackArea(owner,inst)
				fx.AnimState:SetAddColour( 0/255, 255/255, 255/255, 1 )
				local level = v.components.ccs_card_level:GetLevel() 
				local damage1 = 40
				if level == 2 then 
					damage1 = 60 
				elseif level == 3 then
					damage1 = 80 
				elseif level == 4 then
					damage1 = 150 
				end
				if inst:HasTag("ccs_bow")then
					damage1 = damage1 * 0.33
				end
				fx.damage = damage1
				fx.Transform:SetPosition(x,y,z)
			end
			if v.prefab == "ccs_cards_15" then
				local level = v.components.ccs_card_level:GetLevel() 
				if level >= 4 then
					local x,y,z = target:GetPosition():Get() --获取目标位置
					SpawnPrefab("halloween_firepuff_cold_3").Transform:SetPosition(x,y,z)   
					local a = target.components.health.maxhealth * 0.002
					CCSUTL.ttlrealhealth(owner,target,-a,owner.prefab,owner)
				end
			end
			if v.prefab == "ccs_cards_12" then
				local skin = inst.AnimState:GetBuild()
				local x, y, z = target:GetPosition():Get() --获取目标位置
				if skin then
					if skin == 'ccs_sword_skins9' then
						SpawnPrefab("ccs_starhit").Transform:SetPosition(x, y + 1.5, z)
					elseif skin == 'ccs_sword_skins11' then
						local fx = SpawnPrefab("ccs_redswordfx")
						fx.Transform:SetPosition(owner:GetPosition():Get())
						fx:ForceFacePoint(target:GetPosition():Get())
					elseif skin == 'ccs_sword_skins8' then
						SpawnPrefab("ccs_flhm_fx").Transform:SetPosition(x, y, z)
					end
					
				end
				
				local level = v.components.ccs_card_level:GetLevel() 
				if level >= 4 then
					SpawnPrefab("fx_boat_pop").Transform:SetPosition(x,y,z)   
					local a = target.components.health.maxhealth * 0.01
					CCSUTL.ttlrealhealth(owner,target,-a,owner.prefab,owner)
				end
				if level >= 6 then
					local x,y,z = target:GetPosition():Get() --获取目标位置
					SpawnPrefab("fx_boat_pop").Transform:SetPosition(x,y,z)   
					local a = target.components.health.maxhealth * 0.01
					CCSUTL.ttlrealhealth(owner,target,-a,owner.prefab,owner)
				end
			end
			if v.prefab == "ccs_cards_22" and inst:HasTag("ccs_cards_22_enble") then
				if target.components.health:GetPercent() <= .05 then
					local x,y,z = target:GetPosition():Get() --获取目标位置
					SpawnPrefab("fx_boat_pop").Transform:SetPosition(x,y,z)   
					local a = target.components.health.maxhealth
					CCSUTL.ttlrealhealth(owner,target,-a,owner.prefab,owner)
				end
			end
        end
    end
end

local function ccs_cards_11_enble(inst,owner,card)
	inst.components.weapon:SetDamage(inst.components.weapon.damage - 45)            
end

local function ccs_cards_11_close(inst,owner,card)
	inst.components.weapon:SetDamage(inst.components.weapon.damage + 45)            
end

local function ccs_cards_15_enble(inst,owner,card)
	CheckCardompatibility(inst,card,owner)
	local level = card.components.ccs_card_level:GetLevel() or 1 
	inst.components.weapon:SetRange(math.min(4 + level * 2, 12))
	local skin_build = card:GetSkinBuild()
	if inst.blade1 then
		inst.blade1:Remove()
		inst.blade1 = nil
	end
	if inst.blade2 then
		inst.blade2:Remove()
		inst.blade2 = nil
	end
	if skin_build then
		owner.AnimState:OverrideSymbol("swap_object", skin_build, "swap_weapon")
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/"..skin_build..".xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage(skin_build)
		inst:PushEvent("imagechange")
		inst.AnimState:SetBank(GetSkinBank(skin_build)) 		--更新地面动画
		inst.AnimState:SetBuild(skin_build)
		inst.AnimState:PlayAnimation("ccs_cards_15")
		--inst.components.weapon:SetProjectile("ccs_bow_fx")
		
	    inst:AddTag("ccs_bow")
		if skin_build == "ccs_bow_skin_rain2" then
			inst:AddTag("ccs_bow_hearthitfx")
			inst.components.weapon:SetProjectile("ccs_magicarrow_skin_heart")
		else
			inst.components.weapon:SetProjectile(GetBowProjectile(skin_build))
		end
	else
		owner.AnimState:OverrideSymbol("swap_object", "ccs_bow", "swap_weapon")	--手持切换为弓箭形态
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/ccs_bow.xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage("ccs_bow")
		inst:PushEvent("imagechange")
		inst.AnimState:SetBank("ccs_bow") 		--更新地面动画
		inst.AnimState:SetBuild("ccs_bow")
		inst.AnimState:PlayAnimation("idle")
		--inst.components.weapon:SetProjectile("ccs_bow_fx")
	    inst.components.weapon:SetProjectile("ccs_bow_prj")
	    inst:AddTag("ccs_bow")
	end

	if inst._vfx_fx_inst and inst._vfx_fx_inst.prefab == "ccs_lizifx_bubble" then
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 9, -48, 0)
	end
	
end

local function ccs_cards_15_close(inst,owner,card)
	inst.components.weapon:SetRange(4)
	local skin_build = inst:GetSkinBuild()
	
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
		owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_weapon", inst.GUID, "swap_weapon")
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/"..skin_build..".xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage(skin_build)
		inst.AnimState:SetBank(GetSkinBank(skin_build))
		inst.AnimState:SetBuild(skin_build)	
		inst.components.weapon:SetProjectile(nil)
	    inst:RemoveTag("ccs_bow")
		if dynamicweapon_skin_data[skin_build] then
			SetFxOwner(inst, owner, dynamicweapon_fx_map[skin_build] or (skin_build .. "_fx"))
		end
	else
		owner.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand3", "swap_weapon")
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/ccs_magic_wand3.xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage("ccs_magic_wand3")
		inst.AnimState:SetBank("ccs_magic_wand3") 		--更新地面动画
		inst.AnimState:SetBuild("ccs_magic_wand3")	
		inst.components.weapon:SetProjectile(nil)
	    inst:RemoveTag("ccs_bow")
		SetFxOwner(inst, nil)
	end	
	inst:PushEvent("imagechange")
	inst.AnimState:PlayAnimation("idle")
	if inst._vfx_fx_inst and inst._vfx_fx_inst.prefab == "ccs_lizifx_bubble" then
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
	end
	inst:RemoveTag("ccs_bow_hearthitfx")
end

local function onhitother(inst,data)
	if data.target and data.damage and inst.components.inventory:EquipHasTag("ccs_cards_12_enble_card") then
		local hand = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		local card = hand and hand.components.container and hand.components.container:GetItemsWithTag("ccs_cards_12") 
		local level = 1
		for k,v in pairs(card) do
			if v then
				level = v.components.ccs_card_level:GetLevel() or 1
			end
		end
		local a = 0
		if level == 3 then
			a = 2
		elseif level >= 4 then
			a = math.max(data.damage / 50,4)
		end
		CCSUTL.ttlrealhealth(inst,nil,a,"剑牌攻击回血",inst)
	end
end

local function ccs_cards_12_enble(inst,owner,card)
	local level = card.components.ccs_card_level:GetLevel() or 1 
	if level >= 3 then
		inst:AddTag("ccs_cards_12_enble_card")
		-- owner:ListenForEvent("onhitother",onhitother)
	end
	inst:AddTag("is_sword")
	CheckCardompatibility(inst,card,owner)
	if inst.blade1 then
		inst.blade1:Remove()
		inst.blade1 = nil
	end
	if inst.blade2 then
		inst.blade2:Remove()
		inst.blade2 = nil
	end
	local skin_build = card:GetSkinBuild()
	inst.components.weapon:SetRange(1.5)
	inst.components.weapon:SetDamage(51 + math.min(30,level * 5))  
    inst.components.weapon:SetProjectile(nil)
	if skin_build then
		if skin_build == "ccs_sword_skin_yzr" then
			owner.AnimState:OverrideSymbol("swap_object", math.random() < 0.5 and skin_build or skin_build .. 1,
				"swap_weapon")
		else
			owner.AnimState:OverrideSymbol("swap_object", skin_build, "swap_weapon")
		end
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/"..skin_build..".xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage(skin_build)
		inst:PushEvent("imagechange")
		inst.AnimState:SetBank(GetSkinBank(skin_build)) 		--更新地面动画
		inst.AnimState:SetBuild(skin_build)
		inst.AnimState:PlayAnimation("ccs_cards_12")
		if dynamicweapon_skin_data[skin_build] then
			SetFxOwner(inst, owner, dynamicweapon_fx_map[skin_build] or (skin_build .. "_fx"))
		end
		if card:HasTag("swordfx_atk") and inst.components.equippable and inst.components.equippable:IsEquipped() then
			if inst._atk_fx_inst == nil then
				inst._atk_fx_inst = SpawnPrefab('ccs_curve_fx')
				inst._atk_fx_inst.entity:AddFollower()
			end
			inst._atk_fx_inst.entity:SetParent(owner.entity)
			inst._atk_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
		end
	else
		owner.AnimState:OverrideSymbol("swap_object", "ccs_sword", "swap_weapon")	--手持切换为剑形态
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/ccs_sword.xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage("ccs_sword")
		inst:PushEvent("imagechange")
		inst.AnimState:SetBank("ccs_sword") 		--更新地面动画
		inst.AnimState:SetBuild("ccs_sword")
		inst.AnimState:PlayAnimation("idle")
		SetFxOwner(inst, nil)
	end
end

local function ccs_cards_12_close(inst,owner,card)
	inst.components.weapon:SetRange(4)
	inst:RemoveTag("is_sword")
	inst:RemoveTag("ccs_cards_12_enble_card")
	-- local level = card.components.ccs_card_level:GetLevel() or 1 
	-- if level >= 3 then
	-- 	owner:RemoveEventCallback("onhitother",onhitother)
	-- end
	inst.components.weapon:SetDamage(51) 
	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
		owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_weapon", inst.GUID, "swap_weapon")
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/"..skin_build..".xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage(skin_build)
		inst.AnimState:SetBank(GetSkinBank(skin_build))
		inst.AnimState:SetBuild(skin_build)	
		if dynamicweapon_skin_data[skin_build] then
			SetFxOwner(inst, owner, dynamicweapon_fx_map[skin_build] or (skin_build .. "_fx"))
		end
	else
		owner.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand3", "swap_weapon")
		inst.replica.inventoryitem:SetAtlas("images/inventoryimages/ccs_magic_wand3.xml")	--更新物品栏贴图
		inst.replica.inventoryitem:SetImage("ccs_magic_wand3")
		inst.AnimState:SetBank("ccs_magic_wand3") 		--更新地面动画
		inst.AnimState:SetBuild("ccs_magic_wand3")	
		SetFxOwner(inst, nil)
	end	
	inst:PushEvent("imagechange")
	inst.AnimState:PlayAnimation("idle")
	
end

local function ccs_cards_17_enble(inst,owner,card)
	inst:AddTag("ccs_cards_17_enble")
end

local function ccs_cards_17_close(inst,owner,card)
	inst:RemoveTag("ccs_cards_17_enble")
end

local function ccs_cards_22_enble(inst,owner,card)
	inst:AddTag("ccs_cards_22_enble")
end

local function ccs_cards_22_close(inst,owner,card)
	inst:RemoveTag("ccs_cards_22_enble")
end


local ccs_magic_wand_item = {
	-- {item = "ccs_cards_11",fn = ccs_cards_11_enble,fn2 = ccs_cards_11_close},		--火牌
	{item = "ccs_cards_15",fn = ccs_cards_15_enble,fn2 = ccs_cards_15_close},		--矢牌
	{item = "ccs_cards_12",fn = ccs_cards_12_enble,fn2 = ccs_cards_12_close},		--剑牌
	--{item = "ccs_cards_17",fn = ccs_cards_17_enble,fn2 = ccs_cards_17_close},		--双牌
	{item = "ccs_cards_22",fn = ccs_cards_22_enble,fn2 = ccs_cards_22_close},		--消牌
}

local function DuplicationCard(inst,item)
	if inst.components.container:Has(item.prefab,2) then
		return true
	end
	return false
end


local skinfx = {
	ccs_magic_wand3_skins1 = "ccs_star_fx",
	ccs_magic_wand3_skins2 = "ccs_star_fx",
	ccs_magic_wand3_skins6 = "ccs_star_fx_pink",
	ccs_magic_wand3_skins8 = "ccs_rose_fx",
	ccs_magic_wand3_skin_alxy = "ccs_magic_wand3_skin_alxy_fx",
	ccs_magic_wand3_skin_hyjl = "cane_ancient_fx",
	ccs_magic_wand3_skin_xy = "ccs_star_fx",
	ccs_magic_wand3_skin_yueguitu = "ccs_star_fx_gold",
}

local TRAIL_FLAGS = { "ccs_star_fx", 'shadowtrail' }
local function SpawnFx(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if not owner.entity:IsVisible() then
        return
    end

    local x, y, z = owner.Transform:GetWorldPosition()
    if owner.sg ~= nil and owner.sg:HasStateTag("moving") then
        local theta = -owner.Transform:GetRotation() * DEGREES
        local speed = owner.components.locomotor:GetRunSpeed() * .1
        x = x + speed * math.cos(theta)
        z = z + speed * math.sin(theta)
    end
    local mounted = owner.components.rider ~= nil and owner.components.rider:IsRiding()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        (mounted and 1 or .5) + math.random() * .5,
        4,
        function(offset)
            local pt = Vector3(x + offset.x, 0, z + offset.z)
            return map:IsPassableAtPoint(pt:Get())
                and not map:IsPointNearHole(pt)
                and #TheSim:FindEntities(pt.x, 0, pt.z, .7, TRAIL_FLAGS) <= 0
        end
    )

    if offset ~= nil then
        local fx_prefab = skinfx[inst.skinname]
        if fx_prefab then
			local oy = fx_prefab == "cane_ancient_fx" and 0 or 1.7
            SpawnPrefab(fx_prefab).Transform:SetPosition(x + offset.x, oy, z + offset.z)
        end
    end
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
local function onequip(inst, owner) --装备	
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
	if inst:HasTag("is_sword") then
		local skin_build2 
		for k,v in pairs(inst.components.container.slots) do
			if v and v.prefab == "ccs_cards_12" then
				skin_build2 = v:GetSkinBuild()
				break
			end
		end
		if skin_build2 then
			if skin_build2 == "ccs_sword_skin_yzr" then
				owner.AnimState:OverrideSymbol("swap_object", math.random() < 0.5 and skin_build2 or skin_build2 .. 1,
					"swap_weapon")
			else
				owner.AnimState:OverrideSymbol("swap_object", skin_build2, "swap_weapon")
			end
		else
			owner.AnimState:OverrideSymbol("swap_object", "ccs_sword", "swap_weapon")	
		end
		if dynamicweapon_skin_data[skin_build2] then
			SetFxOwner(inst, owner, dynamicweapon_fx_map[skin_build2] or (skin_build2 .. "_fx"))
		end
	elseif inst:HasTag("ccs_bow") then
		local skin_build3 
		for k,v in pairs(inst.components.container.slots) do
			if v and v.prefab == "ccs_cards_15" then
				skin_build3 = v:GetSkinBuild()
				break
			end
		end
		if skin_build3 then
			owner.AnimState:OverrideSymbol("swap_object", skin_build3, "swap_weapon")
            if skin_build3 == "ccs_bow_skin_rain2" then
                inst.components.weapon:SetProjectile("ccs_magicarrow_skin_heart")
            else
                inst.components.weapon:SetProjectile(GetBowProjectile(skin_build3))
            end
		else
			owner.AnimState:OverrideSymbol("swap_object", "ccs_bow", "swap_weapon")	
            inst.components.weapon:SetProjectile("ccs_bow_prj")
		end
	else
		local skin_build = inst:GetSkinBuild()
		if skin_build ~= nil then
			owner:PushEvent("equipskinneditem", inst:GetSkinName())
			owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_weapon", inst.GUID, "swap_weapon")
		else
			owner.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand3", "swap_weapon")
		end
		if dynamicweapon_skin_data[skin_build] then
			SetFxOwner(inst, owner, dynamicweapon_fx_map[skin_build] or (skin_build .. "_fx"))
		end
	end
	
	if inst.skinname ~= nil and skinfx[inst.skinname] ~= nil then
		if inst.ccs_magic_wand_fx_task == nil then
			inst.ccs_magic_wand_fx_task = inst:DoPeriodicTask(6 * FRAMES, SpawnFx, 2 * FRAMES)
		end
	end

	if inst:HasTag("snowlizifx") then
		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab('cane_candy_fx')
			inst._vfx_fx_inst.entity:AddFollower()
		end
		inst._vfx_fx_inst.entity:SetParent(owner.entity)
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
	elseif inst:HasTag("greenleaffx") then
		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab('xiaoying_leaf_fx')
			inst._vfx_fx_inst.entity:AddFollower()
		end
		inst._vfx_fx_inst.entity:SetParent(owner.entity)
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
	elseif inst:HasTag("bubblefx") then
		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab('ccs_lizifx_bubble')
			inst._vfx_fx_inst.entity:AddFollower()
		end
		inst._vfx_fx_inst.entity:SetParent(owner.entity)
		if inst:HasTag("ccs_bow") then
			inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 9, -48, 0)
		else
			inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
		end
	elseif inst:HasTag("rainbowfx") then
		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab('ccs_lizifx_dll')
			inst._vfx_fx_inst.entity:AddFollower()
		end
		inst._vfx_fx_inst.entity:SetParent(owner.entity)
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
	elseif inst:HasTag("rosefx") then
		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab('cane_rose_fx')
			inst._vfx_fx_inst.entity:AddFollower()
		end
		inst._vfx_fx_inst.entity:SetParent(owner.entity)
		inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
	end

	-- 发光
	if inst:HasTag("canlightglow") then
		CreateLight(owner)
	end
		
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	owner:ListenForEvent("onhitother",onhitother)
	for k,v in pairs(inst.components.container.slots) do
		if v then
			if v:HasTag("no_enble_card") then
				v:RemoveTag("no_enble_card")
				for a,b in pairs(ccs_magic_wand_item) do
					if v.prefab == b.item then
						if not DuplicationCard(inst,v) then						
							b.fn(inst,owner,v)
						else
							v:AddTag("ccs_qz_drop")				
							inst.components.container:DropItem(v)
						end
					end
				end
			end
		end
	end
end

local function itemget(inst,data)

	inst:DoTaskInTime(0,function()
		local owner = inst.components.inventoryitem.owner
		if owner then
			if inst.components.equippable:IsEquipped() then
				for k,v in pairs(ccs_magic_wand_item) do
					if data.item.prefab == v.item then
						if not DuplicationCard(inst,data.item) then		--没有重复卡牌就激活效果					
							v.fn(inst,owner,data.item)
						else
							data.item:AddTag("ccs_qz_drop")				--如果有重复卡牌那么重复卡牌弹出不会触发删除属性的函数
							inst.components.container:DropItem(data.item)
						end
					end
				end
			else
				--在身上直接插入卡牌，那么就不启用效果，装备时启用
				data.item:AddTag("no_enble_card")
				inst.components.talker:Say("未装备魔杖插入的卡牌效果将在装备时启用")
			end
		else
			inst.components.container:DropItem(data.item)
			inst.components.talker:Say("需要玩家装备时放入卡牌才会生效")
		end
	end)
end


local function itemlose(inst,data)

	local owner = inst.components.inventoryitem.owner 
	if inst.components.equippable:IsEquipped() and owner then
		for k,v in pairs(ccs_magic_wand_item) do
			if data.prev_item.prefab == v.item and not data.prev_item:HasTag("ccs_qz_drop") then
				v.fn2(inst,owner,data.prev_item)
			end
		end
	end
end

local function onunequip(inst, owner) --解除装备
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end	
	if inst.components.container ~= nil then
		inst.components.container:Close()
	end
	owner:RemoveEventCallback("onhitother",onhitother)
	if inst.ccs_magic_wand_fx_task ~= nil then
        inst.ccs_magic_wand_fx_task:Cancel()
        inst.ccs_magic_wand_fx_task = nil
    end
	if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
	if inst._atk_fx_inst ~= nil then
		inst._atk_fx_inst:Remove()
		inst._atk_fx_inst = nil
	end
	--检查是否存在光源实例
	if owner._ccs_light2 then
		--移除光源
		owner._ccs_light2:Remove()
		owner._ccs_light2 = nil
	end
	SetFxOwner(inst, nil)
end


local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)   --物理
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_magic_wand3")  
    inst.AnimState:SetBuild("ccs_magic_wand3")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("ccs_magic_wand3")
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -900, 0)
	inst.components.talker.colour = Vector3(.9, .4, .4)
    	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_magic_wand3")
        end
        return inst
    end
	
	CCSAPI.CcsItemInit(inst)
	inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.25
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_magic_wand3")
    inst:ListenForEvent("itemget", itemget)
	inst:ListenForEvent("itemlose", itemlose)
	
    inst:AddComponent("weapon") 
    inst.components.weapon:SetDamage(51)
	inst.components.weapon:SetOnAttack(atk)
	inst.components.weapon:SetRange(4)
	
	inst:AddComponent("ccs_card_level")

    inst:AddComponent("inspectable") --可检查
		
    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_magic_wand3.xml"
	
	MakeHauntableLaunchAndPerish(inst) --作祟相关
    return inst
end 
  

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_firestaff_meteor")
    inst.AnimState:SetBuild("lavaarena_firestaff_meteor")
	--inst.AnimState:SetAddColour(0,0,1,0)
    inst.AnimState:PlayAnimation("crash")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("notarget")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.AttackArea = function(inst, attacker, weapon)
        inst.attacker = attacker
        inst.owner = weapon
    end
	
	inst:ListenForEvent("animover", function(inst)
		inst:DoTaskInTime(FRAMES*3, function(inst)
			SpawnPrefab("ccs_splash"):SetPosition(inst:GetPosition())
			local x, y, z = inst:GetPosition():Get()
			local dmg = inst.damage or 40
			local ents = TheSim:FindEntities(x, y, z, 4, {"_combat","_health"}, { "INLIMBO", "companion", "wall", "abigail", "shadowminion", "player", "playerghost","erd_doll","FX" })
			for _,ent in ipairs(ents) do
				if ent.components and ent.components.health and not ent.components.health:IsDead() and
				   ent.components.combat and
				   not (ent.components.follower and ent.components.follower.leader and ent.components.follower.leader:HasTag("player")) and
                   not (ent.components.inventoryitem and ent.components.inventoryitem:GetGrandOwner() == inst.attacker)
				then
					if inst.attacker and inst.attacker:IsValid() then 
						CCSUTL.ttlrealhealth(inst.attacker,ent,- dmg,inst.attacker.prefab,inst.attacker)
					end
				end
			end
			inst:Remove()
		end)
	end)

    return inst
end

local function fn4()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_fire_fx")
    inst.AnimState:SetBuild("lavaarena_fire_fx")
    inst.AnimState:PlayAnimation("firestaff_ult")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(1)
	--inst.AnimState:SetAddColour(0,0,1,0)
	--inst.AnimState:SetMultColour(100/255,100/255,1,100/255)
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.persists = false

    inst.SetPosition = function(inst, pos)
		inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/meteor_strike")
		inst.Transform:SetPosition(pos:Get())
		SpawnPrefab("ccs_splashbase"):SetPosition(pos)
	end
	
	inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function fn5()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_fire_fx")
    inst.AnimState:SetBuild("lavaarena_fire_fx")
    inst.AnimState:PlayAnimation("firestaff_ult_projection")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
	--inst.AnimState:SetAddColour(0,0,1,0)
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.persists = false

    inst.SetPosition = function(inst, pos)
		inst.Transform:SetPosition(pos:Get())
	end
	
	inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function fn6()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_fire_fx")
    inst.AnimState:SetBuild("lavaarena_fire_fx")
    inst.AnimState:PlayAnimation("firestaff_ult_hit")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(1)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.persists = false

    inst.SetTarget = function(inst, target)
		inst.Transform:SetPosition(target:GetPosition():Get())
		local scale = target:HasTag("minion") and .5 or (target:HasTag("largecreature") and 1.3 or .8)
		inst.AnimState:SetScale(scale, scale)
	end
	
	inst:ListenForEvent("animover", inst.Remove)

    return inst
end


return Prefab( "ccs_magic_wand3", fn, assets),
		Prefab("ccs_meteor", fn3, assets2, {"ccs_splash","ccs_splashhit"}),
		Prefab("ccs_splash", fn4, assets2, {"ccs_splashbase"}),
		Prefab("ccs_splashbase", fn5, assets2),
		Prefab("ccs_splashhit", fn6, assets2)

