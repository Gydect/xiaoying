local function WatchOwner(inst, onchanged)
    local watched = {}
    local task
    local refresh
    local function schedule()
        if task == nil then
            task = inst:DoTaskInTime(0, function()
                task = nil
                refresh()
            end)
        end
    end
    local function clear()
        for _, owner in ipairs(watched) do
            inst:RemoveEventCallback("onputininventory", schedule, owner)
            inst:RemoveEventCallback("ondropped", schedule, owner)
            inst:RemoveEventCallback("onremove", schedule, owner)
        end
        watched = {}
    end
    refresh = function()
        clear()
        local owner = inst.components.inventoryitem.owner
        while owner ~= nil and owner.components.inventoryitem ~= nil do
            table.insert(watched, owner)
            inst:ListenForEvent("onputininventory", schedule, owner)
            inst:ListenForEvent("ondropped", schedule, owner)
            inst:ListenForEvent("onremove", schedule, owner)
            owner = owner.components.inventoryitem.owner
        end
        onchanged(inst, owner)
    end
    inst:ListenForEvent("onputininventory", schedule)
    inst:ListenForEvent("ondropped", schedule)
    inst:ListenForEvent("onownerputininventory", schedule)
    inst:ListenForEvent("onownerdropped", schedule)
    inst:ListenForEvent("onremove", function()
        if task ~= nil then task:Cancel() end
        clear()
        onchanged(inst, nil)
    end)
    schedule()
end

local function RestrictToCcs(inst)
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.grabbableoverridetag = "ccs"
    inst.components.equippable.restrictedtag = "ccs"
    WatchOwner(inst, function(item, owner)
        if owner ~= nil and owner:HasTag("player") and not owner:HasTag("ccs") then
            local holder = item.components.inventoryitem.owner
            local inventory = holder and (holder.components.inventory or holder.components.container)
            if inventory ~= nil then
                inventory:DropItem(item)
            end
        end
    end)
end

return { WatchOwner = WatchOwner, RestrictToCcs = RestrictToCcs }
