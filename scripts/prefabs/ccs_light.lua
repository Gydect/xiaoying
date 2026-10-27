local assets=
{
	Asset("ANIM", "anim/ccs_light.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_light.xml"), 
	Asset("IMAGE", "images/inventoryimages/ccs_light.tex"),
}

local ccs_light_data = {
	{level = 2, name = "ccs_light", construction_product = "ccs_light2" },
}

local gl = {
	{id = 1, gl = 0.3},
	{id = 2, gl = 0.25},
	{id = 3, gl = 0.4},
	{id = 4, gl = 0.05},
}

local function dropitem(inst)
	if TheWorld.state.time < .02 and inst.level == 1 then
		local xy = 0
		for k, v in pairs(AllPlayers) do
			if v:HasTag("ccs") then
				xy = xy + 1
			end
		end
		if xy == 0 then
			xy = 1
		end
		for i = 1, xy do
			local b = 1 --樱花数量
			local a = 1
			local gl2 = 0
			local gl3 = math.random()
			for k, v in pairs(gl) do
				gl2 = gl2 + v.gl
				if gl3 <= gl2 then
					a = v.id
					break
				end
			end
			if a <= 3 then
				for i = 1, b do
					inst.components.lootdropper:SpawnLootPrefab("ccs_sakura" .. a)
				end
			end
			if a == 4 then
				local a = math.random(1, 10)
				for i = 1, a do
					inst.components.lootdropper:SpawnLootPrefab("petals")
				end
			end
		end
		local x, y, z = inst:GetPosition():Get()
		local trash = TheSim:FindEntities(x, y, z, 15, { "ccs_trash" })
		local a = #trash > 0 and 0.05 or 0
		if math.random() <= .05 + a then
			local players = TheSim:FindEntities(x, y, z, 30, { "player" })
			for k, v in pairs(players) do
				if v then
					if v:HasTag("ccs") then
						local a = math.random(1, 2)
						if a == 1 then
							inst.components.lootdropper:SpawnLootPrefab("ccs_cards_4", nil, nil, nil, nil, v)
						else
							inst.components.lootdropper:SpawnLootPrefab("ccs_cards_23", nil, nil, nil, nil, v)
						end
					end
				end
			end
		end
	end
end

local function OnIsDay(inst)
	dropitem(inst)
	dropitem(inst)
end

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
		ReplacePrefab(inst, inst._construction_product)
    end
end

local function MakeCcs_Light(name, client_postinit, master_postinit, construction_data)
	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		inst.entity:AddSoundEmitter()
		inst.entity:AddMiniMapEntity()

		inst.AnimState:SetBank("ccs_light")  
		inst.AnimState:SetBuild("ccs_light")
		inst.AnimState:PlayAnimation("anim",true)
	
		inst.MiniMapEntity:SetIcon( "ccs_light.tex" )
		
		inst.Transform:SetScale(2, 2, 2)
		inst.Transform:SetTwoFaced()
        if construction_data then
            inst.level = construction_data.level
        else
            inst.level = 1
        end
		
		inst:SetPhysicsRadiusOverride(1.5)
		MakeObstaclePhysics(inst, inst.physicsradiusoverride)

		inst:AddTag("ccs_light")
		inst:AddTag("rotatableobject") --能让栅栏击剑起作用
		inst:AddTag("ccsflatrotated") -- 自定义栅栏击剑旋转角度
		inst.entity:SetPristine()

        if client_postinit ~= nil then
            client_postinit(inst)
        end

		if not TheWorld.ismastersim then
			return inst
		end
		CCSAPI.CcsItemInit(inst)
		
		if construction_data then
			inst._construction_product = construction_data.construction_product

			inst:AddComponent("constructionsite")
			inst.components.constructionsite:SetConstructionPrefab("construction_container")
			inst.components.constructionsite:SetOnConstructedFn(OnConstructed)
		end

		inst:AddComponent("inspectable")
		inst:AddComponent("lootdropper")
		inst:AddComponent("savedrotation")

		inst:ListenForEvent("onbuilt", onconstruction_built)

        if master_postinit then
           master_postinit(inst)
        end
		
		inst:WatchWorldState("cycles", OnIsDay)
        return inst
	end

	local product = construction_data and construction_data.construction_product or nil
	return Prefab(name, fn, assets, prefabs, product)
end
 
local ret = {}
table.insert(ret, MakeCcs_Light("ccs_light2"))
for i = 1, #ccs_light_data do
	table.insert(ret, MakeCcs_Light(ccs_light_data[i].name, nil, nil, ccs_light_data[i]))
end

return unpack(ret)