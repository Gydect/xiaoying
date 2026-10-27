require "prefabutil"
local cooking = require("cooking")
local assets = {
    Asset("ANIM", "anim/ccs_cookpot.zip"),
    Asset("ANIM", "anim/cook_pot_food.zip"),
	Asset("ANIM", "anim/ui_perfume.zip"),
	Asset("ANIM", "anim/ui_perfume_green.zip"),
	Asset("ANIM", "anim/ui_perfume_purple.zip"),
	Asset("ATLAS", "images/inventoryimages/slot_perfume.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/slot_perfume.tex"),
	Asset("ATLAS", "images/inventoryimages/slot_perfume_green.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/slot_perfume_green.tex"),
	Asset("ATLAS", "images/inventoryimages/slot_perfume_purple.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/slot_perfume_purple.tex"),
}
local assets_item =
{
    Asset("ANIM", "anim/ccs_cookpot.zip"),
	Asset("ATLAS", "images/inventoryimages/ccs_cookpot.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/ccs_cookpot.tex")
}
local prefabs =
{
    "collapse_small",
    "ash",
}
local prefabs_item =
{
    "ccs_cookpot",
}
local cookpot = {
	portablecookpot = 1,
	archive_cookpot = 1,
	cookpot = 1,
	ccs_cookpot = 1
}
--借鉴了勋章的红晶锅
for k,v in pairs(cooking.recipes) do
	if k and v and cookpot[k] then
		--添加菜谱到红晶锅里
		for _,recipe in pairs(v) do
			if not (recipe.spice or recipe.platetype) then--要把调味料理排除掉,把有盘子的料理排除掉(暴食的)
				local newrecipe=shallowcopy(recipe)--浅拷贝一份料理数据
				newrecipe.no_cookbook=true--不应该显示到食谱书里去
				AddCookerRecipe("ccs_cookpot",newrecipe, cooking.IsModCookerFood(k))
			end
		end
	end
end

for k, v in pairs(cooking.recipes.cookpot) do
    table.insert(prefabs, v.name)
	if v.overridebuild then
        table.insert(assets, Asset("ANIM", "anim/"..v.overridebuild..".zip"))
	end
end
for k, v in pairs(cooking.recipes.portablecookpot) do
    table.insert(prefabs, v.name)
	if v.overridebuild then
        table.insert(assets, Asset("ANIM", "anim/"..v.overridebuild..".zip"))
	end
end
local params = {}
local containers = require("containers")
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        containers_widgetsetup_base(container, prefab, data, ...)
    end
end

local function create_cookpot_widget(slotbg_image, slotbg_atlas, animbuild)
    return {
        widget = {
            slotpos = {
                Vector3(0, 64 + 32 + 8 + 4, 0),
                Vector3(0, 32 + 4, 0),
                Vector3(0, -(32 + 4), 0),
                Vector3(0, -(64 + 32 + 8 + 4), 0),
            },
            slotbg = {
                { image = slotbg_image, atlas = slotbg_atlas },
                { image = slotbg_image, atlas = slotbg_atlas },
                { image = slotbg_image, atlas = slotbg_atlas },
                { image = slotbg_image, atlas = slotbg_atlas },
            },
            animbank = "ui_cookpot_1x4",
            animbuild = animbuild,
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
            buttoninfo = {
                text = STRINGS.ACTIONS.COOK,
                position = Vector3(0, -165, 0),
                fn = function(inst)
                    if inst.components.container ~= nil then
                        for k, _ in pairs(inst.components.container.openlist) do
                            BufferedAction(k, inst, ACTIONS.COOK):Do()
                            break
                        end
                    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.COOK.code, inst, ACTIONS.COOK.mod_name)
                    end
                end,
                validfn = function(inst)
                    return inst.replica.container ~= nil and inst.replica.container:IsFull()
                end,
            }
        },
        acceptsstacks = false,
        type = "cooker",
    }
end

params.ccs_cookpot = create_cookpot_widget("slot_perfume.tex", "images/inventoryimages/slot_perfume.xml", "ui_perfume")
params.ccs_cookpot_green = create_cookpot_widget("slot_perfume_green.tex", "images/inventoryimages/slot_perfume_green.xml", "ui_perfume_green")
params.ccs_cookpot_purple = create_cookpot_widget("slot_perfume_purple.tex", "images/inventoryimages/slot_perfume_purple.xml", "ui_perfume_purple")
local skin_mapping = {
    ccs_cookpot_item_skin_green = "ccs_cookpot_skin_green",
    ccs_cookpot_item_skin_purple = "ccs_cookpot_skin_purple",
}

local function ondeploy(inst, pt, deployer)
    local pot = SpawnPrefab("ccs_cookpot",
		skin_mapping[inst.components.ccsskinable and inst.components.ccsskinable._ccsskin], nil,
		inst.components.ccsskinable and inst.components.ccsskinable._ccsuserid)
    if pot ~= nil then
        pt = Vector3(pt.x, 0, pt.z)
        pot.Physics:SetCollides(false)
        pot.Physics:Teleport(pt.x, pt.y, pt.z)
        pot.Physics:SetCollides(true)
        pot.AnimState:PlayAnimation("place")
        pot.AnimState:PushAnimation("idle_empty", false)
        pot.SoundEmitter:PlaySound("dontstarve/common/place_structure_stone")
        inst:Remove()
    end
end



local function storeincontainer(inst, container)
	if container ~= nil and container.components.container ~= nil then
		inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
		inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
		inst._container = container
	end
end

local function unstore(inst)
	if inst._container ~= nil then
		inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
		inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
		inst._container = nil
	end
end

local function topocket(inst, owner)
	if inst._container ~= owner then
		unstore(inst)
		storeincontainer(inst, owner)
	end
end

local function toground(inst)
	unstore(inst)
end

local function onhit(inst)
    if not inst:HasTag("burnt") then

        if inst.components.stewer:IsCooking() then
            inst.AnimState:PlayAnimation("hit_cooking")
            inst.AnimState:PushAnimation("cooking_loop", true)
            inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
        elseif inst.components.stewer:IsDone() then
            inst.AnimState:PlayAnimation("hit_full")
            inst.AnimState:PushAnimation("idle_full", false)
        else
            if inst.components.container ~= nil then
				if inst.components.container:IsOpen() then
					inst.components.container:Close()
				end
				inst.components.container:DropEverything()
                --onclose will trigger sfx already
            else
                inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
            end
            inst.AnimState:PlayAnimation("hit_empty")
            inst.AnimState:PushAnimation("idle_empty", false)
        end
    end
end


local function startcookfn(inst)
	if not inst:HasTag("iscooking") then
		inst:AddTag("iscooking")
	end
	inst.AnimState:PlayAnimation("cooking_loop", true)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
	inst.Light:Enable(true)
end

local function onopen(inst)
	if not inst:HasTag("isopen") then
		inst:AddTag("isopen")
	end
	inst.AnimState:PlayAnimation("cooking_pre_loop", true)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot", "snd")
end

local function onclose(inst)
	if inst:HasTag("isopen") then
		inst:RemoveTag("isopen")
	end
	if not inst.components.stewer:IsCooking() then
	    inst.AnimState:PlayAnimation("idle_empty")
		inst.SoundEmitter:KillSound("snd")
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
end

local function spoilfn(inst)
	inst.components.stewer.product = inst.components.stewer.spoiledproduct
	inst.AnimState:OverrideSymbol("swap_cooked", "cook_pot_food", inst.components.stewer.product)
end


local function SetProductSymbol(inst, product, overridebuild)
    local recipe = cooking.GetRecipe(inst.prefab, product)
    local potlevel = recipe ~= nil and recipe.potlevel or nil
    local build = (recipe ~= nil and recipe.overridebuild) or overridebuild or "cook_pot_food"
    local overridesymbol = (recipe ~= nil and recipe.overridesymbolname) or product

    if potlevel == "high" then
        inst.AnimState:Show("swap_high")
        inst.AnimState:Hide("swap_mid")
        inst.AnimState:Hide("swap_low")
    elseif potlevel == "low" then
        inst.AnimState:Hide("swap_high")
        inst.AnimState:Hide("swap_mid")
        inst.AnimState:Show("swap_low")
    else
        inst.AnimState:Hide("swap_high")
        inst.AnimState:Show("swap_mid")
        inst.AnimState:Hide("swap_low")
    end
	--jammypreserves
	--c_select().AnimState:OverrideSymbol("swap_cooked", "cook_pot_food", "jammypreserves")
	--c_select().AnimState:PlayAnimation("idle_full")
    inst.AnimState:OverrideSymbol("swap_cooked", build, overridesymbol)

end

local function IsNativeCookingProduct(name)
	--普通料理
		for k, v in pairs(require("preparedfoods")) do
			if name==v.name then
				return true
			end
		end
	--大厨料理
	for k, v in pairs(require("preparedfoods_warly")) do
		if name==v.name then
			return true
		end
	end
    return false
end


local function ShowProduct(inst)
	local product = inst.components.stewer.product
	if not inst:HasTag("burnt") then
		SetProductSymbol(inst, product, not IsNativeCookingProduct(product) and product or nil)
    end
end


local function donecookfn(inst)
	if inst:HasTag("iscooking") then
		inst:RemoveTag("iscooking")
	end
	inst.AnimState:PlayAnimation("cooking_pst")
	inst.AnimState:PushAnimation("idle_full",false)
	ShowProduct(inst)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish")
	inst.Light:Enable(false)
end

local function continuedonefn(inst)
	inst.AnimState:PlayAnimation("idle_full")
	ShowProduct(inst)
end

local function continuecookfn(inst)
	inst.AnimState:PlayAnimation("cooking_loop", true)
	inst.Light:Enable(true)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
end

local function harvestfn(inst)
	inst.AnimState:PlayAnimation("idle_empty")
end

local function getstatus(inst)
	if inst.components.stewer:IsCooking() and inst.components.stewer:GetTimeToCook() > 15 then
		return "COOKING_LONG"
	elseif inst.components.stewer:IsCooking() then
		return "COOKING_SHORT"
	elseif inst.components.stewer:IsDone() then
		return "DONE"
	else
		return "EMPTY"
	end
end

local function onbuilt(inst)
	if inst.components.workable ~= nil then
		inst:RemoveComponent("workable")
	end
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle_empty")
end
local function OnHaunt(inst, haunter)
	local ret = false
	if inst.components.stewer ~= nil and inst.components.stewer.product ~= "wetgoop" then
		if inst.components.stewer:IsCooking() then
			inst.components.stewer.product = "wetgoop"
			inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
			ret = true
		elseif inst.components.stewer:IsDone() then
			inst.components.stewer.product = "wetgoop"
			inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
			continuedonefn(inst)
			ret = true
		end
	end
	return ret
end
local skin_mapping2 = {
    ccs_cookpot_skin_green = "ccs_cookpot_item_skin_green",
    ccs_cookpot_skin_purple = "ccs_cookpot_item_skin_purple",
}

local function ChangeToItem(inst)
    if inst.components.stewer.product ~= nil and inst.components.stewer:IsDone() then
        inst.components.stewer:Harvest()
    end
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end

	local item = SpawnPrefab("ccs_cookpot_item",
		skin_mapping2[inst.components.ccsskinable and inst.components.ccsskinable._ccsskin], nil,
		inst.components.ccsskinable and inst.components.ccsskinable._ccsuserid)
    if item ~= nil then
        item.Transform:SetPosition(inst.Transform:GetWorldPosition())
        item.AnimState:PlayAnimation("collapse", false)
        item.AnimState:PushAnimation("idle_ground")
        item.SoundEmitter:PlaySound("dontstarve/common/together/portable/cookpot/collapse")
    end
end


local function OnDismantle(inst)
    ChangeToItem(inst)
    inst:Remove()
end
local function onhammered(inst)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if inst:HasTag("burnt") then
        inst.components.lootdropper:SpawnLootPrefab("ash")
        local fx = SpawnPrefab("collapse_small")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("metal")
    else
        ChangeToItem(inst)
    end
    inst:Remove()
end




local function itemfn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("ccs_cookpot")
	inst.AnimState:SetBuild("ccs_cookpot")
	inst.AnimState:PlayAnimation("idle_ground")

	inst:AddTag("portableitem")
	MakeInventoryFloatable(inst, "med", 0.1, 0.8)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	CCSAPI.CcsItemInit(inst)
	inst._container = nil
	inst._oncontainerownerchanged = function(container)
		topocket(inst, container)
	end

	inst._oncontainerremoved = function()
		unstore(inst)
	end
	inst:ListenForEvent("onputininventory", topocket)
	inst:ListenForEvent("ondropped", toground)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_cookpot.xml"--加载物品栏贴图 mod物品必须有
    inst.components.inventoryitem.imagename = "ccs_cookpot" --物品贴图
	inst:AddComponent("deployable")
	inst.components.deployable.ondeploy = ondeploy

	MakeHauntableLaunch(inst)
	return inst
end
local function oncontainer_change(inst)
    local num = inst._state:value()
    if num == 2 then
        inst.replica.container:WidgetSetup("ccs_cookpot_green")
	elseif num == 3 then
        inst.replica.container:WidgetSetup("ccs_cookpot_purple")
    elseif num == 1 then
        inst.replica.container:WidgetSetup("ccs_cookpot")
    end
end
local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst:SetPhysicsRadiusOverride(.5)
    MakeObstaclePhysics(inst, inst.physicsradiusoverride)

    inst.MiniMapEntity:SetIcon("portablecookpot.png")

	inst.Light:Enable(false)
	inst.Light:SetRadius(1.5)
	inst.Light:SetFalloff(1)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(0/255,79/255,255/255)

	inst.DynamicShadow:SetSize(2, 1)

    inst:AddTag("structure")
    inst:AddTag("stewer")
	inst:AddTag("multfoods_cookpot")
	inst.AnimState:SetBank("ccs_cookpot")
	inst.AnimState:SetBuild("ccs_cookpot")
	inst.AnimState:PlayAnimation("idle_empty")

	inst:SetPrefabNameOverride("ccs_cookpot")

	inst.entity:SetPristine()

	inst._state = net_smallbyte(inst.GUID, "ccs_cookpot._state", "container_change")
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("ccs_cookpot")
		end
		inst:ListenForEvent("container_change", oncontainer_change)
        return inst
	end
	inst._state:set(1)
	CCSAPI.CcsItemInit(inst)
	inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

	inst:AddComponent("stewer")
	inst.components.stewer.cooktimemult = 0.6
	inst.components.stewer.onstartcooking = startcookfn
	inst.components.stewer.oncontinuecooking = continuecookfn
	inst.components.stewer.oncontinuedone = continuedonefn
	inst.components.stewer.ondonecooking = donecookfn
	inst.components.stewer.onharvest = harvestfn
	inst.components.stewer.onspoil = spoilfn


	inst:AddComponent("container")
	inst.components.container:WidgetSetup("ccs_cookpot")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose

    inst:AddComponent("portablestructure")
    inst.components.portablestructure:SetOnDismantleFn(OnDismantle)


	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus


	inst:AddComponent("hauntable")
	inst.components.hauntable:SetOnHauntFn(OnHaunt)

    MakeSmallPropagator(inst)

	inst:ListenForEvent("onbuilt", onbuilt)
	return inst
end

return Prefab( "ccs_cookpot", fn, assets, prefabs),
Prefab("ccs_cookpot_item", itemfn, assets_item, prefabs_item),
MakePlacer( "ccs_cookpot_item_placer", "ccs_cookpot", "ccs_cookpot", "idle_empty" )

