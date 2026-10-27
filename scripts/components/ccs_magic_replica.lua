local Ccs_Magic = Class(function(self, inst)
    self.inst = inst

	self.current = net_float(inst.GUID,"ccs_magic_current")		--当前魔法
	self.max = net_float(inst.GUID,"ccs_magic_max")		--最大魔法
    self.magic_recovery = net_float(inst.GUID,"ccs_magic_recovery")			--魔法恢复
	self.equrecovery = net_float(inst.GUID,"ccs_equrecovery")	
	

end)

--查看光环增值
function Ccs_Magic:GetRecovery()
	return self.magic_recovery:value()
end

--查看当前魔法值
function Ccs_Magic:GetMagic()
	return self.current:value()
end

--最大值
function Ccs_Magic:GetMaxMagic()
   return self.max:value()
end

function Ccs_Magic:GetRecoverytext()
   return self.equrecovery:value()
end

return Ccs_Magic