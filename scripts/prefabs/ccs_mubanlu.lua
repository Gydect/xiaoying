local assets =
{
    Asset("ATLAS", "images/inventoryimages/ccs_mubanlu.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_mubanlu.tex"),
    Asset("ANIM", "anim/ccs_mubanlu.zip"),
}

local ttlmod = require("utils/ccs_modenable")

local function onhammered_regular(inst, worker)
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

    --inst.Transform:SetScale(1.1, 1.1, 1.1)

    inst.AnimState:SetBank("ccs_mubanlu")
    inst.AnimState:SetBuild("ccs_mubanlu")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()

    inst:AddTag("ccs_mubanlu")
    inst:AddTag("DECOR")
    inst:AddTag("rotatableobject")
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
    inst.components.workable:SetOnFinishCallback(onhammered_regular)

    -- MakeHauntableWork(inst)
    -- MakeLargeBurnable(inst, nil, nil, true)
    -- MakeMediumPropagator(inst)

    --inst.OnTheoneRemove = onhammered_common

    return inst
end


return  Prefab("ccs_mubanlu", fn, assets),
        MakePlacer("ccs_mubanlu_placer", "ccs_mubanlu", "ccs_mubanlu", "idle",true, nil, nil, nil, 15)
