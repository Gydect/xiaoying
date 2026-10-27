local Ccs_Card_Level = Class(function(self, inst)
    self.inst = inst

	self.level = net_float(inst.GUID,"ccs_card_level")
	self.maxlevel = net_float(inst.GUID,"ccs_card_max_level")
	self.master = net_string(inst.GUID,"ccs_card_master")
end)

function Ccs_Card_Level:GetLevel()
   return self.level:value()
end

function Ccs_Card_Level:GetMaxLevel()
   return self.maxlevel:value()
end

function Ccs_Card_Level:GetMaster()
   return self.master:value()
end


return Ccs_Card_Level