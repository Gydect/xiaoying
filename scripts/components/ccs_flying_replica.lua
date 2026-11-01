local function OnIsFlyDirty(inst)
	--客户端预测的状态图不会因服务端降落而切换状态，这里收到降落同步时自己结束飞行动画
	if not inst.replica.ccs_flying.isfly:value() then
		CCSAPI.CcsFlyEndAnim(inst)
	end
end

local Ccs_Flying = Class(function(self, inst)
    self.inst = inst

	self.isfly = net_bool(inst.GUID,"ccs_flying_isfly","ccs_flying_isflydirty")
	self.skin = net_string(inst.GUID,"ccs_flying_skin")	--使用的飞牌皮肤名，空字符串为原皮

	if not TheWorld.ismastersim then
		inst:ListenForEvent("ccs_flying_isflydirty", OnIsFlyDirty)
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
