local assets1=
{
    Asset("ANIM", "anim/ccs_sword_skins3.zip"),
}
local assets2=
{
    Asset("ANIM", "anim/ccs_magic_wand2_skin_yingcao.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_magic_wand2_skin_yingcao.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ccs_magic_wand2_skin_yingcao.xml"),
}
local assets3 =
{
    Asset("ANIM", "anim/ccs_magic_wand3_skin_yueguitu.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_magic_wand3_skin_yueguitu.tex"), --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ccs_magic_wand3_skin_yueguitu.xml"),
}
local assets4 =
{
    Asset("ANIM", "anim/ccs_magic_wand3_skin_hyjl.zip"),
    Asset("ANIM", "anim/ccs_starstaff_skin_hyjl.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_magic_wand3_skin_hyjl.tex"), --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ccs_magic_wand3_skin_hyjl.xml"),
}
local assets5 =
{
    Asset("ANIM", "anim/ccs_magic_wand3_skin_xyym.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_magic_wand3_skin_xyym.tex"), --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ccs_magic_wand3_skin_xyym.xml"),
}
local assets6 =
{
    Asset("ANIM", "anim/ccs_starstaff_skin_xyym.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_starstaff_skin_xyym.tex"), --物品栏贴图
    Asset("ATLAS", "images/inventoryimages/ccs_starstaff_skin_xyym.xml"),
}
local assets7 =
{
    Asset("ANIM", "anim/ccs_magic_wand3_skin_goldwing_atkfx.zip"),
}
local function makefx(name, build, assets)
	
	local function fxfn()
        local inst = CreateEntity()
    
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddFollower()
        inst.entity:AddNetwork()
    
        inst.AnimState:SetBank(build)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle_loop", true)
    
        inst:AddTag("FX")
        inst:AddTag("NOCLICK")
        inst:AddTag("NOBLOCK")
    
        inst:AddComponent("highlightchild")
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end
    
        inst.persists = false
    
        return inst
    end

	return Prefab(name.."_fx", fxfn, assets)
end

return makefx("ccs_sword_skins3","ccs_sword_skins3",assets1),
makefx("ccs_magic_wand2_skin_yingcao","ccs_magic_wand2_skin_yingcao",assets2),
    makefx("ccs_magic_wand3_skin_yueguitu", "ccs_magic_wand3_skin_yueguitu", assets3),
    makefx("ccs_magic_wand3_skin_hyjl", "ccs_magic_wand3_skin_hyjl", assets4),
    makefx("ccs_starstaff_skin_hyjl", "ccs_starstaff_skin_hyjl", assets4),
    makefx("ccs_magic_wand3_skin_xyym", "ccs_magic_wand3_skin_xyym", assets5),
    makefx("ccs_starstaff_skin_xyym", "ccs_starstaff_skin_xyym", assets6),
    makefx("ccs_magic_wand3_skin_goldwing", "ccs_magic_wand3_skin_goldwing", assets7)
