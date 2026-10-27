local TotooriaItems_replica = Class(function(self, inst)
    self.inst = inst

    
    self.bounduserid = net_string(inst.GUID, "ccs_items.bounduserid", "bounduseriddirty")
    --self.boundname   = net_string(inst.GUID, "totooria_items.boundname", "boundnamedirty")
    
end)

function TotooriaItems_replica:IsBound()
    return self.bounduserid:value() ~= ""
end

function TotooriaItems_replica:GetBoundUserID()
    return self.bounduserid:value()
end

-- function TotooriaItems_replica:GetBoundName()
--     return self.boundname:value()
-- end

function TotooriaItems_replica:IsAllowed(doer)
    if not self:IsBound() then
        return true
    end
    return doer ~= nil and doer.userid == self:GetBoundUserID()
end

return TotooriaItems_replica