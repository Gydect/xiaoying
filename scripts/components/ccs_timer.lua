local TTL_TIMER = Class(function(self, inst)
    self.inst = inst
    self._timers = {}  -- key -> { cooldown, last, real, _end_cb, _end_task, _permanent }
end)

local function GetNow(real)
    return real and GetTimeRealSeconds() or GetTime()
end

local function StartEndCheck(self, key)
    local timer = self._timers[key]
    if not timer or not timer._end_cb then return end
    if timer._end_task then return end

    timer._end_task = self.inst:DoPeriodicTask(0.2, function()
        if not self.inst:IsValid() then
            if timer._end_task then
                timer._end_task:Cancel()
                timer._end_task = nil
            end
            return
        end

        if self:IsReady(key) then
            local cb = timer._end_cb
            timer._end_task:Cancel()
            timer._end_task = nil
            if cb then
                cb(self.inst, key)
            end
            if not timer._permanent then
                timer._end_cb = nil
            end
        end
    end, nil, "ttl_timer_endcheck_" .. key)
end

function TTL_TIMER:Configure(key, ti, real)
    local timer = self._timers[key]
    if not timer then
        timer = {}
        self._timers[key] = timer
    end
    timer.cooldown = math.max(ti or 0, 0)
    timer.real = real or false
    timer.last = GetNow(timer.real) - timer.cooldown - 1
    if timer._end_task then
        timer._end_task:Cancel()
        timer._end_task = nil
    end
end

function TTL_TIMER:Try(key)
    local timer = self._timers[key]
    if not timer then
        --print(string.format("[TTL_TIMER] Try 键值 [%s] 未配置定时器，直接允许执行。", tostring(key)))
        return true
    end
    local now = GetNow(timer.real)
    if (now - timer.cooldown) > timer.last then
        timer.last = now
        if timer._end_cb and timer._permanent and not timer._end_task then
            StartEndCheck(self, key)
        end
        --print(string.format("[TTL_TIMER] Try 键值 [%s] 冷却结束，允许执行。", tostring(key)))
        return true
    end
    local remaining = timer.last + timer.cooldown - now
    --print(string.format("[TTL_TIMER] Try 键值 [%s] 还在冷却中，剩余 %.2f 秒。", tostring(key), remaining))
    return false
end

function TTL_TIMER:IsReady(key)
    local timer = self._timers[key]
    if not timer then return true end
    local now = GetNow(timer.real)
    return (now - timer.cooldown) > timer.last
end

function TTL_TIMER:Reset(key)
    local timer = self._timers[key]
    if timer then
        timer.last = GetNow(timer.real)
    end
end

function TTL_TIMER:GetRemaining(key)
    local timer = self._timers[key]
    if not timer then return 0 end
    local now = GetNow(timer.real)
    local remaining = timer.last - (now - timer.cooldown)
    return math.max(0, remaining)
end

function TTL_TIMER:SetCooldown(key, newti)
    local timer = self._timers[key]
    if timer then
        timer.cooldown = math.max(newti, 0)
    end
end

function TTL_TIMER:GetCooldown(key)
    local timer = self._timers[key]
    return timer and timer.cooldown or 0
end

function TTL_TIMER:SetOnCooldownEnd(key, fn, permanent)
    local timer = self._timers[key]
    if not timer then return end

    if timer._end_task then
        timer._end_task:Cancel()
        timer._end_task = nil
    end
    timer._end_cb = fn
    timer._permanent = permanent or false

    if fn and not permanent then
        StartEndCheck(self, key)
    end
end

-----------------------------------------------------------
-- 持久化保存（无变化）
-----------------------------------------------------------
function TTL_TIMER:OnSave()
    if next(self._timers) == nil then return {} end
    local data = {}
    for key, timer in pairs(self._timers) do
        local entry = {
            cooldown = timer.cooldown,
            real     = timer.real,
        }
        if timer.real then
            entry.last = timer.last
        else
            entry.remaining = self:GetRemaining(key)
        end
        data[key] = entry
    end
    return { timers = data }
end

-----------------------------------------------------------
-- 持久化加载（修复回调丢失 & 加载后立即触发就绪回调）
-----------------------------------------------------------
function TTL_TIMER:OnLoad(data)
    if not data or not data.timers then return end

    for key, tdata in pairs(data.timers) do
        local timer = self._timers[key]
        if not timer then
            timer = {}
            self._timers[key] = timer
        end

        local real = tdata.real or false
        local cooldown = tdata.cooldown or 0
        local now = GetNow(real)
        local last

        if real then
            last = tdata.last or (now - cooldown - 1)
        else
            local remaining = tdata.remaining or 0
            if remaining > 0 then
                last = now - cooldown + remaining
            else
                last = now - cooldown - 1
            end
        end

        -- 只更新数据，保留 _end_cb、_permanent 等
        timer.cooldown = cooldown
        timer.real = real
        timer.last = last

        -- 加载后处理：
        -- 如果设置了永久回调，且当前冷却未就绪（正在冷却中），启动监测任务
        if timer._end_cb and timer._permanent and not self:IsReady(key) then
            StartEndCheck(self, key)
        end
    end
end

return TTL_TIMER