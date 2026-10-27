local assets=
{
	Asset("ANIM", "anim/ccs_bag.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/ccs_bag.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_bag.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ccs_bag.xml",256),
	Asset("ANIM", "anim/ccs_bag_2x9.zip"),
	Asset("ANIM", "anim/ui_dinosaur_bag_2x9.zip"), 
	Asset("IMAGE", "images/inventoryimages/ui_dinosaur_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_dinosaur_slot.xml"),
	Asset("ANIM", "anim/ui_hanbao_bag_2x9.zip"), 
	Asset("IMAGE", "images/inventoryimages/ui_hanbao_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_hanbao_slot.xml"),
	Asset("ANIM", "anim/ui_ccs_bag_skin_huayu.zip"),
	Asset("ANIM", "anim/ui_ccs_bag_skin_xxcb.zip"),
	Asset("ANIM", "anim/ui_xiaotu_bag_2x9.zip"),
	Asset("IMAGE", "images/inventoryimages/ui_ccs_bubbler_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_ccs_bubbler_slot.xml"),
	Asset("ANIM", "anim/ccs_bag_skin_hana_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_bag_skin_hana_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_bag_skin_hana_slot.xml"),
	Asset("ANIM", "anim/ccs_bag_skin_xiaotucha_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_bag_skin_xiaotucha_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_bag_skin_xiaotucha_slot.xml"),
	Asset("ANIM", "anim/ccs_bag_skin_wuxia_ui.zip"),
	Asset("ANIM", "anim/ccs_bag_yyb_ui.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_bag_yyb_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_bag_yyb_slot.xml"),
	Asset("ANIM", "anim/ui_ccs_bag_skin_xiaohuanghua.zip"),
	Asset("IMAGE", "images/inventoryimages/ccs_bag_skin_xiaohuanghua_slot.tex"),
	Asset("ATLAS", "images/inventoryimages/ccs_bag_skin_xiaohuanghua_slot.xml"),
	
}
local CCSUTL = require("utils/ccs_wanly_utils")
local function CreateLight(owner)
	--检查是否已经存在光源实例
	if owner and not owner._ccs_light1 then
		--生成光源
		local light = SpawnPrefab("ccs_light1")
		--将光源添加到owner下面作为子节点
		owner:AddChild(light)
		--设置光源位置,局部坐标不偏移
		light.Transform:SetPosition(0, 0, 0)
		--将光源实例存储在owner中
		owner._ccs_light1 = light
	end
end
local dynamic = {
	ccs_bag_skin_dinosaur = true,
	ccs_bag_skin_huayu = true,
	ccs_bag_skin_hana = true,
	ccs_bag_skin_wuxia = true,
}
local lightskin = {
	ccs_bag_skin_strawberry = true,
	ccs_bag_skin_xxcb = true,
	ccs_bag_skin_xiaohuanghua = true,
}
local noshow = {
	ccs_skins_madoka = true,
	ccs_skins_madoka1 = true,
	ccs_skins_afu = true,
	ccs_skin_yxxc = true,
}
local function onequip(inst,owner)
	inst:DoTaskInTime(0,function ()
		if inst.components.container ~= nil then
			inst.components.container:Open(owner)
		end
		local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
		local skin_build = inst:GetSkinBuild()
		if not noshow[owner_skin_build] and skin_build and skin_build ~= "ccs_bag_skin_hana" then
			if skin_build ~= nil then
				if skin_build == "shiranui_fan" then
					owner:PushEvent("equipskinneditem", inst:GetSkinName())
					owner.AnimState:OverrideItemSkinSymbol("swap_body_tall", skin_build, "swap_body_tall", inst.GUID, "swap_body_tall")
				else
					owner:PushEvent("equipskinneditem", inst:GetSkinName())
					owner.AnimState:OverrideItemSkinSymbol("swap_body", skin_build, "swap_body", inst.GUID, "swap_body")
				end
				if dynamic[skin_build] then
					if inst.fx ~= nil then
						inst.fx:Remove()
					end
					inst.fx = SpawnPrefab(skin_build.."_fx")
					inst.fx:AttachToOwner(owner)  
				end
			else
				owner.AnimState:OverrideSymbol("swap_body", "ccs_bag", "swap_body")
			end
		end

		if skin_build and skin_build == "ccs_bag_skin_hana" then 
			if owner:HasTag("ccs_cgl") then
				CCSUTL.TTLApplyWeaponSkinAndFX(owner, inst, "swap_body_tall", "tthanabag", "swap_body_tall",
					"fx_tthanabag_backpack", "equip", 0, 0, 0, nil, 6, 13,0)
			end
		end

		if lightskin[skin_build] then
			CreateLight(owner) --生成光源
		end
		
		inst.components.inventoryitem.cangoincontainer = false
	end)
end

local function onunequip(inst,owner)
	if inst.components.container ~= nil then
		inst.components.container:Close(owner)
	end
	local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
	if not noshow[owner_skin_build] then
		local skin_build = inst:GetSkinBuild()
		if skin_build ~= nil then
			owner:PushEvent("unequipskinneditem", inst:GetSkinName())
		end	
		owner.AnimState:ClearOverrideSymbol("swap_body")
		owner.AnimState:ClearOverrideSymbol("swap_body_tall")
		
	end
	if inst.fx ~= nil then
        inst.fx:Remove()
    end
	--检查是否存在光源实例
	if owner._ccs_light1 then
		--移除光源
		owner._ccs_light1:Remove()
		owner._ccs_light1 = nil
	end
	CCSUTL.TTLRemoveWeaponFX(inst)
end


local function AcceptTest(inst, item,giver)
	if item.prefab == "bluegem"  then
		if inst.bluegem < 3 then
			return true
		else
			giver.components.talker:Say("背包已拥有反鲜功能")
		end
	end
	return false
end


local function onaccept(inst,giver,item)
	if item.prefab == "bluegem" then
		inst.bluegem = inst.bluegem + 1
		if inst.bluegem >= 3 then     
			giver.components.talker:Say("现在背包已拥有反鲜功能")
			inst.components.preserver:SetPerishRateMultiplier(-3)
		end
	end
end

local function oncontainer_change(inst)
    local num = inst._state:value()
    if num == 2 then
        inst.replica.container:WidgetSetup("ccs_dinosaur_bag")
	elseif num == 3 then
        inst.replica.container:WidgetSetup("ccs_hanbao_bag")
	elseif num == 4 then
		inst.replica.container:WidgetSetup("ccs_xiaotu_bag")
	elseif num == 5 then
		inst.replica.container:WidgetSetup("ccs_huayu_bag")
	elseif num == 6 then
		inst.replica.container:WidgetSetup("ccs_xxcb_bag")
	elseif num == 7 then
		inst.replica.container:WidgetSetup("ccs_bag_skin_hana_ui")
	elseif num == 8 then
		inst.replica.container:WidgetSetup("ccs_bag_skin_xiaotucha_ui")
	elseif num == 9 then
		inst.replica.container:WidgetSetup("ccs_bag_skin_wuxia_ui")
	elseif num == 10 then
		inst.replica.container:WidgetSetup("ccs_bag_yyb_ui")
	elseif num == 11 then
		inst.replica.container:WidgetSetup("ccs_bag_skin_xiaohuanghua_ui")
	elseif num == 12 then
		inst.replica.container:WidgetSetup("ccs_huihui_bag")
    elseif num == 1 then
        inst.replica.container:WidgetSetup("ccs_bag")
    end
end

--加载
local function onload(inst, data)
	if data then
		inst.bluegem = data.bluegem or 0
		if inst.bluegem >= 3 then
			inst.components.preserver:SetPerishRateMultiplier(-3)
		end
	end
end

--保存
local function onsave(inst, data)
	data.bluegem = inst.bluegem
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)  
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("ccs_bag")  
    inst.AnimState:SetBuild("ccs_bag")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("ccscantsteal")
	
    inst.entity:SetPristine()

	inst._state = net_smallbyte(inst.GUID, "ccs_bag._state", "container_change")
    if not TheWorld.ismastersim then
	    inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_bag")
        end
		inst:ListenForEvent("container_change", oncontainer_change)
        return inst
    end
	inst._state:set(1)
	CCSAPI.CcsItemInit(inst)
	inst.bluegem = 0
	
    inst:AddComponent("inspectable") 
		
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_bag.xml"
	
	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.restrictedtag = "ccs"
	inst.components.equippable.walkspeedmult = 1.1
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("ccs_bag")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
	inst.components.container:EnableInfiniteStackSize(true)
      
	inst:AddComponent("preserver")
	inst.components.preserver:SetPerishRateMultiplier(0.5)

	inst:AddComponent("trader")   --交易
	inst.components.trader:SetAcceptTest(AcceptTest)  --接收的道具
	inst.components.trader.onaccept = onaccept      --给予
	
	inst.OnSave = onsave
	inst.OnPreLoad = onload
	
	MakeHauntableLaunchAndPerish(inst) 
    return inst
end 


local function light1fn() --二号光源用于护符
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddLight()
	inst.entity:AddNetwork()

	inst:AddTag("FX")
	inst:AddTag("NOCLICK")

	inst.Light:SetIntensity(0.5)
	inst.Light:SetRadius(0.01)
	inst.Light:Enable(true)
	inst.Light:SetFalloff(1)
	inst.Light:SetColour(200 / 255, 200 / 255, 200 / 255)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst.persists = false

	return inst
end
    
return Prefab("ccs_bag", fn, assets), Prefab("ccs_light1", light1fn)
