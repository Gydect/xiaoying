local assets=
{
	Asset("ANIM", "anim/ccs_fountain.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_fountain.xml"), 
	Asset("IMAGE", "images/inventoryimages/ccs_fountain.tex"),
}


local function onhammered(inst, worker)
    local fx = SpawnPrefab("collapse_small")   --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function Jt_Task(inst)
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

local function ontimerdone(inst, data)
    if data.name == "magic_water" then 
        inst.pick = (inst.pick or 0) + 1
        inst.components.timer:StartTimer("magic_water", 480)
		if inst.pick >= 1 then 
			inst:AddTag("ccs_canpick")
		end
    end
end

local function onload(inst, data)
    if data then
        if type(data.pick) == "boolean" then
            inst.pick = data.pick and 1 or 0
			if inst.pick >= 1 then 
				inst:AddTag("ccs_canpick")
			end
        else
            inst.pick = data.pick or 0
			if inst.pick >= 1 then 
				inst:AddTag("ccs_canpick")
			end
        end
    end
end

local function onsave(inst, data)
    data.pick = inst.pick
end


local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBank("ccs_fountain")  
    inst.AnimState:SetBuild("ccs_fountain")
	inst.AnimState:PlayAnimation("flow_pre")
	inst.AnimState:PushAnimation("flow_loop", true)
	
	inst.MiniMapEntity:SetIcon( "ccs_fountain.tex" )

	inst:AddTag("ccs_fountain")
    
	inst.Light:SetColour( 0/255, 245/255, 255/255, 1 )
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.7)
    inst.Light:SetRadius(20)
    inst.Light:Enable(true)
	
	inst.Transform:SetScale(.8, .8, .8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	CCSAPI.CcsItemInit(inst)
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  --动作
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)  --锤烂的函数
	
    inst:AddComponent("inspectable") --可检查
	
	inst:AddComponent("ccs_fountain") 
	
	inst:DoPeriodicTask(2,Jt_Task)
	
	inst.pick = 0
	
	inst:AddComponent("timer")
	inst.components.timer:StartTimer("magic_water", 480)
	inst:ListenForEvent("timerdone", ontimerdone)
	
	inst.OnSave = onsave
	inst.OnPreLoad = onload
	
	MakeHauntableLaunchAndPerish(inst) --作祟相关
    return inst
end
CCSAPI.MakeItemSkinDefaultImage('ccs_fountain', 'images/inventoryimages/ccs_fountain.xml',
	'ccs_fountain')
for i = 1, 6 do
	CCSAPI.MakeItemSkin(
		'ccs_fountain',
		'ccs_fountain_skin_clotheshanger' .. i,
		{
			name = "衣架",
			atlas = 'images/inventoryimages/ccs_clotheshanger_skin' .. i .. '.xml',
			image = 'ccs_clotheshanger_skin' .. i,
			build = 'ccs_clotheshanger',
			bank = 'ccs_clotheshanger',
			anim = 'idle' .. i,
			animloop = true,
			basebuild = 'ccs_fountain',
			basebank = 'ccs_fountain',
			baseanim = 'flow_loop',
			baseanimloop = true,
			checkfn = function(inventory, name)
				return CCSAPI.CcsSkinCheckFn(inventory, "ccs_fountain_skin_clotheshanger1")
			end,
			checkclientfn = function(inventory, userid, name)
				return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_fountain_skin_clotheshanger1")
			end,
			init_fn = function(inst)
				if inst.Light then
					inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
				end
			end,
			clear_fn = function(inst)
				inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
			end,
		}
	)
end
CCSAPI.CcsItemAssets(assets, "ccs_fountain_skin_lanhua", true, true)
CCSAPI.MakeItemSkin(
	'ccs_fountain',
	'ccs_fountain_skin_lanhua',
	{
		name = "定制：莲华",
		atlas = 'images/inventoryimages/ccs_fountain_skin_lanhua.xml',
		image = 'ccs_fountain_skin_lanhua',
		build = 'ccs_fountain_skin_lanhua',
		bank = 'ccs_fountain_skin_lanhua',
		anim = 'idle',
		animloop = true,
		basebuild = 'ccs_fountain',
		basebank = 'ccs_fountain',
		baseanim = 'flow_loop',
		baseanimloop = true,
		checkfn = CCSAPI.CcsSkinCheckFn,
		checkclientfn = CCSAPI.CcsSkinCheckClientFn,
	}
)

CCSAPI.CcsItemAssets(assets, "ccs_fountain_skin_xingyeshu", true, true)
CCSAPI.MakeItemSkin(
	'ccs_fountain',
	'ccs_fountain_skin_xingyeshu',
	{
		name = "星夜树",
		atlas = 'images/inventoryimages/ccs_fountain_skin_xingyeshu.xml',
		image = 'ccs_fountain_skin_xingyeshu',
		build = 'ccs_fountain_skin_xingyeshu',
		bank = 'ccs_fountain_skin_xingyeshu',
		anim = 'idle',
		animloop = true,
		basebuild = 'ccs_fountain',
		basebank = 'ccs_fountain',
		baseanim = 'flow_loop',
		baseanimloop = true,
		checkfn = CCSAPI.CcsSkinCheckFn,
		checkclientfn = CCSAPI.CcsSkinCheckClientFn,
	}
)

CCSAPI.CcsItemAssets(assets, "ccs_fountain_skin_mgsds", true, true)
CCSAPI.MakeItemSkin(
	'ccs_fountain',
	'ccs_fountain_skin_mgsds',
	{
		name = "暖冬玫瑰树",
		atlas = 'images/inventoryimages/ccs_fountain_skin_mgsds.xml',
		image = 'ccs_fountain_skin_mgsds',
		build = 'ccs_fountain_skin_mgsds',
		bank = 'ccs_fountain_skin_mgsds',
		anim = 'idle',
		animloop = true,
		basebuild = 'ccs_fountain',
		basebank = 'ccs_fountain',
		baseanim = 'flow_loop',
		baseanimloop = true,
	}
)
return Prefab( "ccs_fountain", fn, assets),
		MakePlacer("ccs_fountain_placer", "ccs_fountain", "ccs_fountain", "flow_loop",false, nil, nil, .8)