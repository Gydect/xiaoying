
local assets =
{
    Asset("ATLAS", "images/inventoryimages/ccs_magic_rocking_chair.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_magic_rocking_chair.tex"),
    Asset("ANIM", "anim/ccs_magic_rocking_chair.zip"), 

}

local prefabs =
{
    "collapse_small",
}

------------------------------------------------------------
-- 摇椅功能函数
------------------------------------------------------------
local function _PlayAnimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(anim, loop)
    if inst.back then
        inst.back.AnimState:PlayAnimation(anim, loop)
    end
end

local function _PushAnimation(inst, anim, loop)
    inst.AnimState:PushAnimation(anim, loop)
    if inst.back then
        inst.back.AnimState:PushAnimation(anim, loop)
    end
end

local function _AnimSetTime(inst, t)
    inst.AnimState:SetTime(t)
    if inst.back then
        inst.back.AnimState:SetTime(t)
    end
end

local function OnHit(inst, worker, workleft, numworks)
    if not inst:HasTag("burnt") then
        _PlayAnimation(inst, "hit")
        _PushAnimation(inst, "idle", false)
        if inst.components.sittable then
            inst.components.sittable:EjectOccupier()
        end
    end
end

local function OnHammered(inst, worker)
    local collapse_fx = SpawnPrefab("collapse_small")
    collapse_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    collapse_fx:SetMaterial("wood")  -- 固定为木头材质

    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function OnBuilt(inst, data)
    _PlayAnimation(inst, "place")
    _PushAnimation(inst, "idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/repair_stonefurniture")

    local builder = (data and data.builder) or nil
    TheWorld:PushEvent("CHEVO_makechair", { target = inst, doer = builder })
end

local function CancelSitterAnimOver(inst)
    if inst._onsitteranimover then
        inst:RemoveEventCallback("animover", inst._onsitteranimover, inst._onsitteranimover_sitter)
        inst._onsitteranimover = nil
        inst._onsitteranimover_sitter = nil
    end
end

local ROCKING_ANIMS = { "rocking", "rocking_smile", "rocking_hat" }

local function IsSitterRockingPre(inst, sitter)
    for i, v in ipairs(ROCKING_ANIMS) do
        if sitter.AnimState:IsCurrentAnimation(v .. "_pre") then
            return true
        end
    end
    return false
end

local function IsSitterRockingLoop(inst, sitter)
    for i, v in ipairs(ROCKING_ANIMS) do
        if sitter.AnimState:IsCurrentAnimation(v .. "_loop") then
            return true
        end
    end
    return false
end

local function OnSyncChairRocking(inst, sitter)
    if inst.components.sittable:IsOccupiedBy(sitter) then
        if IsSitterRockingPre(inst, sitter) then
            _PlayAnimation(inst, "rocking_pre")
            local t = sitter.AnimState:GetCurrentAnimationTime()
            local len = inst.AnimState:GetCurrentAnimationLength()
            if t < len then
                _AnimSetTime(inst, t)
                _PushAnimation(inst, "rocking_loop")
            else
                _PlayAnimation(inst, "rocking_loop", true)
                _AnimSetTime(inst, t - len)
            end
            CancelSitterAnimOver(inst)
        elseif IsSitterRockingLoop(inst, sitter) then
            _PlayAnimation(inst, "rocking_loop", true)
            _AnimSetTime(inst, sitter.AnimState:GetCurrentAnimationTime())
            CancelSitterAnimOver(inst)
        elseif sitter.AnimState:IsCurrentAnimation("sit_off") then
            CancelSitterAnimOver(inst)
        elseif sitter.AnimState:IsCurrentAnimation("sit_jump_off") then
            _PlayAnimation(inst, "rocking_pst")
            _PushAnimation(inst, "idle", false)
            CancelSitterAnimOver(inst)
        else
            if sitter.AnimState:IsCurrentAnimation("sit_loop_pre") then
                _PlayAnimation(inst, "rocking_pst")
                _PushAnimation(inst, "idle", false)
            elseif inst.AnimState:IsCurrentAnimation("rocking_pre") or
                inst.AnimState:IsCurrentAnimation("rocking_loop") or
                sitter.AnimState:IsCurrentAnimation("sit_item_out") or
                sitter.AnimState:IsCurrentAnimation("sit_item_hat") then
                _PlayAnimation(inst, "idle")
            end
            if sitter ~= inst._onsitteranimover_sitter then
                CancelSitterAnimOver(inst)
                inst._onsitteranimover = function(sitter) OnSyncChairRocking(inst, sitter) end
                inst._onsitteranimover_sitter = sitter
                inst:ListenForEvent("animover", inst._onsitteranimover, sitter)
            end
        end
    end
end

local function OnBecomeSittable(inst)
    if inst.AnimState:IsCurrentAnimation("rocking_loop") then
        _PlayAnimation(inst, "rocking_pst")
        _PushAnimation(inst, "idle", false)
    elseif inst.AnimState:IsCurrentAnimation("rocking_pre") then
        _PlayAnimation(inst, "idle")
    end
    CancelSitterAnimOver(inst)
end


local function GetStatus(inst)
    return (inst.components.sittable:IsOccupied() and "OCCUPIED") or nil
end

local function OnSave(inst, data)
end

local function OnLoad(inst, data)
end

------------------------------------------------------------
-- 靠背实体（前置扶手层）
------------------------------------------------------------
local function backfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.Transform:SetNoFaced()

    inst:AddTag("FX")

    inst.AnimState:SetBank("ccs_magic_rocking_chair")
    inst.AnimState:SetBuild("ccs_magic_rocking_chair")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:Hide("parts")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            local parent = inst.entity:GetParent()
            if parent ~= nil and parent.prefab == "ccs_magic_rocking_chair" then
                parent.highlightchildren = { inst }
            end
        end
        return inst
    end

    inst.persists = false
    return inst
end

------------------------------------------------------------
-- 主椅子实体
------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:SetDeploySmartRadius(1)

    MakeObstaclePhysics(inst, 0.25)

    inst.Transform:SetNoFaced()

    inst:AddTag("structure")
    inst:AddTag("limited_chair")
    inst:AddTag("rocking_chair")

    inst.AnimState:SetBank("ccs_magic_rocking_chair")
    inst.AnimState:SetBuild("ccs_magic_rocking_chair")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(-1)
    inst.AnimState:Hide("back_over")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 生成靠背
    inst.back = SpawnPrefab("ccs_magic_rocking_chair_back")
    inst.back.entity:SetParent(inst.entity)
    inst.highlightchildren = { inst.back }

    inst.scrapbook_facing = FACING_DOWN

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "WOOD_CHAIR"
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("lootdropper")
    inst:AddComponent("sittable")
    local last_occupier = nil
    inst:ListenForEvent("becomesittable", function(inst)
        if last_occupier and last_occupier:IsValid() then
            last_occupier:RemoveDebuff("buff_magicrocking")
        end
        last_occupier = nil
    end)

    inst:ListenForEvent("becomeunsittable", function(inst)
        local occupier = inst.components.sittable.occupier
        if occupier and occupier:HasTag("player") then
            occupier:AddDebuff("buff_magicrocking", "buff_magicrocking")
            last_occupier = occupier
        end
    end)


    inst:AddComponent("savedrotation")
    inst.components.savedrotation.dodelayedpostpassapply = true

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(OnHit)
    inst.components.workable:SetOnFinishCallback(OnHammered)

    inst:ListenForEvent("onbuilt", OnBuilt)
    inst:ListenForEvent("ms_sync_chair_rocking", OnSyncChairRocking)
    inst:ListenForEvent("becomesittable", OnBecomeSittable)

    MakeHauntableWork(inst)

    inst:DoPeriodicTask(0.1,function(inst)
        local build = inst.AnimState:GetBuild()
        if inst.back then
            inst.back.AnimState:SetBuild(build)
        end
    end)


    inst.OnLoad = OnLoad
    inst.OnSave = OnSave

    CCSAPI.CcsItemInit(inst)

    return inst
end

------------------------------------------------------------
-- 注册皮肤
------------------------------------------------------------
-- 默认皮肤（物品栏图标）
CCSAPI.MakeItemSkinDefaultImage(
    "ccs_magic_rocking_chair",
    "images/inventoryimages/ccs_magic_rocking_chair.xml",
    "ccs_magic_rocking_chair"
)

local skins = {
    [1] = { name = "小可抱椅", check = false },
    [2] = { name = "小可陪伴", check = true },
    [3] = { name = "斯比陪伴", check = true },
}

for i, value in ipairs(skins) do
    local skinbuild = "ccs_magic_rocking_chair" .. i
    table.insert(assets, Asset("ANIM", "anim/" .. skinbuild .. ".zip"))

    CCSAPI.CcsItemAssets(assets, skinbuild, true, true)
    CCSAPI.MakeItemSkin(
        "ccs_magic_rocking_chair",
        skinbuild,
        {
            name = value.name,
            atlas = "images/inventoryimages/" .. skinbuild .. ".xml",
            image = skinbuild,
            build = skinbuild,
            bank = "ccs_magic_rocking_chair",
            anim = "idle",
            animloop = true,
            basebuild = "ccs_magic_rocking_chair",
            basebank = "ccs_magic_rocking_chair",
            baseanim = "idle",
            baseanimloop = true,
            checkfn = value.check and CCSAPI.CcsSkinCheckFn or nil,
            checkclientfn = value.check and CCSAPI.CcsSkinCheckClientFn or nil,
            
        }
    )
end

------------------------------------------------------------
-- 返回所有预制体
------------------------------------------------------------
return Prefab("ccs_magic_rocking_chair", fn, assets, prefabs),
    Prefab("ccs_magic_rocking_chair_back", backfn, assets),
    MakePlacer("ccs_magic_rocking_chair_placer", "ccs_magic_rocking_chair", "ccs_magic_rocking_chair", "idle", nil, nil, nil, nil, 15, "four")