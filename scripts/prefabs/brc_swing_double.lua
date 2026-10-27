require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/brc_swing_double.zip"),
	Asset("IMAGE", "images/inventoryimages/brc_swing_double.tex"), 
	Asset("ATLAS", "images/inventoryimages/brc_swing_double.xml"),
}
local function onhammered(inst, worker)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end
local function InitFn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	inst.isusing = false

	MakeObstaclePhysics(inst, 0.4, 0.6)

	anim:SetBank("brc_swing_double")
	anim:SetBuild("brc_swing_double")
	anim:PlayAnimation("idle", true)

	inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("brc_swing")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)

	inst:ListenForEvent("ms_playerleft", function(_, player)
		if inst.passengerA == player then
			inst.passengerA = nil
		end
		if inst.passengerB == player then
			inst.passengerB = nil
		end
		if inst.passengerA == nil and inst.passengerB == nil and not inst.AnimState:IsCurrentAnimation("idle") then
			inst.AnimState:PlayAnimation("idle", true)
		end
	end, TheWorld)

	return inst
end

return Prefab("brc_swing_double", InitFn, assets),
MakePlacer("brc_swing_double_placer", "brc_swing_double", "brc_swing_double", "idle")
