-- 噩梦伤害组件
local CCSUTL = require("utils/ccs_wanly_utils")
local TTL_wanly_damage = Class(function(self, inst)
    self.inst = inst

    -- 伤害配置
    self.instant_base_damage = 0
    self.dot_base_damage = 0
    self.instant_percent = 0
    self.dot_percent = 0

    -- 伤害倍率属性
    self.instant_base_multiplier = 1.0
    self.instant_percent_multiplier = 1.0
    self.dot_base_multiplier = 1.0
    self.dot_percent_multiplier = 1.0

    -- 状态管理
    self.active_debuffs = {}
    self.temporary_damage_queue = {}

    -- 免疫配置
    self.immune_tags = {
        "tt_time_stop", "Suchasmountain", "wall", "balloon", "groundspike",
        "fx", "smashable", "totooria"
    }
    self.immune_targets = {
        "archive_centipede_husk", "crabking_icewall", "worm_boss_dirt","worm_boss_shadow_dirt",
        "sora_sign","vault_crawler"
    }

    -- debuff开关配置
    self.enable_dot_debuff = false

    -- 禁疗系统初始化
    self.active_anti_heal_targets = {}
    self._antiheal_periodic_task = nil

    -- 添加组件移除监听
    self.onremove_handler = function() self:OnRemoveEntity() end
    inst:ListenForEvent("onremove", self.onremove_handler)

    inst:ListenForEvent("onattackother", function (inst,data)
        if not inst or not data or not data.target then return end
        inst.alreadydoattack = true
        self:DoAttack(data.target)
    end)
end)

-- ======================
-- DOT常量配置
-- ======================
local WANLY_DOT_DURATION = 3
local WANLY_DOT_INTERVAL = 1
local WANLY_DOT_INITIAL_DELAY = 0

-- ======================
-- 组件生命周期管理
-- ======================

function TTL_wanly_damage:OnRemoveEntity()
    -- 清理所有debuff
    local targets = {}
    for target in pairs(self.active_debuffs) do table.insert(targets, target) end
    for _, target in ipairs(targets) do self:_SafeCancelDebuff(target) end

    -- 清理所有临时伤害队列
    self.temporary_damage_queue = {}

    -- 清理所有由这个施加者创建的DOT
    self:CancelAllDoT()

    -- 清理所有禁疗效果
    self:RemoveAllAntiHeal()

    -- 停止周期任务
    if self._antiheal_periodic_task then
        self._antiheal_periodic_task:Cancel()
        self._antiheal_periodic_task = nil
    end

    -- 停止更新
    if self.inst:IsValid() then self.inst:StopUpdatingComponent(self) end
end

-- 安全的取消debuff方法
function TTL_wanly_damage:_SafeCancelDebuff(target)
    local debuff_info = self.active_debuffs[target]
    if not debuff_info then return end

    -- 移除事件监听
    if debuff_info.onremove_handler and self.inst:IsValid() then
        self.inst:RemoveEventCallback("onremove", debuff_info.onremove_handler, target)
    end

    -- 移除debuff效果
    self:_RemoveDebuff(target)

    -- 清理引用
    self.active_debuffs[target] = nil
end


-- ======================
-- 配置方法
-- ======================

-- 设置基础伤害（同时设置单次和持续基础伤害）
function TTL_wanly_damage:SetBaseDamage(damage)
    self:SetInstantBaseDamage(damage)
    self:SetDotBaseDamage(damage)
end

-- 设置单次攻击的百分比伤害系数
function TTL_wanly_damage:SetInstantPercent(percent)
    self.instant_percent = percent
end

-- 设置持续伤害的百分比伤害系数
function TTL_wanly_damage:SetDotPercent(percent)
    self.dot_percent = percent
end

-- 设置单次攻击基础伤害
function TTL_wanly_damage:SetInstantBaseDamage(damage)
    self.instant_base_damage = damage
end

-- 设置持续伤害基础伤害
function TTL_wanly_damage:SetDotBaseDamage(damage)
    self.dot_base_damage = damage
end

-- 增加基础伤害（同时影响单次和持续伤害）
function TTL_wanly_damage:AddBaseDamage(value)
    self:AddInstantBaseDamage(value)
    self:AddDotBaseDamage(value)
end

-- 增加单次攻击基础伤害
function TTL_wanly_damage:AddInstantBaseDamage(value)
    self.instant_base_damage = math.max(0, self.instant_base_damage + value)
end

-- 增加持续伤害基础伤害
function TTL_wanly_damage:AddDotBaseDamage(value)
    self.dot_base_damage = math.max(0, self.dot_base_damage + value)
end

-- 增加单次攻击百分比系数
function TTL_wanly_damage:AddInstantPercent(value)
    self.instant_percent = self.instant_percent + value
end

-- 增加持续伤害百分比系数
function TTL_wanly_damage:AddDotPercent(value)
    self.dot_percent = self.dot_percent + value
end

-- 设置攻击时回调
function TTL_wanly_damage:SetOnAttack(fn)
    self.onattack = fn
end

-- 添加免疫噩梦伤害的标签
function TTL_wanly_damage:AddImmuneTag(tag)
    if not table.contains(self.immune_tags, tag) then
        table.insert(self.immune_tags, tag)
    end
end

-- 移除免疫噩梦伤害的标签
function TTL_wanly_damage:RemoveImmuneTag(tag)
    for i, v in ipairs(self.immune_tags) do
        if v == tag then
            table.remove(self.immune_tags, i)
            return
        end
    end
end

-- 添加免疫噩梦伤害的实体
function TTL_wanly_damage:AddImmuneTarget(target)
    if not table.contains(self.immune_targets, target) then
        table.insert(self.immune_targets, target)
    end
end

-- 移除免疫噩梦伤害的实体
function TTL_wanly_damage:RemoveImmuneTarget(target)
    for i, v in ipairs(self.immune_targets) do
        if v == target then
            table.remove(self.immune_targets, i)
            return
        end
    end
end

-- 设置伤害倍率方法
function TTL_wanly_damage:SetInstantBaseMultiplier(multiplier)
    self.instant_base_multiplier = multiplier or 1.0
end

function TTL_wanly_damage:SetInstantPercentMultiplier(multiplier)
    self.instant_percent_multiplier = multiplier or 1.0
end

function TTL_wanly_damage:SetDotBaseMultiplier(multiplier)
    self.dot_base_multiplier = multiplier or 1.0
end

function TTL_wanly_damage:SetDotPercentMultiplier(multiplier)
    self.dot_percent_multiplier = multiplier or 1.0
end

-- 批量设置倍率
function TTL_wanly_damage:SetAllMultipliers(multiplier)
    self:SetInstantBaseMultiplier(multiplier)
    self:SetInstantPercentMultiplier(multiplier)
    self:SetDotBaseMultiplier(multiplier)
    self:SetDotPercentMultiplier(multiplier)
end

-- Debuff相关配置方法
function TTL_wanly_damage:SetEnableDotDebuff(enable)
    self.enable_dot_debuff = enable
end

-- 检查目标是否免疫噩梦伤害
function TTL_wanly_damage:IsTargetImmune(target)
    if not target or not target:IsValid() then return true end

    if table.contains(self.immune_targets, target.prefab) then return true end

    for _, tag in ipairs(self.immune_tags) do
        if target:HasTag(tag) then return true end
    end

    return false
end

-- ======================
-- 伤害计算辅助函数
-- ======================

-- 托托莉的水无常形 - 随机伤害浮动
local function ttrandom_damage(inst, damage)
    if inst:HasTag("ttrandom") then
        damage = damage * (0.9 + (1.1 * math.random()))
    end
    return damage
end

-- ======================
-- DOT核心机制
-- ======================

-- DOT更新函数
local function OnUpdate_WanlyDoT(target, data)
    if TTT.TTnodeath(target) then
        -- 造成伤害
        if data.damageFn and type(data.damageFn) == "function" then
            data.damageFn(target, data.attacker)
        end

        -- 应用debuff（如果启用且尚未应用）
        if data.enable_debuff and not data.has_debuff then
            if data.attacker and data.attacker.components.ttl_wanly_damage then
                data.attacker.components.ttl_wanly_damage:_ApplyDebuff(target)
                data.has_debuff = true
            end
        end
    end

    -- 检查是否到达结束时间
    if GetTime() >= data.endtime or not TTT.TTnodeath(target) then
        if data.task then
            data.task:Cancel()
            data.task = nil
        end
        if data.has_debuff and data.attacker and data.attacker.components.ttl_wanly_damage then
            data.attacker.components.ttl_wanly_damage:_RemoveDebuff(target)
        end
        -- 从字典中移除自己
        if target._wanly_dot_effects then
            target._wanly_dot_effects[data.attacker] = nil
            if not next(target._wanly_dot_effects) then
                target._wanly_dot_effects = nil
            end
        end
        data = nil
    end
end

-- 伤害计算函数
local function CalculateWanlyDamage(target, attacker)
    if not target or not target.components.health or not attacker then return end

    if not attacker.components.ttl_wanly_damage then return end

    local damage_component = attacker.components.ttl_wanly_damage

    -- 计算DOT伤害（应用倍率）
    local max_health = target.components.health:GetMaxWithPenalty()
    local base_damage = damage_component.dot_base_damage * damage_component.dot_base_multiplier
    local percent_damage = (max_health * damage_component.dot_percent) * damage_component.dot_percent_multiplier
    local total_damage = base_damage + percent_damage

    -- 应用随机伤害浮动
    total_damage = ttrandom_damage(attacker, total_damage)

    
    -- 应用伤害

    if total_damage > 0 then 
        damage_component:ApplyTTL_wanly_damage(target, total_damage,true)
    end
end

-- 应用DOT效果
function TTL_wanly_damage:ApplyDoT(target, duration, interval)
    duration = duration or WANLY_DOT_DURATION
    interval = interval or WANLY_DOT_INTERVAL

    if not self.inst:IsValid() then return false, "INVALID_INSTIGATOR" end
    if self:IsTargetImmune(target) then return false, "IMMUNE" end
    if not target:IsValid() or not target.components.health then
        return false, "INVALID_TARGET"
    end

    -- 初始化字典
    if not target._wanly_dot_effects then
        target._wanly_dot_effects = {}
    end

    local dict = target._wanly_dot_effects
    local data = dict[self.inst]

    if data == nil then
        -- 首次为该施加者创建 DOT
        data = {
            task = nil,
            endtime = GetTime() + duration,
            attacker = self.inst,
            damageFn = CalculateWanlyDamage,
            enable_debuff = self.enable_dot_debuff,
            has_debuff = false
        }
        dict[self.inst] = data

        -- 创建周期任务
        if WANLY_DOT_INITIAL_DELAY > 0 then
            data.task = target:DoPeriodicTask(interval, OnUpdate_WanlyDoT, WANLY_DOT_INITIAL_DELAY, data)
        else
            data.task = target:DoPeriodicTask(interval, OnUpdate_WanlyDoT, nil, data)
        end

        -- 立即执行第一次更新
        OnUpdate_WanlyDoT(target, data)
    else
        -- 刷新持续时间
        data.endtime = GetTime() + duration
        data.attacker = self.inst
        data.damageFn = CalculateWanlyDamage
        data.enable_debuff = self.enable_dot_debuff

        -- 如果任务不存在则重新创建
        if not data.task then
            data.task = target:DoPeriodicTask(interval, OnUpdate_WanlyDoT, nil, data)
        end
    end

    return true
end

-- 取消特定目标的DOT
function TTL_wanly_damage:CancelDoT(target, instigator)
    if not target or not target._wanly_dot_effects then return end

    local dict = target._wanly_dot_effects

    if instigator then
        local data = dict[instigator]
        if data then
            if data.task then data.task:Cancel() end
            if data.has_debuff then self:_RemoveDebuff(target) end
            dict[instigator] = nil
        end
    else
        for k, v in pairs(dict) do
            if v.task then v.task:Cancel() end
            if v.has_debuff then self:_RemoveDebuff(target) end
            dict[k] = nil
        end
    end

    -- 如果字典为空，清理字段
    if not next(dict) then
        target._wanly_dot_effects = nil
    end
end

-- 取消所有DOT
function TTL_wanly_damage:CancelAllDoT()
    local all_ents = TheSim:FindEntities(0, 0, 0, 10000)
    for _, ent in ipairs(all_ents) do
        if ent._wanly_dot_effects and ent._wanly_dot_effects[self.inst] then
            self:CancelDoT(ent, self.inst)
        end
    end
end

-- ======================
-- Debuff机制
-- ======================

-- 施加debuff效果
function TTL_wanly_damage:_ApplyDebuff(target)
    -- 检查目标是否为玩家 - 如果是玩家，不应用debuff效果
    if target:HasTag("player") then
        return
    end

    local reduce = 0.75
    local useNum = TTT.TTGetusenum(self.inst)

    if useNum >= 15 then
        reduce = 0.75 - 0.74 * ((useNum -15) / 485)

        if reduce <= 0.01 then
            reduce = 0.01
        end
    end

    target.ttl_wanly_reduce = reduce

    -- 检查目标是否为建筑
    if target:HasTag("structure") or target:HasTag("playerghost") then return end

    -- 检查目标是否有战斗组件且不是特定实体
    if not target.components.combat or target.prefab == "archive_centipede_husk"  then
        return
    end

    -- 设置伤害减免（除非目标已有特定标签）
    if not (target:HasTag("totoorianohealth") or target:HasTag("totoorianohealthx")) then
        if target.components.combat then
            target.components.combat.externaldamagemultipliers:SetModifier("jieyuandupei", reduce)
        end
    end

    -- 设置移动速度降低
    if target.components.locomotor then
        target.components.locomotor:SetExternalSpeedMultiplier(target, "tt_prevent", reduce)
    end

    -- 设置治疗限制
    if (TTT and TTT.TTnohealthcheck and TTT.TTnohealthcheck(target)) then
        target:AddTag("totoorianohealth")
    else
        target:AddTag("totoorianohealthx")
    end

    -- 设置颜色效果
    if target.AnimState then
        target.AnimState:SetMultColour(202 / 255, 255 / 255, 255 / 255, 1)
    end
end

-- 移除debuff效果
function TTL_wanly_damage:_RemoveDebuff(target)
    -- 检查目标是否为玩家 - 如果是玩家，不需要移除debuff
    if target:HasTag("player") then
        return
    end

    if target.components.combat then
        target.components.combat.externaldamagemultipliers:RemoveModifier("jieyuandupei")
    end
    if target.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(target, "tt_prevent")
    end

    target:RemoveTag("totoorianohealth")
    target:RemoveTag("totoorianohealthx")

    if target:IsValid() and target.AnimState then
        target.AnimState:SetMultColour(1, 1, 1, 1)
    end
end

-- 独立施加debuff的方法
function TTL_wanly_damage:ApplyDebuffOnly(target, duration)
    -- 检查施加者是否有效
    if not self.inst:IsValid() then return false, "INVALID_INSTIGATOR" end

    -- 检查目标是否免疫噩梦伤害
    if self:IsTargetImmune(target) then return false, "IMMUNE" end

    -- 检查目标是否为玩家 - 如果是玩家，不应用debuff
    if target:HasTag("player") then
        return false, "PLAYER_IMMUNE_TO_DEBUFF"
    end

    -- 检查目标是否有效
    if not target:IsValid() then return false, "INVALID_TARGET" end

    -- 如果已有相同施加者的debuff，先取消
    if self.active_debuffs[target] or target:HasTag("playerghost") then
        self:CancelDebuff(target)
    end

    -- 使用安全的弱引用事件监听
    local weak_self = setmetatable({self = self}, {__mode = "v"})
    local function onTargetRemoved()
        local real_self = weak_self.self
        if real_self and real_self.inst:IsValid() then
            real_self:CancelDebuff(target)
        end
    end

    -- 创建debuff信息
    local debuff_info = {
        target = target,
        duration = duration,
        elapsed = 0,
        onremove_handler = onTargetRemoved
    }

    -- 施加debuff效果
    self:_ApplyDebuff(target)

    -- 添加到活动列表
    self.active_debuffs[target] = debuff_info

    -- 添加事件监听
    self.inst:ListenForEvent("onremove", onTargetRemoved, target)

    -- 启动更新（如果尚未启动）
    self.inst:StartUpdatingComponent(self)

    return true
end

-- 取消特定目标的debuff
function TTL_wanly_damage:CancelDebuff(target)
    -- 检查施加者是否有效
    if not self.inst:IsValid() then
        self:_SafeCancelDebuff(target)
        return
    end

    if self.active_debuffs[target] then
        self:_SafeCancelDebuff(target)

        -- 如果没有其他debuff和临时伤害，停止更新
        if not next(self.active_debuffs) and not next(self.temporary_damage_queue) then
            self.inst:StopUpdatingComponent(self)
        end
    end
end

-- ======================
-- 临时伤害机制
-- ======================

-- 造成一次临时噩梦伤害
function TTL_wanly_damage:ApplyTemporaryDamage(target, damage, options)
    -- 检查施加者是否有效
    if not self.inst:IsValid() then return false, "INVALID_INSTIGATOR" end

    options = options or {}
    local bypass_immune = options.bypass_immune or false
    local ignore_callback = options.ignore_callback or false
    local cause = options.cause or self.inst.prefab
    local afflicter = options.afflicter or self.inst
    local overtime = options.overtime or false

    -- 检查目标是否有效
    if not target:IsValid() or not target.components.health then
        return false, "INVALID_TARGET"
    end

    -- 检查免疫状态（除非绕过）
    if not bypass_immune and self:IsTargetImmune(target) then
        return false, "IMMUNE"
    end

    -- 解析伤害值（支持函数形式）
    local actual_damage = damage
    if type(damage) == "function" then
        actual_damage = damage(target, self.inst)
    end

    -- 确保伤害为数字且有效
    if type(actual_damage) ~= "number" or actual_damage <= 0 then
        return false, "INVALID_DAMAGE"
    end

    -- 执行攻击回调（除非忽略）
    if not ignore_callback and self.onattack ~= nil then
        self.onattack(self.inst, target)
    end

    actual_damage = ttrandom_damage(self.inst, actual_damage)

    -- 应用伤害
    local success, result = self:_ApplyTTL_wanly_damageInternal(target, actual_damage, cause, afflicter,overtime)

    return success, result
end

-- 添加临时伤害到队列（延迟执行）
function TTL_wanly_damage:QueueTemporaryDamage(target, damage, delay, options)
    -- 检查施加者是否有效
    if not self.inst:IsValid() then return nil end

    local id = tostring(target) .. "_" .. tostring(math.random(10000, 99999))

    self.temporary_damage_queue[id] = {
        target = target,
        damage = damage,
        delay = delay,
        options = options or {},
        timer = delay,
        id = id
    }

    -- 启动更新（如果尚未启动）
    self.inst:StartUpdatingComponent(self)
    return id
end

-- 取消队列中的临时伤害
function TTL_wanly_damage:CancelQueuedDamage(id)
    if self.temporary_damage_queue[id] then
        self.temporary_damage_queue[id] = nil

        -- 如果没有其他队列伤害和debuff，停止更新
        if not next(self.temporary_damage_queue) and not next(self.active_debuffs) and self.inst:IsValid() then
            self.inst:StopUpdatingComponent(self)
        end
    end
end

-- ======================
-- 核心伤害应用机制
-- ======================
local function OnCorpsingEntitySleep(inst) -- Go instantly to corpse state
    inst.sg:GoToState("corpse")
    inst:PushEventImmediate("forcecorpsereplace")
end

function TTL_wanly_damage:_ApplyTTL_wanly_damageInternal(target, damage, cause, afflicter, overtime)
    local health = target.components.health
    if not health then return false, "NO_HEALTH_COMPONENT" end

    -- 记录变化前的信息
    local old_percent = health:GetPercent()
    local old_health = health.currenthealth
    local max_health = health:GetMaxWithPenalty()
    local min_health = math.min(health.minhealth or 0, max_health)

    -- 计算新血量
    local new_health = old_health - damage

    -- 先推事件
    target:PushEvent("pre_health_setval", { val = new_health, old_health = old_health })

    if new_health <= min_health then
        new_health = min_health
        target:PushEvent("minhealth", { cause = cause, afflicter = afflicter })
        if afflicter and afflicter:IsValid() and not target.TTCheckMedalKill_ then
            CCSUTL.TTCheckMedalKill(target, afflicter)
            target.TTCheckMedalKill_ = true
        end
    end

    health.currenthealth = new_health

    -- 用于血条显示
    CCSUTL.ttlrealhealth(afflicter, target, -0.000001, "xianshi", afflicter)

    -- 实际变化量
    local actual_amount = new_health - old_health  -- 负数
    local new_percent = health:GetPercent()

    -- healthdelta 事件
    target:PushEvent("healthdelta", {
        oldpercent = old_percent,
        newpercent = new_percent,
        overtime = overtime,
        cause = cause,
        afflicter = afflicter,
        amount = actual_amount,
    })

    -- ondelta 回调
    if health.ondelta ~= nil then
        health.ondelta(target, old_percent, new_percent, overtime or false, cause, afflicter, actual_amount)
    end

    --============ 死亡处理（原版 SetVal 的死亡分支）============
    if old_health > 0 and new_health <= 0 and (target.prefab == "xd_ziyunboss" or not target.ttkillover_) then
        if not (target.IsUnchained and not target:IsUnchained()) then
            target.ttkillover_ = true
        end

        -- 取消持续伤害效果
        self:CancelDoT(target)
        if self.temporary_damage_queue then
            for id, info in pairs(self.temporary_damage_queue) do
                if info.target == target then
                    self.temporary_damage_queue[id] = nil
                end
            end
        end

        -- 死亡元信息（原版）
        target.causeofdeath = afflicter or nil
        local is_corpsing = CanEntityBecomeCorpse(target)
        health.is_corpsing = is_corpsing

        -- 全局死亡事件（原版字段）
        TheWorld:PushEvent("entity_death", {
            inst = target,
            cause = cause,
            afflicter = afflicter,
            corpsing = is_corpsing,
        })

        -- 击杀者事件
        if afflicter and afflicter:IsValid() then
            afflicter:PushEvent("killed", { victim = target })
            if target.components.combat and target.components.combat.onkilledbyother then
                target.components.combat.onkilledbyother(target, afflicter)
            end
        end

        -- 目标自身的死亡事件（原版字段）
        target:PushEvent("death", { cause = cause, afflicter = afflicter, corpsing = is_corpsing })
        target:PushEvent("yyxkdeath", { cause = cause, afflicter = afflicter })

        -- 击杀进度统计（原版）
        local notify_type = (target.isplayer and "TotalPlayersKilled") or "TotalEnemiesKilled"
        NotifyPlayerProgress(notify_type, 1, afflicter)

        -- 30 秒后自动移除（某些特殊实体）
        target:DoTaskInTime(30, function()
            if target:IsValid() and target.components.health
                and target.components.health.currenthealth == target.components.health.minhealth
                and not target.userid
                and target.prefab ~= "xd_ziyunboss" then
                target:Remove()
            end
        end)

        -- -- 尸体 / 消散路径（原版逻辑）
        if health:CanFadeOut() then
            -- 消散
            target:AddTag("NOCLICK")
            target.persists = false
            target.erode_task = target:DoTaskInTime(health.destroytime or 2, ErodeAway)
        elseif health.is_corpsing then
            -- 变尸体：让 state graph 进 corpse
            if target:IsAsleep() then
                OnCorpsingEntitySleep(target)
            else
                target:ListenForEvent("entitysleep", OnCorpsingEntitySleep)
            end
        end


        -- 特殊标签自动移除
        target:DoTaskInTime(0, function()
            if target:IsValid() and target:HasTag("swc2hm") then
                target:Remove()
            end
        end)
    end

    return true, -actual_amount  -- 返回实际扣血量（正数）
end

function TTL_wanly_damage:ApplyTTL_wanly_damage(target, damage,overtime)
    return self:_ApplyTTL_wanly_damageInternal(target, damage, self.inst.prefab, self.inst,overtime)
end

-- ======================
-- 禁疗机制
-- ======================

-- 对目标施加禁疗效果（治疗反噬）
function TTL_wanly_damage:ApplyAntiHeal(target, duration)
    if not self.inst:IsValid() or not target:IsValid() then
        return false, "INVALID_ENTITY"
    end
    if self:IsTargetImmune(target) then
        return false, "IMMUNE"
    end
    if target:HasTag("player") then
        return false, "PLAYER_IMMUNE_TO_ANTI_HEAL"
    end

    duration = duration or 5

    local anti_heal_data = self.active_anti_heal_targets[target]
    if anti_heal_data then
        anti_heal_data.duration = duration
        anti_heal_data.start_time = GetTime()
        if anti_heal_data.remove_task then
            anti_heal_data.remove_task:Cancel()
        end
        anti_heal_data.remove_task = target:DoTaskInTime(duration, function()
            if self.inst:IsValid() then self:RemoveAntiHeal(target) end
        end)
        return true
    end

    local current_hp = target.components.health and target.components.health.currenthealth or 0
    anti_heal_data = {
        target = target,
        start_time = GetTime(),
        duration = duration,
        last_health = current_hp,
        remove_task = target:DoTaskInTime(duration, function()
            if self.inst:IsValid() then self:RemoveAntiHeal(target) end
        end)
    }

    self.active_anti_heal_targets[target] = anti_heal_data

    if self._antiheal_periodic_task == nil then
        self._antiheal_periodic_task = self.inst:DoPeriodicTask(1.0, function()
            self:_CheckAllAntiHealTargets()
        end)
    end

    return true
end

-- 移除目标的禁疗效果
function TTL_wanly_damage:RemoveAntiHeal(target)
    local data = self.active_anti_heal_targets[target]
    if not data then return end

    if data.remove_task then
        data.remove_task:Cancel()
    end

    self.active_anti_heal_targets[target] = nil

    -- 如果没有禁疗目标了，停止周期任务
    if next(self.active_anti_heal_targets) == nil then
        if self._antiheal_periodic_task then
            self._antiheal_periodic_task:Cancel()
            self._antiheal_periodic_task = nil
        end
    end
end

-- 移除所有禁疗效果
function TTL_wanly_damage:RemoveAllAntiHeal()
    local targets = {}
    for target in pairs(self.active_anti_heal_targets) do
        table.insert(targets, target)
    end
    for _, target in ipairs(targets) do
        self:RemoveAntiHeal(target)
    end
end

-- 检查目标是否有禁疗效果
function TTL_wanly_damage:HasAntiHeal(target)
    return self.active_anti_heal_targets[target] ~= nil
end

-- 获取目标的禁疗剩余时间
function TTL_wanly_damage:GetAntiHealTimeLeft(target)
    local data = self.active_anti_heal_targets[target]
    if not data then return 0 end
    local elapsed = GetTime() - data.start_time
    return math.max(0, data.duration - elapsed)
end

-- 每秒执行一次的所有禁疗目标检查
function TTL_wanly_damage:_CheckAllAntiHealTargets()
    for target, data in pairs(self.active_anti_heal_targets) do
        -- 如果目标无效或已移除，清理
        if not target:IsValid() then
            self:RemoveAntiHeal(target)
        else
            local hp = target.components.health and target.components.health.currenthealth
            if hp and hp > data.last_health then
                local heal_amount = hp - data.last_health
                -- 用临时伤害机制造成反噬伤害
                self:ApplyTemporaryDamage(target, heal_amount, {
                    cause = "anti_heal",
                    afflicter = self.inst,
                    bypass_immune = false
                })
                -- 更新记录为当前血量（ApplyTemporaryDamage 已扣血）
                data.last_health = target.components.health.currenthealth
            else
                -- 未增加则更新基准
                data.last_health = hp or data.last_health
            end
        end
    end
end

-- ======================
-- 组件更新
-- ======================

function TTL_wanly_damage:OnUpdate(dt)
    if not self.inst:IsValid() then
        self.active_debuffs = {}
        self.temporary_damage_queue = {}
        self.active_anti_heal_targets = {}
        self.inst:StopUpdatingComponent(self)
        return
    end

    -- 处理debuff
    for target, debuff_info in pairs(self.active_debuffs) do
        if target:IsValid() and not self:IsTargetImmune(target) then
            debuff_info.elapsed = debuff_info.elapsed + dt
            if debuff_info.elapsed >= debuff_info.duration then
                self:CancelDebuff(target)
            end
        else
            self:CancelDebuff(target)
        end
    end

    -- 处理队列中的临时伤害
    for id, damage_info in pairs(self.temporary_damage_queue) do
        if damage_info.target:IsValid() then
            damage_info.timer = damage_info.timer - dt
            if damage_info.timer <= 0 then
                self:ApplyTemporaryDamage(damage_info.target, damage_info.damage, damage_info.options)
                self.temporary_damage_queue[id] = nil
            end
        else
            self.temporary_damage_queue[id] = nil
        end
    end

    -- 如果没有活跃效果，停止更新
    if not next(self.active_debuffs) and not next(self.temporary_damage_queue) and self.inst:IsValid() then
        self.inst:StopUpdatingComponent(self)
    end
end

-- ======================
-- 攻击接口
-- ======================

-- 判断当前攻击是否是远程攻击
function TTL_wanly_damage:_IsCurrentAttackRanged()
    if not self.inst or not self.inst:IsValid() then
        return false
    end

    if self.inst:HasTag("rangedweapon") then
        return true
    end

    local weapon = self:_GetCurrentWeapon()
    if weapon then
        return self:_IsWeaponRanged(weapon)
    end

    if self.inst.components.combat then
        local combat_weapon = self.inst.components.combat:GetWeapon()
        if combat_weapon then
            return self:_IsWeaponRanged(combat_weapon)
        end
    end

    return false
end

-- 获取当前装备的武器
function TTL_wanly_damage:_GetCurrentWeapon()
    if not self.inst then return nil end
    if self.inst.components.inventory then
        return self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    end
    return nil
end

-- 判断武器是否是远程武器
function TTL_wanly_damage:_IsWeaponRanged(weapon)
    if not weapon then return false end
    if weapon:HasTag("rangedweapon") or
       weapon:HasTag("ranged") or
       weapon:HasTag("projectile") then
        return true
    end
    if weapon.components.projectile then
        return true
    end
    if weapon.components.complexprojectile and not weapon.components.complexprojectile.ismeleeweapon then
        return true
    end
    if weapon.components.weapon and weapon.components.weapon:CanRangedAttack() then
        return true
    end
    return false
end

function TTL_wanly_damage:DoAttack(target, options)
    options = options or {}
    local apply_dot = options.apply_dot ~= false
    local dot_duration = options.dot_duration or WANLY_DOT_DURATION
    local dot_interval = options.dot_interval or WANLY_DOT_INTERVAL
    local apply_anti_heal = options.apply_anti_heal or false
    local no_reduce = options.no_reduce or false
    local anti_heal_duration = options.anti_heal_duration or 5

    if not self.inst:IsValid() then return false end
    if self:IsTargetImmune(target) then return false end

    if self.instant_base_damage <= 0 and self.instant_percent <= 0 then
        return false
    end

    if TTT.TTCheckusenum(self.inst, 30) then
        local mult = TTT.TTgetentityMultiplier(self.inst, target, nil, 1)
        self:SetInstantBaseMultiplier(mult)
    end

    if self.onattack ~= nil then self.onattack(self.inst, target) end

    local is_ranged_attack = self:_IsCurrentAttackRanged() and not no_reduce

    local success = false
    local health = target.components.health
    if health ~= nil then
        local max_health = health:GetMaxWithPenalty()
        local base_damage = self.instant_base_damage * self.instant_base_multiplier
        local percent_damage = (max_health * self.instant_percent) * self.instant_percent_multiplier
        local total_damage = base_damage + percent_damage

        if is_ranged_attack then
            total_damage = total_damage * 0.5
        end

        success = self:ApplyTTL_wanly_damage(target, total_damage)
    end

    if apply_dot and (self.dot_base_damage > 0 or self.dot_percent > 0) then
        self:ApplyDoT(target, dot_duration, dot_interval)
    end

    if apply_anti_heal then
        self:ApplyAntiHeal(target, anti_heal_duration)
    end

    return success
end

-- 获取当前伤害配置
function TTL_wanly_damage:GetDamageConfig()
    return {
        instant_base = self.instant_base_damage,
        instant_percent = self.instant_percent,
        dot_base = self.dot_base_damage,
        dot_percent = self.dot_percent,
        instant_base_multiplier = self.instant_base_multiplier,
        instant_percent_multiplier = self.instant_percent_multiplier,
        dot_base_multiplier = self.dot_base_multiplier,
        dot_percent_multiplier = self.dot_percent_multiplier,
        enable_dot_debuff = self.enable_dot_debuff
    }
end

-- 重置所有伤害配置
function TTL_wanly_damage:ResetDamageConfig()
    self.instant_base_damage = 0
    self.dot_base_damage = 0
    self.instant_percent = 0
    self.dot_percent = 0
    self.instant_base_multiplier = 1.0
    self.instant_percent_multiplier = 1.0
    self.dot_base_multiplier = 1.0
    self.dot_percent_multiplier = 1.0
    self.enable_dot_debuff = false
end

return TTL_wanly_damage