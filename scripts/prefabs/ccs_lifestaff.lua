local assets =
{
    Asset("ANIM", "anim/ccs_lifestaff.zip"),  --地上的动画
	Asset("ATLAS", "images/inventoryimages/ccs_lifestaff.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_lifestaff.tex"),
}

local function GetDeployItem(owner, prefab)

    local inventory = owner.components.inventory
    
    local active_item = inventory and inventory:GetActiveItem()
    if active_item and active_item.prefab == prefab then
        return active_item
    end

    local body_item = inventory:GetEquippedItem(EQUIPSLOTS.BODY)  -- 身体部位的装备物品
    local back_item = inventory:GetEquippedItem(EQUIPSLOTS.BACK)  -- 背部部位的装备物品
    local hands_item = inventory:GetEquippedItem(EQUIPSLOTS.HANDS)  -- 手持部位的装备物品

    local hands_container = hands_item and hands_item.components.container
    if hands_container then
        for slot, item in pairs(hands_container.slots or {}) do
            if item and item.prefab == prefab then
                return item
            end
        end
    end
    
    local backpack = (back_item and back_item.components.container) or (body_item and body_item.components.container)
    
    for _, inv in pairs(backpack and {inventory, backpack} or {inventory}) do
        for slot, item in pairs(inv.itemslots or inv.slots or {}) do
            if item and item.prefab == prefab then
                return item
            end
        end
    end
end

--批量种植的函数
local function plant(deployer, prefab, act_pos, rotation,framplant)
    local item = GetDeployItem(deployer,prefab) 
    if  not item or item.components.deployable == nil then 
        return false
    end
    local deploy = item.components.deployable
    if  framplant  then
        local container = deployer.components.inventory or deployer.components.container 
        local obj = container ~= nil and container:RemoveItem(item) or nil
        if obj ~= nil then
            if  obj.components.deployable:Deploy(act_pos, deployer, rotation) then 
                return true
            else
                container:GiveItem(obj) 
            end
        end
    else
        if  deploy.keep_in_inventory_on_deploy then 
            return deploy:Deploy(act_pos, deployer, rotation) 
        else
            local container = deployer.components.inventory or deployer.components.container
            local obj = container ~= nil and container:RemoveItem(item) or nil
            if obj ~= nil then
                if  obj.components.deployable:Deploy(act_pos, deployer, rotation) then
                    return true
                else
                    container:GiveItem(obj)
                end
            end
        end
    end
    return false
end
local function plantsoil(doer, target, prefab)
    local item = GetDeployItem(doer,prefab) 
    if  not item or item.components.deployable == nil then 
        return false
    end
    local container = doer.components.inventory or doer.components.container 
    local seed = container ~= nil and container:RemoveItem(item) or nil
    if seed ~= nil then
        if seed.components.quagmire_plantable ~= nil then
            if seed.components.quagmire_plantable:Plant(target, doer) then
            return true
        end
        elseif seed.components.farmplantable ~= nil then
            if seed.components.farmplantable:Plant(target, doer) then
                return true
            end
        end
        doer.components.inventory:GiveItem(seed)
    end
end

--植树
local function Till(doer,x1,z1)
    local spacing= 4/3
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
end

local function digspell(inst, target, pos, doer)
    if  target and target:IsValid() then
        pos = target:GetPosition()
    end
    if not pos then
        return
    end
    --挖树根
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 16, {"stump", "DIG_workable"})
    while (#ents> 0) do
        local v = table.remove(ents,1)
        doer:StartThread(function ()
            if v and v.components.workable then
                v.components.workable:WorkedBy(doer, 1)
            end
        end)
    end

    --敲巨大作物
    local ents1 = TheSim:FindEntities(pos.x, pos.y, pos.z, 6, nil, {"stale", "spoiled"},{"oversized_veggie","heavy"})
    while (#ents1 > 0) do
        local v = table.remove(ents1,1)
        doer:StartThread(function ()
            if v and v.components.workable then
                v.components.workable:WorkedBy(doer, 1)
            end
        end)
    end
end

local function plantspell(inst, target, pos, doer)
    if  target and target:IsValid() then
        pos = target:GetPosition()
    end
    if not pos then
        return
    end
    local tile_x, tile_y, tile_z = TheWorld.Map:GetTileCenterPoint(pos.x, 0, pos.z)
    local range = 1
    local container = inst.components.container
    if container ~= nil then
        local firstItem = container:GetItemInSlot(1)

        --检查物品栏第一个物品是否可部署
        if firstItem ~= nil and firstItem.components.deployable ~= nil then
            --如果物品是农作物种子
            for x = tile_x - 4 * range, tile_x + 4 * range, 4 do
                for z = tile_z - 4 * range, tile_z + 4 * range, 4 do
                    if  TheWorld.Map:GetTileAtPoint(x, 0, z) == 47  then
                        -- Till(doer,x,z)
                        local ents = TheSim:FindEntities(x,0,z,2,{"soil"})
                        for _, v in ipairs(ents) do
                            local vx,_,vz = v.Transform:GetWorldPosition()
                            if  math.abs(vx - x) <= 2 and math.abs(vz - z) <=2 then
                                plantsoil(doer,v,firstItem.prefab)

                            end
                        end
                    else
                        if  firstItem.components.farmplantable then
                            for offset_x = -1.33, 1.33, 1.33 do
                                for offset_z = -1.33, 1.33, 1.33 do

                                    plant(doer, firstItem.prefab, Vector3(x + offset_x, 0, z + offset_z), 0,true)


                                end
                            end
                        else
                            local spacing = firstItem.components.deployable:DeploySpacingRadius() or 2
                            if  spacing == 3.2 or spacing > 4 then
                                spacing = 4
                            end
                            for offset_x = x - 2 + spacing / 2, x + 2 - spacing / 2, spacing do
                                for offset_z = z - 2 + spacing / 2,z + 2 - spacing / 2, spacing do

                                    plant(doer, firstItem.prefab, Vector3(offset_x, 0, offset_z), 0)

                                end
                            end
                        end
                    end
                end
            end
            
        else
            for x = tile_x - 4 * range, tile_x + 4 * range, 4 do
                for z = tile_z - 4 * range, tile_z + 4 * range, 4 do
                    if  TheWorld.Map:GetTileAtPoint(x, 0, z) == 47 then
                        Till(doer,x,z)
             
                    end
                end
            end

        end

        local Item = container:GetItemInSlot(1)
        if not Item then
            if inst.components.spellcaster then
                inst.components.spellcaster:SetSpellFn(digspell)
            end  
        end
  
    end
end


local PLANTS_RANGE = 1
local MAX_PLANTS = 18

local PLANTFX_TAGS = { "wormwood_plant_fx" }
local function PlantTick(inst)
    if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    if #TheSim:FindEntities(x, y, z, PLANTS_RANGE, PLANTFX_TAGS) < MAX_PLANTS then
        local map = TheWorld.Map
        local pt = Vector3(0, 0, 0)
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * PLANTS_RANGE,
            3,
            function(offset)
                pt.x = x + offset.x
                pt.z = z + offset.z
                return map:CanPlantAtPoint(pt.x, 0, pt.z)
                    and #TheSim:FindEntities(pt.x, 0, pt.z, .5, PLANTFX_TAGS) < 3
                    and map:IsDeployPointClear(pt, nil, .5)
                    and not map:IsPointNearHole(pt, .4)
            end
        )
        if offset then
            local plant = SpawnPrefab("wormwood_plant_fx")
            plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
            --randomize, favoring ones that haven't been used recently
            local rnd = math.random()
            rnd = table.remove(inst.plantpool, math.clamp(math.ceil(rnd * rnd * #inst.plantpool), 1, #inst.plantpool))
            table.insert(inst.plantpool, rnd)
            plant:SetVariation(rnd)
        end
    end
end

local function onequip(inst, owner) --装备
local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
		owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_weapon", inst.GUID, "swap_weapon")
	else
        owner.AnimState:OverrideSymbol("swap_object", "ccs_lifestaff", "swap_weapon")
	end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end

    --植物人开花行走特效
    owner.planttask = nil
    owner.plantpool = { 1, 2, 3, 4 }
    for i = #owner.plantpool, 1, -1 do
        --randomize in place
        table.insert(owner.plantpool, table.remove(owner.plantpool, math.random(i)))
    end

    if not owner.planttask then
        owner.planttask = owner:DoPeriodicTask(.25, PlantTick)
    end

end

local function onunequip(inst, owner) --解除装备
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end

    --移除行走特效
    if owner.planttask then
        owner.planttask:Cancel()
        owner.planttask = nil
    end

end

local function itemget(inst, data)

    if data.item then
        inst:DoTaskInTime(0.1,function ()
            inst.components.spellcaster:SetSpellFn(plantspell)
        end)
    end

end

local function itemlose(inst, data)

    inst.components.spellcaster:SetSpellFn(digspell)

end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75) --漂浮

    inst.AnimState:SetBank("ccs_lifestaff")  --地上动画
    inst.AnimState:SetBuild("ccs_lifestaff")
    inst.AnimState:PlayAnimation("idle")


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            if inst.replica.container then
                inst.replica.container:WidgetSetup('ccs_lifestaff')
            end
        end
        return inst
    end
    CCSAPI.CcsItemInit(inst)
    inst:AddTag("meteor_protection") --防止被流星破坏
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分

    inst:AddComponent("weapon") --增加武器组件 有了这个才可以打人
    inst.components.weapon:SetDamage(8) --设置伤害
    inst.components.weapon:SetRange(6)

    inst:ListenForEvent('itemget', itemget)
    inst:ListenForEvent('itemlose', itemlose)

    inst:AddComponent('container')
    inst.components.container:WidgetSetup('ccs_lifestaff')

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_lifestaff.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.5


    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(digspell)
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.can_cast_fn = function ()
        return true
    end
    inst.components.spellcaster.veryquickcast = true


    return inst
end

return Prefab("ccs_lifestaff", fn, assets)