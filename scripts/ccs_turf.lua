local tile_assets = { -- 地皮的资源文件
    Asset("ANIM", "anim/ccs_turf.zip"),

    Asset("IMAGE", "images/inventoryimages/ccs_turf_green.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_turf_green.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_turf_red.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_turf_red.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_turf_shuangyu.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_turf_shuangyu.xml"),
}

for _, asset in ipairs(tile_assets) do
    table.insert(Assets, asset)
end

AddTile(
    "CCS_TURF_GREEN",  --地皮名称
    "LAND",    --地皮类型 
    {
        ground_name = "绿色地皮", --自定义名字
    },
    {
        name = "yellowgrass",           --边缘样式 比如 牛毛地毯carpet 棋盘blocky 也可以自己做。这里设置为我们文件里的

        noise_texture="ccs_turf_green",     --这里是图片

        --定义在地皮上行走的声音
        runsound="dontstarve/movement/run_marble",  --
        walksound="dontstarve/movement/walk_marble",--
        snowsound="dontstarve/movement/run_ice",
        mudsound="dontstarve/movement/run_mud",

        cannotbedug = nil,  --标记为true则不能挖掉
    },
    {
        name="map_edge",
        noise_texture="quagmire_parkfield_mini",    --小地图图片
    },
    --挖掉的定义，如果这个表为空则挖掉之后不掉地皮
    {
        name = "ccs_green", -- 掉落物的代码
        anim = "green", -- Ground item
        bank_build = "ccs_turf",
    }
)

AddTile(
    "CCS_TURF_RED",  --地皮名称
    "LAND",    --地皮类型 
    {
        ground_name = "粉色地皮", --自定义名字
    },
    {
        name = "yellowgrass",         --边缘样式 比如 牛毛地毯carpet 棋盘blocky 也可以自己做。这里设置为我们文件里的

        noise_texture="ccs_turf_red",     --这里是图片

        --定义在地皮上行走的声音
        runsound="dontstarve/movement/run_marble",  --
        walksound="dontstarve/movement/walk_marble",--
        snowsound="dontstarve/movement/run_ice",
        mudsound="dontstarve/movement/run_mud",

        cannotbedug = nil,  --标记为true则不能挖掉
    },
    {
        name="map_edge",
        noise_texture="quagmire_parkfield_mini",    --小地图图片
    },
    --挖掉的定义，如果这个表为空则挖掉之后不掉地皮
    {
        name = "ccs_red", -- 掉落物的代码
        anim = "red", -- Ground item
        bank_build = "ccs_turf",
    }
)

AddTile(
    "CCS_TURF_SHUANGYU",  --地皮名称
    "LAND",    --地皮类型 
    {
        ground_name = "双鱼地皮", --自定义名字
    },
    {
        name="jungle",      --边缘样式 比如 牛毛地毯carpet 棋盘blocky 也可以自己做。这里设置为我们文件里的

        noise_texture="ccs_turf_shuangyu",     --这里是图片

        --定义在地皮上行走的声音
        runsound="dontstarve/movement/run_marble",  --
        walksound="dontstarve/movement/walk_marble",--
        snowsound="dontstarve/movement/run_ice",
        mudsound="dontstarve/movement/run_mud",

        cannotbedug = nil,  --标记为true则不能挖掉
    },
    {
        name="map_edge",
        noise_texture="quagmire_parkfield_mini",    --小地图图片
    },
    --挖掉的定义，如果这个表为空则挖掉之后不掉地皮
    {
        name = "ccs_shuangyu", -- 掉落物的代码
        anim = "shuangyu",   -- Ground item
        bank_build = "ccs_turf",
    }
)

local function AddTurfInventoryImages(turf_data)
    for _, data in ipairs(turf_data) do
        AddPrefabPostInit(data.prefab, function(inst)
            if not TheWorld.ismastersim then
                return inst
            end

            if inst.components.inventoryitem then
                inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. data.atlasname .. ".xml"
                inst.components.inventoryitem.imagename = data.imagename
            end
        end)
    end
end
local turf_data = {
    { prefab = "turf_ccs_green", atlasname = "ccs_turf_green", imagename = "ccs_turf_green" },
    { prefab = "turf_ccs_red", atlasname = "ccs_turf_red", imagename = "ccs_turf_red" },
    { prefab = "turf_ccs_shuangyu", atlasname = "ccs_turf_shuangyu", imagename = "ccs_turf_shuangyu" },
}
AddTurfInventoryImages(turf_data)