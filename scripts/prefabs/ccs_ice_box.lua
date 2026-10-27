require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/ui_xigewen_box.zip"),
    Asset("ANIM", "anim/ui_shoe_box.zip"),
    Asset("ANIM", "anim/ui_cat_box.zip"),
    Asset("IMAGE", "images/inventoryimages/ui_xigewen_slot.tex"),		--物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ui_xigewen_slot.xml"),
    Asset("IMAGE", "images/inventoryimages/ui_xigewen_slot2.tex"),     --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ui_xigewen_slot2.xml"),
    Asset("IMAGE", "images/inventoryimages/ui_pink_slot.tex"), --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ui_pink_slot.xml"),
    Asset("ANIM", "anim/ccs_ice_box.zip"),		--动画
	Asset("IMAGE", "images/inventoryimages/ccs_ice_box.tex"),		--物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_ice_box.xml"),
}

local prefabs =
{
    "collapse_small",
}

--[[local function fn()
    local inst = CreateEntity()		

    inst.entity:AddTransform()		
    inst.entity:AddAnimState()		
    inst.entity:AddSoundEmitter()	
    inst.entity:AddMiniMapEntity()	
    inst.entity:AddNetwork()		

    inst.MiniMapEntity:SetIcon("ccs_ice_box.tex")

    inst:AddTag("fridge")	
    inst:AddTag("structure")	

    inst.AnimState:SetBank("ccs_ice_box")
    inst.AnimState:SetBuild("ccs_ice_box")
    inst.AnimState:PlayAnimation("closed")

    inst.SoundEmitter:PlaySound("dontstarve/common/ice_box_LP", "idlesound")	

    MakeSnowCoveredPristine(inst)	

    inst.entity:SetPristine()	

    if not TheWorld.ismastersim then	
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_ice_box_rq")		
        end
        return inst
    end

    inst:AddComponent("inspectable")		
    inst:AddComponent("container")			
    inst.components.container:WidgetSetup("ccs_ice_box_rq")	
    inst.components.container.onopenfn = onopen		
    inst.components.container.onclosefn = onclose	
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("lootdropper")			
    inst:AddComponent("workable")				
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)	
    inst.components.workable:SetWorkLeft(2)					
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)		

	inst:AddComponent("preserver")
	inst.components.preserver:SetPerishRateMultiplier(0)	

    inst:ListenForEvent("onbuilt", onbuilt)					
    MakeSnowCovered(inst)		

    AddHauntableDropItemOrWork(inst)

    return inst
end--]]

local function onopen(inst)
    local skin_build = inst:GetSkinBuild()
    if skin_build then
        inst.AnimState:PlayAnimation("open")
        if inst.components.inventoryitem then
            inst.components.inventoryitem:ChangeImageName(skin_build .. "_open")
        end
    end
end

local function onclose(inst)
    local skin_build = inst:GetSkinBuild()
    if skin_build then
        inst.AnimState:PlayAnimation("closed")
        if inst.components.inventoryitem then
            inst.components.inventoryitem:ChangeImageName(skin_build)
        end
    end
    
end

local function oncontainer_change(inst)
    local num = inst._state:value()
    if num == 2 then
        inst.replica.container:WidgetSetup("ccs_ice_box_xigewen")
    elseif num == 3 then
        inst.replica.container:WidgetSetup("ccs_ice_box_shoe")
    elseif num == 4 then
        inst.replica.container:WidgetSetup("ccs_ice_box_cat")
    elseif num == 1 then
        inst.replica.container:WidgetSetup("ccs_ice_box_rq")
    end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)  
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_ice_box")  
    inst.AnimState:SetBuild("ccs_ice_box")
    inst.AnimState:PlayAnimation("closed")
    inst:AddTag("structure")
    inst.entity:SetPristine()

    inst._state = net_smallbyte(inst.GUID, "ccs_ice_box._state", "container_change")
    if not TheWorld.ismastersim then
	    inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_ice_box_rq")
        end
        inst:ListenForEvent("container_change", oncontainer_change)
        return inst
    end
    inst._state:set(1)
	
    CCSAPI.CcsItemInit(inst)
    inst:AddComponent("inspectable") 
		
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_ice_box.xml"
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_ice_box_rq")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	inst.components.container:EnableInfiniteStackSize(true)
     
	inst:AddComponent("preserver")
	inst.components.preserver:SetPerishRateMultiplier(0)

	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 

return Prefab("ccs_ice_box", fn, assets, prefabs)
    --MakePlacer("ccs_ice_box_placer", "ccs_ice_box", "ccs_ice_box", "closed")
