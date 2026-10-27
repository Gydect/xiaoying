local assets =
{
	Asset("ANIM", "anim/ccs_broom.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_broom.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_broom.tex"),
}


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("ccs_broom")
	inst.AnimState:SetBuild("ccs_broom")
	inst.AnimState:PlayAnimation("idle")
	
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end 
	
	inst:AddComponent("stackable")  

	inst:AddComponent("inspectable")
	
	inst:AddComponent("ccs_jb")

	inst:AddComponent("inventoryitem")   --物品
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_broom.xml"

	MakeHauntableLaunchAndSmash(inst)

	return inst
end

return Prefab("ccs_broom", fn, assets)
