local assets =
{
	Asset("ANIM", "anim/ccs_trash.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_trash.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_trash.xml"),
	Asset("ANIM", "anim/ui_ccs_trash_skin_zkbb.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_trash_skin_zkbb_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_trash_skin_zkbb_slot.xml"),
}

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	local skin = inst:GetSkinBuild()
	if skin ~= nil then
		if skin == "ccs_trash_skin_zkbb" then
			inst.AnimState:PlayAnimation("open")
		end
	end
end
		
local function onclose(inst,doer)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	inst.AnimState:PlayAnimation("idle")
end
local function onworked(inst, worker, workleft)
	local skin = inst:GetSkinBuild()
	if skin ~= nil then
		if skin == "ccs_trash_skin_zkbb" then
			if workleft > 0 and not inst:HasTag("burnt") then
				inst.AnimState:PlayAnimation("hit")
				inst.AnimState:PushAnimation("idle")
			end
		end
	end
end
local function onhammered(inst, worker)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end
local function oncontainer_change(inst)
	local num = inst._state:value()
	if num == 2 then
		inst.replica.container:WidgetSetup("ui_ccs_trash_skin_zkbb")
	elseif num == 1 then
		inst.replica.container:WidgetSetup("ccs_trash")
	end
end
local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst:AddTag("ccs_trash")

	inst.AnimState:SetBank("ccs_trash")
	inst.AnimState:SetBuild("ccs_trash")
    inst.AnimState:PlayAnimation("idle")

	inst.MiniMapEntity:SetIcon( "ccs_trash.tex" )

	MakeSnowCoveredPristine(inst)

	inst.Transform:SetScale(2, 2, 2)

	inst.entity:SetPristine()
	inst._state = net_smallbyte(inst.GUID, "ccs_trash._state", "container_change")
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_trash")
        end
		inst:ListenForEvent("container_change", oncontainer_change)
		return inst
	end

	inst._state:set(1)
	CCSAPI.CcsItemInit(inst)

	inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_trash")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnWorkCallback(onworked)
	inst.components.workable:SetOnFinishCallback(onhammered)
	
	MakeSnowCovered(inst)

	return inst
end

return Prefab("ccs_trash", fn, assets),
		MakePlacer("ccs_trash_placer", "ccs_trash", "ccs_trash", "idle",false, nil, nil, 2)