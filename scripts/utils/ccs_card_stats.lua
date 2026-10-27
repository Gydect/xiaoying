local function GetValidCards(box, owner, includeunfinished)
    local cards = {}
    if box == nil or box.components.container == nil or owner == nil or owner.userid == nil then
        return cards
    end
    for _, card in pairs(box.components.container:GetItemsWithTag("ccs_card")) do
        local level = card.components.ccs_card_level
        if card:IsValid() and level ~= nil and (includeunfinished or level:IsMaxLevel()) and level.masterid == owner.userid then
            cards[card.prefab] = card
        end
    end
    return cards
end

local function GetCardCount(box, owner, requiremaxlevel)
    local count = 0
    for _ in pairs(GetValidCards(box, owner, not requiremaxlevel)) do
        count = count + 1
    end
    return count
end

local function GetMaxLevelCount(box, owner)
    return GetCardCount(box, owner, true)
end

local function GetEquippedBox(owner)
    if owner ~= nil and owner.components.inventory ~= nil then
        for _, item in pairs(owner.components.inventory.equipslots) do
            if item:HasTag("ccs_card_box") then
                return item
            end
        end
    end
end

local function GetCarriedCardLevels(owner)
    local levels, visited = {}, {}
    local visit
    visit = function(item)
        if item == nil or visited[item] then return end
        visited[item] = true
        local card = item.components.ccs_card_level
        if card ~= nil and card.masterid == owner.userid then
            levels[item.prefab] = math.max(levels[item.prefab] or 0, card:GetLevel())
        end
        local container = item.components.container
        if container ~= nil then
            for _, child in pairs(container.slots) do visit(child) end
        end
    end
    local inventory = owner.components.inventory
    if inventory ~= nil then
        for _, item in pairs(inventory.itemslots) do visit(item) end
        for _, item in pairs(inventory.equipslots) do visit(item) end
        visit(inventory.activeitem)
    end
    return levels
end

return {
    GetValidCards = GetValidCards,
    GetCardCount = GetCardCount,
    GetMaxLevelCount = GetMaxLevelCount,
    GetEquippedBox = GetEquippedBox,
    GetCarriedCardLevels = GetCarriedCardLevels,
}
