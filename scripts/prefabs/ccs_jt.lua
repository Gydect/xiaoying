local assets=
{
	Asset("ANIM", "anim/ccs_jt.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_jt.xml"), 
	Asset("IMAGE", "images/inventoryimages/ccs_jt.tex"),
}


local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small")   --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function Jt_Task(inst)
	if inst.enble == false then return end
	local pos = inst:GetPosition()
	local ents = TheSim:FindEntities(pos.x, pos.y, pos.z,40,nil,{"campfire"}, { "fire","smolder" })
	for i, v in ipairs(ents) do
		if v.components.burnable ~= nil and v.prefab ~= "laozi_sp" and v.prefab ~= "book_myth" then
			v.components.burnable:Extinguish()
		end
	end
	local enta = TheSim:FindEntities(pos.x, pos.y, pos.z,40,nil,nil, { "witherable"})
	for i, v in ipairs(enta) do
		if v.components.witherable ~= nil then
			v.components.witherable:Protect(60)
		end
	end
	local entb = TheSim:FindEntities(pos.x, pos.y, pos.z,40,{"lunarthrall_plant"})
	for i, v in ipairs(entb) do
		if v and v.prefab ~= "medal_origin_tree" then
			if v.components.health and v.components.combat then
				local x, y, z = v:GetPosition():Get()
				local fx = SpawnPrefab("ccs_meteor")
				fx.AnimState:SetAddColour( 0/255, 255/255, 255/255, 1 )
				fx:AttackArea(inst,inst)
				fx.damage = 0
				fx.Transform:SetPosition(x,y,z)
				v.components.combat:GetAttacked(fx,9999999999999999999999999,fx)
			end
		end
	end
	local x,y,z = inst:GetPosition():Get()
	local ents = TheSim:FindEntities(x,y,z,30,nil,{"FX"})
	for k,v in pairs(ents) do
		if v and v.components then
            if v.components.crop then
				if not (v.components.crop:IsReadyForHarvest() or v:HasTag("withered")) then
					v.components.crop:Fertilize(inst)
				end
            elseif v.components.grower then
				if v.components.grower:IsEmpty() then
					v.components.grower:Fertilize(inst)
				end
            elseif v.components.pickable then
				if v.components.pickable:CanBeFertilized() then
					v.components.pickable:Fertilize(inst)
					TheWorld:PushEvent("CHEVO_fertilized", {target = v, doer = inst})
				end
            elseif v.components.quagmire_fertilizable then
				act.target.components.quagmire_fertilizable:Fertilize(inst)
            end
        end
	end
end

local function AcceptTest(inst, item,giver)
	if item:HasTag("ccs_card") and item.prefab ~= "ccs_cards_26" then
		if item.components.ccs_card_level.level == 1 then
			return true
		end
	end
	return false
end


local function onaccept(inst,giver,item)
	if item:HasTag("ccs_card") then
		giver.components.inventory:GiveItem(SpawnPrefab("ccs_paper"))
	end
end

local function onlight_change(inst)
    local num = inst._state:value()
    if num == 2 then
        inst.Light:SetColour( 216/255, 160/255, 255/255, 1 )
		inst.Transform:SetScale(1.6, 1.6, 1.6)
	elseif num == 3 then
        inst.Light:SetColour( 255/255, 182/255, 193/255, 1 )
		inst.Transform:SetScale(1.8, 1.8, 1.8)
    elseif num == 1 then
        inst.Light:SetColour( 0/255, 245/255, 255/255, 1 )
		inst.Transform:SetScale(2, 2, 2)
    end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBank("ccs_jt")  
    inst.AnimState:SetBuild("ccs_jt")
    inst.AnimState:PlayAnimation("idle",true)
	
	inst.MiniMapEntity:SetIcon( "ccs_jt.tex" )

	inst:AddTag("ccs_jt")
	inst:AddTag("structure")
	inst:AddTag("rotatableobject") --能让栅栏击剑起作用
	inst:AddTag("ccsflatrotated") -- 自定义栅栏击剑旋转角度
    
	inst.Light:SetColour( 0/255, 245/255, 255/255, 1 )
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.7)
    inst.Light:SetRadius(20)
    inst.Light:Enable(true)
	
	inst.Transform:SetScale(2, 2, 2)
	inst.Transform:SetTwoFaced()
	
    inst.entity:SetPristine()

	inst._state = net_smallbyte(inst.GUID, "ccs_jt._state", "light_change")
    if not TheWorld.ismastersim then
		inst:ListenForEvent("light_change", onlight_change)
        return inst
	end
	CCSAPI.CcsItemInit(inst)
	inst._state:set(1)
	inst:AddComponent("savedrotation")
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  --动作
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)  --锤烂的函数
	
    inst:AddComponent("inspectable") --可检查
	
	inst:AddComponent("trader")  
	inst.components.trader:SetAcceptTest(AcceptTest)  --接收的道具
	inst.components.trader.onaccept = onaccept      --给予
	
	inst.enble = true
	
	inst:DoPeriodicTask(2,Jt_Task)
	
	MakeHauntableLaunchAndPerish(inst) --作祟相关
    return inst
end 
for i = 1, 6 do
	CCSAPI.MakeItemSkin(
		'ccs_jt',
		'ccs_jt_skin_clotheshanger' .. i,
		{
			name = "衣架",
			atlas = 'images/inventoryimages/ccs_clotheshanger_skin' .. i .. '.xml',
			image = 'ccs_clotheshanger_skin' .. i,
			build = 'ccs_clotheshanger',
			bank = 'ccs_clotheshanger',
			anim = 'idle' .. i,
			basebuild = 'ccs_jt',
			basebank = 'ccs_jt',
			baseanim = 'idle',
			baseanimloop = true,
			clear_fn = function(inst)
				inst.Transform:SetScale(2, 2, 2)
				inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
			end,
			init_fn = function(inst)
				if inst.Transform then
					inst.Transform:SetScale(1, 1, 1)
				end
				if inst.Light then
					inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
				end
			end,
			checkfn = function(inventory, name)
				return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skin_clotheshanger1")
			end,
			checkclientfn = function(inventory, userid, name)
				return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skin_clotheshanger1")
			end,
		}
	)
end
return Prefab( "ccs_jt", fn, assets),
		MakePlacer("ccs_jt_placer", "ccs_jt", "ccs_jt", "idle",false, nil, nil, 2)