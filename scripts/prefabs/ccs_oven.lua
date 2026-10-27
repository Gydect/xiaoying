require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/ccs_oven.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_oven.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_oven.xml"),
}

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end
		
local function onclose(inst,doer)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
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

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
    end
end

local coldtab = {
	{item = "charcoal" ,product = "ice"},
	{item = "butterflywings" ,product = "goatmilk"},
}

local cooltab = {
	{item = "log" ,product = "charcoal"},
	{item = "twigs" ,product = "ash"}, 
	{item = "cutgrass" ,product = "ash"},
	{item = "butterflywings" ,product = "butter"},
}

local function itemget(inst,data)
	inst:DoTaskInTime(0,function()
		if data and data.item then
			if inst.cold == false then
				--烤箱状态				
				if data.item.components.cookable then
					--local prd = inst.components.cooker:CookItem(data.item)
					--inst.components.container:GiveItem(prd)
					local num = data.item.components.stackable and data.item.components.stackable.stacksize or 1		
					local newitem = data.item.components.cookable:Cook(inst)
					ProfileStatsAdd("cooked_"..data.item.prefab)
					data.item:Remove()
					if newitem.components.stackable then
						newitem.components.stackable:SetStackSize(num)
					end
					inst.components.container:GiveItem(newitem)
				end
				for k,v in pairs(cooltab) do
					if data.item.prefab == v.item then
						local num = data.item.components.stackable and data.item.components.stackable.stacksize or 1				
						data.item:Remove()					
						local prd = SpawnPrefab(v.product)
						if prd.components.stackable then
							prd.components.stackable:SetStackSize(num)
						end
						inst.components.container:GiveItem(prd)
					end
				end
			else
				for k,v in pairs(coldtab) do
					if data.item.prefab == v.item then
						local num = data.item.components.stackable and data.item.components.stackable.stacksize or 1				
						data.item:Remove()					
						local prd = SpawnPrefab(v.product)
						if prd.components.stackable then
							prd.components.stackable:SetStackSize(num)
						end
						inst.components.container:GiveItem(prd)
					end
				end
				if data.item:HasTag("meat") then
					local num = data.item.components.stackable and data.item.components.stackable.stacksize or 1
					data.item:Remove()		
					local prd = SpawnPrefab("bird_egg")
					if prd.components.stackable then
						prd.components.stackable:SetStackSize(num)
					end
					inst.components.container:GiveItem(prd)					
				end
			end
		end		
	end)
end

local oven_skin = {
	["ccs_oven_shasha"] = "定制:鲨鲨熊",
	["ccs_oven_mixue"] = "定制:蜜雪冰橙"
}
local oven_skin_hasui = {
	["ccs_oven_shasha"] = true,
	["ccs_oven_mixue"] = true,
}
local oven_skin_hasui_sp = {
	["ccs_oven_shasha"] = true,
	["ccs_oven_mixue"] = true,
}

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst.Transform:SetTwoFaced()

	inst:AddTag("structure")
	inst:AddTag("chest")
	inst:AddTag("ccs_oven")
	inst:AddTag("rotatableobject")

	inst.AnimState:SetBank("ccs_oven")
	inst.AnimState:SetBuild("ccs_oven")
    inst.AnimState:PlayAnimation("idle1",true)

	inst.MiniMapEntity:SetIcon( "ccs_oven.tex" )

	MakeSnowCoveredPristine(inst)

	inst.Transform:SetScale(2, 2, 2)

	inst.entity:SetPristine()

	inst._ccsskin = net_string(inst.GUID, "ccs_oven._ccsskin", "ccsskin_change")
    inst._ccsskin:set("")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        -- 客户端监听皮肤变化，切换容器UI
        inst:ListenForEvent("ccsskin_change", function(inst)
            local suffix = inst._ccsskin:value()
            local widget_name = "ccs_chest"
            if #suffix > 0 then
                widget_name = suffix
            end
            inst.replica.container:WidgetSetup(widget_name)
        end)
		
		inst.OnEntityReplicated = function(inst)
            local suffix = inst._ccsskin:value()
            local widget_name = "ccs_chest"
            if #suffix > 0 then
                widget_name = suffix
            end
            inst.replica.container:WidgetSetup(widget_name)
        end
		return inst
	end

	CCSAPI.CcsItemInit(inst)
	inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_chest")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose
	inst.components.container.skipclosesnd = true
	inst.components.container.skipopensnd = true

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:AddComponent("hauntable")
	inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	inst:AddComponent("cooker")
	
	inst:ListenForEvent("itemget", itemget)

	inst.fencerotator_delta = 180
	inst:AddComponent("savedrotation")
	
	inst.cold = true
	inst:DoPeriodicTask(0.1,function()
		if inst.cold then 
			inst.AnimState:PlayAnimation("idle1",true)
		else
			inst.AnimState:PlayAnimation("idle2",true)
		end
	end)
	
	MakeSnowCovered(inst)

	return inst
end

CCSAPI.MakeItemSkinDefaultImage('ccs_oven', 'images/inventoryimages/ccs_oven.xml', 'ccs_oven')
for k,v in pairs(oven_skin) do
	table.insert(assets, Asset("ANIM", "anim/" .. k .. ".zip"))
	table.insert(assets, Asset("IMAGE", "images/inventoryimages/" .. k .. ".tex"))
    table.insert(assets, Asset("ATLAS", "images/inventoryimages/" .. k .. ".xml"))
	if oven_skin_hasui[k] then 
		table.insert(assets, Asset("ANIM", "anim/" .. k .. "_ui.zip"))
		table.insert(assets, Asset("IMAGE", "images/inventoryimages/" .. k .. "_slot.tex"))
    	table.insert(assets, Asset("ATLAS", "images/inventoryimages/" .. k .. "_slot.xml"))
		if oven_skin_hasui_sp[k] then 
			table.insert(assets, Asset("ANIM", "anim/" .. k .. "_ui_y.zip"))
			--格子没变化不需要
			--table.insert(Assets, Asset("IMAGE", "images/inventoryimages/" .. k .. "_slot_y.tex"))
			--table.insert(Assets, Asset("ATLAS", "images/inventoryimages/" .. k .. "_slot_y.xml"))
		end
	end

	CCSAPI.MakeItemSkin('ccs_oven',k,
		{
			name = v,
			atlas = 'images/inventoryimages/' .. k .. '.xml',
			image = k,
			build = k,
			bank = k,
			anim = 'idle1',
			basebuild = 'ccs_oven',
			basebank = 'ccs_oven',
			baseanim = 'idle1',
			clear_fn = function(inst)
				if inst.components.container then
					inst.components.container:Close()
					inst.components.container:WidgetSetup("ccs_chest")
				end
				if inst._ccsskin then
					inst._ccsskin:set("")
				end
			end,
			init_fn = function(inst)
				if oven_skin_hasui[k] and TheWorld.ismastersim and inst.components.container then 
					inst.components.container:Close()
					inst.components.container:WidgetSetup(k)
					if inst._ccsskin then
						inst._ccsskin:set(k)
					end
					if oven_skin_hasui_sp[k] then 
						if inst.cold == true then 
							inst.components.container:WidgetSetup(k)
							if inst._ccsskin then
								inst._ccsskin:set(k)
							end
						else
							inst.components.container:WidgetSetup(k.."_y")
							if inst._ccsskin then
								inst._ccsskin:set(k.."_y")
							end
						end
					end
				end
			end,
			checkfn = function(inventory, name)
				return CCSAPI.CcsSkinCheckFn(inventory, k)
				--return true
			end,
			checkclientfn = function(inventory, userid, name)
				return CCSAPI.CcsSkinCheckClientFn(inventory, userid, k)
				--return true
			end,
		}
	)

end

return Prefab("ccs_oven", fn, assets),
		MakePlacer("ccs_oven_placer", "ccs_oven", "ccs_oven", "idle1",false, nil, nil, 2)