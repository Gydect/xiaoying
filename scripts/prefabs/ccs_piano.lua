require "prefabutil"
local TechTree = require("techtree")
local assets =
{
    Asset("ANIM", "anim/ccs_piano.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_piano.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_piano.tex"),
}

local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small")   --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBank("ccs_piano")  
    inst.AnimState:SetBuild("ccs_piano")
    inst.AnimState:PlayAnimation("idle")
	
	inst.MiniMapEntity:SetIcon( "ccs_piano.tex" )

	inst:AddTag("ccs_piano")
    inst:AddTag("giftmachine")
   
	inst.Transform:SetScale(1.5, 1.5, 1.5)
	MakeObstaclePhysics(inst, 1.5)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    CCSAPI.CcsItemInit(inst)
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)  	
	
    inst:AddComponent("inspectable") 
	
	inst:AddComponent("prototyper")
	inst.components.prototyper.trees = TechTree.Create({CCS_PIANO = 4,SCIENCE = 5,CARPENTRY = 3})
	
	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 

return Prefab("ccs_piano", fn, assets, prefabs),
    MakePlacer("ccs_piano_placer", "ccs_piano", "ccs_piano", "idle",false, nil, nil, 1.5)