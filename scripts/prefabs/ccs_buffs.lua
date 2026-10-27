-- 公共辅助：时间叠加逻辑
local function ExtendTime(inst, add, max_time)
    if inst.components.timer then
        local left = inst.components.timer:GetTimeLeft("buffover") or 0
        local new = math.min(left + add, max_time or 99999)
        print(new)
        inst.components.timer:StopTimer("buffover")
        inst.components.timer:StartTimer("buffover", new)
    end
end

-- Buff 工厂函数
local function Ccs_Buffs(data)
    -- 自动生成 OnExtended（时间叠加）
    if not data.OnExtended then
        if data.time_extend and data.time_max then
            data.OnExtended = function(inst, target)
                ExtendTime(inst, data.time_extend, data.time_max)
            end
        elseif data.refresh_time then
            data.OnExtended = function(inst, target)
                if inst.components.timer then
                    inst.components.timer:StopTimer("buffover")
                    inst.components.timer:StartTimer("buffover", data.time)
                end
            end
        else
            data.OnExtended = function() end
        end
    end

    -- 自动生成 OnTimerDone
    if not data.OnTimerDone then
        data.OnTimerDone = function(inst, data)
            if data.name == "buffover" then
                inst.components.debuff:Stop()
            end
        end
    end

    local function fn()
        local inst = CreateEntity()

        if data.tags then
            for _, v in ipairs(data.tags) do inst:AddTag(v) end
        end

        if not TheWorld.ismastersim then
            inst:DoTaskInTime(0, inst.Remove)
            return inst
        end

        inst.entity:AddTransform()
        inst.entity:Hide()
        inst.persists = false
        inst:AddTag("CLASSIFIED")

        inst:AddComponent("debuff")
        inst.components.debuff:SetAttachedFn(data.OnAttached)
        inst.components.debuff:SetDetachedFn(data.OnDetached)
        inst.components.debuff:SetExtendedFn(data.OnExtended)
        inst.components.debuff.keepondespawn = true

        inst:AddComponent("timer")
        if inst:HasTag("indefinite") then
            inst.components.timer:StartTimer("---", data.time or 999999)
        else
            inst.components.timer:StartTimer("buffover", data.time)
            inst:ListenForEvent("timerdone", data.OnTimerDone)
        end

        inst.OnSave = data.OnSave or function() end
        inst.OnPreLoad = data.OnLoad or function() end

        return inst
    end

    return Prefab(data.prefab, fn)
end


local ccs_buffs = {}

local all_defs = require("prefabs/ccs_buff_defs")
for _, def in pairs(all_defs) do
    table.insert(ccs_buffs, Ccs_Buffs(def))
end

return unpack(ccs_buffs)