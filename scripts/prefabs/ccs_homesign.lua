require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/ccs_homesign.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_homesign.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_homesign.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin1.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin1.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin2.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin2.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin3.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin3.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin4.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin4.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin5.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin5.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_clotheshanger_skin6.xml"),
    Asset("IMAGE", "images/inventoryimages/ccs_clotheshanger_skin6.tex"),
    Asset("MINIMAP_IMAGE", "sign"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onopen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
local WEIGHTED_SEED_TABLE = require("prefabs/weed_defs").weighted_seed_table
local function pickfarmplant()
    if math.random() < TUNING.FARM_PLANT_RANDOMSEED_WEED_CHANCE then
        return weighted_random_choice(WEIGHTED_SEED_TABLE)
    else
        local season = TheWorld.state.season
        local weights = {}
        local season_mod = TUNING.SEED_WEIGHT_SEASON_MOD

        for k, v in pairs(VEGGIES) do
            weights[k] = v.seed_weight * ((PLANT_DEFS[k] and PLANT_DEFS[k].good_seasons[season]) and season_mod or 1)
        end

        return "farm_plant_" .. weighted_random_choice(weights)
    end
    return "weed_forgetmelots"
end

local function ReplaceWithPlant(inst)
    local plant_prefab = inst._identified_plant_type or pickfarmplant()
    local plant = SpawnPrefab(plant_prefab)
    plant.Transform:SetPosition(inst.Transform:GetWorldPosition())

    if plant.plant_def ~= nil then
        plant.no_oversized = true
        plant.long_life = inst.long_life
        plant.components.farmsoildrinker:CopyFrom(inst.components.farmsoildrinker)
        plant.components.farmplantstress:CopyFrom(inst.components.farmplantstress)
        plant.components.growable:DoGrowth()
        plant.AnimState:OverrideSymbol("veggie_seed", "farm_soil", "seed")
    end

    inst.grew_into = plant -- so the caller can get the new plant that replaced this object
    inst:Remove()
    return plant
end
local function trygrowth(inst, level)
    if inst:IsInLimbo() then return end
    if inst:HasTag("withered") then inst:RemoveTag("withered") end
    if inst.components.pickable ~= nil then
        if inst.components.pickable:CanBePicked() and
            inst.components.pickable.caninteractwith then
            return
        end
        inst.components.pickable:FinishGrowing()
    end

    if inst.components.crop ~= nil then
        inst.components.crop:DoGrow(TUNING.TOTAL_DAY_TIME * 10, true)
        if TheWorld.state.iswinter then end
    end

    if inst.components.harvestable ~= nil and
        inst.components.harvestable:CanBeHarvested() and
        inst:HasTag("mushroom_farm") then
        inst.components.harvestable:Grow()
    end

    if inst.components.crop_legion ~= nil then
        inst.components.crop_legion:DoGrow(TUNING.TOTAL_DAY_TIME * 10, true)
    end

    if inst.components.timer then
        if inst.components.timer:TimerExists("grow") then
            inst.components.timer:StopTimer("grow")
            inst:PushEvent("timerdone", { name = "grow" })
        end
        if inst.components.timer:TimerExists("growth") then
            inst.components.timer:StopTimer("growth")
            inst:PushEvent("timerdone", { name = "growth" })
        end
        if inst.components.timer:TimerExists("growup") then
            inst.components.timer:StopTimer("growup")
            inst:PushEvent("timerdone", { name = "growup" })
        end
    end

    if inst.components.worldsettingstimer and
        inst.components.worldsettingstimer:TimerExists("grow") then
        inst.components.worldsettingstimer:StopTimer("grow")
        inst:PushEvent("timerdone", { name = "grow" })
    end
    if inst.components.worldsettingstimer and
        inst.components.worldsettingstimer:TimerExists("growth") then
        inst.components.worldsettingstimer:StopTimer("growth")
        inst:PushEvent("timerdone", { name = "growth" })
    end

    if inst.components.growable and inst.components.perennialcrop then
        if not inst.ccs_magic then
            inst.force_oversized = true
            inst.components.growable.stage = 1
            inst.ccs_magic = true
            inst.components.perennialcrop.moisture = 999
            inst.components.perennialcrop.nutrient = 999
            inst.components.perennialcrop.nutrientgrow = 999
            inst.components.perennialcrop.nutrientsick = 999
            inst.components.perennialcrop.sickness = 0
            inst.components.perennialcrop.infested = 0

            inst.components.perennialcrop.moisture_max = 999
            inst.components.perennialcrop.nutrient_max = 999
            inst.components.perennialcrop.nutrientgrow_max = 999
            inst.components.perennialcrop.nutrientsick_max = 999
            inst.components.perennialcrop.pollinated_max = 0
            inst.components.perennialcrop.infested_max = 1000
            inst.components.perennialcrop.cost_moisture = 0
            inst.components.perennialcrop.cost_nutrient = 0
            inst.components.perennialcrop.can_getsick = false
            inst.components.perennialcrop.killjoystolerance = 3
        end
        for i = inst.components.growable.stage, 6 do
            if inst.components.growable.domagicgrowthfn ~= nil then
                inst.components.growable:DoMagicGrowth()
            else
                inst.components.growable:DoGrowth()
            end
        end
    end

    if inst.components.growable ~= nil and
        (inst:HasTag("tree") or inst:HasTag("peachtree") or inst:HasTag("plant") or
            inst:HasTag("winter_tree") or inst:HasTag("boulder") or
            inst:HasTag("siving_derivant") or
            inst.components.growable.magicgrowable) then
        local stage = inst.components.growable.stage
        local maxstage = #inst.components.growable.stages
        if inst:HasTag("evergreens") then maxstage = maxstage - 1 end
        if inst:HasTag("siving_derivant") then
            inst.components.growable:DoGrowth()
            inst.components.growable:DoMagicGrowth()
            inst.components.growable:DoMagicGrowth()
            inst.components.growable:DoMagicGrowth()
        else
            if stage == maxstage then
                inst.components.growable:Pause()
            elseif stage == maxstage - 1 then
                inst.components.growable:DoGrowth()
                inst.components.growable:Pause()
            else
                inst.components.growable:DoGrowth()
            end
        end
    end

    if inst.components.growable then
        if inst.components.growable.magicgrowable or ((inst:HasTag("tree") or inst:HasTag("winter_tree")) and not inst:HasTag("stump")) then
            if inst.components.simplemagicgrower ~= nil then
                inst.components.simplemagicgrower:StartGrowing()
            elseif inst.components.growable.domagicgrowthfn ~= nil
                and inst.components.farmplantstress and inst.components.farmplanttendable then
                local new_plant = nil
                if inst.prefab == "farm_plant_randomseed" then
                    inst.components.growable.stages = {}
                    new_plant = ReplaceWithPlant(inst)
                end
                local plant = new_plant or inst
                local maxstage = #plant.components.growable.stages
                plant.force_oversized = true
                plant:DoTaskInTime(.1, function()
                    for i = 1, 4 do
                        plant:DoTaskInTime(.3, function()
                            local stage = plant.components.growable.stage
                            if stage == maxstage - 1 and plant.components.growable.stages[stage].name == "full" then
                                plant.components.growable:Pause()
                            else
                                plant.components.growable:DoGrowth()
                            end
                        end)
                    end
                end)
            else
                inst.components.growable:DoGrowth()
            end
        end
    end
end
local config = {

    -- 光牌
    ccs_cards_8 = {
        fn = function(inst)
            inst.Light:Enable(true)
        end,
        dayfn = function (inst)

            -- 仙人掌可以开花,冬天启动生长
            local x, y, z = inst:GetPosition():Get()
            local ents = TheSim:FindEntities(x, y, z, 30, nil, { "pickable", "stump", "withered", "INLIMBO" })
            for k, v in pairs(ents) do
                if v.components.pickable then
                    if TheWorld.state.iswinter then
                        if v.components.pickable.paused and not (inst.components.witherable and inst.components.witherable:IsWithered()) then
                            v.components.pickable:Resume()
                        end
                    end
                end
                if v.prefab == "cactus" or v.prefab == "oasis_cactus" then
                    v.ccs_hasflower = true
                end
            end
        end
    },

    -- 树牌
    ccs_cards_16 = {
        dayfn = function(inst)
            local x, y, z = inst:GetPosition():Get()
            local ents = TheSim:FindEntities(x, y, z, 30, nil, { "pickable", "stump", "withered", "INLIMBO" })
            for k, v in pairs(ents) do if v then trygrowth(v, 2) end end
        end
    },

    -- 火牌
    ccs_cards_11 = {
        tasktime = 1,
        taskname = "ccs_cards_11_task",
        taskfn = function (inst)
            local x, y, z = inst:GetPosition():Get()
            local ents = TheSim:FindEntities(x, y, z, 30, { "player" }, { "playerghost" })
            -- 设置温度，不会过冷
            for k, v in pairs(ents) do 
                if v and v.components.temperature and v.components.temperature.current < 10 then
                    v.components.temperature:SetTemperature(30)
                end
            end

        end
    },

    -- 冰牌 
    ccs_cards_2 = {
        tasktime = 1,
        taskname = "ccs_cards_2_task",
        taskfn = function(inst)
            local x, y, z = inst:GetPosition():Get()
            local ents = TheSim:FindEntities(x, y, z, 30, { "player" }, { "playerghost" })
            -- 设置温度，不会过热
            for k, v in pairs(ents) do
                if v and v.components.temperature and v.components.temperature.current > 50 then
                    v.components.temperature:SetTemperature(30)
                end
            end
        end
    },

    -- 影牌
    ccs_cards_25 = {},

    -- 花牌
    ccs_cards_9 = {},

    -- 水牌
    ccs_cards_18 = {},

    -- 剑牌
    ccs_cards_12 = {},

    -- 矢牌
    ccs_cards_15 = {},
}

local sptask = {
    -- 任务1, 范围内人物设置温度30
    -- temperaturetask = {
    --     tasktime = 1,
    --     canfn = function (inst)
    --         -- 容器里面有冰牌和火牌并且卡片满级
    --         local items = inst.components.container:GetAllItems()
    --         local hasfire = false
    --         local hasice = false
    --         for k, v in pairs(items) do
    --             if v.prefab == "ccs_cards_2"then
    --                 if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
    --                     hasice = true
    --                 end
    --             elseif v.prefab == "ccs_cards_11" then
    --                 if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
    --                     hasfire = true
    --                 end
    --             end
    --         end
    --         return hasice and hasfire
    --     end,
    --     taskfn = function(inst)
    --         local x, y, z = inst:GetPosition():Get()
    --         local ents = TheSim:FindEntities(x, y, z, 8, { "player" }, { "playerghost" })
    --         -- 设置温度，不会过冷也不会过热
    --         for k, v in pairs(ents) do
    --             if v and v.components.temperature and v.components.temperature.current < 10 and v.components.temperature.current > 50 then
    --                 v.components.temperature:SetTemperature(30)
    --             end
    --         end
    --     end
    -- },

    -- 任务2，同时放入满级影牌+剑牌+矢牌会秒杀掉范围内的影怪
    immitatetask = {
        tasktime = 3,
        canfn = function(inst, items)
            -- 容器里面有影牌和剑牌和矢牌并且卡片满级
            local hasshadow = false
            local hasweapon = false
            local hasarrow = false
            for k, v in pairs(items) do
                if v.prefab == "ccs_cards_25" then
                    if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                        hasshadow = true
                    end
                elseif v.prefab == "ccs_cards_12" then
                    if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                        hasweapon = true
                    end
                elseif v.prefab == "ccs_cards_15" then
                    if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                        hasarrow = true
                    end
                end
            end
            return hasshadow and hasweapon and hasarrow
        end,
        taskfn = function(inst)
            local x, y, z = inst:GetPosition():Get()
            local ents = TheSim:FindEntities(x, y, z, 30, { "shadow_aligned" }, { "player", "playerghost" })
            for _, entity in ipairs(ents) do
                if entity.components.health then
                    entity.components.health:Kill() -- 击杀
                end
            end
        end
    },
}

local function alldayfn(inst)
    inst:DoTaskInTime(0.5,function ()
        -- 查一下容器里面的东西，如果有config里面的物品，就执行对应的dayfn
        local items = inst.components.container:GetAllItems()
        for k, v in pairs(items) do
            if config[v.prefab] and config[v.prefab].dayfn then
                if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                    config[v.prefab].dayfn(inst)
                end
            end
        end
    end)

end

local function allfn(inst, items)
    -- 查一下容器里面的东西，如果有config里面的物品，就执行对应的fn
    for k, v in pairs(items) do
        if config[v.prefab] and config[v.prefab].fn then
            if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                config[v.prefab].fn(inst)
            end
        end
    end
end

local function alltaskfn(inst, items)
    -- 查一下容器里面的东西，如果有config里面的物品，就执行对应的taskfn
    for k, v in pairs(items) do
        if config[v.prefab] and config[v.prefab].taskfn then
            if v.components.ccs_card_level and v.components.ccs_card_level:IsMaxLevel() then
                if not inst[config[v.prefab].taskname] then
                    inst[config[v.prefab].taskname] = inst:DoPeriodicTask(config[v.prefab].tasktime, config[v.prefab].taskfn)
                end
            end
        end
    end
end

local function clear(inst)
    inst.Light:Enable(false)

    if inst.temperaturetask then
        inst.temperaturetask:Cancel()
        inst.temperaturetask = nil
    end
    if inst.immitatetask then
        inst.immitatetask:Cancel()
        inst.immitatetask = nil
    end
    if inst.ccs_cards_2_task then
        inst.ccs_cards_2_task:Cancel()
        inst.ccs_cards_2_task = nil
    end
    if inst.ccs_cards_11_task then
        inst.ccs_cards_11_task:Cancel()
        inst.ccs_cards_11_task = nil
    end
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

    local items = inst.components.container:GetAllItems()
    clear(inst) -- 先清理

    allfn(inst, items) -- 关闭容器就执行的效果

    alltaskfn(inst, items) -- 启动定时任务

    -- sptask表中的特殊任务，满足条件执行
    for k, v in pairs(sptask) do
        if v.canfn(inst, items) then
            if not inst[k] then
                inst[k] = inst:DoPeriodicTask(v.tasktime, v.taskfn)
            end
        end
    end
    
end
local MIN = TUNING.SHADE_CANOPY_RANGE_SMALL
local MAX = MIN + TUNING.WATERTREE_PILLAR_CANOPY_BUFFER
local function OnFar(inst, player)
    if player.ccssensangucanopy then
        player.ccssensangucanopy = player.ccssensangucanopy - 1
        player:PushEvent("onchangeccssensangucanopyzone", player.ccssensangucanopy > 0)
    end
    inst.players[player] = nil
end

local function OnNear(inst, player)
    inst.players[player] = true

    player.ccssensangucanopy = (player.ccssensangucanopy or 0) + 1

    player:PushEvent("onchangeccssensangucanopyzone", player.ccssensangucanopy > 0)
end

local function OnRemoveEntity(inst)
    for player in pairs(inst.players) do
        if player:IsValid() then
            if player.ccssensangucanopy then
                OnFar(inst, player)
            end
        end
    end
end

local function onsave(inst, data)

end

local function onload(inst, data)
    if inst.components.container then
        inst.components.container:Close()
    end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.entity:AddLight()
    inst.Light:SetFalloff(0.8)
    inst.Light:SetIntensity(.6)
    inst.Light:SetRadius(4.8)
    inst.Light:SetColour(237 / 255, 237 / 255, 209 / 255)
    inst.Light:Enable(false)

    inst:SetDeploySmartRadius(0.75) --recipe min_spacing/2
    MakeObstaclePhysics(inst, .2)

    inst.MiniMapEntity:SetIcon("sign.png")

    inst.AnimState:SetBank("ccs_homesign")
    inst.AnimState:SetBuild("ccs_homesign")
    inst.AnimState:PlayAnimation("idle")


    inst:AddTag("structure")
    inst:AddTag('daylight') --自然光


    inst:AddComponent("raindome")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("ccs_homesign")
        end
        return inst
    end
    CCSAPI.CcsItemInit(inst)
    inst.components.raindome:Enable()
    inst.components.raindome:SetRadius(20)

    inst.players = {}

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetTargetMode(inst.components.playerprox.TargetModes.AllPlayers)
    inst.components.playerprox:SetDist(MIN, MAX)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    inst.components.playerprox:SetOnPlayerNear(OnNear)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_homesign")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)


    inst:WatchWorldState("cycles", alldayfn)
    alldayfn(inst)
    inst.OnRemoveEntity = OnRemoveEntity
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end
CCSAPI.CcsItemAssets(assets, "ccs_clotheshanger")
CCSAPI.MakeItemSkinDefaultImage('ccs_homesign', 'images/inventoryimages/ccs_homesign.xml',
    'ccs_homesign')
for i = 1, 6 do
    CCSAPI.MakeItemSkin(
        'ccs_homesign',
        'ccs_homesign_skin_clotheshanger' .. i,
        {
            name = "衣架",
            atlas = 'images/inventoryimages/ccs_clotheshanger_skin' .. i .. '.xml',
            image = 'ccs_clotheshanger_skin' .. i,
            build = 'ccs_clotheshanger',
            bank = 'ccs_clotheshanger',
            anim = 'idle' .. i,
            basebuild = 'ccs_homesign',
            basebank = 'ccs_homesign',
            baseanim = 'idle',
            checkfn = function(inventory, name)
                return CCSAPI.CcsSkinCheckFn(inventory, "ccs_homesign_skin_clotheshanger1")
            end,
            checkclientfn = function(inventory, userid, name)
                return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_homesign_skin_clotheshanger1")
            end,
            init_fn = function(inst)
                if inst.Light then
                    inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
                end
            end,
            clear_fn = function(inst)
                inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
            end,
        }
    )
end

CCSAPI.CcsItemAssets(assets, "ccs_homesign_skin_tylhs", true, true)
CCSAPI.MakeItemSkin(
    'ccs_homesign',
    'ccs_homesign_skin_tylhs',
    {
        name = "庭院落花伞",
        atlas = 'images/inventoryimages/ccs_homesign_skin_tylhs.xml',
        image = 'ccs_homesign_skin_tylhs',
        build = 'ccs_homesign_skin_tylhs',
        bank = 'ccs_homesign_skin_tylhs',
        anim = 'idle',
        basebuild = 'ccs_homesign',
        basebank = 'ccs_homesign',
        baseanim = 'idle',
        checkfn = CCSAPI.CcsSkinCheckFn,
        checkclientfn = CCSAPI.CcsSkinCheckClientFn,
    }
)
return Prefab("ccs_homesign", fn, assets, prefabs),
    MakePlacer("ccs_homesign_placer", "ccs_homesign", "ccs_homesign", "idle")
