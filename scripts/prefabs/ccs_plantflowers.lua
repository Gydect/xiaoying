local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small") --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function MakeFlower(name)
    local assets = {
        Asset("ANIM", "anim/" .. name .. ".zip"),
        Asset("IMAGE", "images/inventoryimages/" .. name .. ".tex"), --物品栏贴图
        Asset("ATLAS", "images/inventoryimages/" .. name .. ".xml"),
    }
    local function fn(Sim)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("idle", true)
        inst:AddTag("ccs_flower")
        inst:AddTag("cattoy")
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
        if name ~= "ccs_plantflower_jzj" then
            CCSAPI.CcsItemInit(inst)
        end
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(6)
        inst.components.workable:SetOnFinishCallback(onhammered)

        inst:AddComponent("inspectable")


        return inst
    end
    return Prefab(name, fn, assets)
end
return MakeFlower("ccs_plantflower_fhh"),
    MakePlacer("ccs_plantflower_fhh_placer", "ccs_plantflower_fhh", "ccs_plantflower_fhh", "idle", false, nil, nil),
    MakeFlower("ccs_plantflower_jzj"),
    MakePlacer("ccs_plantflower_jzj_placer", "ccs_plantflower_jzj", "ccs_plantflower_jzj", "idle", false, nil, nil),
    MakeFlower("ccs_plantflower_ss"),
    MakePlacer("ccs_plantflower_ss_placer", "ccs_plantflower_ss", "ccs_plantflower_ss", "idle", false, nil, nil),
    MakeFlower("ccs_plantflower_www"),
    MakePlacer("ccs_plantflower_www_placer", "ccs_plantflower_www", "ccs_plantflower_www", "idle", false, nil, nil)
