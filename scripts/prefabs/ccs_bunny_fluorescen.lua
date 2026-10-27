local assets =
{
    Asset("ANIM", "anim/ccs_bunny_fluorescen.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_bunny_fluorescen.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_bunny_fluorescen.tex"),

    Asset("ANIM", "anim/ccs_bunny_fluorescen_fruit.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_bunny_fluorescen_fruit.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_bunny_fluorescen_fruit.tex"),

    Asset("ANIM", "anim/ccs_bunny_fluorescen_seed.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_bunny_fluorescen_seed.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_bunny_fluorescen_seed.tex")
}
local prefabs = {

}

local function onregenfn(inst)
    inst.Light:Enable(false)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle_full")
end

local function makefullfn(inst)
    inst.Light:Enable(true)
    inst.AnimState:PlayAnimation("idle_full")
end

local function onpickedfn(inst)
    inst.Light:Enable(false)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_lightbulb")
    inst.AnimState:PlayAnimation("idle")
end

local function makeemptyfn(inst)
    inst.Light:Enable(false)
    inst.AnimState:PlayAnimation("idle")
end
local function dig(inst, worker)
	inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
	if inst.components.pickable:CanBePicked() then
		inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
	end
	inst:Remove()
end
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("ccs_bunny_fluorescen")
    MakeInventoryPhysics(inst, nil, 0.7)
    inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.MEDIUM] / 2)

    inst.Light:SetFalloff(0.6)
    inst.Light:SetIntensity(0.6)
    inst.Light:SetRadius(2)
    inst.Light:SetColour(200/255, 200/255, 200/255,.8)
    inst.Light:Enable(true)

    inst.AnimState:SetBank("ccs_bunny_fluorescen")
    inst.AnimState:SetBuild("ccs_bunny_fluorescen")
    inst.AnimState:PlayAnimation("idle")

    -- AddDefaultRippleSymbols(inst, true, false)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("pickable")
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable:SetUp("ccs_bunny_fluorescen_fruit", TUNING.TOTAL_DAY_TIME * 3, 1)

    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig)
	inst.components.workable:SetWorkLeft(1)

    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")


    MakeHauntableIgnite(inst)

    return inst
end

local item_weights = {
    {prefab = "purplegem", weight = 2},
    {prefab = "yellowgem", weight = 2},
    {prefab = "bluegem", weight = 2},
    {prefab = "redgem", weight = 2},
    {prefab = "greengem", weight = 2},
    {prefab = "orangegem", weight = 2},
    {prefab = "opalpreciousgem", weight = 1},
    {prefab = "rocks", weight = 18},
    {prefab = "flint", weight = 10},
    {prefab = "nitre", weight = 8},
    {prefab = "thulecite_pieces", weight = 4},
    {prefab = "townportaltalisman", weight = 4},
    {prefab = "moonrocknugget", weight = 4},
    {prefab = "dreadstone", weight = 2},
    {prefab = "purebrilliance", weight = 2},
}

local function on_mine(inst, worker, workleft, workdone)
    local stack_size = inst.components.stackable and inst.components.stackable:StackSize() or 1
    local num_fruits_worked = math.clamp(math.ceil(workdone / TUNING.ROCK_FRUIT_MINES), 1, stack_size)


    -- inst.AnimState:PlayAnimation("idle")

    -- 计算总权重
    local total_weight = 0
    for _, item in ipairs(item_weights) do
        total_weight = total_weight + item.weight
    end


    local function select_item()
        local roll = math.random() * total_weight
        for _, item in ipairs(item_weights) do
            if roll < item.weight then
                return item.prefab
            else
                roll = roll - item.weight
            end
        end
    end


    local spawned_prefabs = {}
    for _ = 1, num_fruits_worked do
        local selected_item = select_item()
        spawned_prefabs[selected_item] = (spawned_prefabs[selected_item] or 0) + 1
    end


    for prefab, count in pairs(spawned_prefabs) do
        local i = 1
        while i <= count do
            local loot = SpawnPrefab(prefab)
            local room = loot.components.stackable ~= nil and loot.components.stackable:RoomLeft() or 0
            if room > 0 then
                local stacksize = math.min(count - i, room) + 1
                loot.components.stackable:SetStackSize(stacksize)
                i = i + stacksize
            else
                i = i + 1
            end
            LaunchAt(loot, inst, worker, -1.8, 0.5, nil, 65)
        end
    end


    local top_stack_item = inst.components.stackable:Get(num_fruits_worked)
    top_stack_item:Remove()
end



local function stack_size_changed(inst, data)
    if data ~= nil and data.stacksize ~= nil and inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(data.stacksize * TUNING.ROCK_FRUIT_MINES)
    end
end
local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst, nil, 0.7)
    inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.MEDIUM] / 2) --bullkelp_root deployspacing/2

    inst.AnimState:SetBank('ccs_bunny_fluorescen_fruit')
    inst.AnimState:SetBuild('ccs_bunny_fluorescen_fruit')
    inst.AnimState:PlayAnimation('idle')


    inst:AddTag('ccs_bunny_fluorescen_fruit')

    MakeInventoryFloatable(inst, 'small', 0.1, 0.8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end



    inst:AddComponent('inventoryitem')
    inst.components.inventoryitem.atlasname = 'images/inventoryimages/ccs_bunny_fluorescen_fruit.xml'

    inst:AddComponent('inspectable')
    inst:AddComponent('stackable')
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCK_FRUIT_MINES * inst.components.stackable.stacksize)
    --inst.components.workable:SetOnFinishCallback(on_mine)
    inst.components.workable:SetOnWorkCallback(on_mine)

    inst:ListenForEvent("stacksizechange", stack_size_changed)

    MakeHauntableLaunch(inst)

    return inst
end

local function ondeploy(inst, pt, deployer)
    local plant = SpawnPrefab("ccs_bunny_fluorescen")
    if plant ~= nil then
        plant.Transform:SetPosition(pt:Get())
        inst.components.stackable:Get():Remove()
        --plant.components.pickable:OnTransplant() -- bullkelp does not suffer from transplant sickness
        plant.components.pickable:MakeEmpty()
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
        end
    end
end
local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank('ccs_bunny_fluorescen_seed')
    inst.AnimState:SetBuild('ccs_bunny_fluorescen_seed')
    inst.AnimState:PlayAnimation('idle')


    inst:AddTag('ccs_bunny_fluorescen_seed')
    inst:AddTag("deployedplant")

    MakeInventoryFloatable(inst, 'small', 0.1, 0.8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end



    inst:AddComponent('inventoryitem')
    inst.components.inventoryitem.atlasname = 'images/inventoryimages/ccs_bunny_fluorescen_seed.xml'

    inst:AddComponent('inspectable')
    inst:AddComponent('stackable')
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
    inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ccs_bunny_fluorescen", fn, assets),
       Prefab("ccs_bunny_fluorescen_fruit", fn1, assets),
       Prefab("ccs_bunny_fluorescen_seed", fn2, assets),
       MakePlacer("ccs_bunny_fluorescen_seed_placer", "ccs_bunny_fluorescen", "ccs_bunny_fluorescen", "idle")