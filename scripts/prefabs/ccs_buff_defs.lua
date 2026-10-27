local CCSUTL = require("utils/ccs_wanly_utils")
-- =====================================================
-- ccs_buff_defs
-- =====================================================

-- 地牌特效相关函数 ------------------------------------------------
local function ApplyEarthBonus(inst, target, data)
    if data ~= nil then
        inst._earth_damage = data.damage
        inst._earth_taken = data.taken
    end
    target.components.combat.externaldamagemultipliers:SetModifier("ccs_card_dp", inst._earth_damage or 1.45)
    target.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_dp", inst._earth_taken or 0.85)
end

local function SaveEarthBonus(inst, data)
    data.earth_damage = inst._earth_damage
    data.earth_taken = inst._earth_taken
end

local function LoadEarthBonus(inst, data)
    if data ~= nil then
        inst._earth_damage = data.earth_damage
        inst._earth_taken = data.earth_taken
    end
end

local function OnAttached_dp(inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    ApplyEarthBonus(inst, target, data)
    if inst._fx ~= nil then inst._fx:kill_fx() end
    inst._fx = SpawnPrefab("forcefieldfx")
    inst._fx.AnimState:SetBuild("ccs_shield_fx")
    inst._fx.entity:SetParent(target.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
end

local function OnDetached_dp(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("地牌强化失效")
        target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
        target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
        if inst._fx ~= nil then inst._fx:kill_fx(); inst._fx = nil end
    end
    inst:Remove()
end

local function OnTimerDone_dp(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_dp") end
    end
end

local function OnExtended_dp(inst, target, followsymbol, followoffset, data)
    ApplyEarthBonus(inst, target, data)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 480)
end

-- 地牌1（带粒子特效） ------------------------------------------------
local function OnAttached_dp1(inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    ApplyEarthBonus(inst, target, data)
    if inst._fx ~= nil then inst._fx:Remove(); inst._fx = nil end
    inst._fx = SpawnPrefab("ccs_lizifx_ranibowspark")
    inst._fx.entity:AddFollower()
    inst._fx.entity:SetParent(target.entity)
    inst._fx.Follower:FollowSymbol(target.GUID, 'swap_body', 0, -30, 0)
end

local function OnDetached_dp1(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("地牌强化失效")
        target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
        target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
        if inst._fx ~= nil then inst._fx:Remove(); inst._fx = nil end
    end
    inst:Remove()
end

local function OnTimerDone_dp1(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_dp1") end
    end
end

local function OnExtended_dp1(inst, target, followsymbol, followoffset, data)
    ApplyEarthBonus(inst, target, data)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 480)
end

-- 地牌2（脚下花瓣） ------------------------------------------------
local function Tick1(inst)
    if not inst:HasTag("playerghost") and inst.components.locomotor then
        if inst.components.locomotor.wantstomoveforward then
            local x, y, z = inst.Transform:GetWorldPosition()
            SpawnPrefab(inst._ccsfxflag and "ccs_dripfx_purpleflower" or "ccs_dripfx_yellowflower").Transform:SetPosition(x, y, z)
            inst._ccsfxflag = not inst._ccsfxflag
        end
    end
end

local function OnAttached_dp2(inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    ApplyEarthBonus(inst, target, data)
    if target._fx ~= nil then target._fx:Cancel(); target._fx = nil end
    target._fx = target:DoPeriodicTask(.25, Tick1)
    if target._ccsbondlevel then
        if not target._ccsbondlevel:value() then target._ccsbondlevel:set(true) else target._ccsbondlevel:set(false) end
    end
    target:DoTaskInTime(3, function()
        if target and target:IsValid() and target._ccsbondlevel then
            if not target._ccsbondlevel:value() then target._ccsbondlevel:set(true) else target._ccsbondlevel:set(false) end
        end
    end)
end

local function OnDetached_dp2(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("地牌强化失效")
        target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
        target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
        if target._fx ~= nil then target._fx:Cancel(); target._fx = nil end
    end
    inst:Remove()
end

local function OnTimerDone_dp2(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_dp2") end
    end
end

local function OnExtended_dp2(inst, target, followsymbol, followoffset, data)
    ApplyEarthBonus(inst, target, data)
    if target._ccsbondlevel then
        if not target._ccsbondlevel:value() then target._ccsbondlevel:set(true) else target._ccsbondlevel:set(false) end
    end
    target:DoTaskInTime(3, function()
        if target and target:IsValid() and target._ccsbondlevel then
            if not target._ccsbondlevel:value() then target._ccsbondlevel:set(true) else target._ccsbondlevel:set(false) end
        end
    end)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 480)
end

-- 地牌3（糖果法杖特效） ------------------------------------------------
local function OnAttached_dp3(inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    ApplyEarthBonus(inst, target, data)
    if inst._fx ~= nil then inst._fx:Remove(); inst._fx = nil end
    inst._fx = SpawnPrefab("cane_candy_fx")
    inst._fx.entity:AddFollower()
    inst._fx.entity:SetParent(target.entity)
    inst._fx.Follower:FollowSymbol(target.GUID, 'swap_body', 0, -30, 0)
end

local function OnDetached_dp3(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("地牌强化失效")
        target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
        target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
        if inst._fx ~= nil then inst._fx:Remove(); inst._fx = nil end
    end
    inst:Remove()
end

local function OnTimerDone_dp3(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_dp3") end
    end
end

local function OnExtended_dp3(inst, target, followsymbol, followoffset, data)
    ApplyEarthBonus(inst, target, data)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 480)
end

-- 冰牌 ------------------------------------------------
local function attacked(inst, data)
    if data.attacker and data.attacker.components.freezable ~= nil then
        data.attacker.components.freezable:AddColdness(99999, 480)
    end
end

local function OnAttached_bp(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    target:ListenForEvent("attacked", attacked)
end

local function OnDetached_bp(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("冰牌强化失效")
        target:RemoveEventCallback("attacked", attacked)
    end
    inst:Remove()
end

local function OnTimerDone_bp(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_bp") end
    end
end



local function OnExtended_fp1(inst, target)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 240)
end


-- 浮牌2~4级（水面行走+护盾） ------------------------------------------------
local function OnAttached_fp24(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    target.components.locomotor:SetExternalSpeedMultiplier(inst, "ccs_card_fp", 1.1)
    if inst._fx ~= nil then inst._fx:kill_fx() end
    inst._fx = SpawnPrefab("forcefieldfx")
    inst._fx.AnimState:SetBuild("ccs_shield_fx")
    inst._fx.entity:SetParent(target.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
    inst._fx.AnimState:SetAddColour(0/255, 212/255, 255/255, 1)
    
    local ccm = CCSUTL.ccsgetcm(target)
    if ccm  then 
        ccm:ManageCounter("ccs_card_fp",1,function ()
            CCSUTL.ttlSetTreadWaterCollides(target,true)
            ccm:SetInstanceProperty("ccs_no_drown",true)
        end,nil)
    end

end

local function OnDetached_fp24(inst)
    local target = inst.entity:GetParent()
    if target then
        target.components.talker:Say("浮牌强化失效了")
        target.components.locomotor:RemoveExternalSpeedMultiplier(target, "ccs_card_fp")
        local ccm = CCSUTL.ccsgetcm(target)
        if ccm  then 
             ccm:ManageCounter("ccs_card_fp",-1,nil,function ()
                 CCSUTL.ttlSetTreadWaterCollides(target,false)
                 ccm:SetInstanceProperty("ccs_no_drown",nil)
             end)
        end
    end
    if inst._fx ~= nil then inst._fx:kill_fx(); inst._fx = nil end
    inst:Remove()
end

local function OnExtended_fp3(inst, target)
    inst.components.timer:StopTimer("buffover")
    inst.components.timer:StartTimer("buffover", 480)
end


local function OnTimerDone_fp2(inst, data)
    if data.name == "buffover" then
        local target = inst.entity:GetParent()
        if target then target.components.debuffable:RemoveDebuff("ccs_card_fp2") end
    end
end

local function RecoverFromFakeDeath(inst)
    if inst.components.health and inst.components.health.currenthealth <= 0 then
        inst.components.health:SetVal(1)
        inst.components.health:SetInvincible(true)
        if inst.components.inventory then
            if inst.components.revivablecorpse then
                inst.components.inventory:Show()
            else
                inst.components.inventory:Open()
            end
        end
        if inst.components.age then inst.components.age:ResumeAging() end
    
        if inst.components.playercontroller then
            inst.components.playercontroller:Enable(true)
        end
        inst:ShowActions(true)
    
        if inst.components.locomotor then
            inst.components.locomotor:Stop()   
            inst.components.locomotor:Clear()
            inst:EnableMovementPrediction(true)  
        end
    
        if inst.components.playeractionpicker then
            ex_fns.ConfigurePlayerActions(inst) 
        end
    
        if inst.Hide then inst:Show() end
        if inst.DynamicShadow then inst.DynamicShadow:Enable(true) end
    end
end


-- ============ 最终配置表 ============
local defs = {

    {
        prefab = "ccs_lock_blood",
        name = "卡牌盒技能锁血",
        tags = {},
        time = 30,
        OnAttached = function(inst, target)
            if target then
               target:AddTag("lock_blooding")
               target:AddTag("ccs_nohealth_x")
               target.components.health.minhealth = 1
               target.components.health:SetInvincible(true)

               if target.RecoverFromFakeDeath == nil then 
                   target.RecoverFromFakeDeath = target:DoPeriodicTask(0.1,function()
                       RecoverFromFakeDeath(target)
                   end)
               end
               
            end
        end,
        OnDetached = function(inst, target)
            if target then
                target:RemoveTag("lock_blooding")
                target:RemoveTag("ccs_nohealth_x")
                target.components.health.minhealth = 0
                target.components.health:SetInvincible(false)

                if target.RecoverFromFakeDeath then
                    target.RecoverFromFakeDeath:Cancel()
                    target.RecoverFromFakeDeath = nil
                end

            end
            inst:Remove()
        end,
    },


    {
        prefab = "ccs_card_fp_max",
        name = "浮牌强化-2级",
        tags = {'indefinite'},
        time = -1,
        OnAttached = function(inst, target)
            if target then
               local ccm = CCSUTL.ccsgetcm(target)
               if ccm  then 
                ccm:ManageCounter("ccs_card_fp",1,function ()
                    CCSUTL.ttlSetTreadWaterCollides(target,true)
                    ccm:SetInstanceProperty("ccs_no_drown",true)

                end,nil)
               end
            end
        end,
        OnDetached = function(inst, target)
            if target then
                local ccm = CCSUTL.ccsgetcm(target)
               if ccm  then 
                    ccm:ManageCounter("ccs_card_fp",-1,nil,function ()
                        CCSUTL.ttlSetTreadWaterCollides(target,false)
                        ccm:SetInstanceProperty("ccs_no_drown",nil)
                    end)
               end
            end
            inst:Remove()
        end,
    },

    {
        prefab = "ccs_cards_usefn25_buff",
        name = "蝙蝠形态",
        tags = {},
        time = 20,
        OnAttached = function(inst, target)
        end,
        OnDetached = function(inst, target)
            inst:Remove()
        end,
    },

    {
        prefab = "ccs_strawberry_food3_buff",
        name = "草莓果冻踏水",
        tags = {},
        time = 480,
        OnAttached = function(inst, target)
            if target and inst then
               local ccm = CCSUTL.ccsgetcm(target)
               if ccm  then 
                ccm:ManageCounter("ccs_card_fp",1,function ()
                    CCSUTL.ttlSetTreadWaterCollides(target,true)
                    ccm:SetInstanceProperty("ccs_no_drown",true)
                    
                end,nil)
               end

            end
        end,
        OnDetached = function(inst, target)
            if target and inst then
                local ccm = CCSUTL.ccsgetcm(target)
                if ccm  then 
                        ccm:ManageCounter("ccs_card_fp",-1,nil,function ()
                            CCSUTL.ttlSetTreadWaterCollides(target,false)
                            ccm:SetInstanceProperty("ccs_no_drown",nil)
                        end)
                end
                inst:Remove()
            end
        end,
        OnExtended = OnExtended_dp3,
    },


    {
        prefab = "ccs_soda_buff",
        name = "气泡水隐身",
        tags = {},
        time = 480,
        OnAttached = function(inst, target)
            if target then
               target:AddTag("css_yinsheng")
            end
        end,
        OnDetached = function(inst, target)
            if target then
                target:RemoveTag("css_yinsheng")
            end
            inst:Remove()
        end,
        OnExtended = OnExtended_dp3,
    },


    {
        prefab = "ccs_tea1_buff",
        name = "魔法奶茶攻击增益",
        tags = {},
        time = 480,
        OnAttached = function(inst, target)
            if inst and target and target.components.combat then
                
               target.components.combat.externaldamagemultipliers:SetModifier("ccs_tea1", 1.3) 	
            end
        end,
        OnDetached = function(inst, target)
            if inst and target and target.components.combat then
               target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_tea1")
               inst:Remove()
            end
        end,
        OnExtended = OnExtended_dp3,
    },

    {
        prefab = "buff_magicrocking",
        name = "魔法摇椅",
        tags = {'indefinite'},
        time = -1,
        OnAttached = function(inst, target)
            if target then
                if target.components.ccs_magic ~= nil and target.magicrocking_task == nil then 
                    target.magicrocking_task = target:DoPeriodicTask(1,function()
                        target.components.ccs_magic:DoDelta(2)
                    end)
                end
                if target.components.hunger ~= nil then
                    target.components.hunger.burnratemodifiers:SetModifier(inst, 0,"buff_magicrocking")
                end
			end
        end,
        OnDetached = function(inst, target)
            if inst and target then

                if target.magicrocking_task then 
                    target.magicrocking_task:Cancel()
                    target.magicrocking_task = nil
                end

				if target.components.hunger ~= nil then
                    target.components.hunger.burnratemodifiers:RemoveModifier(inst,"buff_magicrocking")
                end

                inst:Remove()
			end
        end,
    },

    {
        prefab = "ccs_strawberry_food2_buff",
        name = "草莓大福魔法减轻",
        time = 480,
        time_extend = 480,
        time_max = 4800,
        OnAttached = function(inst, target)
            if inst and target then 
                target.components.ccs_magic:SetConsume_bf(0.5)
            end

        end,
        OnDetached = function(inst, target)
            if inst and target then 
                if target and target.components.ccs_magic ~= nil then
                    target.components.ccs_magic:SetConsume_bf(0)
                end
                inst:Remove()
            end
        end,
    },

    {
        prefab = "ccs_card_fp2",
        chname = "浮牌强化-1级",
        tags = {"time"},
        time = 240,
        OnAttached = OnAttached_fp24,
        OnDetached = OnDetached_fp24,
        OnExtended = OnExtended_fp1,
        OnTimerDone = OnTimerDone_fp2,
    },

    {
        prefab = "ccs_card_dp",
        chname = "地牌强化",
        tags = {"time"},
        time = 480,
        OnAttached = OnAttached_dp,
        OnDetached = OnDetached_dp,
        OnExtended = OnExtended_dp,
        OnTimerDone = OnTimerDone_dp,
        OnSave = SaveEarthBonus,
        OnLoad = LoadEarthBonus,
    },
    {
        prefab = "ccs_card_dp1",
        chname = "地牌强化",
        tags = {"time"},
        time = 480,
        OnAttached = OnAttached_dp1,
        OnDetached = OnDetached_dp1,
        OnExtended = OnExtended_dp1,
        OnTimerDone = OnTimerDone_dp1,
        OnSave = SaveEarthBonus,
        OnLoad = LoadEarthBonus,
    },
    {
        prefab = "ccs_card_dp2",
        chname = "地牌强化",
        tags = {"time"},
        time = 480,
        OnAttached = OnAttached_dp2,
        OnDetached = OnDetached_dp2,
        OnExtended = OnExtended_dp2,
        OnTimerDone = OnTimerDone_dp2,
        OnSave = SaveEarthBonus,
        OnLoad = LoadEarthBonus,
    },
    {
        prefab = "ccs_card_dp3",
        chname = "地牌强化",
        tags = {"time"},
        time = 480,
        OnAttached = OnAttached_dp3,
        OnDetached = OnDetached_dp3,
        OnExtended = OnExtended_dp3,
        OnTimerDone = OnTimerDone_dp3,
        OnSave = SaveEarthBonus,
        OnLoad = LoadEarthBonus,
    },
    {
        prefab = "ccs_card_bp",
        chname = "冰牌强化",
        tags = {"time"},
        time = 480,
        OnAttached = OnAttached_bp,
        OnDetached = OnDetached_bp,
        OnExtended = OnExtended_dp,          -- 复用重置逻辑
        OnTimerDone = OnTimerDone_bp,
    },
    
}

-- 自动注册中文名
for _, v in ipairs(defs) do
    STRINGS.NAMES[string.upper(v.prefab)] = v.chname or v.name
end

return defs
