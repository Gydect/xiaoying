-- local SERVER_SIDE
-- local CLIENT_SIDE
-- if GLOBAL.TheNet:GetIsServer() then
--     SERVER_SIDE = true
--     if not GLOBAL.TheNet:IsDedicated() then
--         CLIENT_SIDE = true
--     end
-- elseif GLOBAL.TheNet:GetIsClient() then
--     SERVER_SIDE = false
--     CLIENT_SIDE = true
-- end

TUNING.CCS_CARD24_ENBLE = GetModConfigData("ccs_card_24_enble")
TUNING.CCS_CARD_COLLECTION = GetModConfigData("ccs_card_collection_difficulty")
TUNING.CCS_SAN_DEL = GetModConfigData("ccs_san_del")
TUNING.CCS_PACK = GetModConfigData("ccs_pack_pz1")
TUNING.CCS_PACK2 = GetModConfigData("ccs_pack_pz2")
TUNING.CCS_CARD14_ENBLE = GetModConfigData("ccs_card_14_enble")
TUNING.CCS_LIGHT3_FW = GetModConfigData("ccs_light3_enble_fw")
TUNING.CCS_BUNNY_FLUORESCEN_ENABLE = GetModConfigData("ccs_bunny_fluorescen_enable")
TUNING.CCS_MONIBOATSG = GetModConfigData("ccs_miniboatsg")
TUNING.CCS_ALLOWED_OTHER = GetModConfigData("allowed_other")

-- 添加角色皮肤Assets
GLOBAL.CcsCharacterAssets = function(assets, skinname, hasbigportraits, ghostbuild, extraassets)
    if not assets or type(assets) ~= "table" then
        return
    end
    if not skinname then
        return
    end
    table.insert(assets, Asset("ANIM", "anim/" .. skinname .. ".zip"))
    if hasbigportraits then
        table.insert(assets, Asset("IMAGE", "bigportraits/" .. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "bigportraits/" .. skinname .. ".xml"))
    end
    if ghostbuild then
        table.insert(assets, Asset("ANIM", "anim/" .. ghostbuild .. ".zip"))
    end
    if extraassets then
        for _, v in ipairs(extraassets) do
            table.insert(assets, v)
        end
    end
end

-- 添加物品皮肤Assets
GLOBAL.CcsItemAssets = function(assets, skinname, image, ATLAS_BUILD, extraassets)
    if not assets or type(assets) ~= "table" then
        return
    end
    if not skinname then
        return
    end

    table.insert(assets, Asset("ANIM", "anim/" .. skinname .. ".zip"))
    if image then
        table.insert(assets, Asset("IMAGE", "images/inventoryimages/" .. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/inventoryimages/" .. skinname .. ".xml"))
        if ATLAS_BUILD then
            table.insert(assets, Asset("ATLAS_BUILD", "images/inventoryimages/" .. skinname .. ".xml", 256))
        end
    end
    if extraassets then
        for _, v in ipairs(extraassets) do
            table.insert(assets, v)
        end
    end
end
