local assets =
{
	Asset("ANIM", "anim/ccs_paper.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_paper.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_paper.tex"),
}


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("ccs_paper")
	inst.AnimState:SetBuild("ccs_paper")
	inst.AnimState:PlayAnimation("idle")
	
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end 
	
	inst:AddComponent("stackable")  

	inst:AddComponent("inspectable")
	inst:AddComponent("tradable")

	inst:AddComponent("inventoryitem")   --物品
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_paper.xml"

	MakeHauntableLaunchAndSmash(inst)

	return inst
end

return Prefab("ccs_paper", fn, assets)
