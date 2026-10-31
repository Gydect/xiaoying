-- 由 ccs_skin.lua 恢复的明文版本；原文件和 modimport 入口保持不变。
-- 去除了字符串解码、无效状态循环及混淆变量名，保留原接口与历史行为。
-- 加载方式与原文件相同：在模组 env 中通过 modimport 执行，不返回模块表。

local create_prefab_skin = nil
local copy_recipe_skins = true
local character_skins = {}
local rarity_frame_symbols = {}
local characters_with_skins = {}
local item_skins_by_prefab = {}
local next_release_group = (-100)
local next_display_order = (-1000)
local rarity_frame_overrides = {}
local skin_affinity_info = require("skin_affinity_info")

-- 注册角色皮肤，并维护角色皮肤列表、稀有度及预制体。
function MakeCharacterSkin(prefab, skin_name, data)
    local skin_prefab = nil
    next_release_group = (next_release_group - 1)
    next_display_order = (next_display_order + 1)
    data.type = nil
    if (not characters_with_skins[prefab]) then
        characters_with_skins[prefab] = true
    end
    character_skins[skin_name] = data
    data.base_prefab = prefab
    data.ischaracterskins = true
    data.rarity = (data.rarity or "Loyal")
    data.release_group = (data.release_group or next_release_group)
    data.display_order = (data.display_order or next_display_order)
    data.build_name_override = (data.build_name_override or skin_name)
    if (not STRINGS.UI.RARITY[data.rarity]) then
        STRINGS.UI.RARITY[data.rarity] = data.rarity
        SKIN_RARITY_COLORS[data.rarity] = (data.raritycorlor or {0.635, 0.769, 0.435, 1})
        RARITY_ORDER[data.rarity] = (data.rarityorder or (-next_release_group))
        if data.FrameSymbol then
            rarity_frame_symbols[data.rarity] = data.FrameSymbol
        else
            rarity_frame_overrides[data.rarity] = {["build"] = (data.rarityoverride_build or "frame_BG"), ["symbol"] = (data.rarityoverride_symbol or "Reward")}
        end
    end
    STRINGS.SKIN_NAMES[skin_name] = (data.name or skin_name)
    STRINGS.SKIN_DESCRIPTIONS[skin_name] = (data.des or "")
    STRINGS.SKIN_QUOTES[skin_name] = (data.quotes or "")
    if (not PREFAB_SKINS[prefab]) then
        PREFAB_SKINS[prefab] = {}
    end
    table.insert(PREFAB_SKINS[prefab], skin_name)
    if (not skin_affinity_info[prefab]) then
        skin_affinity_info[prefab] = {}
    end
    table.insert(skin_affinity_info[prefab], skin_name)
    skin_prefab = create_prefab_skin(skin_name, data)
    if data.clear_fn then
        skin_prefab.clear_fn = data.clear_fn
    end
    skin_prefab.type = "base"
    RegisterPrefabs(skin_prefab)
    TheSim:LoadPrefabs({skin_name})
    return skin_prefab
end

-- 物品皮肤配置、默认外观与皮肤名称映射。
local item_skins = {}
local default_item_images = {}
local item_defaults = {}
function MakeItemSkinDefaultImage(prefab, atlas, image)
    item_defaults[prefab] = (item_defaults[prefab] or {})
    item_defaults[prefab].itemimg = {atlas, ((image or prefab) .. ".tex"), "default.tex"}
    GLOBAL.RegisterInventoryItemAtlas(item_defaults[prefab].itemimg[1], item_defaults[prefab].itemimg[2])
end

function MakeItemSkinDefaultData(prefab, image_data, animation_data, extra_data)
    item_defaults[prefab] = (item_defaults[prefab] or {})
    if image_data then
        if image_data.atlas then
            item_defaults[prefab].itemimg = {image_data.atlas, ((image_data.image or prefab) .. ".tex"), "default.tex"}
        elseif image_data[1] then
            item_defaults[prefab].itemimg = {image_data[1], ((image_data[2] or prefab) .. ".tex"), "default.tex"}
        else
            item_defaults[prefab].itemimg = {("images/inventoryimages/" .. (prefab .. ".xml")), (prefab .. ".tex"), "default.tex"}
        end
        if item_defaults[prefab].itemimg then
            GLOBAL.RegisterInventoryItemAtlas(item_defaults[prefab].itemimg[1], item_defaults[prefab].itemimg[2])
        end
    end
    if animation_data then
        if (((animation_data.bank or animation_data.build) or animation_data.anim) or animation_data.animloop) then
            item_defaults[prefab].itemanim = {(animation_data.bank or prefab), (animation_data.build or prefab), (animation_data.anim or "idle"), ((animation_data.animloop and true) or false)}
        elseif (((animation_data[1] or animation_data[2]) or animation_data[3]) or animation_data[4]) then
            item_defaults[prefab].itemanim = {(animation_data[1] or prefab), (animation_data[2] or prefab), (animation_data[3] or "idle"), ((animation_data[4] and true) or false)}
        else
            item_defaults[prefab].itemanim = {prefab, prefab}
        end
    end
    if extra_data then
        -- 原文件将扩展数据写到总表的 data 字段，保留此行为。
        item_defaults.data = extra_data
    end
end

function GetItemSkinDefaultData(prefab)
    return item_defaults[prefab]
end

function MakeItemSkin(prefab, skin_name, data)
    local skin_index = nil
    next_release_group = (next_release_group - 1)
    next_display_order = (next_display_order + 1)
    data.type = "item"
    item_skins[skin_name] = data
    data.base_prefab = prefab
    data.isitemskins = true
    data.rarity = (data.rarity or "Loyal")
    data.build_name_override = (data.build_name_override or skin_name)
    data.release_group = (data.release_group or next_release_group)
    data.display_order = (data.display_order or next_display_order)
    if (not STRINGS.UI.RARITY[data.rarity]) then
        STRINGS.UI.RARITY[data.rarity] = data.rarity
        SKIN_RARITY_COLORS[data.rarity] = (data.raritycorlor or {0.635, 0.769, 0.435, 1})
        RARITY_ORDER[data.rarity] = (data.rarityorder or (-next_release_group))
        if data.FrameSymbol then
            rarity_frame_symbols[data.rarity] = data.FrameSymbol
        end
    end
    STRINGS.SKIN_NAMES[skin_name] = (data.name or skin_name)
    STRINGS.SKIN_DESCRIPTIONS[skin_name] = (data.des or "")
    if (data.atlas and data.image) then
        RegisterInventoryItemAtlas(data.atlas, (data.image .. ".tex"))
    end
    if (not PREFAB_SKINS[prefab]) then
        PREFAB_SKINS[prefab] = {}
    end
    table.insert(PREFAB_SKINS[prefab], skin_name)
    if (not PREFAB_SKINS_IDS[prefab]) then
        PREFAB_SKINS_IDS[prefab] = {}
    end
    skin_index = 1
    for existing_skin, existing_index in pairs(PREFAB_SKINS_IDS[prefab]) do
        skin_index = (skin_index + 1)
    end
    PREFAB_SKINS_IDS[prefab][skin_name] = skin_index
    if (item_skins_by_prefab[prefab] == nil) then
        item_skins_by_prefab[prefab] = {}
    end
    if (not table.contains(item_skins_by_prefab[prefab], skin_name)) then
        table.insert(item_skins_by_prefab[prefab], skin_name)
    end
    data.skininit_fn = (data.init_fn or nil)
    data.skinclear_fn = (data.clear_fn or nil)
end

local skin_name_map = {}
function GetSkinBase(skin_name)
    return (((item_skins[skin_name] and item_skins[skin_name].base_prefab) or (character_skins[skin_name] and character_skins[skin_name].base_prefab)) or "")
end

function MakeSkinNameMap(base_skin, alias)
    skin_name_map[alias] = base_skin
end

function GetSkinMap(skin_name)
    return (skin_name_map[skin_name] or skin_name)
end

function GetSkinMapByBase(base_skin)
    local names = nil
    names = {[base_skin] = 1}
    for alias, mapped_skin in pairs(skin_name_map) do
        if (mapped_skin == base_skin) then
            names[alias] = 1
        end
    end
    return names
end

-- 扩展库存的皮肤归属查询；非本模组皮肤交还原函数处理。
local ownership_timestamp = 0
local inventory_metatable = getmetatable(TheInventory)
local old_check_ownership = TheInventory.CheckOwnership
inventory_metatable.__index.CheckOwnership = function(inventory, skin_name, ...)
    skin_name = (skin_name_map[skin_name] or skin_name)
    if ((type(skin_name) == "string") and character_skins[skin_name]) then
        if (character_skins[skin_name] and character_skins[skin_name].checkfn) then
            return character_skins[skin_name].checkfn(inventory, skin_name, ...)
        else
            return true
        end
    else
        return old_check_ownership(inventory, skin_name, ...)
    end
end

local old_check_ownership_latest = TheInventory.CheckOwnershipGetLatest
inventory_metatable.__index.CheckOwnershipGetLatest = function(inventory, skin_name, ...)
    skin_name = (skin_name_map[skin_name] or skin_name)
    if ((type(skin_name) == "string") and character_skins[skin_name]) then
        if (character_skins[skin_name] and character_skins[skin_name].checkfn) then
            return character_skins[skin_name].checkfn(inventory, skin_name, ...), ownership_timestamp
        else
            return true, ownership_timestamp
        end
    else
        return old_check_ownership_latest(inventory, skin_name, ...)
    end
end

local old_check_client_ownership = TheInventory.CheckClientOwnership
inventory_metatable.__index.CheckClientOwnership = function(inventory, userid, skin_name, ...)
    skin_name = (skin_name_map[skin_name] or skin_name)
    if ((type(skin_name) == "string") and character_skins[skin_name]) then
        if (character_skins[skin_name] and character_skins[skin_name].checkclientfn) then
            return character_skins[skin_name].checkclientfn(inventory, userid, skin_name, ...)
        else
            return true
        end
    else
        return old_check_client_ownership(inventory, userid, skin_name, ...)
    end
end

-- 兼容联网角色列表和角色选择界面。
local old_exception_arrays = GLOBAL.ExceptionArrays
GLOBAL.ExceptionArrays = function(first, second, ...)
    local from_networking = nil
    from_networking = nil
    for stack_level = 1, 100, 1 do
        local caller = nil
        caller = debug.getinfo(stack_level, "S")
        if caller then
            if (caller.source and caller.source:match("^scripts/networking.lua")) then
                from_networking = true
            end
        end
    end
    if from_networking then
        local values = nil
        values = old_exception_arrays(first, second, ...)
        for prefab, enabled in pairs(characters_with_skins) do
            table.insert(values, prefab)
        end
        return values
    else
        return old_exception_arrays(first, second, ...)
    end
end

local old_is_default_character_skin = IsDefaultCharacterSkin
GLOBAL.IsDefaultCharacterSkin = function(skin_name, ...)
    skin_name = ((skin_name and skin_name_map[skin_name]) or skin_name)
    if (skin_name and character_skins[skin_name]) then
        if character_skins[skin_name].checkfn then
            return character_skins[skin_name].checkfn(nil, skin_name)
        else
            return true
        end
    else
        return old_is_default_character_skin(skin_name, ...)
    end
end

local old_get_portrait_name = GetPortraitNameForItem
GLOBAL.GetPortraitNameForItem = function(skin_name)
    skin_name = ((skin_name and skin_name_map[skin_name]) or skin_name)
    if (skin_name and (character_skins[skin_name] and character_skins[skin_name].share_bigportrait_name)) then
        return character_skins[skin_name].share_bigportrait_name
    end
    return old_get_portrait_name(skin_name)
end

local old_get_frame_symbol = GetFrameSymbolForRarity
GLOBAL.GetFrameSymbolForRarity = function(rarity)
    rarity = ((rarity and skin_name_map[rarity]) or rarity)
    return (rarity_frame_symbols[rarity] or old_get_frame_symbol(rarity))
end

local on_widget_construct = function(widget)
    if (widget.name == "LoadoutSelect") then
        for prefab, enabled in pairs(characters_with_skins) do
            if (not table.contains(DST_CHARACTERLIST, prefab)) then
                table.insert(DST_CHARACTERLIST, prefab)
            end
        end
    elseif (widget.name == "LoadoutRoot") then
        for prefab, enabled in pairs(characters_with_skins) do
            if table.contains(DST_CHARACTERLIST, prefab) then
                RemoveByValue(DST_CHARACTERLIST, prefab)
            end
        end
    end
end

AddClassPostConstruct("widgets/widget", on_widget_construct)
AddSimPostInit(function()
    if (not TheNet:IsOnlineMode()) then
        local net_metatable = nil
        net_metatable = getmetatable(GLOBAL.TheNet)
        net_metatable.__index.IsOnlineMode = function(net, ...)
            return true
        end
    end
end)

-- 在角色切换皮肤时调用皮肤自带的清理与初始化回调。
AddComponentPostInit("skinner", function(skinner)
    local old_set_skin_name = nil
    old_set_skin_name = skinner.SetSkinName
    if old_set_skin_name then
        function skinner.SetSkinName(self, skin_name, ...)
            local previous_skin, next_skin = nil, nil
            previous_skin = self.skin_name
            next_skin = skin_name
            if (character_skins[previous_skin] and character_skins[previous_skin].clear_fn) then
                character_skins[previous_skin].clear_fn(self.inst, previous_skin)
            end
            if (character_skins[next_skin] and character_skins[next_skin].init_fn) then
                character_skins[next_skin].init_fn(self.inst, next_skin)
            end
            old_set_skin_name(self, skin_name, ...)
        end
    end
end)

-- 制作界面使用的物品皮肤归属查询。
local check_item_ownership = function(inventory, skin_name)
    if ((type(skin_name) == "string") and item_skins[skin_name]) then
        if item_skins[skin_name] then
            if item_skins[skin_name].checkfn then
                return item_skins[skin_name].checkfn(inventory, skin_name), 0
            else
                return true, 0
            end
        else
            return false, 0
        end
    end
end

-- 旧版制作弹窗的皮肤选项。
AddClassPostConstruct("widgets/recipepopup", function(widget)
    local old_get_skins_list, old_get_skin_options = nil, nil
    old_get_skins_list = widget.GetSkinsList
    function widget.GetSkinsList(self, ...)
        local skins = nil
        skins = old_get_skins_list(self, ...)
        if (self.recipe and (self.recipe.product and item_skins_by_prefab[self.recipe.product])) then
            for index, skin_name in ipairs(item_skins_by_prefab[self.recipe.product]) do
                local mapped_skin, owned, timestamp = nil, nil, nil
                print(skin_name)
                mapped_skin = (skin_name_map[skin_name] or skin_name)
                owned, timestamp = check_item_ownership(nil, mapped_skin)
                if owned then
                    local option = nil
                    option = {}
                    -- 原文件在此写入全局 type 函数，恢复版保留该历史行为。
                    option.type = type
                    option.item = skin_name
                    option.timestamp = timestamp
                    table.insert(skins, option)
                    if (option.timestamp > widget.timestamp) then
                        self.timestamp = option.timestamp
                    end
                end
            end
        end
        return skins
    end
    old_get_skin_options = widget.GetSkinOptions
    function widget.GetSkinOptions(self, ...)
        local options = nil
        options = old_get_skin_options(self, ...)
        if options then
            if (options[1] and options[1].image) then
                if (self.recipe and (self.recipe.product and default_item_images[self.recipe.product])) then
                    options[1].image = default_item_images[self.recipe.product]
                end
            end
            for index, entry in pairs(self.skins_list) do
                if (options[(index + 1)] and (options[(index + 1)].image and (entry and (entry.item and (item_skins[entry.item] and (item_skins[entry.item].atlas or item_skins[entry.item].image)))))) then
                    local image, atlas = nil, nil
                    image = (item_skins[entry.item].image or (entry.item .. ".tex"))
                    if (image:sub((-4)) ~= ".tex") then
                        image = (image .. ".tex")
                    end
                    atlas = (item_skins[entry.item].atlas or GetInventoryItemAtlas(image))
                    options[(index + 1)].image = {atlas, image, "default.tex"}
                end
            end
        end
        return options
    end
end)

-- 新版制作菜单的皮肤选项。
local CraftingSkinSelector = require("widgets/redux/craftingmenu_skinselector")
local old_selector_get_skins_list = CraftingSkinSelector.GetSkinsList
function CraftingSkinSelector.GetSkinsList(self, ...)
    local skins = nil
    skins = old_selector_get_skins_list(self, ...)
    if (self.recipe and (self.recipe.product and item_skins_by_prefab[self.recipe.product])) then
        for index, skin_name in ipairs(item_skins_by_prefab[self.recipe.product]) do
            local mapped_skin, owned, timestamp = nil, nil, nil
            mapped_skin = (skin_name_map[skin_name] or skin_name)
            owned, timestamp = check_item_ownership(nil, mapped_skin)
            if owned then
                local option = nil
                option = {}
                -- 原文件在此写入全局 type 函数，恢复版保留该历史行为。
                option.type = type
                option.item = skin_name
                option.timestamp = timestamp
                table.insert(skins, option)
                if (option.timestamp > self.timestamp) then
                    self.timestamp = option.timestamp
                end
            end
        end
    end
    return skins
end

local old_selector_get_skin_options = CraftingSkinSelector.GetSkinOptions
function CraftingSkinSelector.GetSkinOptions(self, ...)
    local options = nil
    options = old_selector_get_skin_options(self, ...)
    if options then
        if (options[1] and options[1].image) then
            if (self.recipe and (self.recipe.product and default_item_images[self.recipe.product])) then
                options[1].image = default_item_images[self.recipe.product]
            end
        end
        for index, entry in pairs(self.skins_list) do
            if (options[(index + 1)] and (options[(index + 1)].image and (entry and (entry.item and (item_skins[entry.item] and (item_skins[entry.item].atlas or item_skins[entry.item].image)))))) then
                local image, atlas = nil, nil
                image = (item_skins[entry.item].image or (entry.item .. ".tex"))
                if (image:sub((-4)) ~= ".tex") then
                    image = (image .. ".tex")
                end
                atlas = (item_skins[entry.item].atlas or GetInventoryItemAtlas(image))
                options[(index + 1)].image = {atlas, image, "default.tex"}
            end
        end
    end
    return options
end

-- 皮肤图标与稀有度颜色。
local old_get_skin_inv_icon_name = GetSkinInvIconName
GLOBAL.GetSkinInvIconName = function(skin_name, ...)
    if (item_skins[skin_name] and item_skins[skin_name].image) then
        local image = nil
        image = item_skins[skin_name].image
        if (image:sub((-4)) == ".tex") then
            image = image:sub(1, (-5))
        end
        return image
    end
    return old_get_skin_inv_icon_name(skin_name, ...)
end

local old_get_color_for_item = GLOBAL.GetColorForItem
GLOBAL.GetColorForItem = function(skin_name, ...)
    if (item_skins[skin_name] and item_skins[skin_name].rarity) then
        return SKIN_RARITY_COLORS[item_skins[skin_name].rarity]
    end
    return old_get_color_for_item(skin_name, ...)
end

-- 把制作时选择的皮肤传递到放置预览实体。
AddComponentPostInit("playercontroller", function(controller)
    local old_start_build_placement = nil
    old_start_build_placement = controller.StartBuildPlacementMode
    controller.StartBuildPlacementMode = function(self, recipe, skin_name, ...)
        if (recipe and (type(recipe) == "table")) then
            if (skin_name and item_skins[skin_name]) then
                recipe.ccsskin = skin_name
            else
                recipe.ccsskin = nil
            end
        end
        return old_start_build_placement(self, recipe, skin_name, ...)
    end
end)
AddComponentPostInit("placer", function(placer)
    local old_set_builder = nil
    old_set_builder = placer.SetBuilder
    placer.SetBuilder = function(self, builder, recipe, skin_name, ...)
        if (recipe and recipe.ccsskin) then
            local selected_skin = nil
            selected_skin = recipe.ccsskin
            basic_skininit_fn(placer.inst, selected_skin)
        end
        return old_set_builder(self, builder, recipe, skin_name, ...)
    end
end)

-- 应用物品皮肤：动画、物品栏图标及自定义回调。
function basic_skininit_fn(inst, skin_name)
    local data = nil
    if ((inst.components.placer == nil) and (not TheWorld.ismastersim)) then
        return
    end
    inst.skinname = skin_name
    data = item_skins[skin_name]
    if (not data) then
        return
    end
    if data.bank then
        inst.AnimState:SetBank(data.bank)
    end
    inst.AnimState:SetBuild((data.build or skin_name))
    if data.anim then
        inst.AnimState:PlayAnimation(data.anim, (data.animloop or nil))
    end
    if (inst.components.inventoryitem ~= nil) then
        inst.components.inventoryitem.atlasname = (data.atlas or ("images/inventoryimages/" .. (skin_name .. ".xml")))
        inst.components.inventoryitem:ChangeImageName((data.image or skin_name))
    end
    if data.skininit_fn then
        data.skininit_fn(inst, skin_name)
    end
end

-- 清除物品皮肤，恢复默认动画与图标。
function basic_skinclear_fn(inst, skin_name)
    local prefab, data, defaults = nil, nil, nil
    prefab = (inst.prefab or "")
    data = item_skins[skin_name]
    inst.skinname = nil
    if (not data) then
        return
    end
    defaults = (item_defaults[prefab] or {})
    if defaults.itemanim then
        if defaults.itemanim[1] then
            inst.AnimState:SetBank(defaults.itemanim[1])
        end
        inst.AnimState:SetBuild((defaults.itemanim[2] or prefab))
        if defaults.itemanim[3] then
            inst.AnimState:PlayAnimation(defaults.itemanim[3], defaults.itemanim[4])
        end
    else
        if data.basebank then
            inst.AnimState:SetBank(data.basebank)
        end
        if data.baseanim then
            inst.AnimState:PlayAnimation(data.baseanim, (data.baseanimloop or nil))
        end
        inst.AnimState:SetBuild((data.basebuild or prefab))
    end
    if (inst.components.inventoryitem ~= nil) then
        if defaults.itemimg then
            local image = nil
            inst.components.inventoryitem.atlasname = defaults.itemimg[1]
            image = defaults.itemimg[2]:gsub("%.tex", "")
            inst.components.inventoryitem:ChangeImageName(image)
        else
            inst.components.inventoryitem.atlasname = GetInventoryItemAtlas((prefab .. ".tex"))
            inst.components.inventoryitem:ChangeImageName(prefab)
        end
    end
    if item_skins[skin_name].skinclear_fn then
        item_skins[skin_name].skinclear_fn(inst, skin_name)
    end
end

-- 服务端校验物品皮肤归属，以及 ccsskinable 的换肤和存档接口。
local check_client_item_ownership = function(userid, skin_name)
    local mapped_skin = nil
    mapped_skin = (skin_name_map[skin_name] or skin_name)
    if ((type(mapped_skin) == "string") and item_skins[mapped_skin]) then
        if item_skins[mapped_skin] then
            if item_skins[mapped_skin].checkclientfn then
                return item_skins[mapped_skin].checkclientfn(nil, userid, mapped_skin)
            else
                return true
            end
        else
            return false
        end
    end
end

local set_item_skin = function(self, skin_name, userid)
    if TheNet:GetIsServer() then
        if ((not skin_name) or (skin_name == "")) then
            basic_skinclear_fn(self.inst, self._ccsskin)
            self._ccsskin = nil
            self._ccsuserid = userid
        end
        if check_client_item_ownership(userid, skin_name) then
            basic_skinclear_fn(self.inst, self._ccsskin)
            basic_skininit_fn(self.inst, skin_name)
            self._ccsskin = skin_name
            self._ccsuserid = userid
        end
    end
end

local save_item_skin = function(self)
    if self._ccsskin then
        return {["_ccsskin"] = self._ccsskin, ["_ccsuserid"] = self._ccsuserid}
    end
end

local load_item_skin = function(self, data)
    if data then
        self._ccsskin = data._ccsskin
        self._ccsuserid = data._ccsuserid
    end
    if check_client_item_ownership(self._ccsuserid, self._ccsskin) then
        basic_skininit_fn(self.inst, self._ccsskin)
    end
end

-- 由物品预制体调用，安装皮肤组件与外观查询。
function CcsItemInit(inst)
    local old_get_skin_name, old_get_skin_build = nil, nil
    inst:AddComponent("ccsskinable")
    inst.components.ccsskinable.SetSkin = set_item_skin
    inst.components.ccsskinable.OnSave = save_item_skin
    inst.components.ccsskinable.OnLoad = load_item_skin
    old_get_skin_name = inst.GetSkinName
    inst.GetSkinName = function(self)
        if (self.components.ccsskinable._ccsskin and check_client_item_ownership(self.components.ccsskinable._ccsuserid, self.components.ccsskinable._ccsskin)) then
            return ((item_skins[self.components.ccsskinable._ccsskin] and item_skins[self.components.ccsskinable._ccsskin].build_name_override) or self.components.ccsskinable._ccsskin)
        end
        return old_get_skin_name(self)
    end
    old_get_skin_build = inst.GetSkinBuild
    inst.GetSkinBuild = function(self)
        if (self.components.ccsskinable._ccsskin and check_client_item_ownership(self.components.ccsskinable._ccsuserid, self.components.ccsskinable._ccsskin)) then
            return ((item_skins[self.components.ccsskinable._ccsskin] and item_skins[self.components.ccsskinable._ccsskin].build_name_override) or self.components.ccsskinable._ccsskin)
        end
        return old_get_skin_build(self)
    end
end

-- 生成带自定义皮肤的物品，并兼容原版生成与制作请求。
local old_spawn_prefab = GLOBAL.SpawnPrefab
GLOBAL.SpawnPrefab = function(prefab, skin_name, skin_id, userid, ...)
    if (prefab and (skin_name and item_skins[skin_name])) then
        local inst = nil
        inst = old_spawn_prefab(prefab, nil, nil, userid, ...)
        if inst then
            if inst.components.placer then
                if item_skins[skin_name].placer_fn then
                    item_skins[skin_name].placer_fn(inst, skin_name)
                end
            else
                if TheWorld.ismastersim then
                    if inst.components.ccsskinable then
                        inst.components.ccsskinable:SetSkin(skin_name, userid)
                    end
                end
            end
        end
        return inst
    end
    return old_spawn_prefab(prefab, skin_name, skin_id, userid, ...)
end

local old_validate_recipe_skin = ValidateRecipeSkinRequest
GLOBAL.ValidateRecipeSkinRequest = function(userid, prefab, skin_name, ...)
    local selected_skin = nil
    selected_skin = nil
    if (prefab and (skin_name and (item_skins[skin_name] and check_client_item_ownership(userid, skin_name)))) then
        selected_skin = skin_name
    else
        selected_skin = old_validate_recipe_skin(userid, prefab, skin_name, ...)
    end
    return selected_skin
end

function GetSkin(skin_name)
    return ((character_skins[skin_name] or item_skins[skin_name]) or nil)
end

function GetAllSkin()
    return character_skins, item_skins
end
if copy_recipe_skins then
    AddSimPostInit(function()
        for name, recipe in pairs(AllRecipes) do
            if ((recipe.product ~= recipe.name) and PREFAB_SKINS[recipe.product]) then
                PREFAB_SKINS[recipe.name] = PREFAB_SKINS[recipe.product]
                PREFAB_SKINS_IDS[recipe.name] = PREFAB_SKINS_IDS[recipe.product]
            end
        end
    end)
end

AddClassPostConstruct("widgets/redux/accountitemframe", function(widget)
    local old_set_rarity = nil
    old_set_rarity = widget._SetRarity
    widget._SetRarity = function(self, rarity, ...)
        local override = nil
        override = rarity_frame_overrides[rarity]
        if override then
            local build, symbol = nil, nil
            build = (override.build or "frame_BG")
            symbol = ((override.symbol or override.build) or GetFrameSymbolForRarity(rarity))
            self:GetAnimState():OverrideSymbol("SWAP_frameBG", build, symbol)
        else
            return old_set_rarity(self, rarity, ...)
        end
    end
end)

-- 保留原文件的兼容分支：其他模组替换 CreatePrefabSkin 时使用本地实现。
local original_create_prefab_skin = GLOBAL.CreatePrefabSkin
local create_prefab_skin_info = debug.getinfo(original_create_prefab_skin)
if (create_prefab_skin_info and (create_prefab_skin_info.source and (not create_prefab_skin_info.source:match("scripts/prefabskin%.lua")))) then
    print("UseMySelfCreatePrefabSkin")
    function create_prefab_skin(skin_name, data)
        local skin_prefab = nil
        skin_prefab = Prefab(skin_name, nil, data.assets, data.prefabs)
        skin_prefab.is_skin = true
        if (data.type == nil) then
            data.type = "base"
        end
        skin_prefab.base_prefab = data.base_prefab
        skin_prefab.type = data.type
        skin_prefab.skin_tags = data.skin_tags
        skin_prefab.init_fn = data.init_fn
        skin_prefab.build_name_override = data.build_name_override
        skin_prefab.bigportrait = data.bigportrait
        skin_prefab.rarity = data.rarity
        skin_prefab.rarity_modifier = data.rarity_modifier
        skin_prefab.skins = data.skins
        skin_prefab.skin_sound = data.skin_sound
        skin_prefab.is_restricted = data.is_restricted
        skin_prefab.granted_items = data.granted_items
        skin_prefab.marketable = data.marketable
        skin_prefab.release_group = (data.release_group or next_release_group)
        skin_prefab.linked_beard = data.linked_beard
        skin_prefab.share_bigportrait_name = data.share_bigportrait_name
        if (data.torso_tuck_builds ~= nil) then
            for index, build in pairs(data.torso_tuck_builds) do
                BASE_TORSO_TUCK[build] = "full"
            end
        end
        if (data.torso_untuck_builds ~= nil) then
            for index, build in pairs(data.torso_untuck_builds) do
                BASE_TORSO_TUCK[build] = "untucked"
            end
        end
        if (data.torso_untuck_wide_builds ~= nil) then
            for index, build in pairs(data.torso_untuck_wide_builds) do
                BASE_TORSO_TUCK[build] = "untucked_wide"
            end
        end
        if (data.has_alternate_for_body ~= nil) then
            for index, build in pairs(data.has_alternate_for_body) do
                BASE_ALTERNATE_FOR_BODY[build] = true
            end
        end
        if (data.has_alternate_for_skirt ~= nil) then
            for index, build in pairs(data.has_alternate_for_skirt) do
                BASE_ALTERNATE_FOR_SKIRT[build] = true
            end
        end
        if (data.one_piece_skirt_builds ~= nil) then
            for index, build in pairs(data.one_piece_skirt_builds) do
                ONE_PIECE_SKIRT[build] = true
            end
        end
        if (data.legs_cuff_size ~= nil) then
            for build, size in pairs(data.legs_cuff_size) do
                BASE_LEGS_SIZE[build] = size
            end
        end
        if (data.feet_cuff_size ~= nil) then
            for build, size in pairs(data.feet_cuff_size) do
                BASE_FEET_SIZE[build] = size
            end
        end
        if (data.skin_sound ~= nil) then
            SKIN_SOUND_FX[skin_name] = data.skin_sound
        end
        if (data.fx_prefab ~= nil) then
            SKIN_FX_PREFAB[skin_name] = data.fx_prefab
        end
        if (data.type ~= "base") then
            skin_prefab.clear_fn = _G[(skin_prefab.base_prefab .. "_clear_fn")]
        end
        return skin_prefab
    end
else
    create_prefab_skin = original_create_prefab_skin
end

-- 换肤法杖特效的位置与缩放参数，数值按原文件保留。
local reskin_fx_options = {
    ["abigail"] = {["offset"] = 1.3, ["scale"] = 1.3},
    ["anchor"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["arrowsign_post"] = {["offset"] = 0.9, ["scale"] = 1.2},
    ["beebox"] = {["scale"] = 1.4},
    ["bernie_big"] = {["offset"] = 1.2, ["scale"] = 1.8},
    ["birdcage"] = {["offset"] = 1.2, ["scale"] = 1.8},
    ["bugnet"] = {["offset"] = 0.4},
    ["campfire"] = {["scale"] = 1.2},
    ["cane"] = {["offset"] = 0.4},
    ["cavein_boulder"] = {["scale"] = 1.4},
    ["coldfirepit"] = {["scale"] = 1.2},
    ["cookpot"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["critter_dragonling"] = {["offset"] = 0.8},
    ["critter_glomling"] = {["offset"] = 0.8},
    ["dragonflychest"] = {["offset"] = 0.1, ["scale"] = 1.4},
    ["dragonflyfurnace"] = {["offset"] = 0.6, ["scale"] = 1.8},
    ["endtable"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["featherfan"] = {["scale"] = 1.3},
    ["featherhat"] = {["scale"] = 1.1},
    ["fence"] = {["offset"] = 0.1, ["scale"] = 1.2},
    ["fence_gate"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["firepit"] = {["scale"] = 1.2},
    ["firestaff"] = {["offset"] = 0.4},
    ["firesuppressor"] = {["offset"] = 0.5, ["scale"] = 1.5},
    ["goldenshovel"] = {["offset"] = 0.2},
    ["grass_umbrella"] = {["offset"] = 0.4},
    ["greenstaff"] = {["offset"] = 0.4},
    ["hambat"] = {["offset"] = 0.2},
    ["icebox"] = {["offset"] = 0.3, ["scale"] = 1.3},
    ["icestaff"] = {["offset"] = 0.4},
    ["lightning_rod"] = {["offset"] = 0.8, ["scale"] = 1.3},
    ["mast"] = {["offset"] = 4, ["scale"] = 2},
    ["mast_malbatross"] = {["offset"] = 4, ["scale"] = 2},
    ["meatrack"] = {["offset"] = 1, ["scale"] = 1.7},
    ["mermhouse_crafted"] = {["offset"] = 1.5, ["scale"] = 2.2},
    ["monkey_mediumhat"] = {["scale"] = 1.2},
    ["mushroom_light"] = {["offset"] = 1.2, ["scale"] = 1.4},
    ["mushroom_light2"] = {["offset"] = 1.2, ["scale"] = 1.8},
    ["nightsword"] = {["offset"] = 0.2},
    ["oceanfishingrod"] = {["offset"] = (-0.4)},
    ["opalstaff"] = {["offset"] = 0.4},
    ["orangestaff"] = {["offset"] = 0.4},
    ["pighouse"] = {["offset"] = 1.5, ["scale"] = 2.2},
    ["rabbithouse"] = {["offset"] = 1.5, ["scale"] = 2.2},
    ["rainometer"] = {["offset"] = 0.9, ["scale"] = 1.6},
    ["researchlab"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["researchlab2"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["researchlab3"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["researchlab4"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["ruins_bat"] = {["offset"] = 0.4, ["scale"] = 1.2},
    ["saltbox"] = {["offset"] = 0.3, ["scale"] = 1.3},
    ["sculptingtable"] = {["scale"] = 1.2},
    ["seafaring_prototyper"] = {["offset"] = 0.5, ["scale"] = 1.5},
    ["shovel"] = {["offset"] = 0.2},
    ["siestahut"] = {["scale"] = 1.8},
    ["spear"] = {["offset"] = 0.4},
    ["spear_wathgrithr"] = {["offset"] = 0.4},
    ["stagehand"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["telebase"] = {["scale"] = 1.6},
    ["tent"] = {["offset"] = 0.4, ["scale"] = 2},
    ["treasurechest"] = {["offset"] = 0.1, ["scale"] = 1.1},
    ["treasurechest_upgraded"] = {["offset"] = 0.1, ["scale"] = 1.3},
    ["umbrella"] = {["offset"] = 0.4},
    ["wall_moonrock"] = {["offset"] = 0.2, ["scale"] = 1.2},
    ["wall_ruins"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["wall_stone"] = {["offset"] = 0.2, ["scale"] = 1.3},
    ["wardrobe"] = {["offset"] = 0.5, ["scale"] = 1.4},
    ["winterometer"] = {["offset"] = 0.8, ["scale"] = 1.3},
    ["wormhole"] = {["scale"] = 1.3},
    ["yellowstaff"] = {["offset"] = 0.4},
    ["mighty_gym"] = {["offset"] = 2, ["scale"] = 2.7},
    ["eyeturret"] = {["offset"] = 1, ["scalex"] = 1.4, ["scaley"] = 2.4},
    ["wobybig"] = {["offset"] = 1, ["scalex"] = 2, ["scaley"] = 1.6},
}
local get_reskin_fx_options = function(target)
    if ((target.prefab == "treasurechest") and target._chestupgrade_stacksize) then
        return reskin_fx_options.treasurechest_upgraded
    end
    return (reskin_fx_options[target.prefab] or {})
end

-- 换肤法杖依次选择玩家拥有的物品皮肤，最后恢复默认皮肤。
AddPrefabPostInit("reskin_tool", function(inst)
    if (not TheWorld.ismastersim) then
        return inst
    end
    if (inst and inst.components.spellcaster) then
        if inst.components.spellcaster.can_cast_fn then
            local old_can_cast = nil
            old_can_cast = inst.components.spellcaster.can_cast_fn
            inst.components.spellcaster.can_cast_fn = function(doer, target, position, ...)
                if (target and (target:IsValid() and (doer and (doer:IsValid() and (target.prefab and (item_skins_by_prefab[target.prefab] and target.components.ccsskinable)))))) then
                    local userid, current_skin, skins, skin_count, current_index = nil, nil, nil, nil, nil
                    userid = (doer.userid or "")
                    current_skin = target.components.ccsskinable._ccsskin
                    skins = item_skins_by_prefab[target.prefab]
                    skin_count = (#skins)
                    if (skin_count <= 0) then
                        return false
                    end
                    current_index = 1
                    if current_skin then
                        for index, skin_name in ipairs(skins) do
                            if (skin_name == current_skin) then
                                current_index = index
                            end
                        end
                        for index = (current_index + 1), (#skins), 1 do
                            local skin_name = nil
                            skin_name = skins[index]
                            if check_client_item_ownership(userid, skin_name) then
                                target.ccs_targetskin = skin_name
                                return true
                            end
                        end
                        target.ccs_targetskin = ""
                        return true
                    else
                        for index, skin_name in ipairs(skins) do
                            if check_client_item_ownership(userid, skin_name) then
                                target.ccs_targetskin = skin_name
                                return true
                            end
                        end
                        return false
                    end
                end
                return old_can_cast(doer, target, position, ...)
            end
        end
        if inst.components.spellcaster.spell then
            local old_spell = nil
            old_spell = inst.components.spellcaster.spell
            inst.components.spellcaster.spell = function(tool, target, position, alternate_target, ...)
                if (target and (item_skins_by_prefab[target.prefab] and target.components.ccsskinable)) then
                    local fx_prefab, skin_fx, fx, options, scale, scale_x, scale_y, x, y, z = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
                    target = (target or alternate_target)
                    if (target == nil) then
                        return
                    end
                    fx_prefab = "explode_reskin"
                    skin_fx = SKIN_FX_PREFAB[tool:GetSkinName()]
                    if ((skin_fx ~= nil) and (skin_fx[1] ~= nil)) then
                        fx_prefab = skin_fx[1]
                    end
                    fx = SpawnPrefab(fx_prefab)
                    options = get_reskin_fx_options(target)
                    scale = (options.scale or 1)
                    scale_x = (options.scalex or scale)
                    scale_y = (options.scaley or scale)
                    fx.Transform:SetScale(scale_x, scale_y, scale_x)
                    x, y, z = target.Transform:GetWorldPosition()
                    y = (y + (options.offset or 0))
                    fx.Transform:SetPosition(x, y, z)
                    tool:DoTaskInTime(0, function()
                        if (target:IsValid() and (tool:IsValid() and (tool.parent and tool.parent:IsValid()))) then
                            local userid = nil
                            userid = tool.parent.userid
                            if target.ccs_targetskin then
                                local selected_skin = nil
                                selected_skin = target.ccs_targetskin
                                target.ccs_targetskin = nil
                                if target.components.ccsskinable then
                                    target.components.ccsskinable:SetSkin(selected_skin, userid)
                                end
                                return
                            else
                                local current_skin, skins, skin_count, current_index = nil, nil, nil, nil
                                current_skin = target.components.ccsskinable._ccsskin
                                skins = item_skins_by_prefab[target.prefab]
                                skin_count = (#skins)
                                if (skin_count <= 0) then
                                    return false
                                end
                                current_index = 1
                                if current_skin then
                                    for index, skin_name in ipairs(skins) do
                                        if (skin_name == current_skin) then
                                            current_index = index
                                        end
                                    end
                                    for index = (current_index + 1), (#skins), 1 do
                                        local skin_name = nil
                                        skin_name = skins[index]
                                        if check_client_item_ownership(userid, skin_name) then
                                            if target.components.ccsskinable then
                                                target.components.ccsskinable:SetSkin(skin_name, userid)
                                            end
                                            return
                                        end
                                    end
                                    if target.components.ccsskinable then
                                        target.components.ccsskinable:SetSkin(nil, userid)
                                    end
                                    return
                                else
                                    for index, skin_name in ipairs(skins) do
                                        if check_client_item_ownership(userid, skin_name) then
                                            if target.components.ccsskinable then
                                                target.components.ccsskinable:SetSkin(skin_name, userid)
                                            end
                                            return
                                        end
                                    end
                                    if target.components.ccsskinable then
                                        target.components.ccsskinable:SetSkin(nil, userid)
                                    end
                                    return
                                end
                            end
                        end
                    end)
                else
                    return old_spell(tool, target, position, alternate_target, ...)
                end
            end
        end
    end
end)
