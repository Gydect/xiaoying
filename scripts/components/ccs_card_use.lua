local  Ccs_Card_Use = Class(function(self, inst)
	self.inst = inst
	self.usefn = nil
end)

function Ccs_Card_Use:SetUseFn(fn)
	self.usefn = fn
end  

function Ccs_Card_Use:Use()  
	if self.usefn then
		local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem.owner
		if owner then
			if owner:HasTag("player") and owner:HasTag("ccs") then
				self.usefn(self.inst,owner)
			else
				local owner2 = owner.components.inventoryitem and owner.components.inventoryitem.owner
				if owner2 then
					if owner2:HasTag("player") and owner2:HasTag("ccs") then
						self.usefn(self.inst,owner2)
					end
				end
			end
		end
	end
end

return Ccs_Card_Use