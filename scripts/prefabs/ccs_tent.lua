local assets=
{
	Asset("ANIM", "anim/ccs_tent.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_tent.xml"), 
	Asset("IMAGE", "images/inventoryimages/ccs_tent.tex"),
}


local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small")   --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onsleep(inst, sleeper)
end

local function onwake(inst, sleeper, nostatechange)
end

local function temperaturetick(inst, sleeper)
    if sleeper.components.temperature ~= nil then
        if inst.is_cooling then
            if sleeper.components.temperature:GetCurrent() > TUNING.SLEEP_TARGET_TEMP_TENT then
                sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() - TUNING.SLEEP_TEMP_PER_TICK)
            end
        elseif sleeper.components.temperature:GetCurrent() < TUNING.SLEEP_TARGET_TEMP_TENT then
            sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() + TUNING.SLEEP_TEMP_PER_TICK)
        end
    end
end

local function onhit(inst, worker)
    if inst.components.sleepingbag ~= nil and inst.components.sleepingbag.sleeper ~= nil then
        inst.components.sleepingbag:DoWakeUp()
    end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBank("ccs_tent")  
    inst.AnimState:SetBuild("ccs_tent")
    inst.AnimState:PlayAnimation("idle")
	
	inst.MiniMapEntity:SetIcon( "ccs_tent.tex" )

	inst:AddTag("ccs_tent")
	inst:AddTag("tent")
    inst:AddTag("structure")
   
	inst.Transform:SetScale(2, 2, 2)
	MakeObstaclePhysics(inst, 1)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)  	
	 inst.components.workable:SetOnWorkCallback(onhit)
	
    inst:AddComponent("sleepingbag")
    inst.components.sleepingbag.onsleep = onsleep
    inst.components.sleepingbag.onwake = onwake
    inst.components.sleepingbag.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 2 * 1.5
    --convert wetness delta to drying rate
    inst.components.sleepingbag.dryingrate = math.max(0, -TUNING.SLEEP_WETNESS_PER_TICK / TUNING.SLEEP_TICK_PERIOD)
    inst.components.sleepingbag:SetTemperatureTickFn(temperaturetick)

	
    inst:AddComponent("inspectable") 
	
	
	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 
   
return Prefab( "ccs_tent", fn, assets),
		MakePlacer("ccs_tent_placer", "ccs_tent", "ccs_tent", "idle",false, nil, nil, 2)