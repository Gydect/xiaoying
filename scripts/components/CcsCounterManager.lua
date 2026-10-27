-- 通用的计数防重组件
local TTCounterManager = Class(function(self, inst)
    self.inst = inst
    self.counters = {}
    self.flags = {}
    self.added_tags = {}           -- 记录我们添加的标签
    self.added_components = {}     -- 记录我们添加的组件
    self.modified_properties = {}  -- 记录我们修改的属性 {组件名 = {属性名 = 原始值}}
    self.modified_instance_properties = {} -- 记录我们修改的实例属性 {属性名 = 原始值}
end)

-- 计数器管理功能
function TTCounterManager:ManageCounter(counter_key, delta, on_first, on_last)
    -- 初始化计数器
    if self.counters[counter_key] == nil then
        self.counters[counter_key] = 0
    end
    
    local old_count = self.counters[counter_key]
    self.counters[counter_key] = self.counters[counter_key] + delta
    local new_count = self.counters[counter_key]
    
    -- 处理计数变化
    if delta > 0 then
        -- 增加计数
        if old_count == 0 and new_count == 1 and on_first then
            on_first()
        end
    else
        -- 减少计数
        if old_count == 1 and new_count == 0 and on_last then
            on_last()
        end
        
        -- 清理计数器
        if new_count <= 0 then
            self.counters[counter_key] = nil
            self.flags[counter_key] = nil
        end
    end
end

function TTCounterManager:SetFlag(flag_key, value)
    self.flags[flag_key] = value
end

function TTCounterManager:GetFlag(flag_key)
    return self.flags[flag_key]
end

-- 标签管理功能
function TTCounterManager:AddTags(tags)
    if not self.inst or not self.inst:IsValid() or not tags then return end

    if type(tags) == "string" then 
        local check_key = "ttlhas_"..tags.."_check"
        
        if self.inst:HasTag(tags) then 
            self.inst[check_key] = true
        else
            self.inst[check_key] = false
            self.inst:AddTag(tags) 
            -- 记录我们添加的标签
            self.added_tags[tags] = true
        end
    end

    if type(tags) == "table" then  
        for _, v in ipairs(tags) do 
            if v and type(v) == "string" then
                local check_key = "ttlhas_"..v.."_check"

                if self.inst:HasTag(v) then 
                    self.inst[check_key] = true
                else
                    self.inst[check_key] = false
                    self.inst:AddTag(v)
                    -- 记录我们添加的标签
                    self.added_tags[v] = true
                end
            end
        end
    end
end

function TTCounterManager:RemoveTags(tags)
    if not self.inst or not self.inst:IsValid() or not tags then return end

    if type(tags) == "string" then 
        local check_key = "ttlhas_"..tags.."_check"
        
        -- 只有原本没有这个标签才移除（是我们添加的）
        if self.inst[check_key] == false then
            self.inst:RemoveTag(tags)
            -- 从记录中移除
            self.added_tags[tags] = nil
        end
        -- 清除检查记录
        self.inst[check_key] = nil
    end

    if type(tags) == "table" then
        for _, v in ipairs(tags) do 
            if v and type(v) == "string" then
                local check_key = "ttlhas_"..v.."_check"
                
                if self.inst[check_key] == false then
                    self.inst:RemoveTag(v)
                    -- 从记录中移除
                    self.added_tags[v] = nil
                end
                -- 清除检查记录
                self.inst[check_key] = nil
            end
        end
    end
end

-- 组件管理功能
function TTCounterManager:AddComponents(components)
    if not self.inst or not self.inst:IsValid() or not components then return end

    if type(components) == "string" then 
        -- 检查是否已经有这个组件
        if not self.inst.components[components] then
            self.inst:AddComponent(components)
            -- 记录我们添加的组件
            self.added_components[components] = true
        end
    end

    if type(components) == "table" then
        for _, v in ipairs(components) do 
            if v and type(v) == "string" then
                if not self.inst.components[v] then
                    self.inst:AddComponent(v)
                    -- 记录我们添加的组件
                    self.added_components[v] = true
                end
            end
        end
    end
end

function TTCounterManager:RemoveComponents(components)
    if not self.inst or not self.inst:IsValid() or not components then return end

    if type(components) == "string" then 
        -- 只有是我们添加的组件才移除
        if self.added_components[components] then
            self.inst:RemoveComponent(components)
            self.added_components[components] = nil
        end
    end

    if type(components) == "table" then
        for _, v in ipairs(components) do 
            if v and type(v) == "string" then
                if self.added_components[v] then
                    self.inst:RemoveComponent(v)
                    self.added_components[v] = nil
                end
            end
        end
    end
end

-- 属性管理功能
function TTCounterManager:SetComponentProperty(component_name, property_name, value)
    if not self.inst or not self.inst:IsValid() then return false end
    
    -- 如果组件不存在，先添加组件
    if not self.inst.components[component_name] then
        self:AddComponents(component_name)
    end
    
    local component = self.inst.components[component_name]
    if not component then
        return false
    end
    
    -- 初始化属性记录
    if not self.modified_properties[component_name] then
        self.modified_properties[component_name] = {}
    end
    
    -- 获取当前属性值
    local current_value = component[property_name]
    
    -- 如果属性不存在，我们仍然记录并尝试设置
    if current_value == nil then
        -- 记录原始值为 nil
        if self.modified_properties[component_name][property_name] == nil then
            self.modified_properties[component_name][property_name] = {
                original_value = nil,
                method_used = nil,
                is_new_property = true
            }
        end
        
        -- 尝试直接设置新值
        local success, err = pcall(function()
            component[property_name] = value
        end)
        
        if success then
            return true
        else
            -- 如果直接设置失败，尝试使用方法
            return self:TrySetPropertyWithMethod(component, component_name, property_name, value)
        end
    end
    
    -- 如果属性已存在，检查是否需要记录原始值
    if self.modified_properties[component_name][property_name] == nil then
        -- 首次修改，记录原始值
        self.modified_properties[component_name][property_name] = {
            original_value = current_value,
            method_used = nil,
            is_new_property = false
        }
    end
    
    -- 比较当前值和新值，如果相同则不需要修改
    if self:AreValuesEqual(current_value, value) then
        return true -- 值相同，不需要修改
    end
    
    -- 尝试直接设置属性
    local success, err = pcall(function()
        component[property_name] = value
    end)
    
    if success then
        return true
    else
        -- 如果直接设置失败，尝试使用方法
        return self:TrySetPropertyWithMethod(component, component_name, property_name, value)
    end
end

-- 尝试使用方法设置属性
function TTCounterManager:TrySetPropertyWithMethod(component, component_name, property_name, value)
    -- 生成可能的方法名
    local method_names = {
        "Set" .. property_name:sub(1,1):upper() .. property_name:sub(2),
        "Enable" .. property_name:sub(1,1):upper() .. property_name:sub(2),
        property_name -- 直接使用方法名
    }
    
    -- 尝试每个可能的方法
    for _, method_name in ipairs(method_names) do
        if component[method_name] then
            -- 调用方法
            local method_success, method_err = pcall(function()
                component[method_name](component, value)
            end)
            
            if method_success then
                -- 更新记录，标记使用了哪个方法
                self.modified_properties[component_name][property_name].method_used = method_name
                return true
            end
        end
    end
    
    -- 所有方法都失败
    print(string.format("TTCounterManager: 无法设置组件 %s 的属性 %s，所有方法都失败", component_name, property_name))
    return false
end

-- 比较两个值是否相等（处理各种类型）
function TTCounterManager:AreValuesEqual(a, b)
    if type(a) ~= type(b) then
        return false
    end
    
    if type(a) == "table" then
        -- 简单表格比较（不处理嵌套表格）
        if #a ~= #b then
            return false
        end
        
        for k, v in pairs(a) do
            if b[k] ~= v then
                return false
            end
        end
        
        for k, v in pairs(b) do
            if a[k] ~= v then
                return false
            end
        end
        
        return true
    else
        return a == b
    end
end

-- 恢复组件属性到原始值
function TTCounterManager:RevertComponentProperty(component_name, property_name)
    if not self.modified_properties[component_name] or 
       not self.modified_properties[component_name][property_name] then
        return false
    end
    
    local component = self.inst.components[component_name]
    if not component then
        return false
    end
    
    local record = self.modified_properties[component_name][property_name]
    local original_value = record.original_value
    
    -- 如果使用了方法设置，尝试使用方法恢复
    if record.method_used then
        -- 尝试使用相同的方法恢复
        if component[record.method_used] then
            local success, err = pcall(function()
                component[record.method_used](component, original_value)
            end)
            
            if success then
                -- 清除记录
                self.modified_properties[component_name][property_name] = nil
                
                -- 如果该组件没有其他修改的属性，清理组件记录
                if next(self.modified_properties[component_name]) == nil then
                    self.modified_properties[component_name] = nil
                end
                
                return true
            end
        end
        
        -- 如果使用方法恢复失败，尝试直接设置
        if original_value ~= nil then
            local success, err = pcall(function()
                component[property_name] = original_value
            end)
            
            if success then
                self.modified_properties[component_name][property_name] = nil
                if next(self.modified_properties[component_name]) == nil then
                    self.modified_properties[component_name] = nil
                end
                return true
            end
        end
        
        -- 如果是新创建的属性，直接设为 nil
        if record.is_new_property then
            local success, err = pcall(function()
                component[property_name] = nil
            end)
            
            if success then
                self.modified_properties[component_name][property_name] = nil
                if next(self.modified_properties[component_name]) == nil then
                    self.modified_properties[component_name] = nil
                end
                return true
            end
        end
        
        return false
    else
        -- 直接设置属性恢复
        local success, err = pcall(function()
            component[property_name] = original_value
        end)
        
        if success then
            -- 清除记录
            self.modified_properties[component_name][property_name] = nil
            
            -- 如果该组件没有其他修改的属性，清理组件记录
            if next(self.modified_properties[component_name]) == nil then
                self.modified_properties[component_name] = nil
            end
            
            return true
        else
            return false
        end
    end
end

-- 批量设置组件属性
function TTCounterManager:BatchSetComponentProperties(component_properties)
    if not self.inst or not self.inst:IsValid() or not component_properties then return end
    
    for component_name, properties in pairs(component_properties) do
        if type(properties) == "table" then
            for property_name, value in pairs(properties) do
                self:SetComponentProperty(component_name, property_name, value)
            end
        end
    end
end

-- 恢复所有组件属性
function TTCounterManager:RevertAllComponentProperties()
    for component_name, properties in pairs(self.modified_properties) do
        local component = self.inst.components[component_name]
        if component then
            for property_name, record in pairs(properties) do
                local original_value = record.original_value
                
                -- 如果使用了方法设置，尝试使用方法恢复
                if record.method_used then
                    if component[record.method_used] then
                        pcall(function()
                            component[record.method_used](component, original_value)
                        end)
                    elseif original_value ~= nil then
                        pcall(function()
                            component[property_name] = original_value
                        end)
                    elseif record.is_new_property then
                        pcall(function()
                            component[property_name] = nil
                        end)
                    end
                else
                    -- 直接设置属性恢复
                    pcall(function()
                        component[property_name] = original_value
                    end)
                end
            end
        end
    end
    self.modified_properties = {}
end

-- 实例属性管理
function TTCounterManager:SetInstanceProperty(property_name, value)
    if not self.inst or not self.inst:IsValid() then return false end
    
    -- 记录原始值（如果还没有记录的话）
    if self.modified_instance_properties[property_name] == nil then
        self.modified_instance_properties[property_name] = self.inst[property_name]
    end
    
    -- 设置新值（即使属性不存在也会创建）
    self.inst[property_name] = value
    return true
end

-- 批量设置实例属性
function TTCounterManager:BatchSetInstanceProperties(properties)
    if not self.inst or not self.inst:IsValid() or not properties then return end
    
    for property_name, value in pairs(properties) do
        self:SetInstanceProperty(property_name, value)
    end
end

-- 恢复实例属性到原始值
function TTCounterManager:RevertInstanceProperty(property_name)
    if not self.modified_instance_properties[property_name] then
        return false
    end
    
    self.inst[property_name] = self.modified_instance_properties[property_name]
    self.modified_instance_properties[property_name] = nil
    return true
end

-- 恢复所有实例属性
function TTCounterManager:RevertAllInstanceProperties()
    for property_name, original_value in pairs(self.modified_instance_properties) do
        self.inst[property_name] = original_value
    end
    self.modified_instance_properties = {}
end

-- 清理所有（包括标签、组件、属性等）
function TTCounterManager:Cleanup()
    -- 恢复所有组件属性
    self:RevertAllComponentProperties()
    
    -- 恢复所有实例属性
    self:RevertAllInstanceProperties()
    
    -- 移除所有我们添加的标签
    for tag, _ in pairs(self.added_tags) do
        self.inst:RemoveTag(tag)
    end
    
    -- 移除所有我们添加的组件
    for component, _ in pairs(self.added_components) do
        self.inst:RemoveComponent(component)
    end
    
    -- 清空所有记录
    self.counters = {}
    self.flags = {}
    self.added_tags = {}
    self.added_components = {}
end

-- 返回组件类
return TTCounterManager