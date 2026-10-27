local assets=
{
	Asset("ANIM", "anim/ccs_sb.zip"), 
}

local function GetPeepChance(inst)
    local hunger_percent = inst.components.perishable:GetPercent()
    if hunger_percent <= 0 then
        return 0.8
    elseif hunger_percent < STARVING_PERISH_PERCENT then -- matches spoiled tag
        return (0.2 - inst.components.perishable:GetPercent()) * 2
    elseif hunger_percent < HUNGRY_PERISH_PERCENT then
        return 0.025
    end

    return 0
end

local function IsAffectionate(inst)
    return (inst.components.perishable == nil or inst.components.perishable:GetPercent() > 0.2)
            or false
end

local function IsPlayful(inst)
	return IsAffectionate(inst)
end

local function IsSuperCute(inst)
	return true
end

local function OnSave(inst, data)
	data.chbs = inst.chbs
end

local function OnLoad(inst, data)
	if data then
		if data.chbs then
			inst.chbs = data.chbs
		end
	end
end

local function OnLoadPostPass(inst)
	if inst._special_powers ~= nil then
		inst:PushEvent("perishchange", {percent = inst.components.perishable:GetPercent()})
	end
end

local brain = require("brains/ccs_xk_brain")

local function onopen(inst)
	 inst.sg:GoToState("open")
end


local function onclose(inst)
	 inst.sg:GoToState("close")
end

local function itemget(inst,data)
	inst:DoTaskInTime(0,function()
		if data and data.item then
			if data.slot == 1 and data.item.components.temperature then
				data.item.components.temperature.current = 99 
			end
			if data.slot == 2 and data.item.components.temperature and inst.chbs == 1 then
				data.item.components.temperature.current = -99 
			end
		end		
	end)
end

local function AcceptTest(inst, item,giver)
	if item.prefab == "opalpreciousgem"  then
		if inst.chbs < 1 then
			return true
		else
			giver.components.talker:Say("斯比已经可以制冷制热暖石了")
		end
	end
	if item.prefab == "purplegem" and inst.components.ccsfollewer.player and inst.components.ccsfollewer.player.userid == giver.userid then
		return true
	end
	return false
end


local function onaccept(inst,giver,item)
	if item.prefab == "opalpreciousgem" then
		inst.chbs = inst.chbs + 1
		giver.components.ccs_valid.sb2 = inst.chbs
		if inst.chbs == 1 then     
			giver.components.talker:Say("斯比已经可以制冷制热暖石了")
		end
	end
	if item.prefab == "purplegem" then
		giver.components.ccs_valid.sb = false
		giver.components.ccs_valid.sb2 = 0
		inst:Remove()
	end
end

local function updatelight(inst, phase)  
	if phase == "day" then	
		if inst._light ~= nil then
			if inst._light:IsValid() then
				inst._light:Remove()   
				inst._light = nil    
            end
	    end
	elseif phase == "dusk" then   
		if inst._light ~= nil then
			if inst._light:IsValid() then
				inst._light:Remove()
				inst._light = nil
			end
		end
	elseif phase == "night" then 
		if inst._light == nil or not inst._light:IsValid() then    
			inst._light = SpawnPrefab("ccs_sb_light") 
			inst._light.entity:SetParent(inst.entity)    		  
		end	
	end
end


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()
	
	inst.DynamicShadow:SetSize(1, .33)

	--inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("ccs_sb")
	inst.AnimState:SetBuild("ccs_sb")
	inst.AnimState:PlayAnimation("idle")

	inst.entity:AddPhysics()
	inst.Physics:SetMass(1)
	inst.Physics:SetFriction(0)
	inst.Physics:SetDamping(5)
	inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
	inst.Physics:ClearCollisionMask()
	inst.Physics:CollidesWith((TheWorld.has_ocean and COLLISION.GROUND) or COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.FLYERS)
	inst.Physics:CollidesWith(COLLISION.CHARACTERS)
	inst.Physics:SetCapsule(.5, 1)

	inst:AddTag("flying")
	inst:AddTag("ignorewalkableplatformdrowning")
	inst:AddTag("ccs_sb")
	inst:AddTag("ccs_cw")

	MakeInventoryFloatable(inst)

	inst.Physics:SetDontRemoveOnSleep(true)

	--inst:AddTag("critter")
	inst:AddTag("companion")
	inst:AddTag("notraptrigger")
	inst:AddTag("noauradamage")
	inst:AddTag("small_livestock")
	inst:AddTag("NOBLOCK")

	inst:AddComponent("spawnfader")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_xk_rq")
        end
		return inst
	end

	inst.GetPeepChance = GetPeepChance
    inst.IsAffectionate = IsAffectionate
	inst.IsSuperCute = IsSuperCute
	inst.IsPlayful = IsPlayful

	inst.playmatetags = {"critter"}
	
	inst:AddComponent("inspectable")

	inst:AddComponent("locomotor")
	inst.components.locomotor:EnableGroundSpeedMultiplier(true)
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.softstop = true
	inst.components.locomotor.walkspeed = TUNING.CRITTER_WALK_SPEED * 3
	inst.components.locomotor.runspeed = TUNING.LIGHTFLIER.WALK_SPEED * 4
	inst.components.locomotor.pathcaps = { allowocean = true }
	
	inst:SetStateGraph("SGccs_xk")
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_xk_rq")
	
	inst.chbs = 0

	inst:ListenForEvent("onopen", onopen)
	inst:ListenForEvent("onclose", onclose)
	inst:ListenForEvent("itemget", itemget)
	--inst:ListenForEvent("itemlose", itemlose)
	
	inst:AddComponent("trader")   --交易
	inst.components.trader:SetAcceptTest(AcceptTest)  --接收的道具
	inst.components.trader.onaccept = onaccept      --给予
	
	inst:AddComponent("ccsfollewer")
	
	inst:WatchWorldState("phase", updatelight)
	updatelight(inst, TheWorld.state.phase)
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	inst.OnLoadPostPass = OnLoadPostPass
	

	return inst
end

local function builder_onbuilt(inst, builder)
	inst:Remove()
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = 1
    local offset = FindWalkableOffset(pt, theta, radius, 6, true)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
	--[[for k,v in pairs(builder.components.petleash.pets) do
		if v and v.prefab == "ccs_sb" then
			builder.components.talker:Say("我已经有斯比了")
			return
		end
	end
	builder.components.petleash:CcsSpawnPetAt(pt.x, 0, pt.z, inst.pettype) 	--]]
	if builder.components.ccs_valid then
		if builder.components.ccs_valid.sb == false then
			local sb = SpawnAt(inst.pettype, builder)
			builder.components.ccs_valid.sb = true
			local x,y,z = builder:GetPosition():Get()	
			sb.components.ccsfollewer:Init(builder,x,y,z)
		else
			builder.components.talker:Say("我已经有斯比了")
		end
	end
end

local function fn2()
	local inst = CreateEntity()

	inst.entity:AddTransform()

	inst:AddTag("CLASSIFIED")

	--[[Non-networked entity]]
	inst.persists = false

	--Auto-remove if not spawned by builder
	inst:DoTaskInTime(0, inst.Remove)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.pettype = "ccs_sb"
	inst.OnBuiltFn = builder_onbuilt

	return inst
end

local function light() --光的代码
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX") --特效标签

	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(8) --范围半径
	inst.Light:SetFalloff(0.5) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 177/255, 0/255, 255/255, 1 ) --颜色

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.persists = false 
	
    return inst
end   

return Prefab("ccs_sb", fn, assets),
		Prefab("ccs_sb_light", light),
		Prefab("ccs_sb_builder", fn2, nil, { "ccs_sb" })