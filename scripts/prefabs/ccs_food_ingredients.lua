local function CcsFoods(def)
    local ccsfoodsasses = {
	    Asset("ANIM", "anim/ccs_foods_ingredients.zip"),
        Asset( "IMAGE", "images/inventoryimages/"..def.name..".tex" ),
        Asset( "ATLAS", "images/inventoryimages/"..def.name..".xml" ),
    }
    local function fn()
        local inst = CreateEntity()
		
        inst.entity:AddTransform()  
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("ccs_foods_ingredients")
        inst.AnimState:SetBuild("ccs_foods_ingredients")
        inst.AnimState:PlayAnimation(def.name)

        MakeInventoryFloatable(inst, "med", nil, 0.75)
		
		inst:AddTag("cookable")
		inst:AddTag("sorafood")	

		if def.tag and #def.tag >= 1 then
			for k,v in pairs(def.tag) do
				inst:AddTag(v)
			end
		end
		
        inst.entity:SetPristine()
	
        if not TheWorld.ismastersim then
            return inst
        end
        -----------------------------------
        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..def.name..".xml" 
		
		inst:AddComponent("edible") 
		inst.components.edible.foodtype = def.foodtype
        inst.components.edible:SetOnEatenFn(def.oneatenfn)   
		inst.components.edible.hungervalue = def.hunger
        inst.components.edible.healthvalue = def.health
        inst.components.edible.sanityvalue = def.sanity

		inst:AddComponent("perishable") 
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物
        inst.components.perishable:SetPerishTime(def.perishtime)  
	
		inst:AddComponent("stackable")

        return inst
    end

    return Prefab(def.name, fn, ccsfoodsasses)
end


local ccs_foods = {}

for k, v in pairs(require("ccs_food_ingredients")) do 
    table.insert(ccs_foods, CcsFoods(v))
end

return unpack(ccs_foods)