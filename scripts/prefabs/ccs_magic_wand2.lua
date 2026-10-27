local assets=
{
	Asset("ANIM", "anim/ccs_magic_wand2.zip"),  --动画文件
	Asset("ANIM", "anim/ccs_magic_wand3.zip"),
	Asset("ANIM", "anim/ccs_magic_wand2_snxopen.zip"),
	Asset("ANIM", "anim/ccs_magic_wand2_yzyopen.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_magic_wand2.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_magic_wand2.xml"),
}

local CCSUTL = require("utils/ccs_wanly_utils")


local dynamicweapon_skin_data = {
	ccs_magic_wand2_skin_yingcao = true
}

local open_skin_build = {
    ccs_magic_wand2_bwb = "ccs_magic_wand2_bwbopen",
    ccs_magic_wand2_snx = "ccs_magic_wand2_snxopen",
    ccs_magic_wand2_yzy = "ccs_magic_wand2_yzyopen",
}

local function ApplyWand2Symbol(inst, owner, skin_build, is_open)
    if skin_build ~= nil then
        owner.AnimState:OverrideItemSkinSymbol(
            "swap_object",
            is_open and open_skin_build[skin_build] or skin_build,
            "swap_weapon",
            inst.GUID,
            "swap_weapon"
        )
    else
        owner.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand2", "swap_weapon")
    end
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

local function onequip(inst, owner) --装备	
	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
	end
    ApplyWand2Symbol(inst, owner, skin_build, inst:HasTag("enble_spell"))
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if dynamicweapon_skin_data[skin_build] then
        SetFxOwner(inst, owner, skin_build .. "_fx")
    end
    if inst:HasTag("snowlizifx") then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab('cane_candy_fx')
            inst._vfx_fx_inst.entity:AddFollower()
        end
        inst._vfx_fx_inst.entity:SetParent(owner.entity)
        inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
    elseif inst:HasTag("harlequinlizifx") then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab('cane_harlequin_fx')
            inst._vfx_fx_inst.entity:AddFollower()
        end
        inst._vfx_fx_inst.entity:SetParent(owner.entity)
        inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, 'swap_object', 0, -220, 0)
    elseif inst:HasTag("victorianfx") then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab('cane_victorian_fx')
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
end
--ThePlayer.AnimState:OverrideSymbol("card_fx", "ccs_spell_anim", "card_fx") ThePlayer.AnimState:SetDeltaTimeMultiplier(.5) ThePlayer.AnimState:PlayAnimation("ccs_spell_pre")
local function onunequip(inst, owner) --解除装备
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end	
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    SetFxOwner(inst, nil)
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
end

--[[local INITIAL_LAUNCH_HEIGHT = 0.1
local SPEED = 8
local function launch_away(inst, position)
    local ix, iy, iz = inst.Transform:GetWorldPosition()
    inst.Physics:Teleport(ix, iy + INITIAL_LAUNCH_HEIGHT, iz)

    local px, py, pz = position:Get()
    local angle = (180 - inst:GetAngleToPoint(px, py, pz)) * DEGREES
    local sina, cosa = math.sin(angle), math.cos(angle)
    inst.Physics:SetVel(SPEED * cosa, 4 + SPEED, SPEED * sina)
end

local function do_water_explosion_effect(inst, affected_entity, owner, position)
    if affected_entity.components.health then
        local ae_combat = affected_entity.components.combat
        if ae_combat then
            ae_combat:GetAttacked(owner, TUNING.TRIDENT.SPELL.DAMAGE, inst)
        else
            affected_entity.components.health:DoDelta(-TUNING.TRIDENT.SPELL.DAMAGE, nil, inst.prefab, nil, owner)
        end
    elseif affected_entity.components.oceanfishable ~= nil then
		if affected_entity.components.weighable ~= nil then
	        affected_entity.components.weighable:SetPlayerAsOwner(owner)
		end

        local projectile = affected_entity.components.oceanfishable:MakeProjectile()

        local ae_cp = projectile.components.complexprojectile
        if ae_cp then
            ae_cp:SetHorizontalSpeed(16)
            ae_cp:SetGravity(-30)
            ae_cp:SetLaunchOffset(Vector3(0, 0.5, 0))
            ae_cp:SetTargetOffset(Vector3(0, 0.5, 0))

            local v_position = affected_entity:GetPosition()
            local launch_position = v_position + (v_position - position):Normalize() * SPEED
            ae_cp:Launch(launch_position, projectile)
        else
            launch_away(projectile, position)
        end
    elseif affected_entity.prefab == "bullkelp_plant" then
        local ae_x, ae_y, ae_z = affected_entity.Transform:GetWorldPosition()

        if affected_entity.components.pickable and affected_entity.components.pickable:CanBePicked() then
            local product = affected_entity.components.pickable.product
            local loot = SpawnPrefab(product)
            if loot ~= nil then
                loot.Transform:SetPosition(ae_x, ae_y, ae_z)
                if loot.components.inventoryitem ~= nil then
                    loot.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
                end
                if loot.components.stackable ~= nil
                        and affected_entity.components.pickable.numtoharvest > 1 then
                    loot.components.stackable:SetStackSize(affected_entity.components.pickable.numtoharvest)
                end
                launch_away(loot, position)
            end
        end

        local uprooted_kelp_plant = SpawnPrefab("bullkelp_root")
        if uprooted_kelp_plant ~= nil then
            uprooted_kelp_plant.Transform:SetPosition(ae_x, ae_y, ae_z)
            launch_away(uprooted_kelp_plant, position + Vector3(0.5*math.random(), 0, 0.5*math.random()))
        end

        affected_entity:Remove()
    elseif affected_entity.components.inventoryitem ~= nil then
        launch_away(affected_entity, position)
        affected_entity.components.inventoryitem:SetLanded(false, true)
    elseif affected_entity.waveactive then
        affected_entity:DoSplash()
    elseif affected_entity.components.workable ~= nil and affected_entity.components.workable:GetWorkAction() == ACTIONS.MINE then
        affected_entity.components.workable:WorkedBy(owner, TUNING.TRIDENT.SPELL.MINES)
    end
end

local PLANT_TAGS = {"tendable_farmplant"}
local MUST_HAVE_SPELL_TAGS = nil
local CANT_HAVE_SPELL_TAGS = {"INLIMBO", "outofreach", "DECOR"}
local MUST_HAVE_ONE_OF_SPELL_TAGS = nil
local FX_RADIUS = TUNING.TRIDENT.SPELL.RADIUS * 0.65
local COST_PER_EXPLOSION = TUNING.TRIDENT.USES / TUNING.TRIDENT.SPELL.USE_COUNT
local function create_water_explosion(inst, target, position)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner == nil then
        return
    end

    local px, py, pz = position:Get()

    -- Do gameplay effects.
    local affected_entities = TheSim:FindEntities(px, py, pz, TUNING.TRIDENT.SPELL.RADIUS, MUST_HAVE_SPELL_TAGS, CANT_HAVE_SPELL_TAGS, MUST_HAVE_ONE_OF_SPELL_TAGS)
    for _, v in ipairs(affected_entities) do
        if v:IsOnOcean(false) then
            inst:DoWaterExplosionEffect(v, owner, position)
        end
    end

    -- Spawn visual fx.
    local angle = GetRandomWithVariance(-45, 20)
    for _ = 1, 4 do
        angle = angle + 90
        local offset_x = FX_RADIUS * math.cos(angle * DEGREES)
        local offset_z = FX_RADIUS * math.sin(angle * DEGREES)
        local ox = px + offset_x
        local oz = pz - offset_z

        if TheWorld.Map:IsOceanTileAtPoint(ox, py, oz) and not TheWorld.Map:IsVisualGroundAtPoint(ox, py, oz) then
            local platform_at_point = TheWorld.Map:GetPlatformAtPoint(ox, oz)
            if platform_at_point ~= nil then
                -- Spawn a boat leak slightly further in to help avoid being on the edge of the boat and sliding off.
                local bx, by, bz = platform_at_point.Transform:GetWorldPosition()
                if bx == ox and bz == oz then
                    platform_at_point:PushEvent("spawnnewboatleak", {pt = Vector3(ox, py, oz), leak_size = "med_leak", playsoundfx = true})
                else
                    local p_to_ox, p_to_oz = VecUtil_Normalize(bx - ox, bz - oz)
                    local ox_mod, oz_mod = ox + (0.5 * p_to_ox), oz + (0.5 * p_to_oz)
                    platform_at_point:PushEvent("spawnnewboatleak", {pt = Vector3(ox_mod, py, oz_mod), leak_size = "med_leak", playsoundfx = true})
                end

                local boatphysics = platform_at_point.components.boatphysics
                if boatphysics ~= nil then
                    boatphysics:ApplyForce(offset_x, -offset_z, 1)
                end
            else
                local fx = SpawnPrefab("crab_king_waterspout")
                fx.Transform:SetPosition(ox, py, oz)
            end
        end
    end

	local x, y, z = owner.Transform:GetWorldPosition()
    for _, v in pairs(TheSim:FindEntities(x, y, z, TUNING.TRIDENT_FARM_PLANT_INTERACT_RANGE, PLANT_TAGS)) do
		if v.components.farmplanttendable ~= nil then
			v.components.farmplanttendable:TendTo(owner)
		end
	end
end
--]]

-- ==============================
-- 判断植物是否可批量采摘
-- ==============================
local function CanBatchHarvest(inst)
    if not (inst.components.pickable and inst.components.pickable:CanBePicked()) then
        return false
    end
    if inst.prefab == "flower" or inst.prefab == "tumbleweed" or inst.is_oversized or inst:HasTag("farm_plant") then
        return false
    end
    local pickable = inst.components.pickable
    if pickable.use_lootdropper_for_product then
        return inst.components.lootdropper and inst.components.lootdropper:GenerateLoot() and #inst.components.lootdropper:GenerateLoot() > 0
    else
        return pickable.product ~= nil
    end
end

local NO_DOUBLE_PREFABS = {
    moonbase = true,
    archive_switch = true,
}

local function BulkPickForCSS(owner, pos, range, double_tag)
    local x, y, z = pos:Get()
    local double = double_tag and owner:HasTag(double_tag) or false
    local multiplier = double and 2 or 1

    local pickables = TheSim:FindEntities(x, y, z, range, nil, nil, { "pickable" })
    local batch_targets = {}
    for _, v in ipairs(pickables) do
        if CanBatchHarvest(v) and not string.match(v.prefab or "", "^wx78module") and not v:HasTag("player") then
            table.insert(batch_targets, v)
        end
    end

    if #batch_targets == 0 then return end

    local products = {}
    owner:AddTag("css_magic_pick")

    for _, v in ipairs(batch_targets) do
        local real_multiplier = NO_DOUBLE_PREFABS[v.prefab] and 1 or multiplier
        local pickable = v.components.pickable
        local loot_names = {}

        if pickable.use_lootdropper_for_product and v.components.lootdropper then
            for _, loot_prefab in ipairs(v.components.lootdropper:GenerateLoot()) do
                local count = 1 * real_multiplier
                products[loot_prefab] = (products[loot_prefab] or 0) + count
                for _ = 1, count do table.insert(loot_names, loot_prefab) end
            end
        else
            local prod = pickable.product
            local num = pickable.numtoharvest or 1
            if prod then
                local total = num * real_multiplier
                products[prod] = (products[prod] or 0) + total
                for _ = 1, total do table.insert(loot_names, prod) end
            end
        end

        local oldSpawn = pickable.SpawnProductLoot
        pickable.SpawnProductLoot = function() return nil end
        pickable:Pick(owner)
        pickable.SpawnProductLoot = oldSpawn

        owner:PushEvent("picksomething", { object = v,ccsloot = loot_names })
    end

    owner:RemoveTag("css_magic_pick")

    for prefab, amount in pairs(products) do
        CCSUTL.GiveOrDropBulk(owner, prefab, amount, pos)
    end
end

-- ==============================
-- 法术函数（简化后，调用批量采摘函数）
-- ==============================
local function ccs_spell(staff, target, pos)
    if not pos then
        pos = target:GetPosition()
    end
    local x, y, z = pos:Get()
    local owner = staff.components.inventoryitem.owner
    if owner == nil then return end

    -- 批量采摘可批量植物
    BulkPickForCSS(owner, pos, 5, "ccs_picktwo")

    -- 处理剩余实体
    local ents = TheSim:FindEntities(x, y, z, 5)
    for _, v in ipairs(ents) do

        if v:HasTag("player") then 
            return
        end

        -- 跳过已批量处理的植物
        if v.components.inventoryitem ~= nil and
            v.components.inventoryitem.canbepickedup and
            v.components.inventoryitem.cangoincontainer and
            not v.components.inventoryitem:IsHeld() and v.prefab ~= "trap_fumarole" then
            SpawnPrefab("sand_puff").Transform:SetPosition(v.Transform:GetWorldPosition())
            if v.components.trap ~= nil and v.components.trap:IsSprung() then
                v.components.trap:Harvest(owner)
            else
                owner.components.inventory:GiveItem(v, nil, pos)
            end
        elseif v.components.pickable and not CanBatchHarvest(v) and not string.match(v.prefab or "", "^wx78module") and v.prefab ~= "flower" and v.components.pickable:CanBePicked() then
            v.components.pickable:Pick(owner)
            SpawnPrefab("sand_puff").Transform:SetPosition(v.Transform:GetWorldPosition())
        elseif v.components.harvestable and not string.match(v.prefab or "", "^wx78module") then
            v.components.harvestable:Harvest(owner)
        elseif v.components.dryer then
            v.components.dryer:Harvest(owner)
        elseif v.components.crop then
            v.components.crop:Harvest(owner)
        end
    end

    -- 捕鱼
    local entfish = TheSim:FindEntities(x, y, z, 5, { "oceanfishable" })
    for _, v in pairs(entfish) do
        if v and v:IsValid() and v.components.oceanfishable then
            if v.components.weighable then
                v.components.weighable:SetPlayerAsOwner(owner)
            end
            owner:PushEvent("medal_fishingcollect", { fish = v })
            local projectile = v.components.oceanfishable:MakeProjectile()
            local ae_cp = v.components.complexprojectile
            if ae_cp then
                ae_cp:SetHorizontalSpeed(16)
                ae_cp:SetGravity(-12)
                ae_cp:SetLaunchOffset(Vector3(0, 0.5, 0))
                ae_cp:SetTargetOffset(Vector3(0, 0.5, 0))
                local fx = SpawnPrefab("crab_king_waterspout")
                fx.Transform:SetPosition(v:GetPosition():Get())
                local v_position = owner:GetPosition()
                ae_cp:Launch(v_position, owner)
            end
        end
    end
end


local function onuse(inst)
	local owner = inst.components.inventoryitem.owner
	if owner then
		if inst:HasTag("enble_spell") then
			owner.components.talker:Say("关闭采集功能")
			inst.components.spellcaster.spell = nil
			inst:RemoveTag("enble_spell") 
			inst:AddTag("HAMMER_tool")
			inst:AddTag("DIG_tool")
			inst:AddComponent("fishingrod")
            inst.components.fishingrod:SetWaitTimes(1, 2)
            inst.components.fishingrod:SetStrainTimes(10, 20)
            local skin = inst:GetSkinBuild()
            if inst.components.equippable and inst.components.equippable:IsEquipped() then
                ApplyWand2Symbol(inst, owner, skin, false)
            end
		else
			owner.components.talker:Say("启用采集功能")
			inst:RemoveComponent("fishingrod")
			inst.components.spellcaster:SetSpellFn(ccs_spell)
			inst:AddTag("enble_spell")
			inst:RemoveTag("HAMMER_tool")
			inst:RemoveTag("DIG_tool")
            local skin = inst:GetSkinBuild()
            if inst.components.equippable and inst.components.equippable:IsEquipped() then
                ApplyWand2Symbol(inst, owner, skin, true)
            end
		end
	end
	return false
end

local function CastFn(doer, target, pos)
	local inst = doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if inst and inst:HasTag("ccs_magic_wand2") then
		if inst:HasTag("enble_spell") then
			return true
		end
	end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)   --物理
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_magic_wand2")  
    inst.AnimState:SetBuild("ccs_magic_wand2")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("ccs_magic_wand2")
	inst:AddTag("HAMMER_tool")
	inst:AddTag("DIG_tool")
	inst:AddTag("allow_action_on_impassable")
    	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    CCSAPI.CcsItemInit(inst)
	inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.restrictedtag = "ccs"
    inst.components.equippable.walkspeedmult = 1.25
	
    inst:AddComponent("inspectable") --可检查
		
    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_magic_wand2.xml"
      
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)  --锤子
	inst.components.tool:SetAction(ACTIONS.DIG)     --铲子
    inst.components.tool:SetAction(ACTIONS.CHOP,5)  --砍树
    inst.components.tool:SetAction(ACTIONS.MINE,6)   --挖矿
	inst.components.tool:SetAction(ACTIONS.NET)  --捕虫网
	inst.components.tool:EnableToughWork(true)
	
	inst:AddComponent("useableitem")  	
	inst.components.useableitem:SetOnUseFn(onuse) 
	
	inst:AddComponent("farmtiller")
	--local Old_Till = inst.components.farmtiller.Till
	inst.components.farmtiller.Till = function(self,pt,doer,...)
		local x1, y1, z1 = TheWorld.Map:GetTileCenterPoint(pt.x,pt.y,pt.z)
		local spacing=4/3
		for x2 = 0,2 do
			for y2 = 0,2 do
				local x3 = x1+spacing * x2-spacing
				local y3 = z1+spacing * y2-spacing
				if TheWorld.Map:CanTillSoilAtPoint(x3, 0, y3, false) then
					TheWorld.Map:CollapseSoilAtPoint(x3, 0, y3)
					SpawnPrefab("farm_soil").Transform:SetPosition(x3, 0, y3)
					if doer ~= nil then
						doer:PushEvent("tilling")
					end
				end	
			end
		end
		return true
	end
	
	--钓鱼
   	inst:AddComponent("fishingrod")
	inst.components.fishingrod:SetWaitTimes(1, 2)
	inst.components.fishingrod:SetStrainTimes(10, 20)
	
	inst:AddComponent("spellcaster")
	inst.components.spellcaster.CanCast = function() return true end 
	--inst.components.spellcaster:SetCanCastFn(CastFn)
    inst.components.spellcaster.canuseontargets = true
	inst.components.spellcaster.quickcast = true
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true
    inst.components.spellcaster:SetSpellFn(ccs_spell)
	
	inst:AddComponent("weapon") 
    inst.components.weapon:SetDamage(10)
	
	--inst.DoWaterExplosionEffect = do_water_explosion_effect
	
	MakeHauntableLaunchAndPerish(inst) --作祟相关
    return inst
end 
    
return Prefab( "ccs_magic_wand2", fn, assets)
