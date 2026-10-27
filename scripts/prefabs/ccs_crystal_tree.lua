local assets =
{
	Asset("ANIM", "anim/ccs_crystal_tree.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_crystal_tree.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_crystal_tree.xml"),
}

local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local scale = 3

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	--inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst:AddTag("ccs_two")

	inst.AnimState:SetBank("ccs_crystal_tree")
	inst.AnimState:SetBuild("ccs_crystal_tree")
    inst.AnimState:PlayAnimation("idle1")
	
	--inst.MiniMapEntity:SetIcon( "ccs_chest.tex" )

	MakeSnowCoveredPristine(inst)
	inst.Transform:SetScale(scale, scale, scale)
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("ccs_fountain")

	MakeSnowCovered(inst)

	return inst
end

return Prefab("ccs_crystal_tree", fn, assets),
		MakePlacer("ccs_crystal_tree_placer", "ccs_crystal_tree", "ccs_crystal_tree", "idle1",false, nil, nil, scale)