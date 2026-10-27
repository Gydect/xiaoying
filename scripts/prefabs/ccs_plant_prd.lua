--后面在优化吧，摆
local function onregenfn(inst)
    inst.AnimState:PushAnimation("grow_to_strewberry")
	inst.AnimState:PushAnimation("idle_strewberry",true)
end

local function onpickedfn(inst, picker)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("idle")
end

local function dig_up(inst, worker)
	inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
	if inst.components.pickable:CanBePicked() then
		inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
	end
	inst.components.lootdropper:SpawnLootPrefab("dug_"..inst.prefab)
	inst:Remove()
end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("daed_to_idle")
	inst.AnimState:PushAnimation("idle",true)
end

local function makebarrenfn(inst, wasempty)
	inst.AnimState:PlayAnimation("dead")
end

local function fn(def, stage)
	local assets = 
	{
	    Asset("ANIM", "anim/"..def.name..".zip"),
    }

    local function fn2()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(def.name)
        inst.AnimState:SetBuild(def.name)
        inst.AnimState:PlayAnimation("idle", true)

        inst:AddTag("plant")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

		--[[inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
        local color = 0.75 + math.random() * 0.25
        inst.AnimState:SetMultColour(color, color, color, 1)--]]

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

        inst.components.pickable:SetUp(def.prd, def.time)
        inst.components.pickable.onregenfn = onregenfn		--生长
        inst.components.pickable.onpickedfn = onpickedfn	--采集触发的函数
		inst.components.pickable.ontransplantfn = ontransplantfn	--种植触发的函数
        inst.components.pickable.makeemptyfn = makeemptyfn	--清空状态触发的
		inst.components.pickable.makebarrenfn = makebarrenfn --枯萎触发的函数
		
		inst:DoTaskInTime(0,function()
			if inst.components.pickable:CanBePicked() then
				inst.AnimState:PushAnimation("idle_strewberry",true)
			end
		end)
        
        inst:AddComponent("witherable")

        inst:AddComponent("lootdropper")
        inst:AddComponent("inspectable")

		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.CHOP)
		inst.components.workable:SetOnFinishCallback(dig_up)
		inst.components.workable:SetWorkLeft(5)
        ---------------------

        MakeMediumBurnable(inst)
        MakeSmallPropagator(inst)
        MakeNoGrowInWinter(inst) --冬季不长
        MakeHauntableIgnite(inst)
        ---------------------

        --inst.OnPreLoad = OnPreLoad
        --inst.OnSave = OnSave

        return inst
    end

    return Prefab(def.name, fn2, assets, prefabs)
end

local ccs_plants = {}

for k, v in pairs(require("ccs_plant_prd")) do
    table.insert(ccs_plants, fn(v))
	table.insert(ccs_plants, MakePlacer("dug_"..v.name.."_placer", v.name, v.name, "dead"))
end

return unpack(ccs_plants)