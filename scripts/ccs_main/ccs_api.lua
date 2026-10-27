
local function hidehmj(self, owner)
    local ToggleGoggles_old = self.ToggleGoggles
    self.ToggleGoggles = function(self, show, ...)
        if self.owner and self.owner.replica and self.owner.replica.inventory and self.owner.replica.inventory:EquipHasTag("ccs_hat1") then
            self.inst.entity:Hide(false)
        end
        return ToggleGoggles_old(self, show, ...)
    end
end
AddClassPostConstruct("widgets/gogglesover", hidehmj)


AddPlayerPostInit(function(inst)
    if inst and inst:IsValid() then
        inst.entity:AddFollower()
        inst.AnimState:AddOverrideBuild("brc_hotspring_ying")
    end
    
end)
local seal = {
    "dragonfly",
    "moose",
    "antlion",
    "bearger",
    "deerclops",
    "crabking",
    "shadow_bishop",
	"shadow_rook",
    "alterguardian_phase3",
    "leif",
    "beequeen",   
    "bishop",
    "bishop_nightmare",
	"bat",

    "panflute",
    "ruins_bat",
    "greenamulet",
	"orangestaff",
	"orangeamulet",
	"malbatross",
}

if TUNING.CCS_CARD14_ENBLE then
	table.insert(seal,"pocketwatch_revive")
end

for k, v in pairs(seal) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag("ccs_canseal")
		if not TheWorld.ismastersim then
			return inst
		end
		inst:AddComponent("ccs_canseal")
    end)
end

--蝙蝠形态不播放走路声音
local Old_PlayFootstep = GLOBAL.PlayFootstep
GLOBAL.PlayFootstep = function(inst, volume, ispredicted)
    if inst.prefab == "ccs" and (inst:HasTag("isbf") or inst:HasTag("ccs_cgl") or inst:HasTag("ccs_flyrun") or inst:HasTag("ccs_flyrun2")) then
		return 
	end
	return Old_PlayFootstep(inst, volume, ispredicted)
end

AddComponentPostInit("armor", function(self)	
	function self:Ccs_SetPercent(amount)
		local amount = self.maxcondition * amount
		self.condition = amount
		self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
	end
end)

CHARACTER_INGREDIENT.CCS_MAGIC = "ccs_magic"
local oldIsCharacterIngredient = GLOBAL.IsCharacterIngredient 
if oldIsCharacterIngredient ~= nil then  
	GLOBAL.IsCharacterIngredient =  function(ingredienttype)  
		if ingredienttype and ingredienttype == "ccs_magic" then
			return true
		end
		return oldIsCharacterIngredient(ingredienttype)
	end
end
STRINGS.NAMES[string.upper("ccs_magic")] = "魔法"

local cooking = require("cooking")
local function dospoil(inst, self)
    self.task = nil
    self.targettime = nil
    self.spoiltime = nil

    if self.onspoil ~= nil then
        self.onspoil(inst)
    end
end

local function dostew(inst, self)
    self.task = nil
    self.targettime = nil
    self.spoiltime = nil

    if self.ondonecooking ~= nil then
        self.ondonecooking(inst)
    end

    if self.product == self.spoiledproduct then
        if self.onspoil ~= nil then
            self.onspoil(inst)
        end
    elseif self.product ~= nil then
        local recipe = cooking.GetRecipe(inst.prefab, self.product)
        local prep_perishtime = (recipe ~= nil and (recipe.cookpot_perishtime or recipe.perishtime)) or 0
        if prep_perishtime > 0 then
			local prod_spoil = self.product_spoilage or 1
			self.spoiltime = prep_perishtime * prod_spoil
			self.targettime =  GetTime() + self.spoiltime
			self.task = self.inst:DoTaskInTime(self.spoiltime, dospoil, self)
		end
    end

    self.done = true
end

local function IsPotTwo(inst)
	--[[local hand = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK)
	local hand2 = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
	if hand then
		if hand.prefab == "ccs_card_box" then
			for k,v in pairs(hand.components.container.slots) do
				if v.prefab == "ccs_cards_20" then
					if v.components.ccs_card_level:GetLevel() >= 2 then
						return true
					end
				end
			end
		end
	end
	if hand2 then
		if hand2.prefab == "ccs_card_box" then
			for k,v in pairs(hand2.components.container.slots) do
				if v.prefab == "ccs_cards_20" then
					if v.components.ccs_card_level:GetLevel() >= 2 then
						return true
					end
				end
			end
		end
	end--]]
	if inst.components.inventory:EquipHasTag("ccs_cards_20_enble") then
		return true
	end
	return false
end

AddComponentPostInit("stewer", function(self)
	self.inst:AddComponent("ccs_card_magic")
	self.inst:AddTag("ccs_card_magic_20")
	--hook烹饪时间
    local OldStartCooking = self.StartCooking
	self.StartCooking = function(self, doer,...)
		if OldStartCooking then
			OldStartCooking(self, doer,...)	
			if self.inst.components.container ~= nil then
				if self.inst.components.ccs_card_magic and self.inst.components.ccs_card_magic.card_20_enble then
					if self.task ~= nil then
						self.task:Cancel()
					end
					self.task = self.inst:DoTaskInTime(0, dostew, self)
				end
			end
		end
	end
	--双倍收锅
	local OldHarvest = self.Harvest 
	self.Harvest = function (self,picker,...)
		if not picker then
			return OldHarvest(self,picker,...)
		end
        if picker:HasTag("ccs") and self.inst then
            picker:PushEvent("ccs_cookitem", { cookpot = self.inst })	
        end
        
        local rec = cooking.GetRecipe(self.inst.prefab, self.product)
		local sta = rec and rec.stacksize or 1    
		local istwo = IsPotTwo(picker)
		if self.done and istwo then
			if self.product ~= nil then
				local loot = GLOBAL.SpawnPrefab(self.product)
				if loot ~= nil then
					if sta > 1 then
						loot.components.stackable:SetStackSize(sta)
					end
					if picker ~= nil and picker.components.inventory ~= nil then
						picker.components.inventory:GiveItem(loot, nil, self.inst:GetPosition())
                    else
						GLOBAL.LaunchAt(loot, self.inst, nil, 1, 1)
                    end
				end
			end
		end
		return OldHarvest(self,picker)
	end
end)

local fx = {
"explosivehit",
}

for k,v in pairs(fx) do		
	AddPrefabPostInit(v,function(inst)
		inst:ListenForEvent("animover",function(inst) 
			--inst:PushEvent("endloop")
			--inst = nil		
			inst:Remove()				
		end)
	end)
end


local ccs_card_collection = TUNING.CCS_CARD_COLLECTION
local gl = 0.01
if ccs_card_collection == 1 then
	gl = gl * 10
end

--双牌
AddComponentPostInit("builder", function(self)
	local old_DoBuild = self.DoBuild
	self.DoBuild = function(self,recname, pt, rotation, skin,...)
		local recipe = GetValidRecipe(recname)
		if recipe and recipe.product and (self:IsBuildBuffered(recname) or self:HasIngredients(recipe)) then
			if self.inst and self.inst.components.inventory then
				if self.inst.components.inventory:EquipHasTag("ccs_cards_17_enble") and math.random() <= .1 then 
					local item = SpawnPrefab(recipe.product)
					if item.components.inventoryitem then
						self.inst.components.inventory:GiveItem(item)
					else
						item:Remove()
					end
				end
				if math.random() <= gl and self.inst:HasTag("ccs") and string.sub(recname,1,10) ~= "ccs_cards_" then
					local card = SpawnPrefab("ccs_cards_22")
					card.components.ccs_card_level:SetMaster(self.inst.name,self.inst.userid)
					self.inst.components.inventory:GiveItem(card)
				end
				if self.inst.ccs_cards_28_bd == nil then
					self.inst.ccs_cards_28_bd = 0
				end
				if recname == "reviver" then
					self.inst.ccs_cards_28_bd = self.inst.ccs_cards_28_bd + 1
				end
				if (math.random() <= 0.05 or self.inst.ccs_cards_28_bd == 20) and self.inst:HasTag("ccs") and recname == "reviver" then
					self.inst.ccs_cards_28_bd = 0
					local card = SpawnPrefab("ccs_cards_28")
					card.components.ccs_card_level:SetMaster(self.inst.name,self.inst.userid)
					self.inst.components.inventory:GiveItem(card)
				end
			end
		end	
		return old_DoBuild(self,recname, pt, rotation, skin,...)
	end
	
	--[[local old_KnowsRecipe = self.KnowsRecipe
	self.KnowsRecipe = function(self,recipe, ignore_tempbonus,...)
		if type(recipe) == "string" then
			recipe = GetValidRecipe(recipe)
		end

		if recipe == nil then
			return false
		end
		if self.freebuildmode then
			return true
		elseif recipe.builder_tag ~= nil and not self.inst:HasTag(recipe.builder_tag) then -- builder_tag cehck is require due to character swapping
			return false
		elseif self.station_recipes[recipe.name] or table.contains(self.recipes, recipe.name) then
			return true
		end
		if recipe.level.CCS_PIANO > 0 then
			local x,y,z = self.inst:GetPosition():Get()
			local piano = TheSim:FindEntities(x, y,z, 8,{"ccs_piano"}) 
			if #piano >= 1 then
				return true
			end
		end
		return old_KnowsRecipe(self,recipe, ignore_tempbonus,...)
	end--]]
end)

--掉落卡牌战利品时绑定主人ID
AddComponentPostInit("lootdropper", function(self)
	local old_SpawnLootPrefab = self.SpawnLootPrefab
	self.SpawnLootPrefab = function(self,lootprefab, pt, linked_skinname, skin_id, userid ,doer,...)
		if lootprefab ~= nil and string.sub(lootprefab,1,8) == "ccs_card" then
			local loot = SpawnPrefab( lootprefab, linked_skinname, skin_id, userid )
			if loot ~= nil then
				if loot:HasTag("ccs_card") and doer then
					loot.components.ccs_card_level:SetMaster(doer.name,doer.userid)
					if loot.components.inventoryitem ~= nil then
						if self.inst.components.inventoryitem ~= nil then
							loot.components.inventoryitem:InheritMoisture(self.inst.components.inventoryitem:GetMoisture(), self.inst.components.inventoryitem:IsWet())
						else
							loot.components.inventoryitem:InheritWorldWetnessAtTarget(self.inst)
						end
					end
					self:FlingItem(loot, pt)
					loot:PushEvent("on_loot_dropped", {dropper = self.inst})
					self.inst:PushEvent("loot_prefab_spawned", {loot = loot})
					return loot
				end
			end
		end
		return old_SpawnLootPrefab(self,lootprefab, pt, linked_skinname, skin_id, userid ,...)
	end
end)

AddStategraphPostInit("wilson", function(self)
    local run = self.states.run
    if run then
        local old_enter = run.onenter
        function run.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.components.ccs_flying then
				if inst.components.ccs_flying.isfly then
					inst.AnimState:OverrideSymbol("hand2", "ccs_fly", "hand2")
					inst.AnimState:PlayAnimation("ccs_fly", true)
					inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
				end
            end
        end
    end

    local run_start = self.states.run_start
    if run_start then
        local old_enter = run_start.onenter
        function run_start.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.components.ccs_flying then
				if inst.components.ccs_flying.isfly then
					inst.AnimState:PlayAnimation("ccs_fly")
				end
            end
        end
    end

    local run_stop = self.states.run_stop
    if run_stop then
        local old_enter = run_stop.onenter
        function run_stop.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
			if inst.components.ccs_flying then
				if inst.components.ccs_flying.isfly then
					inst.AnimState:PlayAnimation("ccs_fly")
				end
            end
        end
    end
	
	local old_idle = self.states.idle
    if old_idle then
        local old_idle_enter = old_idle.onenter
        function old_idle.onenter(inst, ...)
            if old_idle_enter then
                old_idle_enter(inst, ...)
            end
			if inst.components.ccs_flying then
				if inst.components.ccs_flying.isfly then
					inst.AnimState:OverrideSymbol("hand2", "ccs_fly", "hand2")
					inst.AnimState:PlayAnimation("ccs_fly",true)
				end
            end
        end
    end
end)

AddStategraphPostInit("wilson_client", function(self)
    local run = self.states.run
    if run then
        local old_enter = run.onenter
        function run.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.replica.ccs_flying and inst.replica.ccs_flying:IsFly() then
				inst.AnimState:OverrideSymbol("hand2", "ccs_fly", "hand2")
				inst.AnimState:PlayAnimation("ccs_fly", true)
				inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
            end
        end
    end

    local run_start = self.states.run_start
    if run_start then
        local old_enter = run_start.onenter
        function run_start.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
			if inst.replica.ccs_flying and inst.replica.ccs_flying:IsFly() then
				inst.AnimState:PlayAnimation("ccs_fly")
            end
        end
    end

    local run_stop = self.states.run_stop
    if run_stop then
        local old_enter = run_stop.onenter
        function run_stop.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
			if inst.replica.ccs_flying and inst.replica.ccs_flying:IsFly() then
				inst.AnimState:PlayAnimation("ccs_fly")
            end
        end
    end
	
	local old_idle = self.states.idle
    if old_idle then
        local old_idle_enter = old_idle.onenter
        function old_idle.onenter(inst, ...)
            if old_idle_enter then
                old_idle_enter(inst, ...)
            end
			if inst.replica.ccs_flying and inst.replica.ccs_flying:IsFly() then
				inst.AnimState:OverrideSymbol("hand2", "ccs_fly", "hand2")
				inst.AnimState:PlayAnimation("ccs_fly",true)
            end
        end
    end
end)

local function onnewstate(inst,data)
	local isfly = inst.components.ccs_flying.isfly
	local action = inst.components.ccs_flying.action
	if isfly then
		local enble = table.contains(action,data.statename)
		if enble == false then
			inst.components.ccs_flying:Land()
		end
	end
end

AddPrefabPostInit("ccs", function(inst)
    if not TheWorld.ismastersim then
        return inst
	end
	
	--inst:ListenForEvent("newstate",onnewstate)
	--飞行时不进入不兼容的sg，因为没动画
	local old_GoToState = inst.sg.GoToState
	function inst.sg.GoToState(self,statename, params,...) 
		local isfly = inst.components.ccs_flying.isfly
		local action = inst.components.ccs_flying.action
		if isfly then
			local enble = table.contains(action,statename)
			if enble == false then
				return inst.sg:GoToState('idle')
			end
		end
		return old_GoToState(self,statename, params,...)
	end
end)

--大牌

local DESTROYSTUFF_CANT_TAGS = { "INLIMBO", "NET_workable" }
local function destroystuff(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 5, nil, DESTROYSTUFF_CANT_TAGS)
    for i, v in ipairs(ents) do
        if v:IsValid() and
            v.components.workable ~= nil and v.components.container == nil and 
            v.components.workable:CanBeWorked() and
            v.components.workable.action ~= ACTIONS.NET then
            SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
            v.components.workable:Destroy(inst)
        end
    end
end

AddStategraphPostInit("wilson", function(sg)    
	local run = sg.states.run
    if run then
        local old_enter = run.onenter
        function run.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.ccs_card24_enble and TUNING.CCS_CARD24_ENBLE then		
				destroystuff(inst)
            end
        end
    end
	
	local run_start = sg.states.run_start
    if run_start then
        local old_enter = run_start.onenter
        function run_start.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.ccs_card24_enble and TUNING.CCS_CARD24_ENBLE then		
				destroystuff(inst)
            end
        end
    end

    local run_stop = sg.states.run_stop
    if run_stop then
        local old_enter = run_stop.onenter
        function run_stop.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst.ccs_card24_enble and TUNING.CCS_CARD24_ENBLE then			
				destroystuff(inst)
            end
        end
    end
end)

local ccs_exclusive_item = {
	"ccs_magic_wand3",
	"ccs_bag",
	"ccs_card_box",
	"ccs_hat1",
	"ccs_magic_wand2",
	"ccs_amulet",
	"ccs_skirt1",
}

local function IsWrongCcsOwner(item, owner)
    return item ~= nil and item:HasTag("ccs_only_item") and owner ~= nil
        and owner:HasTag("player") and not owner:HasTag("ccs")
end

AddComponentPostInit("inventory", function(self)
    local oldCanTakeItemInSlot = self.CanTakeItemInSlot
    function self:CanTakeItemInSlot(item, slot, ...)
        if IsWrongCcsOwner(item, self.inst) then return false end
        return oldCanTakeItemInSlot(self, item, slot, ...)
    end
end)

AddComponentPostInit("container", function(self)
    local oldCanTakeItemInSlot = self.CanTakeItemInSlot
    function self:CanTakeItemInSlot(item, slot, ...)
        local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem:GetGrandOwner() or self.inst
        if IsWrongCcsOwner(item, owner) then return false end
        return oldCanTakeItemInSlot(self, item, slot, ...)
    end
    local function OnCardsChanged()
        local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem:GetGrandOwner()
        if owner ~= nil and owner:HasTag("ccs") then owner:PushEvent("ccs_carried_cards_changed") end
    end
    self.inst:ListenForEvent("itemget", OnCardsChanged)
    self.inst:ListenForEvent("itemlose", OnCardsChanged)
end)

for k,v in pairs(ccs_exclusive_item) do
	AddPrefabPostInit(v,function(inst)
		inst:AddTag("ccs_exclusive")
	end)
end

--卡牌专属
local function OnPutInInventory(fn_old)
    return function(inst, owner)
        if fn_old ~= nil then
            fn_old(inst, owner)
        end
		if inst.prefab == "ccs_amulet" then return end
        inst:DoTaskInTime(0, function()
            if owner ~= nil and owner.components.inventory ~= nil and owner:HasTag("player")then
				if not owner:HasTag("ccs") and owner.components.inventory then
					owner.components.inventory:DropItem(inst)
					owner.components.talker:Say("这是小樱的东西")
				end
				if inst.components.ccs_card_level then
					if inst.components.ccs_card_level.masterid ~= nil and inst.components.ccs_card_level.masterid ~= owner.userid then
						owner.components.inventory:DropItem(inst)
						owner.components.talker:Say("这是别人的东西")
					end
				end
            end
        end)
    end
end

AddPrefabPostInitAny(function(inst)
    if not inst:HasTag("ccs_exclusive") then
        return
    end
    if not TheWorld.ismastersim then
        return
    end
    if inst.components.inventoryitem ~= nil then
        local onputininventoryfn_old = inst.components.inventoryitem.onputininventoryfn
        inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory(onputininventoryfn_old))
    end
end)

--花老师动作兼容
local needchange = true
local PlayerActionPicker = require("components/playeractionpicker")
if PlayerActionPicker.myth_changed then
    needchange = false --如果别的mod也加了这个修改那么就不需要再改一次了
end
PlayerActionPicker.myth_changed = true
if needchange then
    AddComponentPostInit(
        "playeractionpicker", 
        function(self)
            local old_HasAOETargeting = self.HasAOETargeting
            function self:HasAOETargeting()
                if self.inst.replica.inventory:GetActiveItem() == nil then
                    return old_HasAOETargeting(self)
                end
                return false
            end
        end
    )

    function PlayerActionPicker:GetRightClickActions(position, target,spellbook)
        if self.disable_right_click then
            return {}
        end
        if self.rightclickoverride ~= nil then
            local actions, usedefault = self.rightclickoverride(self.inst, target, position)
            if not usedefault or (actions ~= nil and #actions > 0) then
                return actions or {}
            end
        end

        local steering_actions = self:GetSteeringActions(self.inst, position, true)
        if steering_actions ~= nil then
            return steering_actions
        end

		local cannon_aim_actions = self:GetCannonAimActions(self.inst, position, true)
		if cannon_aim_actions ~= nil then
			return cannon_aim_actions
		end
	
        local actions = nil
        local useitem = self.inst.replica.inventory:GetActiveItem()
        local equipitem = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        local ispassable = self.map:IsPassableAtPoint(position:Get())

        if target ~= nil and self.containers[target] then
            actions = self:GetSceneActions(target, true)
        elseif useitem ~= nil then
            if useitem:IsValid() then
                if target == self.inst then
                    actions = self:GetInventoryActions(useitem, true)
                elseif
                    target ~= nil and
                        (not target:HasTag("walkableplatform") or
                            (useitem:HasTag("repairer") and not useitem:HasTag("deployable")))
                 then
                    actions = self:GetUseItemActions(target, useitem, true)
                else
                    actions = self:GetPointActions(position, useitem, true)
                end
            end
        elseif target ~= nil and not target:HasTag("walkableplatform") then
            if equipitem ~= nil and equipitem:IsValid() then
                if equipitem.components.aoetargeting ~= nil and equipitem.components.aoetargeting:IsEnabled() then
                    actions = self:GetSceneActions(target, true)
                    if #actions <= 0 then
                        actions = self:GetEquippedItemActions(target, equipitem, true)
                        return (#actions <= 0 or actions[1].action == ACTIONS.CASTAOE) and actions or {}
                    end
                else
                    actions = self:GetEquippedItemActions(target, equipitem, true)
                end
            end
            if actions == nil or #actions == 0 then
                actions = self:GetSceneActions(target, true)
				if (#actions == 0 or (#actions == 1 and actions[1].action == ACTIONS.LOOKAT)) and target:HasTag("walkableperipheral") then
					if equipitem ~= nil and equipitem:IsValid() then
						local alwayspassable, allowwater--, deployradius
						local aoetargeting = equipitem.components.aoetargeting
						if aoetargeting ~= nil and aoetargeting:IsEnabled() then
							alwayspassable = aoetargeting.alwaysvalid
							allowwater = aoetargeting.allowwater
							--deployradius = aoetargeting.deployradius
						end
						alwayspassable = alwayspassable or equipitem:HasTag("allow_action_on_impassable")
						--V2C: just do passable check here, componentactions tends to redo the full check
						--if self.map:CanCastAtPoint(position, alwayspassable, allowwater, deployradius) then
						if alwayspassable or self.map:IsPassableAtPoint(position.x, 0, position.z, allowwater) then
							actions = self:GetPointActions(position, equipitem, true, target)
						end
					end
				end
            end
        elseif
            equipitem ~= nil and equipitem:IsValid() and spellbook == nil and
                (ispassable or equipitem:HasTag("allow_action_on_impassable") or (equipitem.components.aoetargeting ~= nil and equipitem.components.aoetargeting.alwaysvalid and
                        equipitem.components.aoetargeting:IsEnabled()))
         then
            actions = self:GetPointActions(position, equipitem, true)
		else
			local item = spellbook or equipitem
			if item ~= nil and item:IsValid() then
				local alwayspassable, allowwater--, deployradius
				local aoetargeting = item.components.aoetargeting
				if aoetargeting ~= nil and aoetargeting:IsEnabled() then
					alwayspassable = item.components.aoetargeting.alwaysvalid
					allowwater = item.components.aoetargeting.allowwater
					--deployradius = item.components.aoetargeting.deployradius
				end
				alwayspassable = alwayspassable or item:HasTag("allow_action_on_impassable")
				--V2C: just do passable check here, componentactions tends to redo the full check
				--if self.map:CanCastAtPoint(position, alwayspassable, allowwater, deployradius) then
				if alwayspassable or self.map:IsPassableAtPoint(position.x, 0, position.z, allowwater) then
					actions = self:GetPointActions(position, item, true, target)
				end
			end		
        end

        if (actions == nil or #actions <= 0) and (target == nil or target:HasTag("walkableplatform")) and ispassable then
            actions = self:GetPointSpecialActions(position, useitem, true)
        end

        return actions or {}
    end

    function PlayerActionPicker:DoGetMouseActions(position, target,spellbook)
        local isaoetargeting = false
        local wantsaoetargeting = false
        if position == nil then
            if TheInput:GetHUDEntityUnderMouse() ~= nil then
                return
            end
            isaoetargeting = self.inst.components.playercontroller:IsAOETargeting()
            wantsaoetargeting = not isaoetargeting and self.inst.components.playercontroller:HasAOETargeting()
			
			if isaoetargeting then
				position = self.inst.components.playercontroller:GetAOETargetingPos()
				spellbook = spellbook or self.inst.components.playercontroller:GetActiveSpellBook()

			else
				if target == nil then
					target = TheInput:GetWorldEntityUnderMouse()
					position = self.inst.components.playercontroller:GetAOETargetingPos() or
					TheInput:GetWorldPosition()
				end
            end
			
            local cansee
            if target == nil then
                local x, y, z = position:Get()
                cansee = CanEntitySeePoint(self.inst, x, y, z)
            else
                cansee = target == self.inst or CanEntitySeeTarget(self.inst, target)
            end
            if not cansee then
                local lmb = nil
                local rmb = nil
                if not isaoetargeting then
                    local lmbs = self:GetLeftClickActions(position)
                    for i, v in ipairs(lmbs) do
                        if (v.action == ACTIONS.DROP and self.inst:GetDistanceSqToPoint(position:Get()) < 16) or
                            v.action == ACTIONS.SET_HEADING or
							v.action == ACTIONS.BOAT_CANNON_SHOOT then
							lmb = v
                        end
                    end

                    local rmbs = self:GetRightClickActions(position, nil, spellbook)
                    for i, v in ipairs(rmbs) do
                        if (v.action == ACTIONS.STOP_STEERING_BOAT) or
							v.action == ACTIONS.BOAT_CANNON_STOP_AIMING then
                            rmb = v
                        end
                    end
                end

                return lmb, rmb
            end
        end

        local lmb = not isaoetargeting and self:GetLeftClickActions(position, target)[1] or nil
        local rightaction = self:GetRightClickActions(position, target, spellbook)[1] or nil
        local rmb
        if wantsaoetargeting then
            if rightaction ~= nil and rightaction.action ~= ACTIONS.CASTAOE and rightaction.action ~= ACTIONS.LOOKAT then
                rmb = rightaction
            else
                rmb = nil
            end
        else
            rmb = rightaction
        end
        return lmb, rmb ~= nil and (lmb == nil or lmb.action ~= rmb.action) and rmb or nil
    end
end
--免疫火
AddComponentPostInit("health", function(self)
	local old_DoFireDamage = self.DoFireDamage
	function self:DoFireDamage(...) 
	if self.inst.components.inventory and self.inst.components.inventory:EquipHasTag("ccs_no_huo") then			
		return
	end
		return old_DoFireDamage(self, ...)
	end
end)

--睡觉回复魔力
AddComponentPostInit("sleepingbaguser",function (self)
    local oldDoSleep = self.DoSleep
    self.DoSleep = function (s,bed,...)
		if bed.prefab == "ccs_tent" then
			local x,y,z = self.inst.Transform:GetWorldPosition()
			if TheSim:CountEntities(x, y, z, 12, { "ccs_tent" }) > 0 then
				if not s.ccs_magic and s.inst.prefab == "ccs" then
					s.inst.components.ccs_magic:SetMagicRecovery(30/60)
					s.ccs_magic = true
				end
			end
		end
        return oldDoSleep(s,bed,...)
    end
    local oldDoWakeUp = self.DoWakeUp
    self.DoWakeUp  = function (s,nostatechange,...)
		if s.ccs_magic and s.inst.prefab == "ccs" then
			s.inst.components.ccs_magic:SetMagicRecovery(-30/60)
			s.ccs_magic = false
		end
        return oldDoWakeUp(s,nostatechange,...)
    end
end)

--封印怪不掉落战利品
AddComponentPostInit("lootdropper", function(self)
	local old_DropLoot = self.DropLoot
	self.DropLoot = function(self,pt,...)
		if self and self.inst and self.inst:HasTag("ccs_no_droploot") then			
			return
		end
		return old_DropLoot(self,pt,...)
	end
end)

--去除沙漠目镜的显示效果
local function hidehmj(self,owner)
    local ToggleGoggles_old = self.ToggleGoggles
    self.ToggleGoggles = function(self, show, ...)
		ToggleGoggles_old(self, show, ...)
		if self.owner and self.owner.replica.inventory:EquipHasTag("ccs_hat1") then
            self.inst.entity:Hide(false)
		end
	end
end
AddClassPostConstruct("widgets/gogglesover", hidehmj)


-- local function ToggleOffPhysics(inst)
--     inst.sg.statemem.isphysicstoggle = true
--     inst.Physics:ClearCollisionMask()
--     inst.Physics:CollidesWith(COLLISION.GROUND)
-- end

-- local function DoWortoxPortalTint(inst, val)
--     if val > 0 then
--         inst.components.colouradder:PushColour("portaltint", 154 / 255 * val, 23 / 255 * val, 19 / 255 * val, 0)
--         val = 1 - val
--         inst.AnimState:SetMultColour(val, val, val, 1)
--     else
--         inst.components.colouradder:PopColour("portaltint")
--         inst.AnimState:SetMultColour(1, 1, 1, 1)
--     end
-- end

-- AddStategraphPostInit("wilson", function(self)
--     local portal_jumpin = self.states.portal_jumpin
--     if portal_jumpin then
--         local old_enter = portal_jumpin.onenter
--         function portal_jumpin.onenter(inst,data, ...)
--             if inst:HasTag("ccs") then
-- 				inst.components.locomotor:Stop()
-- 				inst.AnimState:PlayAnimation("wortox_portal_jumpin")
-- 				local x, y, z = inst.Transform:GetWorldPosition()
-- 				local fx = SpawnPrefab("wortox_portal_jumpin_fx")
-- 				fx.AnimState:SetAddColour( 255/255, 0/255, 241/255, 1 )
-- 				fx.Transform:SetPosition(x, y, z)
-- 				inst.sg:SetTimeout(11 * FRAMES)
-- 				inst.sg.statemem.from_map = data and data.from_map or nil
-- 				local dest = data and data.dest or nil
-- 				if dest ~= nil then
-- 					inst.sg.statemem.dest = dest
-- 					inst:ForceFacePoint(dest:Get())
-- 				else
-- 					inst.sg.statemem.dest = Vector3(x, y, z)
-- 				end

-- 				if inst.components.playercontroller ~= nil then
-- 					inst.components.playercontroller:RemotePausePrediction()
-- 				end
-- 			else
-- 				return old_enter(inst,data, ...)
--             end
--         end
--     end
	
--     local portal_jumpout = self.states.portal_jumpout  
--     if portal_jumpout then
--         local old_enter = portal_jumpout.onenter
--         function portal_jumpout.onenter(inst, data,...)
--             if inst:HasTag("ccs") then
-- 				ToggleOffPhysics(inst)
-- 				inst.components.locomotor:Stop()
-- 				inst.AnimState:PlayAnimation("wortox_portal_jumpout")
-- 				inst:ResetMinimapOffset()
-- 				if data and data.from_map then
-- 					inst:SnapCamera()
-- 				end
-- 				local dest = data and data.dest or nil
-- 				if dest ~= nil then
-- 					inst.Physics:Teleport(dest:Get())
-- 					if TheWorld and TheWorld.components.walkableplatformmanager then -- NOTES(JBK): Workaround for teleporting too far causing the client to lose sync.
-- 						TheWorld.components.walkableplatformmanager:PostUpdate(0)
-- 					end
-- 				else
-- 					dest = inst:GetPosition()
-- 				end
-- 				local x, y, z = inst.Transform:GetWorldPosition()
-- 				local fx = SpawnPrefab("wortox_portal_jumpout_fx")
-- 				fx.AnimState:SetAddColour( 255/255, 0/255, 241/255, 1 )
-- 				fx.Transform:SetPosition(x, y, z)
-- 				inst.DynamicShadow:Enable(false)
-- 				inst.sg:SetTimeout(14 * FRAMES)
-- 				DoWortoxPortalTint(inst, 1)
-- 				inst.components.health:SetInvincible(true)
-- 				inst:PushEvent("soulhop")
-- 			else
-- 				return old_enter(inst,data,...)
--             end
--         end
--     end
-- end)

local moddir = KnownModIndex:GetModsToLoad(true)
local enablemods = {}

for k, dir in pairs(moddir) do
    local info = KnownModIndex:GetModInfo(dir)
    local name = info and info.name or "unknow"
    enablemods[dir] = name
end
-- 风铃佬的MOD是否开启，拖拽ui
function IsModEnable(name)
    for k, v in pairs(enablemods) do
        if v and (k:match(name) or v:match(name)) then return true end
    end
    return false
end

function GLOBAL.CcsMakeWidgetMovable(s, name, pos, data) -- 使UI可移动 
    -- 第一个参数为UI实体 第二个参数为 位置存档的名称 注意如果是一个UI的多个实体 记得不同名称
    -- 第三个参数为默认位置 要求为Vector3 或者为空
    -- 第四个参数为扩展属性 是一个table 或者 nil 描述了实体的对齐的问题
    s.ccsmovable = {}
    local m = s.ccsmovable
    m.nullfn = function()
    end
    m.name = name or "default"
    m.self = s
    m.cd = CcsCD(0.5)
    m.dpos = pos or Vector3(0, 0, 0)
    m.pos = pos or Vector3(0, 0, 0)
    m.ha = data and data.ha or 1
    m.va = data and data.va or 2

    m.x, m.y = TheSim:GetScreenSize()
    TheSim:GetPersistentString(m.name, function(load_success, str)
        if load_success then
            local fn = loadstring(str)
            if type(fn) == "function" then
                m.pos = fn()
                if not (type(m.pos) == "table" and m.pos.Get) then
                    m.pos = pos
                end
            end
        end
    end)
    s:SetPosition(m.pos:Get())
    m.OnControl = s.OnControl or m.nullfn
    s.OnControl = function(self, control, down)
        if self.focus and control == CONTROL_SECONDARY then
            m.OnClick(self, down)
        end
        return m.OnControl(self, control, down)
    end
    m.OnRawKey = s.OnRawKey or m.nullfn
    s.OnRawKey = function(self, key, down, ...)
        if s.focus and key == KEY_SPACE and not down and not m.cd() then
            s:SetPosition(m.dpos:Get())
            TheSim:SetPersistentString(m.name, string.format("return Vector3(%d,%d,%d)", m.dpos:Get()), false)
        end
        return m.OnRawKey(self, key, down, ...)
    end

    m.OnClick = function(self, down)
        if down then
            m.FollowMouse(self)
        else
            m.StopFollowMouse(self)
        end
    end

    m.SetMovePosition = function(self, x, y, z)
        if not (s.parent and self.ppos and self.mousepos) then
            return
        end
        local pos
        if type(x) == "number" then
            pos = Vector3(x, y, 0)
        else
            pos = x
        end
        local self_scale = self:GetScale()
        local offset = data and data.drag_offset or 1 -- 偏移修正(容器是0.6)
        local newpos = self.ppos + (pos - self.mousepos) / (self_scale.x / offset) -- 修正偏移值       
        s.SetPosition(self, newpos)
    end
    m.FollowMouse = function(self)
        self.mousepos = TheInput:GetScreenPosition()
        self.ppos = self:GetPosition()
        if m.followhandler == nil then
            m.followhandler = TheInput:AddMoveHandler(function(x, y)
                m.SetMovePosition(self, x, y, 0)
                if not TheInput:IsMouseDown(MOUSEBUTTON_RIGHT) then
                    m.StopFollowMouse(self)
                end
            end)
        end
    end

    m.StopFollowMouse = function(self)
        self.mousepos = nil
        if m.followhandler ~= nil then
            m.followhandler:Remove()
            m.followhandler = nil
        end
        local newpos = self:GetPosition()
        --print("结束save", string.format("return Vector3(%f,%f,%f)", newpos:Get()))
        TheSim:SetPersistentString(m.name, string.format("return Vector3(%f,%f,%f)", newpos:Get()), false)
    end
end

    --给容器组件添加一些事件
    local function containerwidgetapi(self)
        local oldOpen = self.Open
        self.Open = function(self,...)
            oldOpen(self,...)
            if self.container and self.container.replica.container then
                local widget = self.container.replica.container:GetWidget()
                if widget and widget.OnOpenFn then 
                    widget.OnOpenFn(self,...)
                end
            end
        end
        local oldClose = self.Close
        self.Close = function(self,...)
            if self.container and self.container.replica.container then
                local widget = self.container.replica.container:GetWidget()
                if widget and widget.OnCloseFn then 
                    widget.OnCloseFn(self,...)
                end
            end
            oldClose(self,...)
        end
        local oldRefresh = self.Refresh
        self.Refresh = function(self,...)
            oldRefresh(self,...)
            if self.container and self.container.replica.container then
                local widget = self.container.replica.container:GetWidget()
                if widget and widget.OnRefreshFn then 
                    widget.OnRefreshFn(self,...)
                end
            end
        end
    end
    AddClassPostConstruct("widgets/containerwidget", containerwidgetapi)
	
-- 弹出消息
local messages = {}
local PopupDialogScreen = require "screens/redux/popupdialog"
function CcsPushPopupDialog(title, message, button, fn)
    if not (ThePlayer and ThePlayer.HUD and ThePlayer.HUD.controls) then
        table.insert(messages, {title, message, button, fn})
    end
    local buttonstr = button or STRINGS.UI.POPUPDIALOG.OK
    local scr
    local function doclose()
        TheFrontEnd:PopScreen(scr)
    end
    scr = PopupDialogScreen(title, message, {{
        text = buttonstr,
        cb = function()
            doclose()
            if fn then
                fn()
            end
        end
    }})
    TheFrontEnd:PushScreen(scr)
    local screen = TheFrontEnd:GetActiveScreen()
    if screen then
        screen:Enable()
    end
    return scr
end
AddClassPostConstruct("widgets/controls", function(self)
    self.inst:DoTaskInTime(3, function()
        if next(messages) then
            for k, v in pairs(messages) do
                CcsPushPopupDialog(unpack(v))
            end
            messages = {}
        end
    end)
end)


CcsCD = function(ti, real) -- 内置CD
    local t = ti
    local last = -ti
    local get = real and GetTimeRealSeconds or GetTime
    return function()
        local ct = get()
        if (ct - t) > last then
            last = ct
            return true
        end
        return false
    end
end

-- userdata = require "utils/ccsuserdatahook"

--[[AddBrainPostInit("crittersbrain",function(inst) 
	for k,v in pairs(inst.behaviourqueue) do
		print(k,v,"啊")
	end
end)--]]

local function LinkPet(self, pet)
    self.pets[pet] = pet

    self.numpets = self.numpets + 1
	
    self.inst:ListenForEvent("onremove", self._onremovepet, pet)
    pet.persists = false

    if self.inst.components.leader ~= nil then
        self.inst.components.leader:AddFollower(pet)
    end
end


AddComponentPostInit("petleash", function(self)
	function self:CcsSpawnPetAt(x, y, z, prefaboverride, skin)
		local pet = SpawnPrefab(prefaboverride, skin, nil, self.inst.userid)
		if pet ~= nil then
			LinkPet(self, pet)
			if pet.Physics ~= nil then
				pet.Physics:Teleport(x, y, z)
			elseif pet.Transform ~= nil then
				pet.Transform:SetPosition(x, y, z)
			end
	
			if self.onspawnfn ~= nil then
				self.onspawnfn(self.inst, pet)
			end
		end
		return pet
	end
end)


AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return inst
	end
	inst:AddComponent("ccs_valid")
	if inst:HasTag("ccs") then
		inst.components.ccs_valid:InIt()
	end
	--[[inst:DoPeriodicTask(3, function()  
		inst:PushEvent("refreshcrafting")
	end)	--]]
end)

function IsValid(ent)
    if ent and type(ent) == "table" and ent.entity and ent.entity:IsValid() then
        return true
    end
    return false
end

AddComponentPostInit("locomotor", function(self)
    local oldGoToEntity = self.GoToEntity
    self.GoToEntity = function(s, target, ...)
        if target and target.components.ccsfollewer then
            target.components.ccsfollewer.stoptime = 3
        end
        return oldGoToEntity(s, target, ...)
    end
end)

AddComponentPostInit("inventory", function(self)
    self.Ccs_GetEuipItemTag = function(self,tag)
		for k, v in pairs(self.equipslots) do
			if v and v:HasTag(tag) then
				return v
			end
		end
		return nil
    end
end)

--猪王旁生成樱花祈愿站
AddPrefabPostInit("pigking", function(inst)
	if not TheWorld.ismastersim then
		return inst
	end
	inst:AddComponent("ccs_valid")
	inst:DoTaskInTime(1,function()
		inst.components.ccs_valid:Ccs_Light_Init()
	end)
end)

--霸体
AddStategraphPostInit("wilson", function(sg)    
	if sg.events and sg.events.attacked then
		local oldattackedfn = sg.events.attacked.fn
		sg.events.attacked.fn = function(inst, data)
			if inst.components.inventory then
				local guard = inst.components.inventory:Has("ccs_guard",1)
				if guard then
					return
				end
			end        
			return oldattackedfn(inst, data)
        end
	end
end)

--免疫精神控制
AddComponentPostInit("debuffable", function(self)
    local OldAddDebuff = self.AddDebuff
    self.AddDebuff = function(self,name, prefab, data,...)	
        if name then
			if name == "mindcontroller" and self.inst.components.inventory then
				local guard = self.inst.components.inventory:Has("ccs_guard",1)
				if guard then
					return
				end
			end
        end
		return OldAddDebuff(self,name, prefab, data,...)
	end
end)

--免疫催眠
AddComponentPostInit("grogginess", function(self)
	local OldAddGrogginess = self.AddGrogginess
	self.AddGrogginess = function(self,grogginess,...)
		if self.inst.components.inventory then
			local guard = self.inst.components.inventory:Has("ccs_guard",1)
			if guard then
				return
			end
		end
		return OldAddGrogginess(self,grogginess,...)
	end
end)

--快采
AddStategraphPostInit("wilson", function(sg)         
    local old_HARVEST = sg.actionhandlers[ACTIONS.HARVEST].deststate
    sg.actionhandlers[ACTIONS.HARVEST].deststate = function(inst, action,...)
        if inst:HasTag("ccs")  then 
			return "doshortaction"
        end 
        return old_HARVEST(inst, action,...)
    end
end)

AddStategraphPostInit("wilson_client", function(sg)        
    local old_HARVEST = sg.actionhandlers[ACTIONS.HARVEST].deststate
    sg.actionhandlers[ACTIONS.HARVEST].deststate = function(inst, action,...)
        if inst:HasTag("ccs")  then 
			return "doshortaction"
        end 
        return old_HARVEST(inst, action,...)
    end
end)

local function containerwidgetapi(self)
    local oldOpen = self.Open
    self.Open = function(self, ...)
        oldOpen(self, ...)
        if self.container and self.container.replica.container then
            local widget = self.container.replica.container:GetWidget()
            if widget and widget.CcsOnOpenFn then
                widget.CcsOnOpenFn(self, ...)
            end
        end
    end
    local oldClose = self.Close
    self.Close = function(self, ...)
        if self.container and self.container.replica.container then
            local widget = self.container.replica.container:GetWidget()
            if widget and widget.CcsOnCloseFn then
                widget.CcsOnCloseFn(self, ...)
            end
        end
        oldClose(self, ...)
    end
    local oldRefresh = self.Refresh
    self.Refresh = function(self, ...)
        oldRefresh(self, ...)
        if self.container and self.container.replica.container then
            local widget = self.container.replica.container:GetWidget()
            if widget and widget.CcsOnRefreshFn then
                widget.CcsOnRefreshFn(self, ...)
            end
        end
    end
end

AddClassPostConstruct("widgets/containerwidget", containerwidgetapi)

AddComponentPostInit("unwrappable", function(self)	
	function self:Ccs_Unwrap(doer)
		local pos = self.inst:GetPosition()
		pos.y = 0
		if self.itemdata ~= nil then
			if doer ~= nil and
				self.inst.components.inventoryitem ~= nil and
				self.inst.components.inventoryitem:GetGrandOwner() == doer then
				local doerpos = doer:GetPosition()
				local offset = FindWalkableOffset(doerpos, doer.Transform:GetRotation() * DEGREES, 1, 8, false, true, NoHoles)
				if offset ~= nil then
					pos.x = doerpos.x + offset.x
					pos.z = doerpos.z + offset.z
				else
					pos.x, pos.z = doerpos.x, doerpos.z
				end
			end
			local creator = self.origin ~= nil and TheWorld.meta.session_identifier ~= self.origin and { sessionid = self.origin } or nil
			for i, v in ipairs(self.itemdata) do
				local item = SpawnPrefab(v.prefab, v.skinname, v.skin_id, creator)
				if item ~= nil and item:IsValid() then
					if item.Physics ~= nil then
						item.Physics:Teleport(pos:Get())
					else
						item.Transform:SetPosition(pos:Get())
					end
					item:SetPersistData(v.data)
					if item.components.inventoryitem ~= nil then
						if doer.components.container then
							doer.components.container:GiveItem(item)
						else
							item.components.inventoryitem:OnDropped(true, .5)
						end
					end
				end
			end
			self.itemdata = nil
		end
		if self.onunwrappedfn ~= nil then
			self.onunwrappedfn(self.inst, pos, doer)
		end
	end
end)

local upvaluehelper = require "utils/ccsupvaluehelper"
local FLOWER_TAGS = { "ccs_flower" }
local BUTTERFLY_TAGS = { "ccs_butterfly" }
local _maxbutterflies = TUNING.MAX_BUTTERFLIES

local function GetSpawnPoint(player)
    local rad = 25
    local mindistance = 36
    local x, y, z = player.Transform:GetWorldPosition()
    local flowers = TheSim:FindEntities(x, y, z, rad, FLOWER_TAGS)

    for i, v in ipairs(flowers) do
        while v ~= nil and player:GetDistanceSqToInst(v) <= mindistance do
            table.remove(flowers, i)
            v = flowers[i]
        end
    end

    return next(flowers) ~= nil and flowers[math.random(1, #flowers)] or nil
end

AddClassPostConstruct("components/butterflyspawner", function(self) 
	local spawn_fn = upvaluehelper.Get(self.OnPostInit,"SpawnButterflyForPlayer")
	if spawn_fn then
		upvaluehelper.Set(self.OnPostInit,"SpawnButterflyForPlayer",function(player, reschedule)
			spawn_fn(player, reschedule)
			local pt = player:GetPosition()
			local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 64, BUTTERFLY_TAGS)
			if #ents < _maxbutterflies then
				local spawnflower = GetSpawnPoint(player)
				if spawnflower ~= nil then
					local butterfly = SpawnPrefab("ccs_butterfly")
					if butterfly.components.pollinator ~= nil then
						butterfly.components.pollinator:Pollinate(spawnflower)
					end
					butterfly.components.homeseeker:SetHome(spawnflower)
					-- KAJ: TODO: Butterflies can be despawned before getting to the rest of the logic if this is above the homeseeker
					butterfly.Physics:Teleport(spawnflower.Transform:GetWorldPosition())
				end
			end
			reschedule(player)
		end)				
	end
end)


local showmeneed = {
    "ccs_chest2",
	"ccs_ice_box",
	"ccs_light3",
    "ccs_treasurechest"
}

for k, mod in pairs(ModManager.mods) do
    if mod and _G.rawget(mod, "SHOWME_STRINGS") then --showme特有的全局变量
        if
            mod.postinitfns and mod.postinitfns.PrefabPostInit and
            mod.postinitfns.PrefabPostInit.treasurechest
        then
            for _,v in ipairs(showmeneed) do
				mod.postinitfns.PrefabPostInit[v] = mod.postinitfns.PrefabPostInit.treasurechest
			end
        end
        break
    end
end

--showme优先级如果比本mod低，那么这部分代码会生效
TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
for _, v in ipairs(showmeneed) do
	TUNING.MONITOR_CHESTS[v] = true
end

-- local function emptyfn() end
-- _G.CCS_GetSourceFile = function(level)
--     local file = ""
--     level = level or 3
--     if debug.getinfo(level,'S').source then
--         file = debug.getinfo(level,'S').source:match("([^/]+)%.lua$")
--     end
--     return file
-- end
-- --不烧掉落物
-- AddComponentPostInit("burnable", function(self)
--     local IsBurning_old = self.IsBurning or emptyfn
--     self.IsBurning = function(self, ...)
--         local source = CCS_GetSourceFile()
--         if self.inst.ccs_burning and (source == "lootdropper" or source == "koalefant") then
--             return false
--         end
--         return IsBurning_old(self, ...)
--     end
-- end)

--成组交易
AddComponentPostInit("trader", function(Trader)
    local oldAcceptGift = Trader.AcceptGift
    function Trader:AcceptGift(giver, item, count)
        if self.inst:HasTag("ccstrader") and item.components.stackable and count == nil then
            count = self.inst.cantrader and self.inst:cantrader(giver, item) or item.components.stackable.stacksize
            count = math.max(count or 1, 1) 
        end
        return oldAcceptGift(self, giver, item, count)
    end
end)

--弓的连射形态
AddComponentPostInit("weapon",function (weapon)
    local oldLaunchProjectile = weapon.LaunchProjectile
    weapon.LaunchProjectile = function (self,attacker, target,...)
        if self.inst:HasTag("ccs_bow") then
            for i = -1, 1, 1 do
                local proj = SpawnPrefab(self.projectile)
                if proj ~= nil then
                    if self.inst:HasTag("ccs_bow_hearthitfx") and i ~= 0 then
                        proj.AnimState:PlayAnimation("idle")
                        proj.hitfx = false
                    end
                    if proj.components.projectile ~= nil then
                        local x, y, z = attacker.Transform:GetWorldPosition()
                        local radius = attacker:GetPhysicsRadius(0)
                        if self.projectile_offset ~= nil then
                            local dir = (target:GetPosition() - Vector3(x, y, z)):Normalize()
                            dir = dir * self.projectile_offset

                            proj.Transform:SetPosition(x + dir.x , y, z + dir.z)
                        else
                            local offset_x,offset_z
                            if  i == 0 then
                                offset_x = 0
                                offset_z = 0
                            else
                                local dist = attacker:GetDistanceSqToInst(target)
                                local target_pos = target:GetPosition()
                                local sin = math.sqrt ((z - target_pos.z)^ 2 / dist)
                                local cos = math.sqrt ((x - target_pos.x)^ 2 / dist)
                                offset_z = sin * math.cos(PI /2 * i) +  cos * math.sin(PI/2 * i)
                                offset_x = cos * math.cos(PI/2 * i) - sin * math.sin(PI/2 * i)
                            end
                            proj.Transform:SetPosition(x +  offset_x ,y,z+ offset_z )
                        end
                        proj.components.projectile:Throw(self.inst, target, attacker)
                        if self.inst.projectiledelay ~= nil then
                            proj.components.projectile:DelayVisibility(self.inst.projectiledelay)
                        end
                    elseif proj.components.complexprojectile ~= nil then

                        proj.Transform:SetPosition(attacker.Transform:GetWorldPosition())
                        proj.components.complexprojectile:Launch(target:GetPosition(), attacker, self.inst)
                    end
                end

                if self.onprojectilelaunched ~= nil then
                    self.onprojectilelaunched(self.inst, attacker, target, proj)
                end
            end
            return
        end
        return oldLaunchProjectile(self,attacker, target,...)
    end
end)

--免疫冰冻
AddComponentPostInit("freezable", function(self)
    local OldAddColdness = self.AddColdness
	self.AddColdness = function(s,...)
		if  self.inst.components.inventory and s.inst.components.inventory:EquipHasTag('ccs_block_freezable') then
			return false
		end
		return OldAddColdness(s,...)
	end
    local OldFreeze = self.Freeze
    self.Freeze = function(self, freezetime, ...)
        if self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('ccs_block_freezable') then
            return
        end
        return OldFreeze(self, freezetime, ...)
    end
end)

-- 特殊移动动画
local function ccsflyrun(self)
    local run_start = self.states.run_start
    if run_start then
        local old_enter = run_start.onenter
        function run_start.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst:HasTag('ccs') and inst:HasTag("ccs_flyrun") and not (inst.replica.rider and inst.replica.rider:IsRiding()) then
                inst.AnimState:PlayAnimation('ccsflyrun_pre')
            end
        end
    end
    local run = self.states.run
    if run then
        local old_enter = run.onenter
        function run.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst:HasTag('ccs') and not (inst.replica.rider and inst.replica.rider:IsRiding()) then
                if not inst.AnimState:IsCurrentAnimation('ccsflyrun_loop') and inst:HasTag("ccs_flyrun") then
                    inst.AnimState:PlayAnimation('ccsflyrun_loop', true)
                elseif not inst.AnimState:IsCurrentAnimation('fly_loop') and inst:HasTag("ccs_flyrun2") then
                    inst.AnimState:PlayAnimation('fly_loop', true)
                end
                inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
            end
        end
    end
    local run_stop = self.states.run_stop
    if run_stop then
        local old_enter = run_stop.onenter
        function run_stop.onenter(inst, ...)
            if old_enter then
                old_enter(inst, ...)
            end
            if inst:HasTag('ccs') and inst:HasTag("ccs_flyrun") and not (inst.replica.rider and inst.replica.rider:IsRiding()) then
                inst.AnimState:PlayAnimation('ccsflyrun_pst')
            end
        end
    end
end

AddStategraphPostInit('wilson',function (sg)
    ccsflyrun(sg)
end
)
AddStategraphPostInit('wilson_client',function(sg)
    ccsflyrun(sg)
end
)

-- AddStategraphPostInit("wilson", function(self)
--     local run = self.states.run
--     if run then
--         local old_enter = run.onenter
--         function run.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
--             if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_loop", true)
-- 				inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
--             end
--         end
--     end

--     local run_start = self.states.run_start
--     if run_start then
--         local old_enter = run_start.onenter
--         function run_start.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
--             if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pre")
--             end
--         end
--     end

--     local run_stop = self.states.run_stop
--     if run_stop then
--         local old_enter = run_stop.onenter
--         function run_stop.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
--              if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pst")
--             end
--         end
--     end
-- end)

-- AddStategraphPostInit("wilson_client", function(self)
--     local run = self.states.run
--     if run then
--         local old_enter = run.onenter
--         function run.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
--              if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_loop", true)
-- 				inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
--             end
--         end
--     end

--     local run_start = self.states.run_start
--     if run_start then
--         local old_enter = run_start.onenter
--         function run_start.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
-- 			 if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pre")
--             end
--         end
--     end

--     local run_stop = self.states.run_stop
--     if run_stop then
--         local old_enter = run_stop.onenter
--         function run_stop.onenter(inst, ...)
--             if old_enter then
--                 old_enter(inst, ...)
--             end
-- 			 if inst:HasTag("Tomiya_Rin") then  
-- 				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pst")
--                 --inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
--             end
--         end
--     end
-- end)

-- --飞行不播放走路声音
-- local Old_PlayFootstep = GLOBAL.PlayFootstep
-- GLOBAL.PlayFootstep = function(inst, volume, ispredicted)
-- 	if inst:HasTag("Tomiya_Rin") then  
-- 		return 
-- 	end
-- 	return Old_PlayFootstep(inst, volume, ispredicted)
-- end

--工作牌快速制作
local function quick_build(self, action)
    if self and self.actionhandlers and self.actionhandlers[action] then
        local old = self.actionhandlers[action].deststate
        self.actionhandlers[action].deststate = function(inst, action, ...)
            if action and action.doer and action.doer.replica.inventory and action.doer.replica.inventory:EquipHasTag("ccs_cards_7_enble") then
                
                return "doshortaction"
            end
            if type(old) == "string" then
                return old
            end
            return old(inst, action, ...)
        end
    end
end

AddStategraphPostInit("wilson", function(self)
    quick_build(self, ACTIONS.BUILD)
end)
AddStategraphPostInit("wilson_client", function(self)
    quick_build(self, ACTIONS.BUILD)
end)


--让原版的草叉可以叉起地毯
-- local function removethrone(inst)
--     inst:AddComponent("ccs_thronepuller")
--     if inst.components.finiteuses ~= nil then
--         inst.components.finiteuses:SetConsumption(ACTIONS.CCS_REMOVE_THRONE, --叉起地毯的消耗和叉起地皮一样
--             inst.components.finiteuses.consumption[ACTIONS.TERRAFORM] or 1
--         )
--     end
-- end
-- AddPrefabPostInit("pitchfork", removethrone)
-- AddPrefabPostInit("goldenpitchfork", removethrone)


--锅兼容
AddSimPostInit(function ()
    if rawget(_G, "AddCookingPot") then
        _G.AddCookingPot("ccs_cookpot")
    end
end)
local cookware_morphs = {
    cookpot = {
        ccs_cookpot = true,
    },
    portablecookpot = { -- What morph is it (one of [cookpot, portablecookpot, portablespicer])
    ccs_cookpot = true, -- Your cookware name
    }
}
local AUTO_COOKING_COOKWARES = rawget(_G, "AUTO_COOKING_COOKWARES") or {}
_G.AUTO_COOKING_COOKWARES = AUTO_COOKING_COOKWARES
for base, morphs in pairs(cookware_morphs) do
    AUTO_COOKING_COOKWARES[base] = shallowcopy(morphs, AUTO_COOKING_COOKWARES[base])
end

--料理锁san
AddComponentPostInit("sanity", function(sanity)
	local oldDoDelta = sanity.DoDelta
    sanity.DoDelta = function (self, delta, overtime)
        if self.inst and self.inst.ccs_sanlock == true then
            return
        end
        return oldDoDelta(self, delta, overtime)
    end
end)

AddModRPCHandler("Ccs", "Ccs_Equip_show_set", function(player)
	if player then
		--local yj = SpawnPrefab("wardrobe") 
		local yj = SpawnPrefab("ccs_fx5") 
		yj:AddComponent("wardrobe")
		yj.yj = true
		yj.Transform:SetPosition(player.Transform:GetWorldPosition())
		yj.components.wardrobe.onclosefn = function (inst)
			inst.yj = false
		end
		player:DoTaskInTime(.1,function() 
			if yj.components.wardrobe:CanBeginChanging(player) then
				yj.components.wardrobe:BeginChanging(player)
			end
		end) 
	end
end)

local saya_equip_set = require("widgets/ccs_equip_set")

local function AddSaya_equip_set(self)
	if self.owner and self.owner:HasTag("ccs") then
		self.saya_equip_set = self:AddChild(saya_equip_set(self.owner))
	end
end

AddClassPostConstruct("widgets/inventorybar", AddSaya_equip_set)

--免疫冰冻
AddComponentPostInit("freezable", function(self)
    local OldAddColdness = self.AddColdness
	self.AddColdness = function(s,...)
        if self.inst.components.inventory and (s.inst.components.inventory:EquipHasTag('ccs_cards_2_level2') or s.inst.components.inventory:HasItemWithTag("ccs_amulet", 1)) then
			return false
		end
		return OldAddColdness(s,...)
	end
    local OldFreeze = self.Freeze
    self.Freeze = function(s, freezetime, ...)
        if self.inst.components.inventory and (s.inst.components.inventory:EquipHasTag('ccs_cards_2_level2') or s.inst.components.inventory:HasItemWithTag("ccs_amulet", 1)) then
            return
        end
        return OldFreeze(s, freezetime, ...)
    end
end)

AddComponentPostInit("temperature",function (self)
    local oldSetTemperature = self.SetTemperature
    self.SetTemperature = function (s,value,...)
        if value and value < 5 and self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('ccs_cards_2') then
            value = 30
        end
        if value and value > 60 and self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('ccs_cards_11_enble') then
            value = 30
        end
        return oldSetTemperature(s, value,...)
    end
end)

local ROTATE_FENCE_fn_old = ACTIONS.ROTATE_FENCE.fn
ACTIONS.ROTATE_FENCE.fn = function(act)
    if act.invobject ~= nil and act.target ~= nil and act.target:HasTag("ccsflatrotated") then
        local fencerotator = act.invobject.components.fencerotator
        if fencerotator then
            fencerotator:Rotate(act.target, 180)
            return true
        end
    end
    return ROTATE_FENCE_fn_old(act)
end


local function ccs_fastaoespell(sg)
    local old_spell = sg.actionhandlers[ACTIONS.CASTAOE].deststate
    sg.actionhandlers[ACTIONS.CASTAOE].deststate = function(inst, action)
        if action.invobject ~= nil and action.invobject:HasTag("ccs_fastaoespell") then
            return "quickcastspell"
        end
        return old_spell(inst, action)
    end
end
AddStategraphPostInit("wilson", ccs_fastaoespell)
AddStategraphPostInit("wilson_client", ccs_fastaoespell)


AddComponentPostInit("pickable", function(self)
    function self:PickToContainer(picker)
        if self.canbepicked and self.caninteractwith then
            if self.transplanted and self.cycles_left ~= nil then
                self.cycles_left = math.max(0, self.cycles_left - 1)
            end

            if self.protected_cycles ~= nil then
                self.protected_cycles = self.protected_cycles - 1
                if self.protected_cycles <= 0 then
                    self.protected_cycles = nil
                    if self.inst.components.witherable ~= nil then
                        self.inst.components.witherable:Enable(true)
                    end
                end
            end

            local loot = nil
            local worldpicker = picker == TheWorld
            if self.product ~= nil or self.use_lootdropper_for_product ~= nil then
                local inventorypicker = picker and picker.components.container
                local pt = self.inst:GetPosition()
                if self.droppicked and self.inst.components.lootdropper ~= nil and picker.prefab ~= "ccs_spbox" then
                    pt.y = pt.y + (self.dropheight or 0)
                    if self.use_lootdropper_for_product then
                        self.inst.components.lootdropper:DropLoot(pt)
                    else
                        local num = self.numtoharvest or 1
                        for i = 1, num do
                            self.inst.components.lootdropper:SpawnLootPrefab(self.product, pt)
                        end
                    end
                else
                    if self.use_lootdropper_for_product then
                        loot = {}
                        for _, prefab in ipairs(self.inst.components.lootdropper:GenerateLoot()) do
                            table.insert(loot, self.inst.components.lootdropper:SpawnLootPrefab(prefab))
                        end
                        if not IsTableEmpty(loot) then
                            if inventorypicker then
                                picker:PushEvent("picksomething", { object = self.inst, loot = loot })
                            end
                        end
                        for i, item in ipairs(loot) do
                            if inventorypicker then
                                if item.components.inventoryitem ~= nil then
                                    picker.components.container:GiveItem(item, nil, pt)
                                end
                            elseif worldpicker then
                                item.Transform:SetPosition(pt:Get())
                            end
                        end
                    else
                        loot = SpawnPrefab(self.product)
                        if loot ~= nil then
                            if loot.components.inventoryitem ~= nil then
                                loot.components.inventoryitem:InheritWorldWetnessAtTarget(self.inst)
                            end
                            if self.numtoharvest > 1 and loot.components.stackable ~= nil then
                                loot.components.stackable:SetStackSize(self.numtoharvest)
                            end
                            if inventorypicker then
                                picker:PushEvent("picksomething", { object = self.inst, loot = loot })
                                picker.components.container:GiveItem(loot, nil, pt)
                            elseif worldpicker then
                                loot.Transform:SetPosition(pt:Get())
                            end
                        end
                    end
                end
            end

            if self.onpickedfn ~= nil then
                self.onpickedfn(self.inst, picker, loot)
            end

            self.canbepicked = false

            if self.baseregentime ~= nil and not (self.paused or self:IsBarren() or self.inst:HasTag("withered")) then
                if TheWorld.state.isspring then
                    self.regentime = self.baseregentime * TUNING.SPRING_GROWTH_MODIFIER
                end

                if not self.useexternaltimer then
                    if self.task ~= nil then
                        self.task:Cancel()
                    end
                    self.task = self.inst:DoTaskInTime(self.regentime, OnRegen)
                    self.targettime = GetTime() + self.regentime
                else
                    self.stopregentimer(self.inst)
                    self.startregentimer(self.inst, self.regentime)
                end
            end

            self.inst:PushEvent(worldpicker and "pickedbyworld" or "picked",
                { picker = picker, loot = loot, plant = self.inst })

            if self.remove_when_picked then
                self.inst:Remove()
            end

            return true, EntityScript.is_instance(loot) and { loot } or loot
        end
    end
end)

--猴子诅咒免疫
AddComponentPostInit("cursable", function(self)
    local oldIsCursable = self.IsCursable
    function self:IsCursable(item, ...)
        if item and item.components.curseditem and item.components.curseditem.curse == "MONKEY" and self.inst:HasTag("ccs") then
            return false
        end
        return oldIsCursable(self, item, ...)
    end

    local oldApplyCurse = self.ApplyCurse
    function self:ApplyCurse(item, ...)
        if item and item.components.curseditem and item.components.curseditem.curse == "MONKEY" and self.inst:HasTag("ccs") then
            item:RemoveTag("applied_curse")
            item.components.curseditem.cursed_target = nil
            return
        end
        return oldApplyCurse(self, item, ...)
    end

    local oldForceOntoOwner = self.ForceOntoOwner
    function self:ForceOntoOwner(item, ...)
        if item and item.components.curseditem and item.components.curseditem.curse == "MONKEY" and self.inst:HasTag("ccs") then
            return
        end
        return oldForceOntoOwner(self, item, ...)
    end
end)


local function IsDevouring(inst)
    return inst ~= nil
        and inst:IsValid()
        and (inst.sg ~= nil and inst.sg:HasStateTag("devoured")                                   --被吞得sg
            or inst.components.playercontroller and not inst.components.playercontroller:IsEnabled()) --无法控制状态
end

--免疫击退
AddStategraphPostInit('wilson', function(sg)
    if sg.events and sg.events.attacked then
        local oldattackedfn = sg.events.attacked.fn
        sg.events.attacked.fn = function(inst, data)
            if inst and (inst:HasTag("ccs_mianyijitui2") or inst:HasTag("playerghost") or (inst.components.inventory and inst.components.inventory:EquipHasTag("ccs_ignorejiangzhi"))) then
                return
            elseif oldattackedfn then
                return oldattackedfn(inst, data)
            end
        end
    end
    if sg.events and sg.events.knockback then
        local oldknockbackfn = sg.events.knockback.fn
        sg.events.knockback.fn = function(inst, data)
            if inst and inst:HasTag("ccs_mianyijitui") and not (data and data.knocker and data.knocker:HasTag("shadowthrall")) and not IsDevouring(inst) then
                return
            elseif oldknockbackfn then
                return oldknockbackfn(inst, data)
            end
        end
    end
end)

-- 免疫钢羊
AddComponentPostInit("pinnable", function(self)
    local oldStick = self.Stick
    self.Stick = function(self, ...)
        if self.inst and self.inst.components.inventory and self.inst.components.inventory:EquipHasTag("ccs_ignorepinna") then
            return
        end
        return oldStick(self, ...)
    end
end)

AddComponentPostInit("health", function(self)
    --禁疗
    local oldDoDelta = self.DoDelta
    function self:DoDelta(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, ...)
        if self.inst then
            if self.inst:HasTag("ccs_jinliao") and amount > 0 then
                amount = 0
            end


            if self.inst.components.inventory and self.inst.components.inventory:HasItemWithTag("ccs_healthabsorption", 1) and amount < 0 then
                amount = amount * 0.73
            end
        end
        return oldDoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, ...)
    end
end)

-- 偷取组件不能偷取某些目标
AddComponentPostInit("thief", function(thief)
    local OldStealItem = thief.StealItem
    thief.StealItem = function(self, victim, ...)
        if victim and victim:HasTag("ccscantsteal") then
            return false
        end
        return OldStealItem(self, victim, ...)
    end
end)

-- 仙人掌修改
local function fixcactus(inst)
    if inst and inst:IsValid() then
        if inst.OnEntityWake then
            local oldOnEntityWake = inst.OnEntityWake
            inst.OnEntityWake = function(self)
                if self.ccs_hasflower then
                    if self.components.pickable ~= nil and self.components.pickable.canbepicked then
                        self.has_flower = TheWorld.state.issummer or self.ccs_hasflower
                        self.AnimState:PlayAnimation(self.has_flower and "idle_flower" or "idle", true)
                    else
                        self.AnimState:PlayAnimation("empty", true)
                        self.has_flower = false
                    end
                else
                    return oldOnEntityWake(self)
                end
            end
        end

        if inst.components.pickable then
            local onregenfn = inst.components.pickable.onregenfn
            inst.components.pickable.onregenfn = function(self)
                if self.ccs_hasflower then
                    if TheWorld.state.issummer or self.ccs_hasflower then
                        inst.AnimState:PlayAnimation("grow_flower")
                        inst.AnimState:PushAnimation("idle_flower", true)
                        inst.has_flower = true
                    else
                        inst.AnimState:PlayAnimation("grow")
                        inst.AnimState:PushAnimation("idle", true)
                        inst.has_flower = false
                    end
                    inst.Physics:SetActive(true)
                else
                    return onregenfn(self)
                end
                
            end

            local oldonpickedfn = inst.components.pickable.onpickedfn
            inst.components.pickable.onpickedfn = function(self, picker, ...)
                if self.ccs_hasflower then
                    inst.Physics:SetActive(false)
                    inst.AnimState:PlayAnimation((inst.has_flower or self.ccs_hasflower) and "picked_flower" or "picked")
                    inst.AnimState:PushAnimation("empty", true)

                    if picker ~= nil then
                        if picker.components.combat ~= nil and not (picker.components.inventory ~= nil and picker.components.inventory:EquipHasTag("bramble_resistant")) and not picker:HasTag("shadowminion") then
                            picker.components.combat:GetAttacked(inst, TUNING.CACTUS_DAMAGE)
                            picker:PushEvent("thorns")
                        end

                        if inst.has_flower or self.ccs_hasflower then
                            -- You get a cactus flower, yay.
                            local loot = SpawnPrefab("cactus_flower")
                            loot.components.inventoryitem:InheritWorldWetnessAtTarget(inst)
                            if picker.components.inventory ~= nil then
                                picker.components.inventory:GiveItem(loot, nil, inst:GetPosition())
                            else
                                local x, y, z = inst.Transform:GetWorldPosition()
                                loot.components.inventoryitem:DoDropPhysics(x, y, z, true)
                            end
                        end
                    end

                    inst.has_flower = false
                else
                    return oldonpickedfn(self, picker, ...)
                end
            end
            
        end
    end
end
AddPrefabPostInit("cactus", function (inst)
    if not TheWorld.ismastersim then
        return inst
    end
    fixcactus(inst)
end)
AddPrefabPostInit("oasis_cactus", function (inst)
    if not TheWorld.ismastersim then
        return inst
    end
    fixcactus(inst)
end)


-- 屏蔽暗影伞的那个圈
local function onchangeccssensangucanopyzone(inst, underleaves)
    inst._ccssensanguunderleafcanopy:set(underleaves)
end
AddPlayerPostInit(function(inst)
    inst._ccssensanguunderleafcanopy = net_bool(inst.GUID, "localplayer._ccssensanguunderleafcanopy",
        "ccssensanguunderleafcanopydirty")
    inst:ListenForEvent("onchangeccssensangucanopyzone", onchangeccssensangucanopyzone)
end)

AddComponentPostInit("raindomewatcher", function(raindomewatcher)
    local oldOnUpdate = raindomewatcher.OnUpdate
    raindomewatcher.OnUpdate = function(self, dt)
        if self.inst and self.inst._ccssensanguunderleafcanopy ~= nil and self.inst._ccssensanguunderleafcanopy:value() then
            self.underdome = false
            self.inst:PushEvent("exitraindome")
        else
            return oldOnUpdate(self, dt)
        end
    end
end)



-- 联动
local trees = {
    "tbat_plant_cherry_blossom_tree",
}
local function OnWorked_evergreen_sparse(inst, data)
    if
        inst:HasTag("stump") or data == nil or
        data.workleft == nil or data.workleft > 0
    then
        return
    end
    if inst.components.lootdropper ~= nil then
        if math.random() <= 0.03 then
            local sakura = "ccs_sakura" .. math.random(1, 3)
            inst.components.lootdropper:SpawnLootPrefab(sakura)
        end
    end
end
local function FnSet_evergreen(inst)
    --workable.onfinish 容易被官方逻辑替换掉，所以用事件机制更保险
    --"workfinished"事件在 workable.onfinish执行后才触发，inst已经是被remove的状态，没法执行我的逻辑了
    inst:ListenForEvent("worked", OnWorked_evergreen_sparse)
end
for _, v in pairs(trees) do
    AddPrefabPostInit(v, FnSet_evergreen)
end


