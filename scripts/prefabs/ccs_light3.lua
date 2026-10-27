require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/ui_ccs_light3_skins3.zip"),
	Asset("ANIM", "anim/ui_ccs_light3_skin_xingyuan.zip"),
	Asset("ANIM", "anim/ccs_light3.zip"), 
	Asset("IMAGE", "images/inventoryimages/ccs_light3.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_light3.xml"),
	Asset("IMAGE", "images/inventoryimages/ui_ccs_light3_skins3_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_ccs_light3_skins3_slot.xml"),
}

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function oncollect(inst)
	local pickupRange = TUNING.CCS_LIGHT3_FW  and 3000 or 30
	-- print(pickupRange)
	local x,y,z = inst:GetPosition():Get()
	local all_items = TheSim:FindEntities(x, y, z, pickupRange, { "_inventoryitem" }, nil)  -- 查找范围内的物品
	local container_is_full = inst.components.container and inst.components.container:IsFull()
	if all_items and #all_items > 0 then
		-- print(#all_items)
            for i, v in ipairs(all_items) do
                if v and v:IsValid() and v.components.inventoryitem:GetGrandOwner() == nil
                        -- and not v.components.health
                        -- and not v.components.combat
                        -- and not v:HasTag("locomotor")
                        and not v:IsInLimbo()
                then
                    if inst.components.container:Has(v.prefab, 1) then
                        --不能堆叠的实体 容器满了不会再放进去
                        if (not v.components.stackable and not container_is_full) or v.components.stackable then
                            local inst_pos = inst:GetPosition()
                            inst.components.container:GiveItem(v, nil, inst_pos)
                        end
                    end
                end
                container_is_full = inst.components.container and inst.components.container:IsFull()
            end
	end
end
		
local function onclose(inst,doer)
	local container = inst.components.container
	if inst.stone1 == false then
		if container ~= nil then
            for k, item in pairs(container.slots) do
                if item.prefab == "ccs_crystallization1" then
                    container:ConsumeByName("ccs_crystallization1", 1)
                    inst.stone1 = true
					if inst.stone1_task == nil then
						inst.stone1_task = inst:DoPeriodicTask(60,function()
							oncollect(inst)
						end)
					end
                    break
                end
            end
        end
		
	end

	if inst.stone2 == false then
		if container ~= nil then
            for k, item in pairs(container.slots) do
                if item.prefab == "ccs_crystallization2" then
                    container:ConsumeByName("ccs_crystallization2", 1)
                    inst.stone2 = true
					inst:AddComponent("preserver")
			        inst.components.preserver:SetPerishRateMultiplier(0)
                    break
                end
            end
        end
		
	end

	if inst.stone1 == true then
		if container ~= nil then
			for k, item in pairs(container.slots) do
				if item.prefab == "ccs_crystallization3" then
					container:ConsumeByName("ccs_crystallization3", 1)
					inst.stone1 = false
					if inst.stone1_task then
						inst.stone1_task:Cancel()
						inst.stone1_task = nil
					end
					break
				end
			end
		end
	end
	
	

	oncollect(inst)
end

local function onInstCcFn(inst,doer)
	for k,v in pairs(inst.components.container.slots) do
		if k and k > 1 and v and v.components.unwrappable then
			v.components.unwrappable:Ccs_Unwrap(inst)
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

-- local function AcceptTest(inst, item)
-- 	if item.prefab == "ccs_crystallization1" and inst.stone1 == false then
-- 		return true
-- 	end
-- 	if item.prefab == "ccs_crystallization2" and inst.stone2 == false then
-- 		return true
-- 	end
-- 	if item.prefab == "ccs_crystallization3" then
-- 		return true
-- 	end
-- 	return false
-- end

-- local function OnRefuseItem(inst, giver, item)
-- 	if item then
-- 		if item.prefab == "ccs_crystallization1" then
-- 			giver.components.talker:Say("樱花灯已经给过了橙色结晶")
-- 		elseif item.prefab == "ccs_crystallization2" then
-- 			giver.components.talker:Say("樱花灯已经给过了蓝色结晶")
-- 		else
-- 			giver.components.talker:Say("不需要这个")
-- 		end
-- 	end
-- end

-- local function GiveStone(inst,giver,item)
-- 	if item.prefab == "ccs_crystallization1" then
-- 		inst.stone1 = true
-- 		giver.components.talker:Say("樱花灯激活橙色结晶")
-- 		if inst.stone1_task == nil then
-- 			inst.stone1_task = inst:DoPeriodicTask(60,function()
-- 				onclose(inst)
-- 			end)
-- 		end
-- 	end
-- 	if item.prefab == "ccs_crystallization2" then
-- 		inst.stone2 = true
-- 		giver.components.talker:Say("樱花灯激活蓝色结晶")
-- 		inst:AddComponent("preserver")
-- 		inst.components.preserver:SetPerishRateMultiplier(0)
-- 	end
-- 	if item.prefab == "ccs_crystallization3" then
-- 		inst.stone1 = false
-- 		giver.components.talker:Say("橙色结晶效果已取消")
-- 		if inst.stone1_task ~= nil then
-- 			inst.stone1_task:Cancel()
-- 			inst.stone1_task = nil
-- 		end
-- 	end
-- end

--加载
local function onload(inst, data)
	if data then
		inst.stone1 = data.stone1 or false
		inst.stone2 = data.stone2 or false
		if inst.stone1_task == nil and inst.stone1 then
			inst.stone1_task = inst:DoPeriodicTask(60,function()
				oncollect(inst)
			end)
		end
		if inst.stone2 then
			inst:AddComponent("preserver")
			inst.components.preserver:SetPerishRateMultiplier(0)
		end
	end
end

--保存
local function onsave(inst, data)
	data.stone1 = inst.stone1
	data.stone2 = inst.stone2
end

local scale = 2.2
local function oncontainer_change(inst)
	local num = inst._state:value()
	if num == 2 then
		inst.replica.container:WidgetSetup("ui_ccs_light3_skins3")
	elseif num == 3 then
		inst.replica.container:WidgetSetup("ui_ccs_light3_skin_xingyuan")
	elseif num == 1 then
		inst.replica.container:WidgetSetup("ccs_light3")
	end
end
local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	--inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst:AddTag("structure")
	inst:AddTag("chest")
	inst:AddTag("ccs_light3")

	inst.AnimState:SetBank("ccs_light3")
	inst.AnimState:SetBuild("ccs_light3")
    inst.AnimState:PlayAnimation("idle")
	
	--inst.MiniMapEntity:SetIcon( "ccs_chest.tex" )

	MakeSnowCoveredPristine(inst)
	inst.Transform:SetScale(scale, scale, scale)
	
	inst.entity:SetPristine()

	inst._state = net_smallbyte(inst.GUID, "ccs_light3._state", "container_change")
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_light3")
        end
		inst:ListenForEvent("container_change", oncontainer_change)
		return inst
	end
	inst._state:set(1)
	CCSAPI.CcsItemInit(inst)
	inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_light3")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose
	inst.components.container.skipclosesnd = true
	inst.components.container.skipopensnd = true
	inst.components.container:EnableInfiniteStackSize(true)
	
	-- inst:AddComponent("trader")   --交易
	-- inst.components.trader:SetAcceptTest(AcceptTest)  --接收的道具
	-- inst.components.trader.onaccept = GiveStone      --给予
	-- inst.components.trader.onrefuse = OnRefuseItem   --拒绝
	
	inst.CloseSnFn = oncollect
	inst.InstCcFn = onInstCcFn
	
	inst.stone1 = false
	inst.stone2 = false

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)

	MakeSnowCovered(inst)
	
	inst.OnSave = onsave
	inst.OnPreLoad = onload

	return inst
end

return Prefab("ccs_light3", fn, assets),
		MakePlacer("ccs_light3_placer", "ccs_light3", "ccs_light3", "idle",false, nil, nil, scale)