local assets =
{
    Asset("ANIM", "anim/ccs_miniboatlantern.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_miniboatlantern.xml"), 
    Asset("IMAGE", "images/inventoryimages/ccs_miniboatlantern.tex"),
}

local prefabs =
{
    "miniboatlanternlight",
    "miniboatlantern_loseballoon",
    "small_puff",
}

local brain 
local SG
if TUNING.CCS_MONIBOATSG == true then
    SG = "SGccs_miniboatlantern"
    brain = require "brains/ccs_miniboatlanternbrain"
else
    SG = "SGccs_miniboatlantern1"
    brain = require "brains/ccs_miniboatlanternbrain"
end

local LIGHT_RADIUS = 1.2
local LIGHT_COLOUR = Vector3(235 / 255, 150 / 255, 100 / 255)
local LIGHT_INTENSITY = .8
local LIGHT_FALLOFF = .5

local sounds =
{
    active_loop = "dontstarve/wilson/lantern_LP",
}

local balloon_layers =
{
    "balloon",
    "string",
    "string_base",
}

local function OnUpdateFlicker(inst, starttime)
    local time = starttime ~= nil and (GetTime() - starttime) * 15 or 0
    local flicker = (math.sin(time) + math.sin(time + 2) + math.sin(time + 0.7777)) * .5 -- range = [-1 , 1]
    flicker = (1 + flicker) * .5 -- range = 0:1
    inst.Light:SetRadius(LIGHT_RADIUS + .1 * flicker)
    flicker = flicker * 2 / 255
    inst.Light:SetColour(LIGHT_COLOUR.x + flicker, LIGHT_COLOUR.y + flicker, LIGHT_COLOUR.z + flicker)
end

local function HasFuel(inst)
    return true
end

local function OnTimerDone(inst, data)
end

local function StartSelfCombustionTimer(inst, time_to_combustion)
    if not inst.components.timer:TimerExists("self_combustion") then
        time_to_combustion = time_to_combustion or 1

        inst.components.timer:StartTimer("self_combustion", time_to_combustion)
    end
end

local function TurnOn(inst)
	if inst.components.inventoryitem and inst.components.inventoryitem.owner ~= nil then return end
        if inst._light == nil then
            inst._light = SpawnPrefab("miniboatlanternlight")
        end
		inst.AnimState:Show("glow")
        inst._light.entity:SetParent(inst.entity)

        inst.components.timer:ResumeTimer("self_combustion")

        inst.SoundEmitter:PlaySound(sounds.active_loop, "lp")
end

local function TurnOff(inst)
	if inst._light ~= nil then
		inst._light:Remove()
		inst._light = nil
	end

    inst.AnimState:Hide("glow")

    inst.components.locomotor:Stop()

	if inst._acceleration_task ~= nil then
		inst._acceleration_task:Cancel()
		inst._acceleration_task = nil
    end

    inst.components.timer:PauseTimer("self_combustion")

    inst:PushEvent("onturnoff")

    inst.SoundEmitter:KillSound("lp")
end

local function SpawnBalloonFX(inst, hide_symbols)
    if not POPULATING then
        local balloon = SpawnPrefab("miniboatlantern_loseballoon")
        balloon.Transform:SetPosition(inst.Transform:GetWorldPosition())
        balloon.Transform:SetRotation(inst.Transform:GetRotation())
    end
    if hide_symbols then
        for _,v in pairs(balloon_layers) do
            inst.AnimState:Hide(v)
        end
    end
end

local function nofuel(inst)
    SpawnBalloonFX(inst, true)
    TurnOff(inst)
    inst.components.timer:StopTimer("self_combustion")
end

local function OnDropped(inst)
    TurnOn(inst)
end

local function OnPutInInventory(inst)
    TurnOff(inst)
end

local function AccelerationTick(inst)
	inst.components.locomotor.walkspeed = inst.components.locomotor.walkspeed + TUNING.MINIBOATLANTERN_ACCELERATION

	if inst.components.locomotor.walkspeed >= TUNING.MINIBOATLANTERN_SPEED then
		inst.components.locomotor.walkspeed = TUNING.MINIBOATLANTERN_SPEED

		inst._acceleration_task:Cancel()
		inst._acceleration_task = nil
	end
end

local function OnInventoryLanded(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst.components.knownlocations:RememberLocation("home", Point(x, y, z))

	if TheWorld.Map:IsPassableAtPoint(x, y, z) then
        if HasFuel(inst) then
            inst.components.locomotor.walkspeed = 0

            if inst._acceleration_task ~= nil then
                inst._acceleration_task:Cancel()
            end
            inst._acceleration_task = inst:DoPeriodicTask(FRAMES, AccelerationTick)
        end
	else
        if inst._acceleration_task ~= nil then
            inst._acceleration_task:Cancel()
            inst._acceleration_task = nil
        end
    end

    inst.sg:GoToState("idle")
end

local function OnBurnt(inst)
    SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if HasFuel(inst) then
        SpawnBalloonFX(inst)
    end
end

local function OnExtinguish(inst)
    OnBurnt(inst)
    inst:Remove()
end

local function OnHaunt(inst)
    return false
end

local function OnSave(inst, data)
	data.nofuel = true
end

local function OnLoad(inst, data)
    if data ~= nil then
        if data.nofuel then
            nofuel(inst)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ccs_miniboatlantern")
    inst.AnimState:SetBuild("ccs_miniboatlantern")
	--inst.AnimState:PlayAnimation("idel_sway", true)

    --inst.Transform:SetSixFaced()

    MakeInventoryFloatable(inst, "small", 0.165, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    CCSAPI.CcsItemInit(inst)
	--inst._acceleration_task = nil
    --inst._light = nil

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_miniboatlantern.xml"

    inst:AddComponent("locomotor")
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.walkspeed = TUNING.MINIBOATLANTERN_SPEED
	inst.components.locomotor.pathcaps = { allowocean = true, ignoreLand = true }

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)

	inst:AddComponent("knownlocations")

	inst:SetStateGraph(SG)
	inst:SetBrain(brain)

    MakeSmallPropagator(inst)

    inst:AddComponent("timer")
    StartSelfCombustionTimer(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

	inst:DoTaskInTime(0.5,function()
		TurnOn(inst)
	end)
   

    inst:ListenForEvent("on_landed", OnInventoryLanded)
    inst:ListenForEvent("onburnt", OnBurnt)
    inst:ListenForEvent("onextinguish", OnExtinguish)
    inst:ListenForEvent("timerdone", OnTimerDone)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("ccs_miniboatlantern", fn, assets, prefabs)
