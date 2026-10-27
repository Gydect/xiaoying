local Ccs_ThronePuller = Class(function(self, inst)
    self.inst = inst
end)

function Ccs_ThronePuller:DoIt(pos, doer)
    local res = false
    local x, y, z = pos:Get()
	local ents = TheSim:FindEntities(x, y, z, 2, { "ccs_throne" }, { "INLIMBO" }, nil)
    for _, v in ipairs(ents) do
        if v.OnTheoneRemove ~= nil then
            v.OnTheoneRemove(v, doer)
        end
        v:Remove()
        res = true
    end
    return res
end

return Ccs_ThronePuller
