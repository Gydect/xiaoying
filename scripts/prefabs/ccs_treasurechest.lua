local assets=
{
	Asset("ANIM", "anim/ccs_treasurechest.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_treasurechest.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_treasurechest.xml"),
}


local function onworked(inst, worker, workleft)
    if workleft > 0 and not inst:HasTag("burnt") then
        -- inst.AnimState:PlayAnimation("closed")
        
        if inst.workTask ~= nil then
            inst.workTask:Cancel()
        end
        
        inst.workTask = inst:DoTaskInTime(15, function()
            inst.components.workable:SetWorkLeft(6)
            inst.workTask = nil 
        end)
    end
    
    if inst.components.container and workleft == 3 then
        inst.components.container:DropEverything()
    end
end



local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if inst.components.container then
        inst.components.container:DropEverything()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")   --锤烂的特效
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end
-- local function OnUpgrade(inst, performer, upgraded_from_item)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     local fx = SpawnPrefab("chestupgrade_stacksize_fx")
--     fx.Transform:SetPosition(x, y, z)
--     inst.components.container:EnableInfiniteStackSize(true)
--     inst._chestupgrade_stacksize = true
-- end
-- local function OnLoad(inst, data, newents)
--     if inst.components.upgradeable ~= nil and inst.components.upgradeable.numupgrades > 0 then
--         OnUpgrade(inst)
--     end
-- end
-- local invPrefabList = require("mod_inventoryprefabs_list")  --mod中有物品栏图片的prefabs的表
-- local invBuildMaps = {
--     "images_minisign1", "images_minisign2", "images_minisign3",
--     "images_minisign4", "images_minisign5", "images_minisign6",
--     "images_minisign_skins1", "images_minisign_skins2" --7、8
-- }

local function SetShowSlot(inst, slot)
    local item = inst.components.container.slots[slot]
    if item == nil then
        inst.AnimState:ClearOverrideSymbol("slot".. slot)
        inst.AnimState:ClearOverrideSymbol("slotbg".. slot)
    else
        local atlas, bgimage, bgatlas
        local image = FunctionOrValue(item.drawimageoverride, item, inst) or (#(item.components.inventoryitem.imagename or "") > 0 and item.components.inventoryitem.imagename) or item.prefab or nil
        if image ~= nil then
            atlas = FunctionOrValue(item.drawatlasoverride, item, inst) or (#(item.components.inventoryitem.atlasname or "") > 0 and item.components.inventoryitem.atlasname) or nil
            if item.inv_image_bg ~= nil and item.inv_image_bg.image ~= nil and item.inv_image_bg.image:len() > 4 and item.inv_image_bg.image:sub(-4):lower() == ".tex" then
                bgimage = item.inv_image_bg.image:sub(1, -5)
                bgatlas = item.inv_image_bg.atlas ~= GetInventoryItemAtlas(item.inv_image_bg.image) and item.inv_image_bg.atlas or nil
            end

            if atlas ~= nil then
                atlas = resolvefilepath_soft(atlas) --为了兼容mod物品，不然是没有这道工序的
            end
            inst.AnimState:OverrideSymbol("slot".. slot, atlas or GetInventoryItemAtlas(image..".tex"), image..".tex")
            if bgimage ~= nil then
                if bgatlas ~= nil then
                    bgatlas = resolvefilepath_soft(bgatlas) --为了兼容mod物品，不然是没有这道工序的
                end
                inst.AnimState:OverrideSymbol("slotbg".. slot, bgatlas or GetInventoryItemAtlas(bgimage..".tex"), bgimage..".tex")
            else
                inst.AnimState:ClearOverrideSymbol("slotbg".. slot)
            end
        else
            inst.AnimState:ClearOverrideSymbol("slot".. slot)
            inst.AnimState:ClearOverrideSymbol("slotbg".. slot)
        end
    end
end
local function ItemGet_chest(inst, data)
    if data and data.slot and data.slot <= inst.shownum_l then
        SetShowSlot(inst, data.slot)
    end
end
local function ItemLose_chest(inst, data)
    if data and data.slot and data.slot <= inst.shownum_l then
        SetShowSlot(inst, data.slot)
    end
end
local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("closed")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    for i = 1, inst.shownum_l, 1 do
        SetShowSlot(inst, i)
    end
    local container = inst.components.container
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
end
--加载
local function onload(inst, data)
	if data then

		inst.stone2 = data.stone2 or false
		if inst.stone2 then
			inst:AddComponent("preserver")
			inst.components.preserver:SetPerishRateMultiplier(0)
		end
	end
end

--保存
local function onsave(inst, data)

	data.stone2 = inst.stone2
end
local function fn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)  
	MakeSnowCoveredPristine(inst)

    inst.AnimState:SetBank("ccs_treasurechest")  
    inst.AnimState:SetBuild("ccs_treasurechest")
    inst.AnimState:PlayAnimation("closed")


    inst._chestupgrade_stacksize = true
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	    inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_treasurechest")
        end
        return inst
    end
    -- MakeSmallBurnable(inst, nil, nil, true)
    -- MakeSmallPropagator(inst)
    MakeSnowCovered(inst)
    inst:AddTag("meteor_protection") --防止被流星破坏
        --因为有容器组件，所以不会被猴子、食人花、坎普斯等拿走
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分
    inst:AddTag("structure")
	
    inst:AddComponent("inspectable") 
		
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_treasurechest")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container:EnableInfiniteStackSize(true)
    inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  --动作
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)  --锤烂的函数
    inst.components.workable:SetOnWorkCallback(onworked)
    inst:ListenForEvent("itemget", ItemGet_chest)
    inst:ListenForEvent("itemlose", ItemLose_chest)
    inst.shownum_l = 1
    inst.stone2 = false

    inst.OnSave = onsave
	inst.OnPreLoad = onload
    return inst
end 
    
return Prefab( "ccs_treasurechest", fn, assets),
MakePlacer("ccs_treasurechest_placer", "ccs_treasurechest", "ccs_treasurechest", "closed")