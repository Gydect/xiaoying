-- 只遮蔽装备显示，保留穿戴回调、属性和手持物。记录原本的显示状态以便换肤恢复。
local states = setmetatable({}, { __mode = "k" })
local original = {}
local layers = {
    HAT = false, HAT_HAIR = false, HAIR_HAT = false,
    HAIR = true, HAIR_NOHAT = true, HEAD = true,
    HEAD_HAT = false, HEAD_HAT_NOHELM = false, HEAD_HAT_HELM = false,
}
local symbols = {
    swap_hat = false, swap_body = false, swap_body_tall = false,
    face = true, swap_face = true, beard = true, cheeks = true,
}

local function IsHiddenSlot(slot)
    return slot == EQUIPSLOTS.HEAD or slot == EQUIPSLOTS.BODY
end

local function IsEquipmentBuild(state, build)
    -- 小樱帽子、衣服有延迟设置贴图的情况，不能仅依赖 equip 事件。
    if type(build) == "string" and (build:find("^ccs_hat") or build:find("^ccs_skirt")) then
        return true
    end
    local inventory = state.inst.components.inventory
    for slot, item in pairs(inventory ~= nil and inventory.equipslots or {}) do
        if IsHiddenSlot(slot) and (build == item.prefab or build == item:GetSkinBuild()) then
            return true
        end
    end
    return false
end

local function HookVisibility(show, hide, forced, field)
    original[show], original[hide] = AnimState[show], AnimState[hide]
    for _, method in ipairs({ show, hide }) do
        local visible = method == show
        AnimState[method] = function(anim, name, ...)
            local state = states[anim]
            if state ~= nil and forced[name] ~= nil then
                state[field][name] = visible
                if state.hidden then
                    return original[forced[name] and show or hide](anim, name, ...)
                end
            end
            return original[method](anim, name, ...)
        end
    end
end

HookVisibility("Show", "Hide", layers, "layers")
HookVisibility("ShowSymbol", "HideSymbol", symbols, "symbols")
original.UseHeadHatExchange = AnimState.UseHeadHatExchange
AnimState.UseHeadHatExchange = function(anim, enabled, ...)
    local state = states[anim]
    if state ~= nil then
        state.headexchange = enabled
        if state.hidden then
            enabled = false
        end
    end
    return original.UseHeadHatExchange(anim, enabled, ...)
end

original.AddOverrideBuild = AnimState.AddOverrideBuild
original.ClearOverrideBuild = AnimState.ClearOverrideBuild
AnimState.AddOverrideBuild = function(anim, build, ...)
    local state = states[anim]
    if state ~= nil then
        state.buildorder = state.buildorder + 1
        state.builds[build] = state.buildorder
        if state.hidden and IsEquipmentBuild(state, build) then
            state.hiddenbuilds[build] = true
            return
        end
    end
    return original.AddOverrideBuild(anim, build, ...)
end
AnimState.ClearOverrideBuild = function(anim, build, ...)
    local state = states[anim]
    if state ~= nil then
        state.builds[build], state.hiddenbuilds[build] = nil, nil
    end
    return original.ClearOverrideBuild(anim, build, ...)
end

local function RestoreEffects(state)
    for fx in pairs(state.hiddenfx) do
        if fx:IsValid() then
            fx:Show()
        end
    end
    state.hiddenfx = {}
end

local function HideEffect(state, fx)
    if fx ~= nil and fx.IsValid ~= nil and fx:IsValid() and fx.entity:IsVisible() then
        state.hiddenfx[fx] = true
        fx:Hide()
    end
end

-- 棱镜等模组会用 UserDataHook 把 inst.AnimState 换成代理表，原生对象存放在 inst.userdatas.AnimState。
-- 原生函数只接收引擎对象，所以这里统一取回原生 AnimState；取不到时跳过遮蔽，避免崩溃。
local function GetAnim(inst)
    local anim = inst.AnimState
    if type(anim) == "userdata" then
        return anim
    end
    anim = inst.userdatas ~= nil and inst.userdatas.AnimState or nil
    return type(anim) == "userdata" and anim or nil
end

local function Refresh(inst)
    local anim = GetAnim(inst)
    local state = anim ~= nil and states[anim] or nil
    if state == nil then return end
    state.task = nil
    if not state.hidden then return end

    -- 装备回调在 inventory 写入装备栏之前执行；事件后再检查一次覆盖贴图和附属特效。
    for build in pairs(state.builds) do
        if IsEquipmentBuild(state, build) then
            original.ClearOverrideBuild(anim, build)
            state.hiddenbuilds[build] = true
        end
    end
    -- 已卸下帽子的退场动画仍可能短暂挂在头上；保持遮蔽，直到离开人物或换肤。
    for fx in pairs(state.hiddenfx) do
        if not fx:IsValid() then
            state.hiddenfx[fx] = nil
        elseif fx.entity:GetParent() ~= inst then
            fx:Show()
            state.hiddenfx[fx] = nil
        end
    end
    local inventory = inst.components.inventory
    for slot, item in pairs(inventory ~= nil and inventory.equipslots or {}) do
        if IsHiddenSlot(slot) then
            for _, field in ipairs({ "_front", "_back", "hat_fx", "fx" }) do
                HideEffect(state, item[field])
            end
            for _, fx in ipairs(item.swapfx or {}) do
                HideEffect(state, fx)
            end
        end
    end
end

local function ScheduleRefresh(inst)
    local anim = GetAnim(inst)
    local state = anim ~= nil and states[anim] or nil
    if state ~= nil and state.hidden and state.task == nil then
        state.task = inst:DoTaskInTime(0, Refresh)
    end
end

local function Init(inst)
    local anim = GetAnim(inst)
    if not TheWorld.ismastersim or anim == nil or states[anim] ~= nil then return end
    local state = {
        inst = inst, layers = {}, symbols = {}, headexchange = false,
        builds = {}, hiddenbuilds = {}, buildorder = 0, hiddenfx = {},
    }
    states[anim] = state
    for name, visible in pairs(layers) do
        state.layers[name] = visible
    end
    for name in pairs(symbols) do
        state.symbols[name] = true
    end
    inst:ListenForEvent("equip", ScheduleRefresh)
    inst:ListenForEvent("unequip", ScheduleRefresh)
    inst:ListenForEvent("ms_respawnedfromghost", ScheduleRefresh)
    inst:ListenForEvent("onremove", function()
        if state.task ~= nil then state.task:Cancel() end
        states[anim] = nil
    end)
end

local function SetHidden(inst, hidden)
    if not TheWorld.ismastersim then return end
    Init(inst)
    local anim = GetAnim(inst)
    local state = anim ~= nil and states[anim] or nil
    if state == nil or state.hidden == hidden then return end
    if state.task ~= nil then
        state.task:Cancel()
        state.task = nil
    end
    state.hidden = hidden
    for name, visible in pairs(hidden and layers or state.layers) do
        original[visible and "Show" or "Hide"](anim, name)
    end
    for name, visible in pairs(hidden and symbols or state.symbols) do
        original[visible and "ShowSymbol" or "HideSymbol"](anim, name)
    end
    original.UseHeadHatExchange(anim, not hidden and state.headexchange or false)
    if hidden then
        Refresh(inst)
        ScheduleRefresh(inst)
    else
        RestoreEffects(state)
        local builds = {}
        for build in pairs(state.hiddenbuilds) do
            if state.builds[build] ~= nil then
                table.insert(builds, build)
            end
        end
        table.sort(builds, function(a, b) return state.builds[a] < state.builds[b] end)
        for _, build in ipairs(builds) do
            original.AddOverrideBuild(anim, build)
        end
        state.hiddenbuilds = {}
    end
end

return { Init = Init, SetHidden = SetHidden }
