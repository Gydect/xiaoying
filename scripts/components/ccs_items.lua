local TotooriaItems = Class(function(self, inst)
    self.inst = inst

    self._bounduserid = ""
    --self._boundname   = ""

    -- if inst.components.equippable then
    --     self._onequip = function(inst, data)
    --         self:TryBind(data.owner)
    --     end
    --     inst:ListenForEvent("equipped", self._onequip)
    -- else
    --     self._onpickup = function(inst, data)
    --         self:TryBind(data.owner)
    --     end
    --     inst:ListenForEvent("onpickup", self._onpickup)
    -- end
end)

function TotooriaItems:TryBind(owner)
    if self._bounduserid == "" and owner ~= nil and owner.userid ~= nil then
        self.inst:DoTaskInTime(0, function()
            if not self.inst:IsValid() or not (owner and owner:IsValid()) then
                return
            end

            -- if self.inst.components.equippable and not self.inst.components.equippable:IsEquipped() then
            --     return
            -- end

            if self._bounduserid ~= "" then
                return
            end

            local uid  = owner.userid
            --local name = owner:GetDisplayName() or ""
            self._bounduserid = uid
            --self._boundname   = name
            -- local mg = ''

            -- if self.inst.components.equippable then 
            --     mg = '首次装备,绑定'
            -- else
            --     mg = '首次持有,绑定'
            -- end


            if self.inst.replica.ccs_items then
                self.inst.replica.ccs_items.bounduserid:set(uid)
                --self.inst.replica.ccs_items.boundname:set(name)
            end

            -- 通知
            -- if TTWHISPER ~= nil then
            --     local itemname   = self.inst:GetDisplayName() or self.inst.prefab or "物品"
            --     local playername = owner:GetDisplayName() or owner.name
            --     TTWHISPER(owner, {
            --         sender_name = itemname,
            --         s_colour    = {1, 0.8, 0.2, 1},
            --         m_colour    = {1, 1, 0, 1},
            --         message     = mg .. playername,
            --         icondata    = "profileflair_amulet_red_rose"
            --     })
            -- end
        end)
    end
end

function TotooriaItems:IsBound()
    return self._bounduserid ~= ""
end

function TotooriaItems:GetBoundUserID()
    return self._bounduserid
end

-- function TotooriaItems:GetBoundName()
--     return self._boundname
-- end

function TotooriaItems:IsAllowed(doer)
    if not self:IsBound() then
        return true
    end
    return doer ~= nil and doer.userid == self._bounduserid
end

function TotooriaItems:OnSave()
    if self:IsBound() then
        return {
            bounduserid = self._bounduserid,
            --boundname   = self._boundname,
        }
    end
end

function TotooriaItems:OnLoad(data)
    if data ~= nil and data.bounduserid ~= nil then
        self._bounduserid = data.bounduserid
        --self._boundname   = data.boundname or ""

        if self.inst.replica.ccs_items then
            self.inst.replica.ccs_items.bounduserid:set(self._bounduserid)
            --self.inst.replica.ccs_items.boundname:set(self._boundname)
        end
    end
end

return TotooriaItems