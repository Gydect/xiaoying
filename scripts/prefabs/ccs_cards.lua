local function onuse(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner ~= nil and owner.components.timestopper ~= nil and owner:HasTag("ccs") then
		if owner.components.ccs_magic:GetMagic() > 30 then
			owner.components.ccs_magic:DoDelta(-30)
			inst._owner = owner
			owner.components.timestopper:DoTimeStop(TUNING.TIMESTOPPER_DEFAULT_DURATION)
		else
			owner.components.talker:Say("魔力不足")
		end
    end
end

local function onstopuse(inst)
	local owner = inst.components.inventoryitem:GetGrandOwner() or inst._owner
	if owner ~= nil and owner.components.timestopper ~= nil then
		inst._owner = nil
        owner.components.timestopper:BreakTimeStop()
    end
end

local function toground(inst)
	inst:DoTaskInTime(0.1, function()
		inst:RemoveTag("ccs_qz_drop")
	end)
end

local function StructureCard(def)
    local asasses = {
	    Asset("ANIM", "anim/ccs_cards.zip"),
        Asset( "IMAGE", "images/inventoryimages/ccs_cards/"..def.name..".tex" ),
        Asset( "ATLAS", "images/inventoryimages/ccs_cards/"..def.name..".xml" ),
    }
    local function fn()
        local inst = CreateEntity()
		
        inst.entity:AddTransform()  
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("ccs_cards")
        inst.AnimState:SetBuild("ccs_cards")
        inst.AnimState:PlayAnimation(def.name,true)

        MakeInventoryFloatable(inst, "med", nil, 0.75)
		
		inst:AddTag("ccs_card")
		inst:AddTag(def.name)
		inst:AddTag("ccs_exclusive")
		inst.cost = def.cost 
        inst.costsan = def.costsan
		if def.tag and #def.tag >= 1 then
			for k,v in pairs(def.tag) do
				inst:AddTag(v)
			end
		end
		
		if inst:HasTag("ccs_cards_14") then
		    inst:AddTag("irreplacable")
			inst:AddTag("useabletargeteditem_inventorydisable")
			inst:AddTag("castfrominventory")
		end
		
		if def.reclamation then
			inst._custom_candeploy_fn = def.CLIENT_CanDeployDockKit
		end
		
		if def.aoe then
			inst:AddComponent("aoetargeting")
			inst.components.aoetargeting:SetAlwaysValid(true) 	
			inst.components.aoetargeting:SetRange(10)
			inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoe" 
			inst.components.aoetargeting.reticule.pingprefab = "reticuleaoeping" 
			inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }  
			inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }  
			inst.components.aoetargeting.reticule.ease = true
			inst.components.aoetargeting.reticule.mouseenabled = true 
		end
		
        inst.entity:SetPristine()
		
        if not TheWorld.ismastersim then
            return inst
        end
        -----------------------------------
		---
		if def.skin then
			CCSAPI.CcsItemInit(inst)
		end

        inst:AddComponent("inspectable")
		
		inst:AddComponent("tradable")
		
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_cards/"..def.name..".xml" 
		
		inst:AddComponent("ccs_card_level")
		inst.components.ccs_card_level:SetMaxLevel(def.maxlevel or 1)
		
		--卡牌使用
		if def.onuse then		
			inst:AddComponent("ccs_card_use")
			inst.components.ccs_card_use:SetUseFn(def.usefn)
		end
		
		--卡牌放置
		if def.reclamation then		
		    inst:AddComponent("deployable")
			inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM)
			inst.components.deployable:SetUseGridPlacer(true)
		end
		
		--卡牌肥料
		if def.is_fertilizer then		
			inst:AddComponent("fertilizer")
			inst.components.fertilizer.fertilizervalue = TUNING.POOP_FERTILIZE
			inst.components.fertilizer.soil_cycles = TUNING.POOP_SOILCYCLES
			inst.components.fertilizer.withered_cycles = TUNING.POOP_WITHEREDCYCLES
			inst.components.fertilizer:SetNutrients(TUNING.FERTILIZER_NUTRIENTS[1], TUNING.FERTILIZER_NUTRIENTS[2], TUNING.FERTILIZER_NUTRIENTS[3])
		end
		
		--卡牌装备
		if def.equip then		
			inst:AddComponent("equippable") 
			inst.components.equippable:SetOnEquip(def.onequip)
			inst.components.equippable:SetOnUnequip(def.onunequip)
		end
		
		--卡牌cd
		if def.rechargeable then	
			inst:AddComponent("rechargeable") 
		end
		
		--卡牌施法
		if def.aoe then		
			inst:AddComponent("ccs_aoespell")
			inst.components.aoespell = inst.components.ccs_aoespell					
			inst.components.aoespell:Ccs_SetSpellFn(def.spellfn)
			inst:RegisterComponentActions("aoespell")	
		end
		--时停
		if inst:HasTag("ccs_cards_14") then
		    inst:AddComponent("spellcaster")
			inst.components.spellcaster.canusefrominventory = true
			inst.components.spellcaster.quickcast = true
			inst.components.spellcaster:SetSpellFn(onuse)
			
			inst:ListenForEvent("ondropped", onstopuse)
			inst:ListenForEvent("onownerdropped", onstopuse)
		end
		
		if def.stackable then
			inst:AddComponent("stackable")
		end

		inst:ListenForEvent("ondropped", toground)
		
        return inst
    end

    return Prefab(def.name, fn, asasses)
end


local ccs_cards = {}

for k, v in pairs(require("ccs_cards")) do
    table.insert(ccs_cards, StructureCard(v))
end

return unpack(ccs_cards)