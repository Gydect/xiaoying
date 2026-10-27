local assets =
{
    Asset("ATLAS", "images/inventoryimages/ccs_throne.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_throne.tex"),
    Asset("ANIM", "anim/ccs_throne.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_throne2.xml"),     --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_throne2.tex"),
    Asset("ANIM", "anim/ccs_throne2.zip"),
}

local ttlmod = require("utils/ccs_modenable")

local function onhammered_common(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(0.9, 0.9, 0.9)

    inst.AnimState:SetBank("ccs_throne")
    inst.AnimState:SetBuild("ccs_throne")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()

    inst:AddTag("ccs_throne")
    inst:AddTag("DECOR")
    -- inst:AddTag("NOCLICK")
    -- inst:AddTag("NOBLOCK")

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    if ttlmod:tbatEnable() then 
        inst:AddComponent("tbat_com_universal_baton_data")
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered_common)

    -- MakeHauntableWork(inst)
    -- MakeLargeBurnable(inst, nil, nil, true)
    -- MakeMediumPropagator(inst)

    inst.OnTheoneRemove = onhammered_common

    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(0.9, 0.9, 0.9)

    inst.AnimState:SetBank("ccs_throne2")
    inst.AnimState:SetBuild("ccs_throne2")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.entity:SetPristine()

    inst:AddTag("ccs_throne")
    inst:AddTag("DECOR")
    -- inst:AddTag("NOCLICK")
    -- inst:AddTag("NOBLOCK")

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    if ttlmod:tbatEnable() then 
        inst:AddComponent("tbat_com_universal_baton_data")
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered_common)

    -- MakeHauntableWork(inst)
    -- MakeLargeBurnable(inst, nil, nil, true)
    -- MakeMediumPropagator(inst)

    inst.OnTheoneRemove = onhammered_common

    return inst
end


return  Prefab("ccs_throne", fn, assets),
        MakePlacer("ccs_throne_placer", "ccs_throne", "ccs_throne", "idle", true, nil, nil, 0.9),
    Prefab("ccs_throne2", fn2, assets),
    MakePlacer("ccs_throne2_placer", "ccs_throne2", "ccs_throne2", "idle", true, nil, nil, 0.9)
