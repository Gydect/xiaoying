local assets=
{
	Asset("ANIM", "anim/ccs_bag2.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_bag2.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_bag2.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ccs_bag2.xml",256),
}

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)  
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_bag2")  
    inst.AnimState:SetBuild("ccs_bag2")
    inst.AnimState:PlayAnimation("idle")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	    inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_bag2")
        end
        return inst
    end
	
	inst.bluegem = 0
	
    inst:AddComponent("inspectable") 
		
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_bag2.xml"
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_bag2")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
     

	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 
    
return Prefab( "ccs_bag2", fn, assets) 