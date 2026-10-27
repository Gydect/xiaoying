
local assets =
{
    Asset("ANIM", "anim/ccs_balloon.zip"),  --地上的动画
	Asset("ATLAS", "images/inventoryimages/ccs_balloon.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_balloon.tex"),
}

local function onequip(inst, owner) --装备

    owner.AnimState:OverrideSymbol("swap_object", "ccs_balloon", "swap_weapon")
								--替换的动画部件	使用的动画	替换的文件夹（注意这里也是文件夹的名字）
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

end

local function onunequip(inst, owner) --解除装备
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end


local function OnDepleted(inst)
    if inst then
        inst:Remove()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75) --漂浮

    inst.AnimState:SetBank("ccs_balloon")  --地上动画
    inst.AnimState:SetBuild("ccs_balloon")
    inst.AnimState:PlayAnimation("idle")


    inst.entity:SetPristine()

    

    inst:AddTag("meteor_protection") --防止被流星破坏
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon") --增加武器组件 有了这个才可以打人
    inst.components.weapon:SetDamage(17) --设置伤害

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_balloon.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult =  1.3

    inst:AddComponent('fueled')
    inst.components.fueled:InitializeFuelLevel(TUNING.TOTAL_DAY_TIME * 2)
    inst.components.fueled:SetDepletedFn(OnDepleted)
    inst.components.fueled:SetFirstPeriod(1, 1)
    inst.components.fueled:StartConsuming()


    return inst
end

return Prefab("ccs_balloon", fn, assets)