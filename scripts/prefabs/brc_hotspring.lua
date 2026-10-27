require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/brc_hotspring.zip"),
    Asset("ANIM", "anim/brc_hotspring_ying.zip"),
	Asset("IMAGE", "images/inventoryimages/brc_hotspring.tex"), 
	Asset("ATLAS", "images/inventoryimages/brc_hotspring.xml"),
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

	anim:SetBank("brc_hotspring")
	anim:SetBuild("brc_hotspring")
	anim:PlayAnimation("idle", true)
	anim:SetLayer(LAYER_BACKGROUND)

    inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("brc_hotspring")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)

	inst:ListenForEvent("ms_playerleft", function (_, player)
		if inst.passenger == player and inst:HasTag("isusing") then
			inst:RemoveTag("isusing")
		end
	end, TheWorld)

	return inst
end

return Prefab("brc_hotspring", InitFn, assets),
MakePlacer("brc_hotspring_placer", "brc_hotspring", "brc_hotspring", "idle")