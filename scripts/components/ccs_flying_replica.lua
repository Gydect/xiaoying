local function OnIsFlyDirty(inst)
    local flying = inst.replica.ccs_flying
    if flying:IsFly() then
        -- WASD 预测可能先进入起步状态；收到起飞/皮肤同步时立即补齐承载物贴图。
        CCSAPI.CcsFlyApplySymbols(inst, flying:GetSkin())
        CCSAPI.CcsFlyRefreshAnim(inst)
    else
        CCSAPI.CcsFlyApplySymbols(inst, false)
        -- 客户端预测的状态图不会因服务端降落而切换状态，这里自己结束飞行动画。
        CCSAPI.CcsFlyEndAnim(inst)
    end
end

local Ccs_Flying = Class(function(self, inst)
    self.inst = inst

    self.isfly = net_bool(inst.GUID, "ccs_flying_isfly", "ccs_flying_isflydirty")
    self.skin = net_string(inst.GUID, "ccs_flying_skin", "ccs_flying_skindirty") -- 使用的飞牌皮肤名，空字符串为原皮

    if not TheWorld.ismastersim then
        inst:ListenForEvent("ccs_flying_isflydirty", OnIsFlyDirty)
        inst:ListenForEvent("ccs_flying_skindirty", OnIsFlyDirty)
    end
end)

function Ccs_Flying:IsFly()
    return self.isfly:value()
end

function Ccs_Flying:GetSkin()
    local skin = self.skin:value()
    return skin ~= "" and skin or nil
end

return Ccs_Flying
