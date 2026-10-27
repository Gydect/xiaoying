local function CcsMagic(def)
    local ccsamagicsasses = {
        Asset( "IMAGE", "images/inventoryimages/ccs_cards/"..def.name..".tex" ),
        Asset( "ATLAS", "images/inventoryimages/ccs_cards/"..def.name..".xml" ),
    }
    local function fn()
        local inst = CreateEntity()
		
        inst.entity:AddTransform() 

        if not TheWorld.ismastersim then
            return inst
        end
        -----------------------------------
		inst.OnBuiltFn = function(inst,doer,...) 
			--判断有无装备魔法棒
			--if (doer.components.inventory:EquipHasTag("ccs_magic_wand3") or doer.components.inventory:EquipHasTag("ccs_starstaff")) then
				--获取卡牌盒
				local box = doer.components.inventory:Ccs_GetEuipItemTag("ccs_card_box")
				if box then
					--获取卡牌盒有无对应卡牌
					local card = box.components.container:GetItemsWithTag(def.name,1)
					if #card >=1 then
						--有卡牌就执行卡牌的施法函数
						if def.usefn then
							def.usefn(card[1],doer,doer:GetPosition():Get())
						end
					end
				end
			--end
			inst:DoTaskInTime(5,inst.Remove)
		end
        return inst
    end
   
    return Prefab(def.name.."magic", fn, ccsamagicsasses)
end

local ccs_magic = {}
for i, v in pairs(require("ccs_cards")) do
	table.insert(ccs_magic, CcsMagic(v))
end

return unpack(ccs_magic)