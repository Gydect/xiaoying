local assets =
{
    Asset("ATLAS", "images/inventoryimages/ccs_liushuhuatan.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_liushuhuatan.tex"),
    Asset("ANIM", "anim/ccs_liushuhuatan.zip"),
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

    inst.AnimState:SetBank("ccs_liushuhuatan")
    inst.AnimState:SetBuild("ccs_liushuhuatan")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()

    inst:AddTag("ccs_throne")
    inst:AddTag("DECOR")
    inst:AddTag("rotatableobject")
    -- inst:AddTag("NOCLICK")
    -- inst:AddTag("NOBLOCK")

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("inspectable")
    CCSAPI.CcsItemInit(inst)
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

CCSAPI.MakeItemSkinDefaultImage('ccs_liushuhuatan', 'images/inventoryimages/ccs_liushuhuatan.xml', 'ccs_liushuhuatan')
local skins = {
    [1] = { name = "黄宝石蜂巢", check = true },
    [2] = { name = "暖冬夜苹果", check = true },
    [3] = { name = "小熊地毯" , check = true},
    [4] = { name = "蝶恋花" , check = true},
}

for i, value in ipairs(skins) do
    CCSAPI.CcsItemAssets(assets, "ccs_liushuhuatan_skin" .. i, true, true)
    CCSAPI.MakeItemSkin(
        'ccs_liushuhuatan',
        'ccs_liushuhuatan_skin' .. i,
        {
            name = value.name,
            atlas = 'images/inventoryimages/ccs_liushuhuatan_skin' .. i .. '.xml',
            image = 'ccs_liushuhuatan_skin' .. i,
            build = 'ccs_liushuhuatan_skin' .. i,
            bank = 'ccs_liushuhuatan_skin' .. i,
            anim = 'idle',
            animloop = true,
            basebuild = 'ccs_liushuhuatan',
            basebank = 'ccs_liushuhuatan',
            baseanim = 'idle',
            baseanimloop = true,
            checkfn = value.check and CCSAPI.CcsSkinCheckFn or nil,
            checkclientfn = value.check and CCSAPI.CcsSkinCheckClientFn or nil,
        }
    )
end

return Prefab("ccs_liushuhuatan", fn, assets),
    MakePlacer("ccs_liushuhuatan_placer", "ccs_liushuhuatan", "ccs_liushuhuatan", "idle", true)
