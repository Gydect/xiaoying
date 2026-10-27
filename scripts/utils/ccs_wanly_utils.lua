local fns

local ttlmod = require("utils/ccs_modenable")

local function CheckSpawnedLoot(loot)
    if loot.components.inventoryitem ~= nil then
        loot.components.inventoryitem:TryToSink()
    else
        local lootx, looty, lootz = loot.Transform:GetWorldPosition()
        if ShouldEntitySink(loot, true) or
            TheWorld.Map:IsPointNearHole(Vector3(lootx, 0, lootz)) then
            SinkEntity(loot)
        end
    end
end

--- 掉落物成组抛出函数
-- @param center_x, center_z,用于获取坐标和生成特效
-- @param loot_table 掉落物表，格式为 {prefab = count, ...}
-- @param radius 抛出半径范围，默认1.5
-- @param min_radius 最小抛出半径，默认0.5
local function spawn_grouped_loot(center_x, center_z, loot_table, radius, min_radius)
    if not loot_table or not next(loot_table) then
        return
    end
    
    -- 设置默认参数
    radius = radius or 0.1
    min_radius = min_radius or 0.1
    
    -- 遍历掉落物表
    for loot_prefab, total_count in pairs(loot_table) do
        if total_count > 0 then
            -- 获取该物品的实际堆叠上限
            local max_stack = 1  -- 默认堆叠上限
            
            local test_item = SpawnPrefab(loot_prefab)
            if test_item then
                if test_item.components.stackable then
                    max_stack = test_item.components.stackable.maxsize or 1
                end
                test_item:Remove()
            end
            
            local remaining = total_count
            
            -- 生成堆叠物品
            while remaining > 0 do
                local stack_size = math.min(remaining, max_stack)
                
                -- 生成物品
                local drop_item = SpawnPrefab(loot_prefab)
                if drop_item then
                    -- 关键：确保设置堆叠大小
                    if drop_item.components.stackable then
                        drop_item.components.stackable:SetStackSize(stack_size)
                    end
                    
                    -- 设置随机掉落位置
                    local angle = math.random() * 2 * PI
                    local drop_radius = math.random() * radius + min_radius
                    local drop_x = center_x + math.cos(angle) * drop_radius
                    local drop_z = center_z + math.sin(angle) * drop_radius
                    
                    drop_item.Transform:SetPosition(drop_x, 0, drop_z)
                    
                    -- 设置随机速度，类似原SpawnLootPrefab函数
                    if drop_item.Physics ~= nil then
                        drop_item.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
                        drop_item:DoTaskInTime(1, CheckSpawnedLoot)
                    end
                    
                    -- 掉落物品
                    if drop_item.components.inventoryitem then
                        drop_item.components.inventoryitem:OnDropped(true)
                    end
                    
                    -- 触发事件
                    drop_item:PushEvent("on_loot_dropped", {dropper = nil})
                    
                    remaining = remaining - stack_size
                else
                    break
                end
            end
        end
    end
end


-- 通用物品批量放置函数
-- doer: 玩家实体
-- prefab: 物品 prefab 名称
-- amount: 总数量
-- pos: 施法/掉落位置 (Vector3 或 {x, z})
function GiveOrDropBulk(doer, prefab, amount, pos)
    if amount <= 0 or not doer or not doer:IsValid() then
        return
    end

    local inventory = doer.components.inventory
    if not inventory then
        spawn_grouped_loot(pos.x, pos.z, { [prefab] = amount })
        return
    end

    local max_stack = 1
    local test_item = SpawnPrefab(prefab)
    if test_item then
        if test_item.components.stackable then
            max_stack = test_item.components.stackable.maxsize
        end
        test_item:Remove()
    end

    local remaining = amount

    for _, item in pairs(inventory.itemslots) do
        if remaining <= 0 then break end
        if item and item.prefab == prefab and item.components.stackable then
            local current = item.components.stackable:StackSize()
            local room = max_stack - current
            if room > 0 then
                local to_add = math.min(room, remaining)
                item.components.stackable:SetStackSize(current + to_add)
                remaining = remaining - to_add
            end
        end
    end

    local all_containers = {}
    for _, item in pairs(inventory.equipslots) do
        if item and item.components.container then
            table.insert(all_containers, item.components.container)
        end
    end
    for _, item in pairs(inventory.itemslots) do
        if item and item.components.container then
            table.insert(all_containers, item.components.container)
        end
    end

    local infinite_containers = {}
    for _, cont in ipairs(all_containers) do
        if cont.infinitestacksize then
            table.insert(infinite_containers, cont)
        end
    end

    local function IsInfinite(cont)
        return cont.infinitestacksize
    end

    for _, cont in ipairs(all_containers) do
        if remaining <= 0 then break end
        for _, slot_item in pairs(cont.slots) do
            if remaining <= 0 then break end
            if slot_item and slot_item.prefab == prefab and slot_item.components.stackable then
                local current = slot_item.components.stackable:StackSize()
                local room = IsInfinite(cont) and remaining or (max_stack - current)
                if room > 0 then
                    local to_add = math.min(room, remaining)
                    slot_item.components.stackable:SetStackSize(current + to_add)
                    remaining = remaining - to_add
                end
            end
        end
    end

    if remaining > 0 then
        for _, cont in ipairs(infinite_containers) do
            if remaining <= 0 then break end
            for i = 1, cont.numslots do
                if not cont.slots[i] then
                    local new_item = SpawnPrefab(prefab)
                    if new_item then
                        if new_item.components.stackable then
                            new_item.components.stackable:SetStackSize(remaining)
                        end
                        if cont:GiveItem(new_item, i) then
                            remaining = 0
                        else
                            new_item:Remove()
                        end
                    end
                    break
                end
            end
        end
    end

    if remaining > 0 then
        while remaining > 0 do
            local stack_size = math.min(remaining, max_stack)
            local new_item = SpawnPrefab(prefab)
            if new_item then
                if new_item.components.stackable and stack_size > 1 then
                    new_item.components.stackable:SetStackSize(stack_size)
                end
                if inventory:GiveItem(new_item) then
                    remaining = remaining - stack_size
                else
                    new_item:Remove()
                    break
                end
            else
                break
            end
        end
    end

    if remaining > 0 then
        spawn_grouped_loot(pos.x, pos.z, { [prefab] = remaining })
    end
end


local function ttlFnDecorator(obj, key, beforeFn, afterFn, isUseBeforeReturn)
    assert(type(obj) == "table")
    assert(beforeFn == nil or type(beforeFn) == "function",
           "beforeFn must be nil or a function")
    assert(afterFn == nil or type(afterFn) == "function",
           "afterFn must be nil or a function")

    local oldVal = obj[key]

    obj[key] = function(...)
        local retTab, isSkipOld, newParam, r
        if beforeFn then retTab, isSkipOld, newParam = beforeFn(...) end

        if type(oldVal) == "function" and not isSkipOld then
            if newParam ~= nil then
                r = {oldVal(unpack(newParam))}
            else
                r = {oldVal(...)}
            end
            if not isUseBeforeReturn then retTab = r end
        end

        if afterFn then retTab = afterFn(retTab, ...) end

        if retTab == nil then return nil end
        return unpack(retTab)
    end
end


-- 勋章击杀检测
local medal_list = {
    valkyrie_examine_certificate = true,
    valkyrie_test_certificate = true,
    valkyrie_certificate = true,
    arrest_certificate = true,
    justice_certificate = true
}

local function TTGetEquippedMedals(attacker)
    if not (attacker and attacker:IsValid() and attacker.components and attacker.components.inventory) then
        return {}
    end
    
    local equipped_medals = {}
    
    -- 遍历勋章列表，检查哪些是装备的
    for medal_prefab, _ in pairs(medal_list) do
        local medal = attacker.components.inventory:EquipMedalWithName(medal_prefab)
        if medal then
            equipped_medals[medal_prefab] = medal
        end
    end
    
    return equipped_medals
end

local function TTCheckMedalKill(target, attacker)
    if not (target and attacker and attacker:IsValid()) then
        return false
    end

    if not ttlmod:MedalEnable() then return end
    
    -- 获取装备的勋章
    local equipped_medals = TTGetEquippedMedals(attacker)
    
    if next(equipped_medals) == nil then
        return false  -- 没有装备任何勋章
    end
    
    -- 触发每个装备的勋章
    for medal_prefab, medal in pairs(equipped_medals) do
        -- 触发勋章击杀事件
        attacker:PushEvent("medal_killed", {
            victim = target,
            prefab = medal_prefab
        })
    end
    
    return true
end


local function ttlrealhealth(player, target, num, cause, afflicter, force_set)
    if player == nil or num == nil then return end

    local ph = player.components.health

    if target == nil then
        -- 操作对象为玩家自身
        if ph and not ph:IsDead() then
            local old_health = ph.currenthealth
            local old_percent = ph:GetPercent()

            if force_set then
                ph:SetVal(math.abs(num), cause, afflicter)
            else
                ph:SetVal(ph.currenthealth + num, cause, afflicter)
            end

            ph:DoDelta(0.000001, false, "xianshi", true, afflicter, true)

            local actual_amount = ph.currenthealth - old_health

            player:PushEvent("healthdelta", {
                oldpercent = old_percent,
                newpercent = ph:GetPercent(),
                overtime = false,
                cause = cause,
                afflicter = afflicter,
                amount = actual_amount
            })
        end
    else
        -- 操作对象为目标实体
        local th = target.components.health
        if not th then return end

        if player:HasTag("ttrandom") then
            num = num * (0.9 + (1.1 * math.random()))
        end

        local old_health = th.currenthealth
        local old_percent = th:GetPercent()

        th:SetVal(th.currenthealth + num, cause, afflicter)
        th:DoDelta(-0.000001, false, "xianshi", true, afflicter, true)

        local actual_amount = th.currenthealth - old_health
        local new_percent = th:GetPercent()

        if target:IsValid() then
            target:PushEvent("healthdelta", {
                oldpercent = old_percent,
                newpercent = new_percent,
                overtime = false,          
                cause = cause,
                afflicter = afflicter,
                amount = actual_amount     
            })
        end

        if th:IsDead() and player:IsValid() then
            TTCheckMedalKill(target, player)
            player:PushEvent("killed", {victim = target})
            if target.components.combat ~= nil and
                target.components.combat.onkilledbyother ~= nil then
                target.components.combat.onkilledbyother(target, player)
            end
        end
    end
end


local function ttlSetTreadWaterCollides(player,canTread)
	if player ~= nil and player.Physics ~= nil and not player:HasTag("playerghost") then
		player.medal_canTread = canTread
		player.Physics:ClearCollisionMask()
		player.Physics:CollidesWith(canTread and COLLISION.GROUND or COLLISION.WORLD)
		player.Physics:CollidesWith(COLLISION.OBSTACLES)
		player.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
		player.Physics:CollidesWith(COLLISION.CHARACTERS)
		player.Physics:CollidesWith(COLLISION.GIANTS)
		player.Physics:Teleport(player.Transform:GetWorldPosition())
	end

    if player.tashui_task then 
        player.tashui_task:Cancel()
        player.tashui_task = nil
    end

    if canTread then 
        player.tashui_task = player:DoPeriodicTask(0.5,function()
            if player.components.drownable ~= nil then
                if player.components.drownable.enabled ~= false then
                    player.components.drownable.enabled = false
                end
            end
            RemovePhysicsColliders(player)
        end)
    else
        if player.components.drownable ~= nil then
            if player.components.drownable.enabled == false then
                player.components.drownable.enabled = true
            end
        end
        ChangeToCharacterPhysics(player)
    end

end

local function ccsgetcm(inst)
	if not inst then return end

    if not inst.components.CcsCounterManager then 
        inst:AddComponent("CcsCounterManager")
    end
    
    return inst.components.CcsCounterManager 
end



local function InitQueue(target)
    if not target._bufffx_queue then
        target._bufffx_queue = {}
    end
end

-- inst:        buff 实例
-- target:      目标实体
-- createFx:    生成特效的回调，形式 function(target) return fx end
--              这个回调会被保存在 inst._createFx 中，供日后重建使用
function Attach(inst, target, createFx)
    if not inst or not target then return end
    InitQueue(target)
    local queue = target._bufffx_queue

    -- 1. 移除当前正在显示的特效（如果存在）
    if #queue > 0 then
        local last_inst = queue[#queue]
        if last_inst._fx then
            last_inst._fx:Remove()
            last_inst._fx = nil
        end
    end

    -- 2. 保存创建特效的回调到 buff 实例上（供重建用）
    inst._createFx = createFx

    -- 3. 创建并显示当前 buff 的特效
    local fx = nil
    if createFx then
        fx = createFx(target)
    end
    inst._fx = fx

    -- 4. 加入队列末尾
    table.insert(queue, inst)
end

function Detach(inst, target)
    if not inst or not target then return end
    local queue = target._bufffx_queue
    if not queue then return end

    -- 1. 找到自己在队列中的位置
    local idx = nil
    for i, v in ipairs(queue) do
        if v == inst then
            idx = i
            break
        end
    end
    if not idx then return end

    local was_last = (idx == #queue)
    table.remove(queue, idx)

    -- 2. 如果移除的是队尾（当前显示的特效）
    if was_last then
        -- 移除自己的特效
        if inst._fx then
            inst._fx:Remove()
            inst._fx = nil
        end
        -- 如果还有前一个 buff，则重建并显示它的特效
        if #queue > 0 then
            local new_last = queue[#queue]
            if new_last._createFx then
                local fx = new_last._createFx(target)
                new_last._fx = fx
                -- fx 生成后默认就是显示状态，无需额外操作
            end
        end
    else
        -- 不是队尾，自己的特效可能早就被移除了，这里保险清空引用即可
        if inst._fx then
            inst._fx:Remove()
            inst._fx = nil
        end
    end

    -- 清理 buff 实例上保存的回调引用（可选）
    inst._createFx = nil
end


function TTgetentityMultiplier(inst, target, weapon, multiplier)
    -- 参数验证
    if inst == nil then
        return 1
    end
    
    -- 获取攻击者的战斗组件
    local combat = inst.components.combat
    if combat == nil then
        return 1
    end
    
    -- 如果未提供武器，尝试从攻击者手上获取武器
    if weapon == nil then
        -- 检查是否有库存组件
        if inst.components.inventory ~= nil then
            weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            -- 确保获取的物品是武器
            if weapon ~= nil and weapon.components.weapon == nil then
                weapon = nil
            end
        end
        
        -- 如果是骑乘状态，检查坐骑
        if weapon == nil and inst.components.rider ~= nil and inst.components.rider:IsRiding() then
            local mount = inst.components.rider:GetMount()
            if mount ~= nil then
                combat = mount.components.combat or combat
            end
        end
    end
    
    -- 处理目标参数
    local final_target = target
    if final_target == nil then
        -- 如果没有提供目标，使用攻击者的当前目标
        final_target = combat.target
    end
    
    -- 方案1：直接调用方法（如果已定义）
    if combat.GetCompleteAttackerMultiplier_ccs ~= nil then
        return combat:GetCompleteAttackerMultiplier_ccs(inst, final_target, weapon, multiplier)
    end
      
end

local EQUIP_SLOTS = {
    EQUIPSLOTS.HANDS,
    EQUIPSLOTS.BODY,
    EQUIPSLOTS.HEAD,
    EQUIPSLOTS.NECK,
    EQUIPSLOTS.BACK,
    EQUIPSLOTS.BELLY,
}

local function GetInventory(inst)
    return inst.components.inventory or inst.replica.inventory
end

local function GetEquippedItem(inventory, slot)
    if not inventory then return nil end
    if inventory.GetEquippedItem then
        return inventory:GetEquippedItem(slot)
    end
    return inventory.equipslots and inventory.equipslots[slot]
end

local function ForEachEquipped(inst, fn)
    local inventory = GetInventory(inst)
    if not inventory then return end

    -- 标准槽位
    for _, slot in ipairs(EQUIP_SLOTS) do
        local item = GetEquippedItem(inventory, slot)
        if item and fn(item, slot) then
            return true
        end
    end

    -- 兜底：遍历 equipslots 字典（含 MOD 自定义槽位）
    if inventory.equipslots then
        for slot, item in pairs(inventory.equipslots) do
            if item and fn(item, slot) then
                return true
            end
        end
    end
end

-- 检查是否装备了特定标签的物品
local function TTLiseqbytag(inst, tag)
    return ForEachEquipped(inst, function(item) return item:HasTag(tag) end)
end

-- 检查是否装备了特定预制体的物品
local function TTLiseqbypre(inst, prefab)
    return ForEachEquipped(inst, function(item) return item.prefab == prefab end)
end

-- 获取第一个匹配预制体的装备物品
local function TTLgeteqbypre(inst, prefab)
    local found = nil
    ForEachEquipped(inst, function(item)
        if item.prefab == prefab then found = item; return true end
    end)
    return found
end

-- 获取第一个匹配标签的装备物品
local function TTLgeteqbytag(inst, tag)
    local found = nil
    ForEachEquipped(inst, function(item)
        if item:HasTag(tag) then found = item; return true end
    end)
    return found
end

-- 防止特殊禁疗的特殊目标
local TTnohealthcheck_table = {"klaus", "zhijiang_soulreaver"}
local TTnohealthcheck_table_s = {"xd_ziyunboss"}

local function TTnohealthcheck(value)

    for k, v in pairs(TTnohealthcheck_table_s) do
        if v == value.prefab then return true end
    end

    for k, v in pairs(TTnohealthcheck_table) do
        if v == value.prefab and value.IsUnchained ~= nil and
            not value:IsUnchained() then return true end
    end
    return false
end

-- 延迟执行任务，自动取消之前的同名任务，防止重复触发
-- target: 要挂载任务的实体
-- taskField: 存储任务句柄的字段名（字符串）
-- delay: 延迟秒数
-- fn: 任务回调函数
local function ScheduleTask(target, taskField, delay, fn)
    if target[taskField] then
        target[taskField]:Cancel()
        target[taskField] = nil
    end
    target[taskField] = target:DoTaskInTime(delay, function()
        target[taskField] = nil
        fn()
    end)
end

-- 清理旧特效
local function TTLRemoveWeaponFX(inst)
    if inst._weapon_fx then
        inst._weapon_fx:Remove()
        inst._weapon_fx = nil
    end
end

-- 通用装备皮肤与特效设置函数
-- 参数说明：
--   owner         玩家实例
--   inst          装备实例（用于保存特效引用）
--   swap_symbol   动画挂点，如 "swap_object"（武器）、"swap_body_tall"（背包）
--   build         皮肤 build 名
--   symbol_name   build 中的符号名，nil 则不替换模型,有fx的话可有可无
--   fx_prefab     特效预制件名，nil 则不生成特效
--   fx_anim       特效动画名（可选）
--   ox, oy, oz    主要偏移量，对应 FollowSymbol 的 offsetX, offsetY, offsetZ
--                 （武器特效的位置由它们决定，例如 0,160,0）
--   targetSymbol  要跟随的子符号名，nil 则跟随整个符号（可选）
--   postX, postY, postZ  微调偏移，对应 FollowSymbol 的最后三个参数（可选）
local function TTLApplyWeaponSkinAndFX(owner, inst, swap_symbol, build, symbol_name,
                                        fx_prefab, fx_anim, ox, oy, oz,
                                        targetSymbol, postX, postY, postZ)
    -- 1. 替换模型符号
    if symbol_name then
        owner.AnimState:OverrideSymbol(swap_symbol, build, symbol_name)
    end

    -- 2. 清除旧特效
    TTLRemoveWeaponFX(inst)

    if not fx_prefab then return end

    -- 3. 生成新特效
    local fx = SpawnPrefab(fx_prefab)
    if fx then
        fx.entity:SetParent(owner.entity)

        -- 背包类装备置于身体后方（避免遮挡），武器不影响
        fx.AnimState:SetFinalOffset(1)

        -- FollowSymbol 参数：
        -- (guid, symbol, offsetX, offsetY, offsetZ, useSpriteOffsets, targetSymbol, postX, postY, postZ)
        fx.Follower:FollowSymbol(
            owner.GUID,
            swap_symbol,
            ox or 0, oy or 0, oz or 0,        
            true,                              
            targetSymbol,                      
            postX or 0, postY or 0, postZ or 0 
        )

        if fx_anim then
            fx.AnimState:PlayAnimation(fx_anim, true)
        end

        inst._weapon_fx = fx
    end
end

local ttspecialmonster = {
    "gelblob", "elecarmet", "houndmound", "wasphive",
    "eyeofterror_mini_grounded","corrupt_heart"
}

local function isintable(value, tb)
    for k, v in pairs(tb) do if v == value then return true end end
    return false
end

local function IsEnemyPre(ent)
    if ent.components.health == nil or ent.components.health:IsDead() or
        ent.components.combat == nil then return true end
    if ent.sg ~= nil and
        (ent.sg:HasStateTag("flight") or ent.sg:HasStateTag("invisible")) then
        return true
    end
end

local function IsPlayerFollower(ent)
    if ent.components.follower ~= nil then
        local leader = ent.components.follower:GetLeader()
        if leader ~= nil then
            if leader:HasTag("player") then return true end
            if leader.components.inventoryitem ~= nil then -- leader 是个物品
                leader = leader.components.inventoryitem:GetGrandOwner()
                return leader ~= nil and leader:HasTag("player")
            end
        end
    end
    return false
end

local function IsEnemy_player(inst, ent) -- 是否为 全体玩家 的当前敌人
    if IsEnemyPre(ent) then return false end
    -- if inst == nil then return true end

    local ent_target = ent.components.combat.target
    if ent_target ~= nil and ent_target:HasTag("player") then -- 仇视玩家，肯定是敌人
        return true
    end

    local team_threat
    if ent.components.teamattacker ~= nil and
        ent.components.teamattacker.teamleader ~= nil then
        team_threat = ent.components.teamattacker.teamleader.threat
        if team_threat ~= nil and team_threat:HasTag("player") then -- 团队仇视玩家，肯定是敌人。主要是蝙蝠、企鹅在用这个机制
            return true
        end
    end

    if IsPlayerFollower(ent) then -- ent 跟随着玩家，就不要攻击了，防止后面逻辑引起跟随者内战
        return false
    end
    if ent_target ~= nil and IsPlayerFollower(ent_target) then -- ent 想攻击玩家的跟随者，打它！
        return true
    end
    if team_threat ~= nil and IsPlayerFollower(team_threat) then -- ent 想攻击玩家的跟随者，打它！
        return true
    end
    return false
end

local function ttchecktarget(inst, target) -- 是否为合法目标
    if target.components.freezable or target:HasTag("monster") or
        IsEnemy_player(inst, target) or
        isintable(target.prefab, ttspecialmonster) then return true end
    return false
end

fns = {
    spawn_grouped_loot = spawn_grouped_loot,
    TTLRemoveWeaponFX = TTLRemoveWeaponFX,
    TTLApplyWeaponSkinAndFX = TTLApplyWeaponSkinAndFX,
    TTCheckMedalKill = TTCheckMedalKill,
    ScheduleTask = ScheduleTask,
    ttchecktarget = ttchecktarget,
    GiveOrDropBulk = GiveOrDropBulk,
    ttlFnDecorator = ttlFnDecorator,
    ttlrealhealth = ttlrealhealth,
    ttlSetTreadWaterCollides = ttlSetTreadWaterCollides,
    ccsgetcm = ccsgetcm,
    Attach = Attach,
    Detach = Detach,
    TTgetentityMultiplier = TTgetentityMultiplier,
    TTLiseqbytag = TTLiseqbytag,
    TTLiseqbypre = TTLiseqbypre,
    TTLgeteqbypre = TTLgeteqbypre,
    TTLgeteqbytag = TTLgeteqbytag,
    TTnohealthcheck = TTnohealthcheck,
}

return fns