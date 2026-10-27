local assets=
{
	Asset("ANIM", "anim/ccs_magic_wand1.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_magic_wand1.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_magic_wand1.xml"),
}

local skin_build_map = {
    ccs_magic_wand1_skin_snx = "ccs_magic_wand2_snx",
    ccs_magic_wand1_skin_yzy = "ccs_magic_wand2_yzy",
}

local function onequip(inst, owner) --装备	
	local skin_build = inst:GetSkinBuild()
	local visual_skin_build = skin_build_map[skin_build] or skin_build
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
		owner.AnimState:OverrideItemSkinSymbol("swap_object", visual_skin_build, "swap_weapon", inst.GUID, "swap_weapon")
	else
		 owner.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand1", "swap_weapon")
	end

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

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

local function onunequip(inst, owner) --解除装备
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end	
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)   --物理
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_magic_wand1")  
    inst.AnimState:SetBuild("ccs_magic_wand1")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("ccs_magic_wand1")
	inst:AddTag("HAMMER_tool")
	inst:AddTag("DIG_tool")
    	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	CCSAPI.CcsItemInit(inst)
	
	inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
    inst:AddComponent("inspectable") --可检查
		
    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_magic_wand1.xml"
      
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)  --锤子
	inst.components.tool:SetAction(ACTIONS.DIG)     --铲子
    inst.components.tool:SetAction(ACTIONS.CHOP,5)  --砍树
    inst.components.tool:SetAction(ACTIONS.MINE,6)   --挖矿
	inst.components.tool:SetAction(ACTIONS.NET)  --捕虫网
	inst.components.tool:EnableToughWork(true)
	
	inst:AddComponent("weapon") 
    inst.components.weapon:SetDamage(10)

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
	
	MakeHauntableLaunchAndPerish(inst) --作祟相关
    return inst
end 
    
return Prefab( "ccs_magic_wand1", fn, assets)
