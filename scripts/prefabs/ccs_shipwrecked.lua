local assets=
{
	Asset("ANIM", "anim/ccs_shipwrecked.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_shipwrecked.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_shipwrecked.xml"),
}

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("idle")
end


local function OnActivate(inst, doer)
	if inst:HasTag("ccsusing") then
		return false
	end
	inst:AddTag("ccsusing")
	inst.passenger = doer
	inst.components.workable:SetWorkable(false)
	inst.components.activatable.inactive = true
    -- doer.player_classified.ishudvisible:set(false)
	-- ChangeToObstaclePhysics(doer)
    if doer.components.health and not doer.components.health:IsDead() then
		doer.ccs_shipwrecked = inst
        if doer.components.rider:IsRiding() then
            doer.sg:GoToState("ccs_shipwrecked_portal_mounted")
        else
            doer.sg:GoToState("ccs_shipwrecked_portal_pre")
        end
    end

end


local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    -- inst.entity:AddMiniMapEntity()
	-- inst.MiniMapEntity:SetIcon("shipwrecked_exit.tex")

	MakeObstaclePhysics(inst, 1)

    inst.AnimState:SetBank("ccs_shipwrecked")
    inst.AnimState:SetBuild("ccs_shipwrecked")
	inst.AnimState:PlayAnimation("idle")


    inst:AddTag("ccs_shipwrecked")



    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:AddComponent("activatable")
	inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.CanActivateFn = function ()
		return true
	end
	inst.components.activatable.quickaction = true
	inst.components.activatable.forcenopickupaction = true

	inst.onplayerleave = function (src, player)
		if inst.passenger == player and inst:HasTag("ccsusing") then
			inst.AnimState:PlayAnimation("idle")
			inst:RemoveTag("ccsusing")
			inst:Show()
			inst.components.workable:SetWorkable(true)
			inst.components.activatable.inactive = true
		end
	end
	inst:ListenForEvent("ms_playerleft", inst.onplayerleave, TheWorld)

	inst:AddComponent("named")

    return inst
end

return Prefab("ccs_shipwrecked", fn, assets),
	MakePlacer("ccs_shipwrecked_placer", "ccs_shipwrecked", "ccs_shipwrecked", "idle")
