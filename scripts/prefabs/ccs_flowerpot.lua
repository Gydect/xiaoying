local assets=
{
	Asset("ANIM", "anim/ccs_flowerpot.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_flowerpot.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_flowerpot.xml"),
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

    inst.AnimState:SetBank("ccs_flowerpot")  
    inst.AnimState:SetBuild("ccs_flowerpot")
    inst.AnimState:PlayAnimation("idle")
	

	inst:AddTag("ccs_flowerpot")
    inst:AddTag("flower")
    inst:AddTag("cattoy")
   
	-- inst.Transform:SetScale(1.5, 1.5, 1.5)
	-- MakeObstaclePhysics(inst, 1.5)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    CCSAPI.CcsItemInit(inst)
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)  	
	
    inst:AddComponent("inspectable") 
	

    return inst
end 

return Prefab("ccs_flowerpot", fn, assets),
    MakePlacer("ccs_flowerpot_placer", "ccs_flowerpot", "ccs_flowerpot", "idle", false, nil, nil)