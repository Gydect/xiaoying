 local assets =
{
    Asset("ANIM", "anim/ui_ccs_spbox.zip"),
    Asset("ANIM", "anim/ccs_spbox.zip"),                         --动画
    Asset("IMAGE", "images/inventoryimages/ccs_spbox.tex"),      --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ccs_spbox.xml"),
}
local function compareItems(a, b)
    local aIsFarmPlant = a:HasTag("deployedfarmplant")
    local bIsFarmPlant = b:HasTag("deployedfarmplant")

    if aIsFarmPlant and not bIsFarmPlant then
        return true
    end

    if bIsFarmPlant and not aIsFarmPlant then
        return false
    end

    -- 如果两者都是或都不是农场植物，则保持原有顺序
    return false
end
local function sortContainerItems(inst)
    if inst and inst.components.container then
        local items = {}
        for k, v in pairs(inst.components.container.slots) do
            local item = inst.components.container:RemoveItemBySlot(k, true)
            if item then
                table.insert(items, item)
            end
        end
        table.sort(items, compareItems)

        for i = 1, #items do
            if items[i] then
                inst.components.container:GiveItem(items[i])
            end
            
        end
    end
end
local function collect(inst, doer)
    if not doer then
        return
    end

    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 20,nil,
        { "INLIMBO", "NOCLICK", "catchable", "fire", "notdevourable", "singingshell" })
    for k, v in ipairs(ents) do
        -- 采集
        if v:HasTag("pickable") and v:HasTag("farm_plant") and v.components.pickable then
            v.components.pickable:PickToContainer(inst)
        end
    end

    local ents2 = TheSim:FindEntities(x, y, z, 20, { "_inventoryitem" },
        { "INLIMBO", "NOCLICK", "catchable", "fire", "notdevourable", "singingshell" })
    for k, v in ipairs(ents2) do
        -- 拾取
        if v and v:IsValid() and v.components.inventoryitem ~= nil and
            v.components.inventoryitem.canbepickedup and
            v.components.inventoryitem.cangoincontainer and
            not v:IsInLimbo()
            and not (inst.components.health and inst.components.health:IsDead())
            and not v.components.inventoryitem:IsHeld()
            and v.replica.inventoryitem ~= nil and inst.components.container:CanTakeItemInSlot(v) then
            inst.components.container:GiveItem(v)
        end
    end
    --敲巨大作物
    local ents1 = TheSim:FindEntities(x, y, z, 20, nil, { "stale", "spoiled" }, { "oversized_veggie", "heavy" })
    while (#ents1 > 0) do
        local v = table.remove(ents1, 1)
        doer:StartThread(function()
            if v and v.components.workable and v:HasTag("waxable") then
                v.components.workable:WorkedBy(doer, 1)
            end
        end)
    end
    sortContainerItems(inst)

end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    --inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_spbox")
    inst.AnimState:SetBuild("ccs_spbox")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("ccs_spbox")

    inst.entity:SetPristine()

    inst._state = net_smallbyte(inst.GUID, "ccs_spbox._state", "container_change")
    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("ccs_spbox")
        end
        return inst
    end
    inst._state:set(1)


    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_spbox")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container:EnableInfiniteStackSize(true)

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(-1)

    inst.collect = collect

    return inst
end
return Prefab("ccs_spbox", fn, assets),
MakePlacer("ccs_spbox_placer", "ccs_spbox", "ccs_spbox", "idle")
