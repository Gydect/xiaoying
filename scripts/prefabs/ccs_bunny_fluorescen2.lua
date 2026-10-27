
local assets=
{
	Asset("ANIM", "anim/ccs_bunny_fluorescen2.zip"),  --动画文件
    Asset("IMAGE", "images/inventoryimages/ccs_bunny_fluorescen2.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_bunny_fluorescen2.xml")
}


local function dig(inst, worker)
	inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddLight()

    inst:AddTag("ccs_bunny_fluorescen2")
    MakeInventoryPhysics(inst, nil, 0.7)

    inst.AnimState:SetBank("ccs_bunny_fluorescen2")
    inst.AnimState:SetBuild("ccs_bunny_fluorescen2")
    inst.AnimState:PlayAnimation("anim0")

    inst.entity:SetPristine()

    inst.Light:SetFalloff(0.6)
    inst.Light:SetIntensity(0.6)
    inst.Light:SetRadius(2)
    inst.Light:SetColour(200/255, 200/255, 200/255,.8)
    inst.Light:Enable(true)

    if not TheWorld.ismastersim then
        return inst
    end
    CCSAPI.CcsItemInit(inst)
    inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig)
	inst.components.workable:SetWorkLeft(1)

    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")


    MakeHauntableIgnite(inst)

    return inst
end
CCSAPI.MakeItemSkinDefaultImage('ccs_bunny_fluorescen2', 'images/inventoryimages/ccs_bunny_fluorescen2.xml', 'ccs_bunny_fluorescen2_0')
local skins = {"月光花朵","月光花朵","月光花朵","月光花朵","月光花朵"}
for i, v in ipairs(skins) do
    CCSAPI.MakeItemSkin(
    'ccs_bunny_fluorescen2',
    'ccs_bunny_fluorescen2_skin_' .. i,
    {
        name = v,
        atlas = 'images/inventoryimages/ccs_bunny_fluorescen2.xml',
        image = 'ccs_bunny_fluorescen2_' .. i,
        build = 'ccs_bunny_fluorescen2',
        basebuild = 'ccs_bunny_fluorescen2',
        anim = 'anim' .. i,
        baseanim = 'anim0',
        rarity = "free",
    }
)
end



return Prefab("ccs_bunny_fluorescen2", fn, assets),
       MakePlacer("ccs_bunny_fluorescen2_placer", "ccs_bunny_fluorescen2", "ccs_bunny_fluorescen2", "anim0")
