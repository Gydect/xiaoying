local assets =
{
    Asset("ANIM", "anim/ccs_guard.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_guard.xml"),
	Asset("IMAGE", "images/inventoryimages/ccs_guard.tex"),
}

local function Update(inst)
    if inst.ccs_sakura3 >= 25 then
        inst:AddTag("ccs_ignorepinna")
    end
    if inst.ccs_cards_28 >= 1 then
        inst:AddTag("ccs_healthabsorption")
    end
end
local function TraderCount(inst, giver, item)
    if item.prefab == 'ccs_sakura3' then
        return math.max(1, 25 - inst.ccs_sakura3)
    end
    if item.prefab == 'ccs_cards_28' then
        return 1
    end
    return 1
end
local function AcceptTest(inst, item)
    if item.prefab == "ccs_sakura3" and inst.ccs_sakura3 < 25 then
        return true
    end
    if item.prefab == "ccs_cards_28" and inst.ccs_cards_28 < 1 and item.components.ccs_card_level and item.components.ccs_card_level:IsMaxLevel() then
        return true
    end
    return false
end

local function GiveSakura(inst, giver, item)
    if item.prefab == "ccs_sakura3" then
        local num = 1
        if item.components.stackable then
            num = item.components.stackable.stacksize
        end
        inst.ccs_sakura3 = inst.ccs_sakura3 + num
        giver.components.talker:Say("当前给予樱花数量：" .. inst.ccs_sakura3 .. "/25")
    end
    if item.prefab == "ccs_cards_28" then
        inst.ccs_cards_28 = inst.ccs_cards_28 + 1
        giver.components.talker:Say("当前给予卡片数量：" .. inst.ccs_cards_28 .. "/1")
    end
    Update(inst)
end

--加载
local function onload(inst, data)
    if data then
        inst.ccs_sakura3 = data.ccs_sakura3 or 0
        inst.ccs_cards_28 = data.ccs_cards_28 or 0
        Update(inst)
    end
end

--保存
local function onsave(inst, data)
    data.ccs_sakura3 = inst.ccs_sakura3 or 0
    data.ccs_cards_28 = inst.ccs_cards_28 or 0
end
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ccs_guard")
    inst.AnimState:SetBuild("ccs_guard")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("ccs_guard")
    inst:AddTag("ccs_mianyijitui2")
    inst:AddTag("ccstrader")
	
	MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()
    
	
    if not TheWorld.ismastersim then
        return inst
    end
    CCSAPI.CcsItemInit(inst)
    inst.ccs_sakura3 = 0
    inst.ccs_cards_28 = 0

    

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")   --物品
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_guard.xml"

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(AcceptTest)
    inst.components.trader.onaccept = GiveSakura
    inst.cantrader = TraderCount

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("ccs_guard", fn, assets)