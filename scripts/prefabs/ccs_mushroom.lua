
local MUSHROOM_ANIMS =
{
    { idle = "seed" },
    { idle = "grow"},
    { idle = "full"},
}

local function play_idle(inst, stage)
    inst.AnimState:PlayAnimation(MUSHROOM_ANIMS[stage].idle)
end

local function set_stage1(inst)
    inst.components.pickable:ChangeProduct(nil)

    inst.components.pickable.canbepicked = false

    play_idle(inst, 1)
    inst.Transform:SetScale(2, 2, 2)
end
local function set_stage2(inst)
    inst.components.pickable:ChangeProduct(nil)

    inst.components.pickable.canbepicked = false

    play_idle(inst, 2)
    inst.Transform:SetScale(1, 1, 1)
end
local function set_stage3(inst)
    inst.components.pickable:ChangeProduct(inst.mushroomprdouct)

    inst.components.pickable:Regen()

    play_idle(inst, 3)
    inst.Transform:SetScale(1, 1, 1)
end
local STAGE1 = "stage_1"
local STAGE2 = "stage_2"
local STAGE3 = "stage_3"
local growth_stages =
{
    {
        name = STAGE1,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.EMPTY.BASE,
                TUNING.ROCK_FRUIT_REGROW.EMPTY.VAR) end,
        fn = set_stage1,
    },
    {
        name = STAGE2,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.PREPICK.BASE,
                TUNING.ROCK_FRUIT_REGROW.PREPICK.VAR) end,
        fn = set_stage2,
    },
    {
        name = STAGE3,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.PICK.BASE,
                TUNING.ROCK_FRUIT_REGROW.PICK.VAR) end,
        fn = set_stage3,
    },
}
local function onregenfn(inst)
    -- If we got here via debug and we're not at pickable yet, just skip us ahead to the first pickable stage.
    if inst.components.growable.stage < 3 then
        inst.components.growable:SetStage(3)
    end
end
local function onpickedfn(inst, picker)
    inst.components.growable:SetStage(1)
    inst.AnimState:PlayAnimation("seed")
end
local function makeemptyfn(inst)
    inst.components.growable:SetStage(1)
    inst.components.growable:StartGrowing()
    inst.components.growable.magicgrowable = true
end

local function dig(inst, worker)
    if inst.components.pickable:CanBePicked() then
        inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
    end
    inst:Remove()
end
local function makeccsmushroom(name, build, bank, prdouct)
    local assets = {
        Asset("ANIM", "anim/".. build .. ".zip"),
        Asset("ATLAS", "images/inventoryimages/" .. build .. ".xml"),
        Asset("IMAGE", "images/inventoryimages/" .. build .. ".tex"),
    }
    local function ccs_mushroom()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("seed")

        inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.DEFAULT] / 2) --plantables deployspacing/2
        MakeSmallObstaclePhysics(inst, .1)

        inst:AddTag("plant")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.mushroomprdouct = prdouct

        inst:AddComponent("lootdropper")

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.DIG)
        inst.components.workable:SetWorkLeft(1)
        inst.components.workable:SetOnFinishCallback(dig)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
        inst.components.pickable.numtoharvest = 3
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.onregenfn = onregenfn

        inst:AddComponent("inspectable")

        inst:AddComponent("growable")
        inst.components.growable.stages = growth_stages
        inst.components.growable.loopstages = true
        inst.components.growable.springgrowth = true
        inst.components.growable.magicgrowable = true
        inst.components.growable:SetStage(1)
        inst.components.growable:StartGrowing()

        inst:AddComponent("simplemagicgrower")
        inst.components.simplemagicgrower:SetLastStage(#inst.components.growable.stages)



        return inst
    end
    return Prefab(name, ccs_mushroom, assets)
end

local function makeccsmushroompicked(name, build, bank)
    local assets = {
        Asset("ANIM", "anim/" .. build .. ".zip"),
        Asset("ATLAS", "images/inventoryimages/" .. build .. ".xml"),
        Asset("IMAGE", "images/inventoryimages/" .. build .. ".tex"),
    }
    local function ccs_mushroom()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")
        
        MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst)


        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. build .. ".xml"
        inst.components.inventoryitem.imagename = build


        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("edible")     -- 可食物组件
        inst.components.edible.foodtype = FOODTYPE.GOODIES
        inst.components.edible.hungervalue = 6
        inst.components.edible.healthvalue = 6
        inst.components.edible.sanityvalue = 6


        return inst
    end
    return Prefab(name, ccs_mushroom, assets)
end

local function ondeploy(inst, pt, deployer)
    local tree = SpawnPrefab(inst.tree)
    if tree ~= nil then
        tree.Transform:SetPosition(pt:Get())
        inst.components.stackable:Get():Remove()
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            --V2C: WHY?!! because many of the plantables don't
            --     have SoundEmitter, and we don't want to add
            --     one just for this sound!
            deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
        end
    end
end
local function makeccsmushroomitem(name, build, bank, tree)
    local assets = {
        Asset("ANIM", "anim/" .. build .. ".zip"),
        Asset("ATLAS", "images/inventoryimages/" .. build .. ".xml"),
        Asset("IMAGE", "images/inventoryimages/" .. build .. ".tex"),
    }
    local function ccs_mushroom()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")

        MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst)


        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.tree = tree

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. build .. ".xml"
        inst.components.inventoryitem.imagename = build

        inst:AddComponent("deployable")
        --inst.components.deployable:SetDeployMode(DEPLOYMODE.ANYWHERE)
        inst.components.deployable.ondeploy = ondeploy
        inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)


        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM


        return inst
    end
    return Prefab(name, ccs_mushroom, assets)
end

local function makeccsmushroomstump(name, build, bank)
    local assets = {
        Asset("ANIM", "anim/" .. build .. ".zip"),
        Asset("ATLAS", "images/inventoryimages/" .. build .. ".xml"),
        Asset("IMAGE", "images/inventoryimages/" .. build .. ".tex"),
    }
    local function onhammered(inst, worker)
        local fx = SpawnPrefab("collapse_small") --锤烂的特效
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("metal")
        inst:Remove()
    end
    local function fn(Sim)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")
        inst:SetPhysicsRadiusOverride(0)  -- 物理碰撞半径
        inst:SetDeploySmartRadius(0)     -- 与周围物体的最小间距

        inst:AddTag("structure")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER) --动作
        inst.components.workable:SetWorkLeft(3)
        inst.components.workable:SetOnFinishCallback(onhammered) --锤烂的函数


        inst:AddComponent("inspectable")

        inst:AddComponent("lootdropper")

        return inst
    end
    return Prefab(name, fn, assets)
end


return makeccsmushroompicked("ccs_mushroomred_picked", "ccs_mushroomred_picked", "ccs_mushroomred_picked"),
makeccsmushroom("ccs_mushroomred", "ccs_mushroomred", "ccs_mushroomred", "ccs_mushroomred_picked"),
MakePlacer("ccs_mushroomred_placer", "ccs_mushroomred", "ccs_mushroomred", "seed"),
makeccsmushroomstump("ccs_mushroomred_stump", "ccs_mushroomred_stump", "ccs_mushroomred_stump"),
MakePlacer("ccs_mushroomred_stump_placer", "ccs_mushroomred_stump", "ccs_mushroomred_stump", "idle"),
makeccsmushroomitem("ccs_mushroomred_item", "ccs_mushroomred_item", "ccs_mushroomred_item", "ccs_mushroomred"),
MakePlacer("ccs_mushroomred_item_placer", "ccs_mushroomred", "ccs_mushroomred", "seed"),

makeccsmushroompicked("ccs_mushroomorange_picked", "ccs_mushroomorange_picked", "ccs_mushroomorange_picked"),
makeccsmushroom("ccs_mushroomorange", "ccs_mushroomorange", "ccs_mushroomorange", "ccs_mushroomorange_picked"),
MakePlacer("ccs_mushroomorange_placer", "ccs_mushroomorange", "ccs_mushroomorange", "seed"),
makeccsmushroomitem("ccs_mushroomorange_item", "ccs_mushroomorange_item", "ccs_mushroomorange_item", "ccs_mushroomorange"),
MakePlacer("ccs_mushroomorange_item_placer", "ccs_mushroomorange", "ccs_mushroomorange", "seed"),

makeccsmushroompicked("ccs_mushroompurple_picked", "ccs_mushroompurple_picked", "ccs_mushroompurple_picked"),
makeccsmushroom("ccs_mushroompurple", "ccs_mushroompurple", "ccs_mushroompurple", "ccs_mushroompurple_picked"),
MakePlacer("ccs_mushroompurple_placer", "ccs_mushroompurple", "ccs_mushroompurple", "seed"),
makeccsmushroomstump("ccs_mushroompurple_stump", "ccs_mushroompurple_stump", "ccs_mushroompurple_stump"),
MakePlacer("ccs_mushroompurple_stump_placer", "ccs_mushroompurple_stump", "ccs_mushroompurple_stump", "idle"),
makeccsmushroomitem("ccs_mushroompurple_item", "ccs_mushroompurple_item", "ccs_mushroompurple_item", "ccs_mushroompurple"),
MakePlacer("ccs_mushroompurple_item_placer", "ccs_mushroompurple", "ccs_mushroompurple", "seed"),

makeccsmushroompicked("ccs_mushroomgreen_picked", "ccs_mushroomgreen_picked", "ccs_mushroomgreen_picked"),
makeccsmushroom("ccs_mushroomgreen", "ccs_mushroomgreen", "ccs_mushroomgreen", "ccs_mushroomgreen_picked"),
MakePlacer("ccs_mushroomgreen_placer", "ccs_mushroomgreen", "ccs_mushroomgreen", "seed"),
makeccsmushroomstump("ccs_mushroomgreen_stump", "ccs_mushroomgreen_stump", "ccs_mushroomgreen_stump"),
MakePlacer("ccs_mushroomgreen_stump_placer", "ccs_mushroomgreen_stump", "ccs_mushroomgreen_stump", "idle"),
makeccsmushroomitem("ccs_mushroomgreen_item", "ccs_mushroomgreen_item", "ccs_mushroomgreen_item", "ccs_mushroomgreen"),
MakePlacer("ccs_mushroomgreen_item_placer", "ccs_mushroomgreen", "ccs_mushroomgreen", "seed")

