local CCSUTL = require("utils/ccs_wanly_utils")
local CARDSTATS = require("utils/ccs_card_stats")

local function MakeSleepBookEffect(target)
    if target == nil or not target:IsValid() or not target.components.health  then
        return false
    end

    if target.components.health:IsDead() then
        return false
    end

    if target:HasTag("structure") then
        return false
    end

    -- 不适用于冻结、被钉住或已化石的目标
    if target.components.freezable and target.components.freezable:IsFrozen() then
        return false
    end
    if target.components.pinnable and target.components.pinnable:IsStuck() then
        return false
    end
    if target.components.fossilizable and target.components.fossilizable:IsFossilized() then
        return false
    end

    -- 如果目标正在骑乘，让坐骑也入睡
    local ismount, mount
    if target.components.rider then
        ismount = target.components.rider:IsRiding()
        mount = target.components.rider:GetMount()
    end
    if mount then
        mount:PushEvent("ridersleep", { sleepiness = 10, sleeptime = 20 })
    end

    -- 按优先级施加睡眠/眩晕/击倒效果
    if target.components.sleeper then
        target.components.sleeper:AddSleepiness(10, 20)
    elseif target.components.grogginess then
        target.components.grogginess:AddGrogginess(10, 20)
    else
        target:PushEvent("knockedout")
    end

    -- 生成对应的视觉特效
    local fx_prefab = ismount and "fx_book_sleep_mount" or "fx_book_sleep"
    local fx = SpawnPrefab(fx_prefab)
    if fx then
        local x, y, z = target.Transform:GetWorldPosition()
        fx.Transform:SetPosition(x, y, z)
        fx.Transform:SetRotation(target.Transform:GetRotation())
    end

    return true
end

local function CreateShadowPillarsAt(target, caster)
    if target == nil or not target:IsValid() or not target.components.health then
        return nil
    end

    if target.components.health:IsDead() then
        return nil
    end
    
    if target:HasTag("structure") then
        return nil
    end

    -- 如果目标身上已有标记，说明柱子还在（或冷却中），不重复生成
    if target._pillars_mark then
        return nil
    end

    local x, y, z = target.Transform:GetWorldPosition()
    local spell = SpawnPrefab("shadow_pillar_spell")
    if spell == nil then
        return nil
    end

    if caster then
        spell.caster = caster
    end

    local platform = TheWorld.Map:GetPlatformAtPoint(x, z)
    if platform then
        spell.entity:SetParent(platform.entity)
        spell.Transform:SetPosition(platform.entity:WorldToLocalSpace(x, y, z))
    else
        spell.Transform:SetPosition(x, y, z)
    end

    target._pillars_mark = true

    if target._pillars_clear_task then
        target._pillars_clear_task:Cancel()
    end
    
    target._pillars_clear_task = target:DoTaskInTime(5, function(t)
        t._pillars_mark = nil
        t._pillars_clear_task = nil
    end)

    --return spell
end

local function GetCardBoxMaxLevelCount(box)
    local owner = box and box.components.inventoryitem and box.components.inventoryitem:GetGrandOwner()
    return CARDSTATS.GetMaxLevelCount(box, owner)
end

-- ★★★ 新增：可封印的 Boss 列表 + 对应满级卡牌
local Valid_seal = {
    dragonfly             = "ccs_cards_11",
    moose                 = "ccs_cards_5",
    antlion               = "ccs_cards_21",
    bearger               = "ccs_cards_13",
    deerclops             = "ccs_cards_2",
    crabking              = "ccs_cards_18",
    shadow_bishop         = "ccs_cards_25",
    shadow_rook           = "ccs_cards_1",
    alterguardian_phase3  = "ccs_cards_8",
    leif                  = "ccs_cards_16",
    beequeen              = "ccs_cards_6",
    bishop                = "ccs_cards_15",
    bishop_nightmare      = "ccs_cards_15",
    bat                   = "ccs_cards_26",
    malbatross            = "ccs_cards_27",
}

-- 返回 true  → 需要封印（没有满级卡）
-- 返回 false → 不封印（有满级卡 / 不在名单里 / 没卡牌盒）
local function checkccscards(owner, target)
    local card = Valid_seal[target.prefab]
    if not card then
        return false        -- 不在名单
    end

    local cardbox
    local magic_wands
    for _, v_e in pairs(owner.components.inventory.equipslots) do
        if v_e.prefab == "ccs_card_box" then
            cardbox = v_e
        end
        if v_e.prefab == "ccs_magic_wand3" then
            magic_wands = v_e
        end
    end

    if not cardbox then
        return false
    end

    -- shadow 系列必须是 epic，不是 smallepic
    if target.prefab == "shadow_bishop" or target.prefab == "shadow_rook" then
        if not (target:HasTag("epic") and not target:HasTag("smallepic")) then
            return false
        end
    end

    local cards = cardbox.components.container:FindItem(function(item)
        return item.prefab == card
    end)

    if not cards then
        -- 大主教/梦魇大主教：法杖里有满级矢牌也算“有卡”
        if magic_wands and
           (target.prefab == "bishop" or target.prefab == "bishop_nightmare") then
            for _, v in pairs(magic_wands.components.container.slots) do
                if v and v.prefab == "ccs_cards_15" and
                   v.components.ccs_card_level:GetMaxLevel() == v.components.ccs_card_level:GetLevel() then
                    return false
                end
            end
        end
        return true   -- 没找到卡 → 要封印
    end

    -- 有卡但没满级 → 要封印；满级 → 不封印
    if cards.components.ccs_card_level:GetMaxLevel() == cards.components.ccs_card_level:GetLevel() then
        return false
    else
        return true
    end
end

local function ccs_onhit(inst,data)
    if not data or not data.target or data.target:HasTag("structure") then return end
    local target = data.target
    --禁疗
    if CCSUTL.TTLiseqbytag(inst,"healing_block") and target.prefab ~= "archive_centipede_husk" and not target:HasTag("player") then 
        if CCSUTL.TTnohealthcheck(target) then 
            target:AddTag("ccs_nohealth")
        else
            target:AddTag("ccs_nohealth_x")
        end

        CCSUTL.ScheduleTask(target,"ccs_nohealth",15,function()
            target:RemoveTag("ccs_nohealth")
            target:RemoveTag("ccs_nohealth_x")
        end)
    end
    
    --破甲
    -- if CCSUTL.TTLiseqbytag(inst,"armor_break") then 
        
    --     target:AddTag("ccs_armor_break")
        
    --     CCSUTL.ScheduleTask(target,"ccs_armor_break",15,function()
    --         target:RemoveTag("ccs_armor_break")
    --     end)

    -- end

    
    if target.issuoxue == nil and target.prefab and Valid_seal[target.prefab] and CCSUTL.TTLiseqbytag(inst, "ccs_card_box") then
        if checkccscards(inst, data.target) then
            target:AddTag("ccs_suoxue")
        end
    end

    if CCSUTL.TTLiseqbytag(inst,"stun") and math.random() <= 0.2 then 
        MakeSleepBookEffect(target)
    end

    if CCSUTL.TTLiseqbytag(inst,"shadow_cage") then 
        CreateShadowPillarsAt(target, inst)
    end


    if CCSUTL.TTLiseqbytag(inst,"ccs_card_box") then 
        local w_d = inst.components.ccs_wanly_damage
        if not  w_d then 
            inst:AddComponent("ccs_wanly_damage")
            w_d = inst.components.ccs_wanly_damage
        end
        if CCSUTL.ttchecktarget(inst,data.target) then 
            local box = CCSUTL.TTLgeteqbytag(inst,"ccs_card_box")
            local num = GetCardBoxMaxLevelCount(box) or 0
            if num >= 1 and data.target.components.health then 
                local damage = 2 * num + (num * 0.0005) * data.target.components.health.maxhealth
                w_d:ApplyTemporaryDamage(data.target,damage)
            end
        end
    end
    
end



AddPrefabPostInit("ccs", function(inst)
    if not TheWorld.ismastersim then return end

    inst:AddComponent("ccs_wanly_damage")

    inst:ListenForEvent("onhitother", ccs_onhit)

    if inst.components.combat and inst.components.combat.CalcDamage then 
        --暴击
        inst.components.combat.OldCalcDamage = inst.components.combat.CalcDamage
        inst.components.combat.CalcDamage = function(self, target, weapon, multiplier, ...)
            local damage, spdamage = self:OldCalcDamage(target, weapon, multiplier, ...)
            if math.random() <= 0.2 and CCSUTL.TTLiseqbytag(self.inst,"critical") then
                damage = damage * 2 --暴击双倍伤害
                if spdamage ~= nil then
                    for k, v in pairs(spdamage) do
                        spdamage[k] = v * 2
                    end
                end
                SpawnPrefab("explode_small").Transform:SetPosition(target.Transform:GetWorldPosition())
            end
            return damage, spdamage
        end 

        --闪避
        inst.components.combat:SetShouldRecoilFn(function(self_inst, attacker, weapon, damage)
            if CCSUTL.TTLiseqbytag(inst,"dodge") and math.random() <= 0.35 then
                return true, nil 
            end
        end)

    end


end)

--正常扣血
AddComponentPostInit("health", function(self)
    local oldSetVal = self.SetVal
    self.SetVal = function(self, val, cause, afflicter, ...)
        if self.inst
            and self.inst:HasTag("ccs_suoxue")
            and not self.inst.userid                    -- 不是玩家
            and self.currenthealth > 0
            and val < self.maxhealth * 0.1              -- 血量 < 10%
        then
            -- 锁血到 10%-1
            self.minhealth = self.maxhealth * 0.1 - 1
            self:SetCurrentHealth(self.maxhealth * 0.1 - 1)

            -- 禁疗 / 封印标签
            self.inst:AddTag("ccs_nohealth_x")
            self.inst:AddTag("tt_time_stop")


            if self.inst.AnimState then
                self.inst.AnimState:SetMultColour(255/255, 212/255, 0/255, 1)
            end

            if self.inst.tt_seal_task_h == nil  then 
                self.inst.tt_seal_task_h = self.inst:DoTaskInTime(6, function(inst)
                    if inst and inst:IsValid() and inst.components.health then
                        inst.components.health.minhealth = 0
                        if inst.AnimState then
                            inst.AnimState:SetMultColour(1, 1, 1, 1)
                        end
                        inst:RemoveTag("ccs_nohealth_x")
                        inst:RemoveTag("ccs_suoxue")
                        inst:RemoveTag("tt_time_stop")
                        inst.tt_seal_task_h = nil
                        inst.issuoxue = true
                    end
                end)
            end
            
            return
        end
        
        if val <= 0 and
           self.currenthealth > 0 and
           self.inst and
           self.inst:HasTag("ccs") then

            local box = CCSUTL.TTLgeteqbypre(self.inst,"ccs_card_box")
            if box then 
                if box:HasTag("lock_blood") and box.components.ccs_timer:Try("lock_blood") and not box:HasTag("lock_blood_full") then 
                    self.currenthealth = 1
                    CCSWHISPER(self.inst, {
                        sender_name = "卡牌盒",
                        s_colour    = {1, 0.8, 0.2, 1},
                        m_colour    = {1, 1, 0, 1},
                        message     = "坚持住！！！",
                        icondata    = "profileflair_rose"
                    })
                    self.inst:AddDebuff("ccs_lock_blood","ccs_lock_blood")
                    return
                end

                if box:HasTag("lock_blood_full") and box.components.ccs_timer:Try("lock_blood_full") then 
                    self.currenthealth = self.maxhealth
                    CCSWHISPER(self.inst, {
                        sender_name = "卡牌盒",
                        s_colour    = {1, 0.8, 0.2, 1},
                        m_colour    = {1, 1, 0, 1},
                        message     = "哎嘿，满血复活！",
                        icondata    = "profileflair_rose"
                    })
                    self.inst:AddDebuff("ccs_lock_blood","ccs_lock_blood")
                    return
                end

            end
            
        end

        if oldSetVal then
            return oldSetVal(self, val, cause, afflicter, ...)
        end
    end
end)


local function RecoverFromFakeDeath(inst)
   
    if inst.components.revivablecorpse ~= nil then
        inst.components.inventory:Show()
    else
        inst.components.inventory:Open()          
        if inst.components.age then
            inst.components.age:ResumeAging()     
        end
    end

    if inst.components.playercontroller then
        inst.components.playercontroller:Enable(true)
    else
        inst:AddComponent("playercontroller")
        inst.components.playercontroller:Enable(true)
    end

    if inst.Hide then inst:Show() end
    if inst.DynamicShadow then inst.DynamicShadow:Enable(true) end
end

--代码杀
local oldPushEvent = EntityScript.PushEvent
EntityScript.PushEvent = function(inst, name, data, ...)
    if name == "death" or  name == "makeplayerghost" and inst:HasTag("ccs") then

        if inst:HasTag("lock_blooding") then 
            RecoverFromFakeDeath(inst)
            return
        end

        local health = inst.components.health
        local box = CCSUTL.TTLgeteqbypre(inst,"ccs_card_box")
       
        if health and box then 
            if box:HasTag("lock_blood") and box.components.ccs_timer:Try("lock_blood") and not box:HasTag("lock_blood_full") then 
                CCSWHISPER(inst, {
                    sender_name = "卡牌盒",
                    s_colour    = {1, 0.8, 0.2, 1},
                    m_colour    = {1, 1, 0, 1},
                    message     = "坚持住！！！",
                    icondata    = "profileflair_rose"
                })

                RecoverFromFakeDeath(inst)

                box:DoTaskInTime(0,function()
                    local owner = box.components.inventoryitem and box.components.inventoryitem:GetGrandOwner()
                    if owner and owner.components.health then 
                        owner.components.health.currenthealth = 1
                        owner:AddDebuff("ccs_lock_blood","ccs_lock_blood")
                    end
                end)

                return
            end

            if box:HasTag("lock_blood_full") and box.components.ccs_timer:Try("lock_blood_full") then 
                CCSWHISPER(inst, {
                    sender_name = "卡牌盒",
                    s_colour    = {1, 0.8, 0.2, 1},
                    m_colour    = {1, 1, 0, 1},
                    message     = "哎嘿，满血复活！",
                    icondata    = "profileflair_rose"
                })
                RecoverFromFakeDeath(inst)

                box:DoTaskInTime(0,function()
                    local owner = box.components.inventoryitem and box.components.inventoryitem:GetGrandOwner()
                    if owner and owner.components.health then 
                        owner.components.health.currenthealth = owner.components.health.maxhealth
                        owner:AddDebuff("ccs_lock_blood","ccs_lock_blood")
                    end
                end)

                return
            end

        end

    end
    return oldPushEvent(inst, name, data, ...)
end
