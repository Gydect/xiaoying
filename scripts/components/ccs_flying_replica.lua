local Ccs_Flying = Class(function(self, inst)
    self.inst = inst

	self.isfly = net_bool(inst.GUID,"ccs_flying_isfly")
	
end)

function Ccs_Flying:IsFly()
   return self.isfly:value()
end

return Ccs_Flying