require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/ccs_chest.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_chest.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_chest.xml"),
}

local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")

        if inst.skin_open_sound then
            inst.SoundEmitter:PlaySound(inst.skin_open_sound)
        else
            inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
        end
    end
end


local function murdered(target,doer,inst)
    local murdered = target
    if murdered ~= nil and (murdered.components.health ~= nil or murdered.components.murderable ~= nil) then
		inst.components.container:DropItem(target)
        local x, y, z = doer.Transform:GetWorldPosition()
        murdered.components.inventoryitem:RemoveFromOwner(true)
        murdered.Transform:SetPosition(x, y, z)

        if murdered.components.health ~= nil and murdered.components.health.murdersound ~= nil then
            doer.SoundEmitter:PlaySound(FunctionOrValue(murdered.components.health.murdersound, murdered, doer))
        elseif murdered.components.murderable ~= nil and murdered.components.murderable.murdersound ~= nil then
            doer.SoundEmitter:PlaySound(FunctionOrValue(murdered.components.murderable.murdersound, murdered, doer))
        end

        local stacksize = murdered.components.stackable ~= nil and murdered.components.stackable:StackSize() or 1

        -- NOTES(JBK): Push the events before spawning any giving any loot.
        doer:PushEvent("murdered", { victim = murdered, stackmult = stacksize })
        doer:PushEvent("killed", { victim = murdered, stackmult = stacksize })

        if murdered.components.lootdropper ~= nil then
            murdered.causeofdeath = doer
            local pos = Vector3(x, y, z)
            for i = 1, stacksize do
                local loots = murdered.components.lootdropper:GenerateLoot()
                for k, v in pairs(loots) do
                    local loot = SpawnPrefab(v)
                    if loot ~= nil then
                        doer.components.inventory:GiveItem(loot, nil, pos)
                    end
                end
            end
        end

        if murdered.components.inventory and murdered:HasTag("drop_inventory_onmurder") then
            murdered.components.inventory:TransferInventory(doer)
        end

        murdered:Remove()
	end
end
		
local function onclose(inst,doer)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("close")
        inst.AnimState:PushAnimation("closed", false)

        if inst.skin_close_sound then
            inst.SoundEmitter:PlaySound(inst.skin_close_sound)
        else
            inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
        end
    end
	local x,y,z = inst:GetPosition():Get()
	local ents = TheSim:FindEntities(x,y,z,30)  
	local items = {}
	for k,v in pairs(inst.components.container.slots) do
		if v then
			for k2,v2 in pairs(ents) do 
				--找相同的物品跟生物
				if v2 and v2.components and v2.components.inventoryitem and v2.prefab == v.prefab then
					if v2.GUID ~= v.GUID and v2:IsValid() and v2.components.inventoryitem.owner == nil then
						table.insert(items,v2)
					end
				end
			end
		end
	end
	--再找一遍生物
	for k2,v2 in pairs(ents) do 
		if v2 and v2.components and v2.components.inventoryitem and v2.replica.inventoryitem and (v2.components.health or v2.components.murderable) then
			if v2:IsValid() and v2.components.inventoryitem.owner == nil then
				if v2.components.occupier then
					if v2.components.occupier:GetOwner() == nil then
						table.insert(items,v2)
					end
				else
					table.insert(items,v2)
				end
				
			end
		end
	end
	for k,v in pairs(items) do
		if v and v.components.inventoryitem and v.replica.inventoryitem and not v:HasTag("spider") then
			inst.components.container:GiveItem(v)
		end
	end

	for k,v in pairs(inst.components.container.slots) do
		if v and v.components.health and not v:HasTag("spider") then
			murdered(v,doer,inst)
		end
		if v and v.components.murderable and not v:HasTag("spider") then	
			murdered(v,doer,inst)
		end
	end		
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", false)
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", false)
    if inst.skin_place_sound then
        inst.SoundEmitter:PlaySound(inst.skin_place_sound)
    else
        inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
    end
end

local function onsave(inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt and inst.components.burnable ~= nil then
        inst.components.burnable.onburnt(inst)
    end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst:AddTag("structure")
	inst:AddTag("chest")

	inst.AnimState:SetBank("chest")
	inst.AnimState:SetBuild("ccs_chest")
    inst.AnimState:PlayAnimation("closed")
    inst.scrapbook_anim="closed"
	
	inst.MiniMapEntity:SetIcon( "ccs_chest.tex" )

	MakeSnowCoveredPristine(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_chest")
        end
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_chest")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose
	inst.components.container.skipclosesnd = true
	inst.components.container.skipopensnd = true

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	MakeSmallBurnable(inst, nil, nil, true)
	MakeMediumPropagator(inst)


	inst:AddComponent("hauntable")
	inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

	inst:ListenForEvent("onbuilt", onbuilt)
	MakeSnowCovered(inst)


	inst.OnSave = onsave
	inst.OnLoad = onload

	return inst
end

return Prefab("ccs_chest", fn, assets),
		MakePlacer("ccs_chest_placer", "ccs_chest", "ccs_chest", "closed")