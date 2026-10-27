local function commonfn(name)
	local assets =
	{
		Asset("ANIM", "anim/ccs_sakuras.zip"),
		Asset("ATLAS", "images/inventoryimages/"..name..".xml"),
		Asset("IMAGE", "images/inventoryimages/"..name..".tex"),
	}


	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)

		inst.AnimState:SetBank("ccs_sakuras")
		inst.AnimState:SetBuild("ccs_sakuras")
		inst.AnimState:PlayAnimation(name)
		
		inst:AddTag("ccs_pack_item")
	
		MakeInventoryFloatable(inst)

		inst.entity:SetPristine()
    
	
		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("tradable")    --可交易
	
		inst:AddComponent("stackable")   --叠堆


		inst:AddComponent("inspectable")

		inst:AddComponent("inventoryitem")   --物品
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"
		inst.components.inventoryitem.imagename = name
		
		if name == "ccs_sakura2" then
			inst:AddComponent("ccs_packer")
		end
	
		MakeHauntableLaunchAndSmash(inst)

		return inst
	end

	return Prefab(name, fn, assets)
end

return commonfn("ccs_sakura1"),
	commonfn("ccs_sakura2"),
	commonfn("ccs_sakura3")