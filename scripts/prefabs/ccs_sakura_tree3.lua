local assets =
{
	Asset("ANIM", "anim/ccs_sakura_tree2.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_sakura_tree3.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_sakura_tree3.xml"),
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

	inst.AnimState:SetBank("ccs_sakura_tree2")
	inst.AnimState:SetBuild("ccs_sakura_tree2")
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

return Prefab("ccs_sakura_tree3", fn, assets),
		MakePlacer("ccs_sakura_tree3_placer", "ccs_sakura_tree2", "ccs_sakura_tree2", "idle1",false, nil, nil, scale)