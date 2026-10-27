local assets =
{
    Asset("ANIM", "anim/ccs_crystallization.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_crystallization1.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_crystallization1.tex"),
	
	Asset("ATLAS", "images/inventoryimages/ccs_crystallization2.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_crystallization2.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_crystallization3.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_crystallization3.tex"),
}


local function fn_common(name,anim_name)
	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)

		inst.AnimState:SetBank("ccs_crystallization")
		inst.AnimState:SetBuild("ccs_crystallization")
		inst.AnimState:PlayAnimation(anim_name)
		
		MakeInventoryFloatable(inst, "med", nil, 0.75)

		inst.entity:SetPristine()
		
		
		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("tradable")    --可交易

		inst:AddComponent("inspectable")

		inst:AddComponent("inventoryitem") 
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"
		
		MakeHauntableLaunchAndSmash(inst)

		return inst
	end
	
	return Prefab(name, fn, assets)
end

return fn_common("ccs_crystallization1","idle2"),
fn_common("ccs_crystallization2","idle"),
fn_common("ccs_crystallization3","idle3")


