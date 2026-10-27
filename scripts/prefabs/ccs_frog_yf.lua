local assets =
{
    Asset("ANIM", "anim/ccs_frog_yf.zip"),  
    Asset("ANIM", "anim/ccs_frog_yf_ground.zip"), 
	Asset("ATLAS", "images/inventoryimages/ccs_frog_yf.xml"), 
    Asset("IMAGE", "images/inventoryimages/ccs_frog_yf.tex"),
}

local noshow = {
    ccs_skins_madoka = true,
    ccs_skins_madoka1 = true,
    ccs_skins_afu = true,
    ccs_skin_yxxc = true,
}

local function onequip(inst, owner) --装备
	if inst.isequip then
		return
	end
	inst.isequip = true
    local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
    if not noshow[owner_skin_build] then
        local name = inst:GetSkinName()
        if name then
            owner.AnimState:AddOverrideBuild(name)
        else
            owner.AnimState:AddOverrideBuild("ccs_frog_yf")
        end
    end
	
end

local function onunequip(inst, owner)  --脱下
	inst.isequip = false
    local owner_skin_build = owner.components.skinner and owner.components.skinner.skin_name
    if not noshow[owner_skin_build] then
        local name = inst:GetSkinName()
        if name then
            owner.AnimState:ClearOverrideBuild(name)
        else
            owner.AnimState:ClearOverrideBuild("ccs_frog_yf")
        end
    end
	
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ccs_frog_yf_ground") 
    inst.AnimState:SetBuild("ccs_frog_yf_ground") 
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetScale(2,2,2)	

	inst:AddTag("ccs_frog_yf")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    CCSAPI.CcsItemInit(inst)
    inst:AddComponent("inspectable") 

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_frog_yf.xml" 

	inst:AddComponent("waterproofer")  
    inst.components.waterproofer:SetEffectiveness(1)

    inst:AddComponent("equippable") 
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY 
	inst.components.equippable.walkspeedmult =  1.15 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(2000,0.85)
	
	inst:AddComponent("ccs_frog_yf")
	
    MakeHauntableLaunch(inst)

    return inst
end
CCSAPI.MakeItemSkin("ccs_frog_yf", "ccs_frog_yf_skin_dzm", {
    name = "定制：蝶之梦",
    atlas = "images/inventoryimages/ccs_skirt_skin_dzm.xml",
    image = "ccs_skirt_skin_dzm",
    build = "ccs_skirt_skin_dzm",
    bank = "ccs_skirt_skin_dzm",
    basebuild = "ccs_frog_yf_ground",
    basebank = "ccs_frog_yf_ground",
    build_name_override = "ccs_skirt_skin_dzm",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_skirt_skin_dzm")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_skirt_skin_dzm")
    end
})
CCSAPI.MakeItemSkin("ccs_frog_yf", "ccs_frog_yf_skin_jgzw", {
    name = "定制：极光之吻",
    atlas = "images/inventoryimages/ccs_skirt_skin_jgzw.xml",
    image = "ccs_skirt_skin_jgzw",
    build = "ccs_skirt_skin_jgzw",
    bank = "ccs_skirt_skin_jgzw",
    basebuild = "ccs_frog_yf_ground",
    basebank = "ccs_frog_yf_ground",
    build_name_override = "ccs_skirt_skin_jgzw",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_skirt_skin_jgzw")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_skirt_skin_jgzw")
    end
})
return Prefab("ccs_frog_yf", fn, assets) 
