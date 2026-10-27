local assets = {
    Asset("ANIM", "anim/tthanabag.zip"),
	Asset("ANIM", "anim/ccs_hat_skins_dancecat.zip"),

}

local function MakeStaffFX(name, bank, build, anim_name)
    local function fxfn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddFollower()
        inst.entity:AddNetwork()

        inst:AddTag("FX")
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation(anim_name, true)

        inst:AddComponent("highlightchild")
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("colouradder")
        inst.persists = false
        return inst
    end

    return Prefab(name, fxfn, assets)
end

local function MakeMultiFaceFX(name, bank, build, anim_name, fourfaced)
    local function fxfn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddFollower()
        inst.entity:AddNetwork()

        if fourfaced ~= false then
            inst.Transform:SetFourFaced()
        end

        inst:AddTag("FX")
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation(anim_name, true)
        inst.AnimState:SetFinalOffset(1)

        inst:AddComponent("highlightchild")
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("colouradder")
        inst.persists = false
        return inst
    end

    return Prefab(name, fxfn, assets)
end

return MakeMultiFaceFX("fx_tthanabag_backpack", "tthanabag", "tthanabag", "equip", true)
