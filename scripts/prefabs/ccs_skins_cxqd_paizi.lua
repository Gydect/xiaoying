-- “举牌”配方的产物：不是真正的物品，制作完成后让制作者进入举牌动作，然后自我移除。
-- 需要 ccsskinable 才能接收制作栏选中的牌子皮肤（ccs_skins_cxqd_paizi_skin1 等）。

local function OnBuiltFn(inst, builder)
    local paizi_skin = inst.components.ccsskinable ~= nil and inst.components.ccsskinable._ccsskin or nil
    if CCSAPI.CcsCxqdStartPaizi ~= nil then
        -- 等制作动作结束后再进入举牌状态
        builder:DoTaskInTime(0, CCSAPI.CcsCxqdStartPaizi, paizi_skin)
    end
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState() -- 皮肤系统换肤时会设置 build

    --[[Non-networked entity]]
    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst.persists = false

    if not TheWorld.ismastersim then
        return inst
    end

    CCSAPI.CcsItemInit(inst)
    inst.OnBuiltFn = OnBuiltFn

    -- 正常流程会在 OnBuiltFn 里移除；兜底防止残留
    inst:DoTaskInTime(1, inst.Remove)

    return inst
end

return Prefab("ccs_skins_cxqd_paizi", fn)
