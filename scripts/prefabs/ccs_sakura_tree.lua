local assets=
{
	Asset("ANIM", "anim/ccs_sakura_tree.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_sakura_tree.xml"), 
	Asset("IMAGE", "images/inventoryimages/ccs_sakura_tree.tex"),
}

local ccs_light_data = {
	{level = 2, name = "ccs_sakura_tree", construction_product = "ccs_sakura_tree2" },
}

local function onconstruction_built(inst)
    PreventCharacterCollisionsWithPlacedObjects(inst)
    inst.level = 2
end

local function OnConstructed(inst, doer)
    local concluded = true
    for i, v in ipairs(CONSTRUCTION_PLANS[inst.prefab] or {}) do
        if inst.components.constructionsite:GetMaterialCount(v.type) < v.amount then
            concluded = false
            break
        end
    end
	if concluded then
		local tree = ReplacePrefab(inst, inst._construction_product)
    end
end

local function ccs_sakura_tree2_master_fn(inst)
	if inst.ccs_tree_task then
		inst.ccs_tree_task:Cancel()
		inst.ccs_tree_task = nil
	end
	inst.ccs_tree_task = inst:DoPeriodicTask(5, function()  
		local x,y,z = inst:GetPosition():Get()	
		local players = TheSim:FindEntities(x, y,z, 15,{"player"}) 
		for k,v in pairs(players) do
			if v then
				v.components.sanity:DoDelta(5)
				v.components.health:DoDelta(1)
			end
		end
	end, 0)		
end

local function ccs_sakura_tree2_clinent_fn(inst)
	inst:AddTag("lightningrod")
	inst.entity:AddLight()
	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(8) --范围半径
	inst.Light:SetFalloff(0.8) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 197/255, 126/255, 126/255  ) --颜色
end

local scale = 2

local function MakeCcs_Light(name, client_postinit, master_postinit, construction_data)
	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		inst.entity:AddSoundEmitter()
		--inst.entity:AddMiniMapEntity()

		inst.AnimState:SetBank("ccs_sakura_tree")  
		inst.AnimState:SetBuild("ccs_sakura_tree")
		inst.AnimState:PlayAnimation("idle",true)
	
		--inst.MiniMapEntity:SetIcon( "ccs_light.tex" )
		
		inst.Transform:SetScale(scale, scale, scale)
        if construction_data then
            inst.level = construction_data.level
        else
            inst.level = 1
        end
		
		inst:SetPhysicsRadiusOverride(1.5)
		MakeObstaclePhysics(inst, inst.physicsradiusoverride)

		inst:AddTag("ccs_sakura_tree")
		inst.entity:SetPristine()

        if client_postinit ~= nil then
            client_postinit(inst)
        end

		if not TheWorld.ismastersim then
			return inst
		end

		if construction_data then
			inst._construction_product = construction_data.construction_product

			inst:AddComponent("constructionsite")
			inst.components.constructionsite:SetConstructionPrefab("construction_container")
			inst.components.constructionsite:SetOnConstructedFn(OnConstructed)
		end

		inst:AddComponent("inspectable")
		inst:AddComponent("lootdropper")

		inst:ListenForEvent("onbuilt", onconstruction_built)

        if master_postinit then
           master_postinit(inst)
        end

        return inst
	end

	local product = construction_data and construction_data.construction_product or nil
	return Prefab(name, fn, assets, prefabs, product)
end
 
local ret = {}
table.insert(ret, MakeCcs_Light("ccs_sakura_tree2",ccs_sakura_tree2_clinent_fn,ccs_sakura_tree2_master_fn))
table.insert(ret, MakePlacer("ccs_sakura_tree_placer", "ccs_sakura_tree", "ccs_sakura_tree", "idle",false, nil, nil, scale))
for i = 1, #ccs_light_data do
	table.insert(ret, MakeCcs_Light(ccs_light_data[i].name, nil, nil, ccs_light_data[i]))
end

return unpack(ret)