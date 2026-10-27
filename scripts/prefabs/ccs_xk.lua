local All = {}
local IsValid = CCSAPI.IsValid

local function uninit(inst)
    if inst and inst.ccs_xk and inst.ccs_xk:IsValid() then
        local data, refs = inst.ccs_xk:GetPersistData()
        inst.components.ccssavecmp:SetSave("ccs_xk", {
            init = 0,
            data = data,
            refs = refs
        })
        inst.ccs_xk:AddTag("FX")
        inst.ccs_xk:AddTag("NOCLICK")
        if inst.ccs_xk.components.container:IsOpen() then
            inst.ccs_xk.components.container:Close()
        end
        local items = inst.ccs_xk.components.container:RemoveAllItems()
        for k, v in pairs(items) do
            v:Remove()
        end
        ErodeAway(inst.ccs_xk, 2)
        inst.components.rechargeable:Discharge(0)
    end
    inst.ccs_xk = nil
end


local skin = {
	{name = "ccs_xk_item_skins1",skin = "ccs_xk_skins1"},
	{name = "ccs_xk_item_skins2",skin = "skeletonxk",anim = "animation",scale = 2},
	{name = "ccs_xk_item_skins3",skin = "skeletonxk2",anim = "animation",scale = 2},
	{name = "ccs_xk_item_sxz_skins1",skin = "skeletonjy",anim = "animation",scale = 0.5},
	{name = "ccs_xk_item_sxz_skins2",skin = "skeletonjy2",anim = "animation",scale = 0.5}, 
	{name = "ccs_xk_item_sxz_skins3",skin = "skeletonwsq",anim = "animation",scale = 0.5},
	{name = "ccs_xk_item_sxz_skins4",skin = "skeletonwsq2",anim = "animation",scale = 0.5}, 
	{name = "ccs_xk_item_sxz_skins5",skin = "skeletonxb",anim = "animation",scale = 0.5},
	{name = "ccs_xk_item_sxz_skins6",skin = "skeletonxb2",anim = "animation",scale = 0.5}, 
	{name = "ccs_xk_item_skins7",skin = "ccs_sb_item_skins7",anim = "animation"}, 
	{name = "ccs_xk_item_skins8",skin = "ccs_sb_item_skins8",anim = "animation"}, 
    {name = "ccs_xk_item_skins9",skin = "ccs_sb_item_skins9",anim = "animation"}, 
    {name = "ccs_xk_item_skins10",skin = "ccs_sb_item_skins10",anim = "animation"}, 
    {name = "ccs_xk_item_skins11",skin = "ccs_sb_item_skins11",anim = "animation"}, 
    {name = "ccs_xk_item_skins12",skin = "ccs_sb_item_skins12",anim = "animation",scale = 0.5}, 
    {name = "ccs_xk_item_skins13",skin = "ccs_sb_item_skins13",anim = "animation"}, 
    {name = "ccs_xk_item_skins14",skin = "ccs_xk_item_skins14",anim = "animation",scale = 1.5}, 
    {name = "ccs_xk_item_skins15",skin = "ccs_sb_item_skins15",anim = "animation"}, 
    {name = "ccs_xk_item_skins16",skin = "ccs_sb_item_skins16",anim = "animation"}, 
    {name = "ccs_xk_item_skins17",skin = "ccs_sb_item_skins17",anim = "animation",state = 2,container = "ccs_bluepet"}, 
    {name = "ccs_xk_item_skins18",skin = "ccs_sb_item_skins18",anim = "animation",state = 3,container = "ccs_blackpet"}, 
    {name = "ccs_xk_item_skins21",skin = "ccs_sb_item_skins21",bank = "kitcoon",anim = "idle_loop",state = 6,container = "ccs_meimeipet",initfn = function (inst) inst.Transform:SetSixFaced() end},
    {name = "ccs_xk_item_skins22",skin = "ccs_sb_item_skins22",bank = "kitcoon",anim = "idle_loop",state = 7,container = "ccs_xuexuepet",initfn = function (inst) inst.Transform:SetSixFaced() end},
    {name = "ccs_sbxk_item_tusi",skin = "ccs_sbxk_item_tusi",anim = "animation",scale = 0.7},
    { name = "ccs_xk_item_skins_balloon", skin = "ccs_xk_item_skins_balloon", anim = "animation" },
    { name = "ccs_xk_item_skins_snowy",    skin = "ccs_xk_item_skins_snowy",    anim = "animation",  scale = 0.8},
    { name = "ccs_xk_item_skins_fox",      skin = "ccs_sb_item_skins_fox",     anim = "animation" },
    { name = "ccs_xk_item_skins_windbell", skin = "ccs_sb_item_skins_windbell", anim = "animation",  scale = 0.8},
    { name = "ccs_xk_item_skins_sdz",      skin = "ccs_sb_item_skins_sdz",      anim = "animation" },
    { name = "ccs_xk_item_skins23",        skin = "ccs_sb_item_skins23",        anim = "animation" },
    { name = "ccs_xk_item_skins24",        skin = "ccs_sb_item_skins24",        anim = "animation" },
    { name = "ccs_xk_item_skins25",        skin = "ccs_sb_item_skins25",        anim = "animation" },
    { name = "ccs_xk_item_skins26",skin = "ccs_sb_item_skins26",bank = "kitcoon",anim = "idle_loop",initfn = function (inst) inst.Transform:SetSixFaced() end},
    { name = "ccs_xk_item_skin_baozi",     skin = "ccs_sb_item_skin_baozi",     anim = "animation" ,container = "ui_ccs_sb_item_baozi", state = 11},
    { name = "ccs_xk_item_skin_daohe",     skin = "ccs_sb_item_skin_daohe",     anim = "idle_loop", initfn = function (inst) inst.Transform:SetFourFaced() end  ,scale = 0.5  },
    { name = "ccs_xk_item_skin_xingye",    skin = "ccs_sb_item_skin_xingye",    bank = "kitcoon", anim = "idle_loop", initfn = function (inst) inst.Transform:SetSixFaced() end },
    { name = "ccs_xk_item_skin_ckln",      skin = "ccs_sb_item_skin_ckln",      anim = "animation", scale = 0.75 },
    { name = "ccs_xk_item_skin_daergou",   skin = "ccs_sb_item_skin_daergou",   anim = "animation" },
    { name = "ccs_xk_item_skin_baihe",     skin = "ccs_sb_item_skin_baihe",     anim = "animation",  scale = 0.5 },
    { name = "ccs_xk_item_skin_xuekeke",   skin = "ccs_xk_item_skin_xuekeke",   anim = "animation" },
    { name = "ccs_xk_item_szn",            skin = "ccs_sb_item_szn",            anim = "animation",  scale = 0.8},
    { name = "ccs_xk_item_skin_rzym",      skin = "ccs_sb_item_skin_rzym",      anim = "animation", container = "ui_ccs_sb_item_skin_rzym", state = 8 },
}
local function onuse(inst, doer)
	if not doer:HasTag("ccs") then doer.components.talker:Say("只有小樱才可以召唤小可") return false end
    if inst.ccs_xk and inst.ccs_xk:IsValid() and doer:HasTag("ccs") then
        uninit(inst)
        if doer and doer.components.talker then
            doer.components.talker:Say("回去休息吧")
        end
        return false
    elseif doer then
        if doer.ccs_xk and doer.ccs_xk:IsValid() then
            if doer and doer.components.talker then
                doer.components.talker:Say("你已经有一只小可了")
            end
            return false
        end
		local skinname = inst:GetSkinName()
        inst.components.rechargeable:Discharge(99999999)
        local ccs_xk = SpawnAt("ccs_xk", doer)
		
		if skinname then
			for k,v in pairs(skin) do
				if skinname == v.name then
					ccs_xk.AnimState:SetBank(v.bank or v.skin) 	
					ccs_xk.AnimState:SetBuild(v.skin)	
					if v.anim then
						ccs_xk.AnimState:PlayAnimation(v.anim, true)
						local scale = v.scale or 1
						ccs_xk.AnimState:SetScale(scale, scale,scale)
                        if v.state then
                            ccs_xk._state:set(v.state)
                        end
                        if v.container then
                            ccs_xk.components.container:WidgetSetup(v.container)
                            ccs_xk.components.container:Close()
                        end
                        if v.initfn then
                            v.initfn(ccs_xk)
                        end
					end
				end
			end
		end
		
        local save = inst.components.ccssavecmp:GetSave("ccs_xk")
        if save and save.data then
            ccs_xk:SetPersistData(save.data, save.refs)
        end
        ccs_xk.components.container.canbeopened = true
        ccs_xk.components.ccsfollewer:Init(doer)

        if TUNING.CCS_ALLOWED_OTHER then 

            if not ccs_xk.components.ccs_items then 
                ccs_xk:AddComponent("ccs_items")
            end
            ccs_xk.components.ccs_items:TryBind(doer)
        end


		ccs_xk.item = inst
        doer.ccs_xk = ccs_xk
        inst.ccs_xk = ccs_xk
        if doer and doer.components.talker then
            doer.components.talker:Say("召唤小可")
        end
        return false
    end
    inst.components.rechargeable:Discharge(0)
    return false
end
local function onturnon(inst)
    if inst._animtask then
        inst._animtask:Cancel()
        inst._animtask = nil
    end
    local skinname = inst:GetSkinName()
    if skinname ~= "ccs_sb_item_skin_daergou" then
        return
    end
    inst._animtask = inst:DoPeriodicTask(0.5, function()
        local x, y, z = inst.Transform:GetWorldPosition()
        local players = FindPlayersInRange(x, y, z, 9, true)
        if players and #players > 0 then
            if not (inst.AnimState:IsCurrentAnimation("proximity_loop") or inst.AnimState:IsCurrentAnimation("proximity_pre")) then
                inst.AnimState:PlayAnimation("proximity_pre")
                inst.AnimState:PushAnimation("proximity_loop", true)
            end
        else
            if inst.AnimState:IsCurrentAnimation("proximity_loop") then
                inst.AnimState:PlayAnimation("proximity_pst")
                inst.AnimState:PushAnimation("idle", false)
            else
                inst.AnimState:PlayAnimation("idle")
            end
        end
    end, 0)
end

local function onturnoff(inst)
    if inst._animtask then
        inst._animtask:Cancel()
        inst._animtask = nil
    end
    local skinname = inst:GetSkinName()
    if skinname ~= "ccs_xk_item_skin_daergou" then
        return
    end
    if not inst.components.inventoryitem:IsHeld() then
        inst.AnimState:PlayAnimation("proximity_pst")
        inst.AnimState:PushAnimation("idle", false)
    else
        inst.AnimState:PlayAnimation("idle")
    end
end
local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("onremove", inst._oncontainerremoved, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("onremove", inst._oncontainerremoved, inst._container)
        inst._container = nil
    end
end

local function tostore(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
    owner = owner.components.inventoryitem ~= nil and owner.components.inventoryitem:GetGrandOwner() or owner
    if inst._owner ~= owner then
        inst._owner = owner
    end
end

local function topocket(inst, owner)
    onturnoff(inst)
    tostore(inst, owner)
end

local function toground(inst)
    onturnon(inst)
    unstore(inst)
    inst._owner = nil
end
local function OnDropped(inst)
    uninit(inst)
    toground(inst)
end
local function makexk_item()
    local function lightflierfn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst:AddTag("NOBLOCK")
        inst:AddTag("rechargeable")
        inst:AddTag("soracantpack")
        inst.Transform:SetTwoFaced()
        inst.AnimState:SetBuild("ccs_pack_gift")
        inst.AnimState:SetBank("ccs_pack_gift")
        inst.AnimState:PlayAnimation("idle", true)

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end
        CCSAPI.CcsItemInit(inst)
        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_xk_item.xml"
		inst.components.inventoryitem.imagename = "ccs_xk_item"
        inst.components.inventoryitem.canonlygoinpocket = true

        inst:AddComponent("ccsuseable")
        inst.components.ccsuseable:SetOnUseFn(onuse)
        inst:AddComponent("rechargeable")
        inst.components.rechargeable:SetMaxCharge(99999999)

        inst:AddComponent("ccssavecmp")
        inst.components.ccssavecmp:AddSave("ccs_xk", function(inst, data)
            if inst.ccs_xk and inst.ccs_xk:IsValid() then
                local d, r = inst.ccs_xk:GetPersistData()
                return {
                    init = (inst.ccs_xk and inst.ccs_xk:IsValid() and 1 or 0),
                    data = d,
                    refs = r
                }
            end
            return data
        end)
        inst.components.ccssavecmp:AddLoad("ccs_xk", function(i, data)
            if data.init == 1 and data.data then
                i:DoTaskInTime(1, function()
                    local owner = i.components.inventoryitem:GetGrandOwner()
                    if owner then
                        onuse(inst, owner)
                    end
                end)
            end
            return data
        end)

        inst:ListenForEvent("onputininventory", topocket)
        inst:ListenForEvent("ondropped", OnDropped)
        inst:ListenForEvent("onremove", uninit)
        inst._oncontainerownerchanged = function(container)
            tostore(inst, container)
        end

        inst._oncontainerremoved = function()
            unstore(inst)
        end
        return inst
    end
    return Prefab("ccs_xk_item", lightflierfn)
end

local catbrain = require "brains/ccs_followerbrain"

-- local function onopen(inst)
-- 	 inst.sg:GoToState("open")
-- end


-- local function onclose(inst)
-- 	 inst.sg:GoToState("close")
-- end

local function itemget(inst,data)
	inst:DoTaskInTime(0,function()
		if data and data.item then
			if data.slot == 1 and data.item.components.temperature then
				data.item.components.temperature.current = 99 
			end
			if data.slot == 2 and data.item.components.temperature then
				data.item.components.temperature.current = -99 
			end
		end		
	end)
end

local function oncontainer_change(inst)
    local num = inst._state:value()
    if num == 2 then
        inst.replica.container:WidgetSetup("ccs_bluepet")
	elseif num == 3 then
        inst.replica.container:WidgetSetup("ccs_blackpet")
    elseif num == 6 then
        inst.replica.container:WidgetSetup("ccs_meimeipet")
    elseif num == 7 then
        inst.replica.container:WidgetSetup("ccs_xuexuepet")
    elseif num == 8 then
        inst.replica.container:WidgetSetup("ui_ccs_sb_item_skin_rzym")
    elseif num == 1 then
        inst.replica.container:WidgetSetup("chester")
    elseif num == 11 then
        inst.replica.container:WidgetSetup("ui_ccs_sb_item_baozi")
    end
end
local function onopen(inst)
    local build = inst.AnimState:GetBuild()
    if build and build == "ccs_sb_item_skin_rzym" then
        inst.SoundEmitter:PlaySound("ccssound/ccssound/rzymsound")
    end
end
local function makexk()
	local asstes = {
		Asset("ANIM", "anim/ccs_xk.zip"), 
	}
    local function lightflier_catfn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()
        MakeGhostPhysics(inst, 1, .1)
        inst:AddTag("NOBLOCK")
        inst:AddTag("soracantpack")
        inst:AddTag("companion")
        inst:AddTag("nosteal")
        inst:AddTag("flying")
        inst:AddTag("ccscantsteal")
        inst:AddTag("structure")
        inst.entity:SetCanSleep(false)
        inst.AnimState:SetBuild("ccs_xk")
        inst.AnimState:SetBank("ccs_xk")
        inst.AnimState:PlayAnimation("idle", true)
        inst.AnimState:SetLightOverride(1)
        inst.entity:AddLight()
        inst.Light:SetFalloff(0.8)
        inst.Light:SetIntensity(.6)
        inst.Light:SetRadius(4.8)
        inst.Light:SetColour(237 / 255, 237 / 255, 209 / 255)
        inst.Light:Enable(true)

        inst.Transform:SetFourFaced()

        inst.entity:SetPristine()

        inst._state = net_smallbyte(inst.GUID, "ccs_xk._state", "container_change")
        if not TheWorld.ismastersim then
			inst.OnEntityReplicated = function(inst)
				inst.replica.container:WidgetSetup("chester")
			end
            inst:ListenForEvent("container_change", oncontainer_change)
            return inst
        end
        inst._state:set(1)
        inst:AddComponent("container")
        inst.components.container.openlimit = 1
        inst.components.container:WidgetSetup("chester")
        inst.components.container.canbeopened = false
        inst.components.container.onopenfn = onopen
       -- inst.components.container:EnableInfiniteStackSize(true)
        inst:AddComponent("preserver")
        inst.components.preserver:SetPerishRateMultiplier(-5000)
        inst:DoTaskInTime(0, function()
            if not inst.components.container.canbeopened then
                local items = inst.components.container:RemoveAllItems()
                for k, v in pairs(items) do
                    v:Remove()
                end
            end
        end)
        -- inst:AddComponent("locomotor")
        -- inst.components.locomotor.walkspeed = TUNING.LIGHTFLIER.WALK_SPEED * 3
        -- inst.components.locomotor.runspeed = TUNING.LIGHTFLIER.WALK_SPEED * 5
        -- inst.components.locomotor:SetTriggersCreep(false)
        -- inst.components.locomotor.pathcaps = { allowocean = true }

        -- inst:SetStateGraph("SGccs_xk")
        -- inst:SetBrain(catbrain)
        inst:AddComponent("scaler")
        inst.components.scaler:SetScale(1.25)
        inst:AddComponent("ccsfollewer")
		
		-- inst:ListenForEvent("onopen", onopen)
		-- inst:ListenForEvent("onclose", onclose)
		inst:ListenForEvent("itemget", itemget)
        inst:WatchWorldState("cycles", onopen)
        inst.magicfx = SpawnPrefab("cane_victorian_fx")
        if inst.magicfx then
            inst.magicfx.entity:AddFollower()
            inst.magicfx.entity:SetParent(inst.entity)
            inst.magicfx.Follower:FollowSymbol(inst.GUID, "body_full", 0, -60, 0)
        end
        inst.persists = false
        return inst
    end
    return Prefab("ccs_xk", lightflier_catfn,asstes)
end

table.insert(All, makexk())
table.insert(All, makexk_item())

return unpack(All)
