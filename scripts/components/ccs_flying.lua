local CCSUTL = require("utils/ccs_wanly_utils")

local function ccs_isfly(self, isfly) -- 最大值
    if self.inst.replica.ccs_flying then
        self.inst.replica.ccs_flying.isfly:set(isfly)
    end
end

local function ccs_skin(self, skin)
    if self.inst.replica.ccs_flying then
        self.inst.replica.ccs_flying.skin:set(skin or "")
    end
end

local function RemoveFlightLight(self)
    if self._zhimenglight ~= nil then
        if self._zhimenglight:IsValid() then
            self._zhimenglight:Remove()
        end
        self._zhimenglight = nil
    end
end

local function UpdateFlightLight(self, skin)
    if skin ~= "ccs_cards_26_skin_zhimeng" then
        RemoveFlightLight(self)
    elseif self._zhimenglight == nil or not self._zhimenglight:IsValid() then
        self._zhimenglight = SpawnPrefab("ccs_fly_zhimeng_light")
        if self._zhimenglight ~= nil then
            self._zhimenglight.entity:SetParent(self.inst.entity)
            self._zhimenglight.Transform:SetPosition(0, 0, 0)
        end
    end
end

local Ccs_Flying = Class(function(self, inst)
        self.inst = inst
        self.isfly = false -- 是否正在飞行
        self.skin = nil    -- 使用的飞牌皮肤名，nil 为原皮
        self.action = {
            "death",
            "run",
            "run_start",
            "run_stop",
            "idle",
            "hop_pre",
            "hop_loop",
            "hop_pst",
            "doshortaction"
        }

        self.inst:ListenForEvent("death", function()
            if self.isfly then
                self:Land()
            end
        end)
    end,
    nil,
    {
        isfly = ccs_isfly,
        skin = ccs_skin,
    })

function Ccs_Flying:IsFly()
    return self.inst.replica.ccs_flying.isfly:value() or self.isfly
end

local function onunequipped(inst, data)
    local owner = data.owner
    owner.components.ccs_flying:Land()
end

function Ccs_Flying:Fly(skin)
    self.skin = skin
    -- 起飞可能发生在移动状态中，不能等下次进入 idle/run 才补上飞行承载物。
    CCSAPI.CcsFlyApplySymbols(self.inst, skin)
    self.isfly = true
    UpdateFlightLight(self, skin)
    CCSAPI.CcsFlyRefreshAnim(self.inst)
    self.inst.AnimState:Hide("ARM_carry")
    self.inst.AnimState:Show("ARM_normal")
    if self.inst.Physics then
        RemovePhysicsColliders(self.inst)
    end
    if self.inst.components.drownable then
        self.inst.components.drownable.enabled = false
    end
    if self.inst then
        local fx = SpawnPrefab("spawn_fx_small")
        fx.entity:SetParent(self.inst.entity)
        if self.inst.components.inventory then
            local hand = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if hand and (hand:HasTag("ccs_magic_wand3") or hand:HasTag("ccs_starstaff")) then
                hand:ListenForEvent("unequipped", onunequipped)
            end
        end
    end
    self.inst:AddTag("ccs_isfly")
    self.inst.components.locomotor:SetExternalSpeedMultiplier(self.inst, "ccs_fly", 1.5)
end

function Ccs_Flying:Land()
    self.isfly = false
    RemoveFlightLight(self)
    if self.inst.Physics then
        ChangeToCharacterPhysics(self.inst)
    end

    if self.inst.components.drownable then
        self.inst.components.drownable.enabled = true
    end
    if self.inst then
        local fx = SpawnPrefab("spawn_fx_small")
        fx.entity:SetParent(self.inst.entity)
        if self.inst.components.inventory then
            local hand = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if hand then
                self.inst.AnimState:Show("ARM_carry")
                self.inst.AnimState:Hide("ARM_normal")
                if hand:HasTag("ccs_magic_wand3") or hand:HasTag("ccs_starstaff") then
                    hand:RemoveEventCallback("unequipped", onunequipped)
                end
            end
        end
    end
    self.inst:RemoveTag("ccs_isfly")
    self.inst.components.locomotor:RemoveExternalSpeedMultiplier(self.inst, "ccs_fly")
    CCSAPI.CcsFlyApplySymbols(self.inst, false)
    self.skin = nil
    CCSAPI.CcsFlyEndAnim(self.inst)


    if self.inst and (self.inst.ccs_no_drown or self.inst:HasTag('css_nodrown') or self.inst:HasTag('css_nodrown_box')) then
        CCSUTL.ttlSetTreadWaterCollides(self.inst, true)
    end
end

function Ccs_Flying:OnRemoveFromEntity()
    RemoveFlightLight(self)
end

Ccs_Flying.OnRemoveEntity = Ccs_Flying.OnRemoveFromEntity

function Ccs_Flying:OnSave()
    return
    {
        isfly = self:IsFly(),
        skin = self.skin,
    }
end

function Ccs_Flying:OnLoad(data)
    if data then
        if data.isfly ~= nil and data.isfly == true then
            self:Fly(data.skin)
        end
    end
end

return Ccs_Flying
