require "prefabutil"
local assets = {
    Asset("ANIM", "anim/ccs_cookpot2.zip"),
    Asset("ANIM", "anim/ui_sandclock.zip"),
    Asset("ATLAS", "images/inventoryimages/ccs_cookpot2.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_cookpot2.tex"),

}
local cooking = require("cooking")
local containers = require("containers")
local params = containers.params
local HH_UTILS = require("utils/tr_hh_utils")

local function Cookpot2MagicCook(inst, doer)
    if HH_UTILS:HasComponents(inst, "container") and HH_UTILS:HasComponents(doer, "inventory") then
        local container_com = inst.components.container
        local input_slots = 4
        local save_prefab = {}
        local num_list = {}
        local need_msg = "请放满四格食材"
        for i = 1, input_slots do
            local hh_slot = container_com:GetItemInSlot(i)
            if not hh_slot then
                HH_UTILS:HHSay(doer, need_msg)
                return
            end
            table.insert(save_prefab, hh_slot.prefab)
            if HH_UTILS:HasComponents(hh_slot, "stackable") then
                table.insert(num_list, hh_slot.components.stackable.stacksize or 1)
            else
                table.insert(num_list, 1)
            end
        end
        local product = cooking.CalculateRecipe("portablecookpot", save_prefab)
        if not product then
            HH_UTILS:HHSay(doer, "未查询到食谱，请放入正确的材料")
            return
        end

        local cook_recipe = cooking.GetRecipe("portablecookpot", product)
        local cook_num = cook_recipe and cook_recipe.stacksize or 1
        local product_num = math.min(unpack(num_list))
        local remove_num = product_num
        product_num = product_num * cook_num * 2

        local test_product = SpawnPrefab(product)
        if not test_product then
            HH_UTILS:HHSay(doer, "未查询到食物")
            return
        end

        local test_num = 1
        if HH_UTILS:HasComponents(test_product, "stackable") then
            test_num = tonumber(test_product.components.stackable.maxsize) or 1
        end
        test_product:Remove()

        repeat
            local result_food = SpawnPrefab(product)
            if HH_UTILS:HasComponents(result_food, "stackable") then
                if product_num >= test_num then
                    result_food.components.stackable:SetStackSize(test_num)
                else
                    result_food.components.stackable:SetStackSize(product_num)
                end
            end
            product_num = product_num - test_num
            if container_com:IsFull() then
                doer.components.inventory:GiveItem(result_food)
            else
                container_com:GiveItem(result_food, nil, inst:GetPosition())
            end
        until product_num <= 0

        for i = 1, input_slots do
            local hh_slot = container_com:GetItemInSlot(i)
            if hh_slot then
                if HH_UTILS:HasComponents(hh_slot, "stackable") then
                    local current_stack = hh_slot.components.stackable.stacksize or 1
                    if current_stack > remove_num then
                        hh_slot.components.stackable:SetStackSize(current_stack - remove_num)
                    else
                        hh_slot:Remove()
                    end
                else
                    hh_slot:Remove()
                end
            end
        end
    elseif HH_UTILS:HasReplica(inst, "container") then
        SendRPCToServer(RPC["DoWidgetButtonAction"], nil, inst, nil)
    end
end

CCSAPI.Cookpot2MagicCook = Cookpot2MagicCook

params["ccs_cookpot2"] = {
    ["widget"] = {
        ["slotpos"] = {
            Vector3(-80, 64 + 32 + 8 + 4 - 40, 0),
            Vector3(-80, 32 + 4 - 40, 0),
            Vector3(-80, -(32 + 4) - 40, 0),
            Vector3(-80, -(64 + 32 + 8 + 4) - 40, 0),

            Vector3(40, 64 + 32 + 8 + 4 - 180 + 72 + 72 - 3, 0),
            Vector3(40, 32 + 4 - 180 + 72 + 72 - 3, 0),
            Vector3(120, 64 + 32 + 8 + 4 - 180 + 72 + 72 - 3, 0),
            Vector3(120, 32 + 4 - 180 + 72 + 72 - 3, 0),
            Vector3(40, 64 + 32 + 8 + 4 - 180 - 3, 0),
            Vector3(40, 32 + 4 - 180 - 3, 0),
            Vector3(120, 64 + 32 + 8 + 4 - 180 - 3, 0),
            Vector3(120, 32 + 4 - 180 - 3, 0),
        },
        animbank = "ui_dragonflyfurnace_2x2",
        animbuild = "ui_sandclock",
        ["slotbg"] = {
            { image = "inv_slot_dragonflyfurnace.tex", atlas = "images/hud2.xml" },
            { image = "inv_slot_dragonflyfurnace.tex", atlas = "images/hud2.xml" },
            { image = "inv_slot_dragonflyfurnace.tex", atlas = "images/hud2.xml" },
            { image = "inv_slot_dragonflyfurnace.tex", atlas = "images/hud2.xml" },
        },
        ["pos"] = Vector3(200, 0, 0),
        ["buttoninfo"] = {
            ["text"] = "魔法烹饪",
            ["position"] = Vector3(-80, -220, 0),
            ["fn"] = function(inst, doer)
                Cookpot2MagicCook(inst, doer)
            end,
            ["validfn"] = function(inst)
                return inst["replica"]["container"] ~= nil and not inst["replica"]["container"]:IsEmpty()
            end,
        }
    },
    ["type"] = "ccs_cookpot2",
}

params["ccs_cookpot2"]["itemtestfn"] = function(container, item, slot)
    if item["replica"] and item["replica"]["container"] then
        return false
    end
    return true
end

--_state 对应的容器界面，1 或未列出的为默认界面
local STATE_WIDGETS = {
    [2] = "ui_ccs_cookpot2_skin_xiaoke",
    [3] = "ui_ccs_cookpot2_skin_xingmian",
}

local function oncontainer_change(inst)
    if not inst._state or not inst.replica or not inst.replica.container then
        return
    end
    inst.replica.container:WidgetSetup(STATE_WIDGETS[inst._state:value()] or "ccs_cookpot2")
end

--靠近动画（星冕皮肤）：玩家靠近播放 proximity_pre 再循环 proximity_loop，远离播放 proximity_pst 再循环 idle
local function onplayernear(inst)
    inst.AnimState:PlayAnimation("proximity_pre")
    inst.AnimState:PushAnimation("proximity_loop", true)
end

local function onplayerfar(inst)
    inst.AnimState:PlayAnimation("proximity_pst")
    inst.AnimState:PushAnimation("idle", true)
end

local function Cookpot2SetProximity(inst, enable)
    if enable then
        inst.ccs_nohitanim = true
        if inst.components.playerprox == nil then
            inst:AddComponent("playerprox")
            inst.components.playerprox:SetDist(4, 6)
            inst.components.playerprox:SetOnPlayerNear(onplayernear)
            inst.components.playerprox:SetOnPlayerFar(onplayerfar)
        end
    else
        inst.ccs_nohitanim = nil
        if inst.components.playerprox ~= nil then
            inst:RemoveComponent("playerprox")
        end
    end
end

CCSAPI.Cookpot2SetProximity = Cookpot2SetProximity



local function onhammered(inst)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if inst:HasTag("burnt") then
        inst.components.lootdropper:SpawnLootPrefab("ash")
        local fx = SpawnPrefab("collapse_small")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("metal")
    else
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
        end
    end
    inst:Remove()
end

local function onhit(inst)
    if not inst:HasTag("burnt") then

        if inst.components.container ~= nil then
            if inst.components.container:IsOpen() then
                inst.components.container:Close()
            end
            inst.components.container:DropEverything()
            --onclose will trigger sfx already
        else
            inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
        end
        if not inst.ccs_nohitanim then --星冕皮肤没有受击动画，被敲时保持当前动画
            inst.AnimState:PlayAnimation("hit")
            inst.AnimState:PushAnimation("idle", true)
        end
    end
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()


    inst:AddTag("structure")
	inst:AddTag("multfoods_cookpot")
	inst.AnimState:SetBank("ccs_cookpot2")
	inst.AnimState:SetBuild("ccs_cookpot2")
	inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.3, 0.8)


	inst.entity:SetPristine()
	inst._state = net_smallbyte(inst.GUID, "ccs_cookpot2._state", "container_change")

	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			oncontainer_change(inst)
        end
        inst:ListenForEvent("container_change", oncontainer_change)
        return inst
	end
    inst._state:set(1)
    CCSAPI.CcsItemInit(inst)
	inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)


	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_cookpot2")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

	return inst
end
return Prefab( "ccs_cookpot2", fn, assets),
MakePlacer( "ccs_cookpot2_placer", "ccs_cookpot2", "ccs_cookpot2", "idle" )
