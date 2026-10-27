local function StructureCard(def)
    local asasses = {
	    Asset("ANIM", "anim/ccs_monster_cards.zip"),
        Asset( "IMAGE", "images/inventoryimages/ccs_monster_cards/"..def.name..".tex" ),
        Asset( "ATLAS", "images/inventoryimages/ccs_monster_cards/"..def.name..".xml" ),
    }
    local function fn()
        local inst = CreateEntity()
		
        inst.entity:AddTransform()  
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("ccs_monster_cards")
        inst.AnimState:SetBuild("ccs_monster_cards")
        inst.AnimState:PlayAnimation(def.name,true)
		
		inst:AddTag("ccs_monster_card")
		
        MakeInventoryFloatable(inst, "med", nil, 0.75)
		
        inst.entity:SetPristine()
		
        if not TheWorld.ismastersim then
            return inst
        end
        -----------------------------------

        inst:AddComponent("inspectable")
			
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_monster_cards/"..def.name..".xml" 
		
		inst:AddComponent("ccs_card_use")
		inst.masterboss = def.master
		if def.cave then
			inst.caveboss = def.cave
		end

        return inst
    end

    return Prefab(def.name, fn, asasses)
end


local ccs_monster_cards = {}

for k, v in pairs(require("ccs_monster_cards")) do
    table.insert(ccs_monster_cards, StructureCard(v))
end

return unpack(ccs_monster_cards)