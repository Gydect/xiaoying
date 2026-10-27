local assets =
{
    Asset("ATLAS", "images/inventoryimages/ccs_throne_flower.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_throne_flower.tex"),
    Asset("ANIM", "anim/ccs_throne_flower.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_throne_flower_skin1.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_throne_flower_skin1.tex"),
    Asset("ANIM", "anim/ccs_throne_flower_skin1.zip"),
}



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

local function onhammered_regular(inst, worker)
    onhammered_common(inst, worker)
    TheWorld:PushEvent("onthronedestroyed", {throne = inst})
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- inst.Transform:SetScale(0.9, 0.9, 0.9)

    inst.AnimState:SetBank("ccs_throne_flower")
    inst.AnimState:SetBuild("ccs_throne_flower")
    inst.AnimState:PlayAnimation("idle")

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

    CCSAPI.CcsItemInit(inst)

    -- inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

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
CCSAPI.MakeItemSkinDefaultImage('ccs_throne_flower', 'images/inventoryimages/ccs_throne_flower.xml', 'ccs_throne_flower')
CCSAPI.MakeItemSkin(
    'ccs_throne_flower',
    'ccs_throne_flower_big',
    {
        name = "花朵地毯（大）",
        atlas = "images/inventoryimages/ccs_throne_flower.xml",
        image = "ccs_throne_flower",
        build = "ccs_throne_flower",
        bank =  "ccs_throne_flower",
        basebuild = "ccs_throne_flower",
        basebank =  "ccs_throne_flower",
        clear_fn = function (inst)
            inst.Transform:SetScale(1,1,1)
        end,
        init_fn = function (inst)
            inst.Transform:SetScale(1.35,1.35,1.35)
        end,
    }
)
CCSAPI.MakeItemSkin(
    'ccs_throne_flower',
    'ccs_throne_flower_skin1',
    {
        name = "紫色地毯",
        atlas = "images/inventoryimages/ccs_throne_flower_skin1.xml",
        image = "ccs_throne_flower_skin1",
        build = "ccs_throne_flower_skin1",
        bank =  "ccs_throne_flower",
        basebuild = "ccs_throne_flower",
        basebank =  "ccs_throne_flower",
    }
)
CCSAPI.MakeItemSkin(
    'ccs_throne_flower',
    'ccs_throne_flower_skin1big',
    {
        name = "紫色地毯（大）",
        atlas = "images/inventoryimages/ccs_throne_flower_skin1.xml",
        image = "ccs_throne_flower_skin1",
        build = "ccs_throne_flower_skin1",
        bank =  "ccs_throne_flower",
        basebuild = "ccs_throne_flower",
        basebank =  "ccs_throne_flower",
        clear_fn = function (inst)
            inst.Transform:SetScale(1,1,1)
        end,
        init_fn = function (inst)
            inst.Transform:SetScale(1.35,1.35,1.35)
        end,
    }
)

return  Prefab("ccs_throne_flower", fn, assets),
        MakePlacer("ccs_throne_flower_placer", "ccs_throne_flower", "ccs_throne_flower", "idle", true)