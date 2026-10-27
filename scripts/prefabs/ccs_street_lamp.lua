local assets =
{
	Asset("ANIM", "anim/ccs_street_lamp.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_street_lamp.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_street_lamp.xml"),
}

local function onhammered(inst, worker)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local scale = 2.2

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
	--inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("ccs_street_lamp")
	inst.AnimState:SetBuild("ccs_street_lamp")
    inst.AnimState:PlayAnimation("idle")
	
	--inst.MiniMapEntity:SetIcon( "ccs_chest.tex" )

	MakeSnowCoveredPristine(inst)
	inst.Transform:SetScale(scale, scale, scale)
	
	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(8) --范围半径
	inst.Light:SetFalloff(0.8) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 197/255, 126/255, 126/255  ) --颜色
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end
	CCSAPI.CcsItemInit(inst)
	
	inst:AddComponent("inspectable")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)
	

	MakeSnowCovered(inst)

	return inst
end

return Prefab("ccs_street_lamp", fn, assets),
		MakePlacer("ccs_street_lamp_placer", "ccs_street_lamp", "ccs_street_lamp", "idle",false, nil, nil, scale)