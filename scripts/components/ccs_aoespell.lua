local  Aoespell = Class(function(self, inst)
	self.inst = inst
	self.spellfn = nil
end)


function Aoespell:CanCast(doer, pos)
    return self.spellfn 
end


function Aoespell:Ccs_SetSpellFn(fn)
    self.spellfn = fn
end

function Aoespell:CastSpell(doer, pos)
    if self.spellfn ~= nil then
        self.spellfn(self.inst,doer, pos)
	end
	return true
end


return Aoespell