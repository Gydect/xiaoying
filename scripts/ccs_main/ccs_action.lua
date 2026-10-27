--SCENE--点击物品栏物品或世界上的物品时执行,比如采集
--USEITEM--拿起某物品放到另一个物品上点击后执行，比如添加燃料
--POINT--装备某手持武器或鼠标拎起某一物品时对地面执行，比如植物人种田
--EQUIPPED--装备某物品时激活，比如装备火把点火
--INVENTORY--物品栏右键执行，比如吃东西

--doshortaction 秒放
--dolongaction 起手式
local CCSUTL = require("utils/ccs_wanly_utils")
AddComponentAction("USEITEM", "tradable", function(inst, doer, target, actions, right)
    if right and inst.prefab == "ccs_paper" and target:HasTag("ccs_card_box") then
        -- An open container otherwise offers STORE before GIVE for magic paper.
        for i = #actions, 1, -1 do
            if actions[i] == ACTIONS.STORE then table.remove(actions, i) end
        end
    end
end)

local function ExtraDropDist(doer, dest, bufferedaction)
    return 10
end

local function ExtraDeployDist()
	return 1.5
end

local function GetCardOwner(doer)
	return doer and doer.replica and (doer.replica.inventory:EquipHasTag("ccs_magic_wand3") or doer.replica.inventory:EquipHasTag("ccs_starstaff"))
end

local CCS_SEAL = GLOBAL.Action({ priority = 999, extra_arrive_dist = ExtraDropDist })
CCS_SEAL.id = "CCS_SEAL"
CCS_SEAL.str = "封印"

local Valid_seal = {
   { target =  "dragonfly", card = "ccs_cards_11"},
   { target =  "moose", card = "ccs_cards_5"},
   { target =  "antlion", card = "ccs_cards_21"}, 
   { target =  "bearger", card = "ccs_cards_13"},
   { target =  "deerclops", card = "ccs_cards_2"},
   { target =  "crabking", card = "ccs_cards_18"},
   { target =  "shadow_bishop", card = "ccs_cards_25"},
   { target =  "shadow_rook", card = "ccs_cards_1"},
   { target =  "alterguardian_phase3", card = "ccs_cards_8"},
   { target =  "leif", card = "ccs_cards_16"},
   { target =  "beequeen", card = "ccs_cards_6"},
   { target =  "bishop", card = "ccs_cards_15"},
   { target =  "bishop_nightmare", card = "ccs_cards_15"},
   { target =  "bat", card = "ccs_cards_26"},
   { target =  "malbatross", card = "ccs_cards_27"},
   --物品
   { target =  "panflute", card = "ccs_cards_19"},   
   { target =  "ruins_bat", card = "ccs_cards_12"},
   { target =  "orangestaff", card = "ccs_cards_24"},
   { target =  "greenamulet", card = "ccs_cards_10"},
   { target =  "orangeamulet", card = "ccs_cards_7"},
}

if TUNING.CCS_CARD14_ENBLE then
	table.insert(Valid_seal,{ target =  "pocketwatch_revive", card = "ccs_cards_14"})
end

local function SpawnCard(target,card,doer)
	if not target.components.health:IsDead() then

		if target:HasTag("ccs_suoxue") then 
			target:RemoveTag("ccs_suoxue")
			target.components.health.minhealth = 0
		end

		target.components.health:Kill()
		
		if target.components.health:IsDead() then
			target:AddTag("ccs_no_droploot")
			target.components.lootdropper:SpawnLootPrefab(card,nil,nil,nil,nil,doer)
		end
	end
end

CCS_SEAL.fn = function(act)
	if act.target.fy then
		if act.target.flyer ~= act.doer.userid then
			act.doer.components.talker:Say("已由其他玩家先行进行封印，只能由该玩家进行后续封印")
			return true
		end
	end
	if act.target.fy == nil or act.target.fy == false then
		act.target.fy = true
		act.target.flyer = act.doer.userid or nil
	end
    for k,v in pairs(Valid_seal) do
        if act.target.prefab == v.target then
            if act.target.components.health then
                if act.target.components.health:GetPercent() <= .1 or act.target.components.health.currenthealth <= 30 then
					if not act.target.components.health:IsDead() then
						if act.target.prefab == "shadow_bishop" or act.target.prefab == "shadow_rook" then
							if act.target.level == 3 then
								SpawnCard(act.target,v.card,act.doer)
							else
								act.doer.components.talker:Say("暗影boss不是三级")
							end
						else
							SpawnCard(act.target,v.card,act.doer)
						end
					else
						act.doer.components.talker:Say("怪物已死亡，封印失败")
						return true
					end
				end
            else
				if act.target.prefab == "antlion" then
					act.doer.components.talker:Say("要先激活蚁狮并满足条件")
					return true
				end
                act.target:Remove()
				local card = SpawnPrefab(v.card)
				card.components.ccs_card_level:SetMaster(act.doer.name,act.doer.userid)
                act.doer.components.inventory:GiveItem(card)
            end
        end
    end
    return true
end
AddAction(CCS_SEAL)

AddComponentAction("SCENE", "ccs_canseal", function(inst, doer, actions, right)
	local doer_card = GetCardOwner(doer)
    if right and inst and inst:HasTag("ccs_canseal") and doer_card then
        table.insert(actions, ACTIONS.CCS_SEAL)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_SEAL, "ccs_seal_magic"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_SEAL, "ccs_seal_magic"))

--卡牌使用
local CCS_USE_CARD = GLOBAL.Action({priority = 999})
CCS_USE_CARD.id = "CCS_USE_CARD"
CCS_USE_CARD.str = "激活卡牌"

CCS_USE_CARD.fn = function(act)
	if act.invobject then
		act.invobject.components.ccs_card_use:Use()
	end
    return true
end
AddAction(CCS_USE_CARD)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_USE_CARD, "attack"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_USE_CARD, "attack"))
--
--水牌使用
local function CheckTileWithinRange(doer, dest)
	local doer_pos = doer:GetPosition()
	local target_pos = Vector3(dest:GetPoint())

    local tile_x, tile_y, tile_z = TheWorld.Map:GetTileCenterPoint(target_pos.x, 0, target_pos.z)
    local dist = TILE_SCALE * 0.5
    if math.abs(tile_x - doer_pos.x) <= dist and math.abs(tile_z - doer_pos.z) <= dist then
        return true
    end
end

local CCS_USE_CARD_18 = GLOBAL.Action({priority = 999,distance=1.1, extra_arrive_dist=ExtraDeployDist })
CCS_USE_CARD_18.id = "CCS_USE_CARD_18"
CCS_USE_CARD_18.str = "水牌填海"

CCS_USE_CARD_18.fn = function(act)
	if act.pos == nil then return end
	local x,y,z = act.pos:GetPosition():Get()
    local tile = TheWorld.Map:GetTileAtPoint(x, y, z)
    local tx, ty = TheWorld.Map:GetTileCoordsAtPoint(x, y, z)
    if IsOceanTile(tile) then
		if act.doer.components.ccs_magic:GetMagic() >= 5 then
			TheWorld.Map:SetTile(tx, ty, WORLD_TILES.GRASS)
			act.doer.components.ccs_magic:DoDelta(-5)
		else
			act.doer.components.talker:Say("魔力不足")
		end
		return true
	else
		if act.doer.components.ccs_magic:GetMagic() >= 5 then
			TheWorld.Map:SetTile(tx, ty, WORLD_TILES.OCEAN_COASTAL)
			act.doer.components.ccs_magic:DoDelta(-5)
		else
			act.doer.components.talker:Say("魔力不足")
		end
		return true
    end
	return false
end
AddAction(CCS_USE_CARD_18)

AddComponentAction("POINT", "deployable", function(inst, doer, pos, actions, right, target)
	if right and inst.replica.inventoryitem ~= nil then
		--if inst.replica.inventoryitem:CanDeploy(pos, nil, doer, (doer.components.playercontroller ~= nil and doer.components.playercontroller.deployplacer ~= nil) 
				--and doer.components.playercontroller.deployplacer.Transform:GetRotation() or 0) then
			local doer_card = GetCardOwner(doer)
			if inst:HasTag("ccs_cards_18") and doer:HasTag("ccs") and doer_card then
				table.insert(actions, ACTIONS.CCS_USE_CARD_18)
			end
		--end
	end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_USE_CARD_18, "attack"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_USE_CARD_18, "attack"))

--浮牌传送

local CCS_USE_CARD_6 = GLOBAL.Action({ priority = 999})
CCS_USE_CARD_6.id = "CCS_USE_CARD_6"
CCS_USE_CARD_6.str = "浮牌传送"

CCS_USE_CARD_6.fn = function(act)
	local pos = act.target and act.target.pos
	if pos then
		local x1,y1,z1 = act.doer:GetPosition():Get()
		SpawnPrefab("spawn_fx_medium").Transform:SetPosition(x1,y1,z1)
		act.doer.Transform:SetPosition(pos.x,pos.y,pos.z) 
		SpawnPrefab("spawn_fx_medium").Transform:SetPosition(pos.x,pos.y,pos.z)
		act.target:Remove()
		return true
	else
		act.doer.components.talker:Say("这张卡牌没有目标地点")
		return true
	end
    return false
end
AddAction(CCS_USE_CARD_6)

AddComponentAction("SCENE", "ccs_card_6_fx", function(inst, doer, actions, right)
    if inst and inst:HasTag("ccs_card_6_fx") then
        table.insert(actions, ACTIONS.CCS_USE_CARD_6)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_USE_CARD_6, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_USE_CARD_6, "doshortaction"))


--移牌传送

local function CanBlinkTo(pt)
    return (TheWorld.Map:IsAboveGroundAtPoint(pt.x, pt.y, pt.z) or TheWorld.Map:GetPlatformAtPoint(pt.x, pt.z) ~= nil) and not TheWorld.Map:IsGroundTargetBlocked(pt)
end

local function GetPointSpecialActions(inst, pos, useitem, right)
    if right and CanBlinkTo(pos) and useitem == nil and inst.replica.inventory:EquipHasTag("ccs_cards_24",1) and (inst.replica.inventory:EquipHasTag("ccs_magic_wand3") or inst.replica.inventory:EquipHasTag("ccs_starstaff")) then
		return { ACTIONS.BLINK }
    end
    return {}
end

local function OnSetOwner(inst)
    if inst.components.playeractionpicker ~= nil then
        inst.components.playeractionpicker.pointspecialactionsfn = GetPointSpecialActions
    end
end

AddPrefabPostInit("ccs", function(inst)
	inst:ListenForEvent("setowner", OnSetOwner)
end)

--动作hook

local old_BLINK_strfn = GLOBAL.ACTIONS.BLINK.strfn		
GLOBAL.ACTIONS.BLINK.strfn = function(act)
	if act.doer:HasTag("ccs") and act.doer.replica.inventory:EquipHasTag("ccs_cards_24",1) and (act.doer.replica.inventory:EquipHasTag("ccs_magic_wand3") or act.doer.replica.inventory:EquipHasTag("ccs_starstaff")) then
		return "移牌传送"
	end
	return old_BLINK_strfn(act)
end

local old_BLINK_fn = GLOBAL.ACTIONS.BLINK.fn
GLOBAL.ACTIONS.BLINK.fn = function(act)
	if act.doer:HasTag("ccs") and act.doer.components.inventory:EquipHasTag("ccs_cards_24",1) and (act.doer.replica.inventory:EquipHasTag("ccs_magic_wand3") or act.doer.replica.inventory:EquipHasTag("ccs_starstaff")) then
		local xh = 2
		if act.doer.components.inventory:EquipHasTag("ccs_cards_24_level2",1) then
			xh = 1
		end
		act.doer.components.ccs_magic:DoDelta(-xh)
		local act_pos = act:GetActionPoint()
		-- local platform = TheWorld.Map:GetPlatformAtPoint(act_pos.x, act_pos.z)
        -- local platformoffset
        -- if platform then
        --     platformoffset = platform:GetPosition() - act_pos
        -- end
		act.doer.sg:GoToState("ccs_portal_jumpin", {dest = act_pos})
		return true
	end
    return old_BLINK_fn(act)
end

local old_BLINK_MAP_stroverridefn = GLOBAL.ACTIONS.BLINK_MAP.stroverridefn	
GLOBAL.ACTIONS.BLINK_MAP.stroverridefn = function(act)
	if act.doer:HasTag("ccs") and act.doer.replica.inventory:EquipHasTag("ccs_cards_24_level3", 1) then
		act.ccs_magic_cs_xh = act.ccs_magic_cs_xh or 50
		return string.format("移牌传送:魔法消耗".."(%u)",act.ccs_magic_cs_xh)
	end
	return old_BLINK_MAP_stroverridefn(act)
end

local old_BLINK_MAP_fn = GLOBAL.ACTIONS.BLINK_MAP.fn
GLOBAL.ACTIONS.BLINK_MAP.fn = function(act)
	if act.doer:HasTag("ccs") and act.doer.components.inventory:EquipHasTag("ccs_cards_24_level3", 1) then
		if act.doer.components.inventory:EquipHasTag("ccs_cards_24_level3",1) then
			act.ccs_magic_cs_xh = act.ccs_magic_cs_xh or 50
			if act.doer.components.ccs_magic:GetMagic() >= act.ccs_magic_cs_xh then	
				local act_pos = act:GetActionPoint()
				-- local platform = TheWorld.Map:GetPlatformAtPoint(act_pos.x, act_pos.z)
				-- local platformoffset
				-- if platform then
				-- 	platformoffset = platform:GetPosition() - act_pos
				-- end
				act.doer.sg:GoToState("ccs_portal_jumpin", {dest = act_pos, from_map = true,})
				act.doer.components.ccs_magic:DoDelta(-act.ccs_magic_cs_xh)
			elseif act.doer.components.talker then
				act.doer.components.talker:Say("魔法不够移牌传送")
			end
			return true
		else
			act.doer.components.talker:Say("移牌等级不够")
			return true
		end
	end
	return old_BLINK_MAP_fn(act)
end

local BLINK_MAP_MUST = { "CLASSIFIED", "globalmapicon", "fogrevealer" }
local function Ccs_Blink_code(act, targetpos)
    local doer = act.doer
    if doer == nil then
        return nil
    end
    local aimassisted = false
    local distoverride = nil
    if not TheWorld.Map:IsVisualGroundAtPoint(targetpos.x, targetpos.y, targetpos.z) then
        -- NOTES(JBK): No map tile at the cursor but the area might contain a boat that has a maprevealer component around it.
        -- First find a globalmapicon near here and look for if it is from a fogrevealer and assume it is on landable terrain.
        local ents = TheSim:FindEntities(targetpos.x, targetpos.y, targetpos.z, PLAYER_REVEAL_RADIUS * 0.4, BLINK_MAP_MUST)
        local revealer = nil
        local MAX_WALKABLE_PLATFORM_DIAMETERSQ = TUNING.MAX_WALKABLE_PLATFORM_RADIUS * TUNING.MAX_WALKABLE_PLATFORM_RADIUS * 4 -- Diameter.
        for _, v in ipairs(ents) do
            if doer:GetDistanceSqToInst(v) > MAX_WALKABLE_PLATFORM_DIAMETERSQ then -- Ignore close boats because the range for aim assist is huge.
                revealer = v
                break
            end
        end
        if revealer == nil then
            return nil
        end
        -- NOTES(JBK): Ocuvigils are normally placed at the edge of the boat and can result in the teleportee being pushed out of the boat boundary.
        -- The server will make the adjustments to the target position without the client being able to know so we force the original distance to be an override.
        targetpos.x, targetpos.y, targetpos.z = revealer.Transform:GetWorldPosition()
        distoverride = act.pos:GetPosition():Dist(targetpos)
        if revealer._target ~= nil then
            -- Server only code.
            local boat = revealer._target:GetCurrentPlatform()
            if boat == nil then
                -- This should not happen but in case it does fail the act to not teleport onto water.
                return nil
            end
            targetpos.x, targetpos.y, targetpos.z = boat.Transform:GetWorldPosition()
        end
        aimassisted = true
    end
    local dist = distoverride or act.pos:GetPosition():Dist(targetpos)
    local act_remap = BufferedAction(doer, nil, ACTIONS.BLINK_MAP, act.invobject, targetpos)
    local dist_mod = ((doer._freesoulhop_counter or 0) * (TUNING.WORTOX_FREEHOP_HOPSPERSOUL - 1)) * act.distance
    local dist_perhop = (act.distance * TUNING.WORTOX_FREEHOP_HOPSPERSOUL * TUNING.WORTOX_MAPHOP_DISTANCE_SCALER)
    local dist_souls = (dist + dist_mod) / dist_perhop
    act_remap.maxsouls = TUNING.WORTOX_MAX_SOULS
    act_remap.distancemod = dist_mod
    act_remap.distanceperhop = dist_perhop
    act_remap.distancefloat = dist_souls
    act_remap.distancecount = math.clamp(math.ceil(dist_souls), 1, act_remap.maxsouls)
    act_remap.aimassisted = aimassisted
	---
	--7距离1魔法
	local x,y,z = doer:GetPosition():Get()	
	local x1,z1 = (targetpos.x - x) * (targetpos.x - x) , (targetpos.z - z) * (targetpos.z - z)
	local xb = x1 + z1
	local zz = math.sqrt(xb) 		--最终距离
	act_remap.ccs_magic_cs_xh = math.min(50,zz / 7)
	---

    return act_remap
end

local old_BLINK_code = GLOBAL.ACTIONS_MAP_REMAP[ACTIONS.BLINK.code]
ACTIONS_MAP_REMAP[ACTIONS.BLINK.code] = function(act, targetpos)
	if act.doer:HasTag("ccs") and act.doer.replica.inventory:EquipHasTag("ccs_cards_24",1) then
		return Ccs_Blink_code(act, targetpos)
	end
	return old_BLINK_code(act, targetpos)
end

--甜牌使用
local CCS_CARD_20_USE = GLOBAL.Action({priority = 999})
CCS_CARD_20_USE.id = "CCS_CARD_20_USE"
CCS_CARD_20_USE.str = "甜牌强化"
CCS_CARD_20_USE.fn = function(act)
    if act.target.components.ccs_card_magic.card_20_enble == false then
		act.doer.components.talker:Say('使用成功！')
		act.target.components.ccs_card_magic.card_20_enble = true
	else
		act.doer.components.talker:Say("这个锅已经获得了甜牌能力")
    end 
	return true
end
AddAction(CCS_CARD_20_USE)
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.CCS_CARD_20_USE, "attack"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.CCS_CARD_20_USE, "attack"))

--卡牌使用
local CCS_USE_CARD_MONSTER = GLOBAL.Action({priority = 999})
CCS_USE_CARD_MONSTER.id = "CCS_USE_CARD_MONSTER"
CCS_USE_CARD_MONSTER.str = "召唤Boss"

CCS_USE_CARD_MONSTER.fn = function(act)
	local hand = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if hand == nil then
		act.doer.components.talker:Say("手持魔杖召唤以boss") 
		return true 
	end
	if hand.prefab ~= "ccs_magic_wand3" and hand.prefab ~= "ccs_starstaff"  then 
		act.doer.components.talker:Say("手持魔杖召唤以boss") 
		return true 
	end
	
	local x,y,z = act.doer:GetPosition():Get()
	if TheWorld:HasTag("cave") then
		if act.invobject.caveboss ~= nil then
			for k,v in pairs(act.invobject.caveboss) do
				local boss = SpawnPrefab(v)
				boss.Transform:SetPosition(x,y,z)
				if v == "klaus" then
					boss:SpawnDeer()
				end
			end
			act.invobject:Remove()
			return true
		end
	end
	for k,v in pairs(act.invobject.masterboss) do 
		local boss = SpawnPrefab(v)
		boss.Transform:SetPosition(x,y,z)
		if v == "klaus" then
			boss:SpawnDeer()
		end
	end
	act.invobject:Remove()
	return true
end
AddAction(CCS_USE_CARD_MONSTER)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_USE_CARD_MONSTER, "attack"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_USE_CARD_MONSTER, "attack"))

AddComponentAction("INVENTORY", "ccs_card_use", function(inst, doer, actions)
	
    if inst and inst:HasTag("ccs_card_use") then 
		table.insert(actions, ACTIONS.CCS_USE_CARD)
    end
	if inst and inst:HasTag("ccs_monster_card") then  
		table.insert(actions, ACTIONS.CCS_USE_CARD_MONSTER)
    end
end)

--卡牌升级
local CCS_CARD_UP_Level = GLOBAL.Action({priority = 999})
CCS_CARD_UP_Level.id = "CCS_CARD_UP_Level"
CCS_CARD_UP_Level.str = "卡牌升级"
CCS_CARD_UP_Level.fn = function(act)
	if act.target.components.inventoryitem.owner then
		if act.target.components.inventoryitem.owner.prefab == "ccs_magic_wand3" then
			act.doer.components.talker:Say("卡牌不能在魔杖中升级")
			return true
		end
		if act.target.components.inventoryitem.owner.prefab == "ccs_card_box" then
			act.doer.components.talker:Say("卡牌不能在卡牌盒中升级")
			return true
		end
	end
	if act.target.components.ccs_card_level.masterid == nil then
		act.doer.components.talker:Say("目标卡牌没有绑定主人，无法进行升级")
		return true
	end
	if act.invobject.components.ccs_card_level.masterid == nil then
		act.doer.components.talker:Say("操作卡牌没有绑定主人，无法进行升级")
		return true
	end
	if act.target.components.ccs_card_level.masterid and act.invobject.components.ccs_card_level.masterid then
		if act.target.components.ccs_card_level.masterid ~= act.invobject.components.ccs_card_level.masterid then
			act.doer.components.talker:Say("两张卡牌主人不同，无法进行升级")
			return true
		end
	end
	
    if not act.target.components.ccs_card_level:IsMaxLevel() then
		if act.invobject.components.ccs_card_level:GetLevel() == act.target.components.ccs_card_level:GetLevel() then
			act.invobject:Remove()
			act.target.components.ccs_card_level:UpLevel()
		else
			act.doer.components.talker:Say("两张卡牌等级不同")
		end
	else
		act.doer.components.talker:Say("该卡牌已经满级")
    end 
	return true
end
AddAction(CCS_CARD_UP_Level)
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.CCS_CARD_UP_Level, "doshortaction"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.CCS_CARD_UP_Level, "doshortaction"))

-----打包
local skin_data = {
	ccs_amulet_skin1 = {"ccs_pack_gift_skin1", "ccs_pack_gift_skin2", "ccs_pack_gift_skin3"},
	ccs_amulet_skin2 = "ccs_pack_gift_skin4",
	ccs_amulet_skin3 = {"ccs_pack_gift_skin5","ccs_pack_gift_skin6"},
	ccs_amulet_skin4 = "ccs_pack_gift_skin7",
	ccs_amulet_skin_bkm = { "ccs_pack_gift_bkm1", "ccs_pack_gift_bkm2", "ccs_pack_gift_bkm3" }
}
local CCS_PACK = GLOBAL.Action({priority = 99})
CCS_PACK.id = "CCS_PACK"
CCS_PACK.str = "打包"
CCS_PACK.fn = function(act)
	local target = act.target	
	local doer = act.doer
	-- if not doer:HasTag("ccs") then
	-- 	if doer.components and doer.components.talker then
	-- 		doer.components.talker:Say("只有小樱才可以使用")
	-- 	end
	-- 	return true
	-- end
	local can_spell = false
	if doer:HasTag("ccs") then
        can_spell = doer.components.ccs_magic.current >= 20
    elseif doer:HasTag("player") and doer.components.sanity then
        can_spell = doer.components.sanity.current >= 35
    else
        return false
    end
	if  not can_spell  then
        doer.components.talker:Say(doer:HasTag("ccs") and  "魔法不足" or  "理智不足" )
        return false
    end
	local skin = nil
	local userid = doer.userid
	if  target ~= nil then	
		if act.invobject and act.invobject.prefab == "ccs_amulet" then
			local obj = act.invobject
			local name = obj:GetSkinName()
			userid = obj.components.ccsskinable and obj.components.ccsskinable._ccsuserid
			if skin_data[name] then
				local selected_skin
				if type(skin_data[name]) == "table" then
					selected_skin = skin_data[name][math.random(#skin_data[name])]
				else
					selected_skin = skin_data[name]
				end
				skin = selected_skin
			end
		end
		local targetpos = target:GetPosition()
		local package = GLOBAL.SpawnPrefab("ccs_pack_gift", skin, nil, userid)
    	if package and package.components.ccs_pack then
			if 	not package.components.ccs_pack:CanPack(target) then
				package:Remove()
				return false
			end
			if target.components.teleporter ~= nil and target.components.teleporter:IsBusy() then
				package:Remove()
				return false			
			end
			if doer:HasTag("ccs") then
				doer.components.ccs_magic:DoDelta(-20)
			else
				doer.components.sanity:DoDelta(-35)
			end
			if act.invobject then
				if act.invobject.prefab == "ccs_sakura2" then
					if act.invobject.components.stackable and act.invobject.components.stackable:IsStack() then		
						act.invobject.components.stackable:Get():Remove()
					else
						act.invobject:Remove()
					end
				end
				
			end
			package.components.ccs_pack:Pack(target, doer)
			package.Transform:SetPosition( targetpos:Get() )
			if doer and doer.SoundEmitter then
				doer.SoundEmitter:PlaySound("dontstarve/common/staff_dissassemble")
			end
			return true
		end		
	end  			
end
AddAction(CCS_PACK) 
AddComponentAction("USEITEM", "ccs_packer" , function(inst, doer, target, actions) 
	if inst:HasTag("ccs_pack_item") and not target:HasTag("player")then
		table.insert(actions, GLOBAL.ACTIONS.CCS_PACK)
    end
end)
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.CCS_PACK, "doshortaction"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.CCS_PACK, "doshortaction"))

--解除绑定
local CCS_ABANDON_MASTER = GLOBAL.Action({priority = 999})
CCS_ABANDON_MASTER.id = "CCS_ABANDON_MASTER"
CCS_ABANDON_MASTER.str = "解绑卡牌"
CCS_ABANDON_MASTER.fn = function(act)
	local target = act.target	
	local doer = act.doer
	if not doer:HasTag("ccs") then
		if doer.components and doer.components.talker then
			doer.components.talker:Say("只有小樱才可以使用")
		end
		return true
	end
	if target ~= nil then	
		local master = target.components.ccs_card_level.master
		local masterid = target.components.ccs_card_level.masterid
		if masterid ~= nil then
			target.components.ccs_card_level:AbandonMaster()
			doer.components.talker:Say("已经成功抹除这张卡的主人")
			if act.invobject.components.stackable and act.invobject.components.stackable:IsStack() then		
				act.invobject.components.stackable:Get():Remove()
			else
				act.invobject:Remove()
			end
		else
			doer.components.talker:Say("这张卡牌没有主人")
		end
	end 
	return true
end
AddAction(CCS_ABANDON_MASTER)
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.CCS_ABANDON_MASTER, "doshortaction"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.CCS_ABANDON_MASTER, "doshortaction"))

AddComponentAction("USEITEM", "ccs_jb" , function(inst, doer, target, actions) 
	if target and inst then
		if target:HasTag("ccs_card") then
			table.insert(actions, GLOBAL.ACTIONS.CCS_ABANDON_MASTER)
		end	
	end
end)

--降落

local CCS_LAND = GLOBAL.Action({ priority = 999})
CCS_LAND.id = "CCS_LAND"
CCS_LAND.str = "降落"

CCS_LAND.fn = function(act)
	if act.doer.components.ccs_flying:IsFly() then
		act.doer.components.ccs_flying:Land()
	end
    return true
end
AddAction(CCS_LAND)

AddComponentAction("SCENE", "ccs_flying", function(inst, doer, actions, right)
    if inst and inst:HasTag("player") and doer and doer:HasTag("ccs") and doer.replica.ccs_flying.isfly:value() == true and doer.userid == inst.userid then
        table.insert(actions, ACTIONS.CCS_LAND)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_LAND, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_LAND, "doshortaction"))

--关闭祭坛
local Clos_Ccs_Jt = GLOBAL.Action()
Clos_Ccs_Jt.id = "Clos_Ccs_Jt"  
Clos_Ccs_Jt.str = "改变祭坛"   

Clos_Ccs_Jt.fn = function(act)  
    if act.target and act.target.prefab == "ccs_jt" then
		if act.target.enble == true then
			act.doer.components.talker:Say("祭坛已关闭")
			act.target.enble = false
		else
			act.doer.components.talker:Say("祭坛已开启")
			act.target.enble = true
		end
        return true
    end
end
AddAction(Clos_Ccs_Jt)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(Clos_Ccs_Jt, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(Clos_Ccs_Jt, "doshortaction"))

--改变烤箱

local Ccs_Oven_Cut = GLOBAL.Action()
Ccs_Oven_Cut.id = "Ccs_Oven_Cut"  
Ccs_Oven_Cut.str = "改变烤箱"   

Ccs_Oven_Cut.fn = function(act)  
    if act.target and act.target.prefab == "ccs_oven" and act.target.components.container then
		act.target.components.container:Close(act.doer)
		if act.target.cold == true then
			act.doer.components.talker:Say("烤箱更改为烘烤模式")
			act.target.AnimState:PlayAnimation("idle2",true)
			if act.target.skinname == "ccs_oven_shasha" or act.target.skinname == "ccs_oven_mixue" then 
				act.target.components.container:WidgetSetup(act.target.skinname.."_y")
				if act.target._ccsskin then
					act.target._ccsskin:set(act.target.skinname.."_y")
				end
			end
			act.target.cold = false
		else
			act.doer.components.talker:Say("烤箱更改为冷冻模式")
			act.target.AnimState:PlayAnimation("idle1",true)
			if act.target.skinname == "ccs_oven_shasha" or act.target.skinname == "ccs_oven_mixue" then 
				act.target.components.container:WidgetSetup(act.target.skinname)
				if act.target._ccsskin then
					act.target._ccsskin:set(act.target.skinname)
				end
			end
			act.target.cold = true
		end
        return true
    end
end
AddAction(Ccs_Oven_Cut)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(Ccs_Oven_Cut, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(Ccs_Oven_Cut, "doshortaction"))

AddComponentAction("SCENE", "workable", function(inst, doer, actions, right)  --scene类型,绑定在了workable组件上
    if right then
        if inst:HasTag("ccs_jt") then
            table.insert(actions, ACTIONS.Clos_Ccs_Jt)
        end
		if inst:HasTag("ccs_oven") then
            table.insert(actions, ACTIONS.Ccs_Oven_Cut)
        end
    end
end)

-- 装备栏使用（勋章的切换）
local CCSUSE = GLOBAL.Action({
    priority = 99
})
CCSUSE.id = "CCSUSE"
CCSUSE.str = "使用"
CCSUSE.fn = function(act)
    if act.invobject ~= nil and act.invobject.components.ccsuseable ~= nil and
        act.invobject.components.ccsuseable:CanInteract() and act.doer.components.inventory ~= nil and
        act.doer.components.inventory:IsOpenedBy(act.doer) then
        act.invobject.components.ccsuseable:StartUsingItem(act.doer)
        return true
    end
end

AddAction(CCSUSE)
AddComponentAction("INVENTORY", "ccsuseable", function(inst, doer, actions, right)
    if not inst:HasTag("ccsinuse") and doer.replica.inventory ~= nil and doer.replica.inventory:IsOpenedBy(doer) then
        table.insert(actions, ACTIONS.CCSUSE)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(ACTIONS.CCSUSE, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(ACTIONS.CCSUSE, "doshortaction"))


--爱牌复活
local CCS_CARD_28_USE = GLOBAL.Action()
CCS_CARD_28_USE.id = "CCS_CARD_28_USE"  
CCS_CARD_28_USE.str = "爱牌复活"   

CCS_CARD_28_USE.fn = function(act) 
	if act.target and act.target:HasTag("playerghost") and act.doer and act.doer:HasTag("ccs") then
		act.invobject:Remove()
		act.target:PushEvent("respawnfromghost", { user = act.doer })
		return true
	end
end
AddAction(CCS_CARD_28_USE)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(ACTIONS.CCS_CARD_28_USE, "give"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(ACTIONS.CCS_CARD_28_USE, "give"))

AddComponentAction("USEITEM", "ccs_card_level" , function(inst, doer, target, actions) 
	if target and inst then
		if target.prefab == inst.prefab then
			table.insert(actions, ACTIONS.CCS_CARD_UP_Level)
		end
		if target:HasTag("ccs_card_magic_20") and inst:HasTag("ccs_cards_20") then
			table.insert(actions, ACTIONS.CCS_CARD_20_USE)
		end
		if target and target:HasTag("playerghost") and inst.replica.ccs_card_level:GetLevel() == 1 then
			table.insert(actions, ACTIONS.CCS_CARD_28_USE)
		end
	end
end)

--喷泉采集
local CCS_FOUNTAIN_PICK = GLOBAL.Action({ priority = 999})
CCS_FOUNTAIN_PICK.id = "CCS_FOUNTAIN_PICK"
CCS_FOUNTAIN_PICK.str = "采集魔法水"

CCS_FOUNTAIN_PICK.fn = function(act)
    local target = act.target
    if target then
        local count = target.pick or 0
        if count > 0 then
            for i = 1, count do
                act.doer.components.inventory:GiveItem(SpawnPrefab("ccs_magic_water"))
            end
            target.pick = 0
			target:RemoveTag("ccs_canpick")
            act.doer.components.talker:Say("采集成功，共取走 " .. count .. " 份魔法水")
            return true
        else
            act.doer.components.talker:Say("喷泉现在还没有魔法水")
            return true
        end
    end
    return false
end
AddAction(CCS_FOUNTAIN_PICK)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_FOUNTAIN_PICK, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_FOUNTAIN_PICK, "dolongaction"))

local actionqueuer_status = pcall(require, "components/actionqueuer")
if actionqueuer_status and AddActionQueuerAction then
    AddActionQueuerAction("leftclick", "CCS_FOUNTAIN_PICK", true)
end

--调转树方向
local CCS_TREE_TWO = GLOBAL.Action({ priority = 999})
CCS_TREE_TWO.id = "CCS_TREE_TWO"
CCS_TREE_TWO.str = "改变朝向"

CCS_TREE_TWO.fn = function(act)
	local target = act.target
	if target then
		if target.AnimState:IsCurrentAnimation("idle1") then
			target.AnimState:PlayAnimation("idle2")
		else
			target.AnimState:PlayAnimation("idle1")
		end
	end
    return true
end
AddAction(CCS_TREE_TWO)

AddComponentAction("SCENE", "ccs_fountain", function(inst, doer, actions, right)
	if inst and inst:HasTag("ccs_fountain") and inst:HasTag("ccs_canpick") then
        table.insert(actions, ACTIONS.CCS_FOUNTAIN_PICK)
    end
	if doer.replica.inventory:EquipHasTag("fence_rotator") and inst:HasTag("ccs_two") then
        table.insert(actions, ACTIONS.CCS_TREE_TWO)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_TREE_TWO, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_TREE_TWO, "doshortaction"))

--墙修理，懒得调官方的了，看的头大

AddComponentAction("USEITEM", "ccs_wall", function(inst, doer, target, actions, right)
	if right then
		if doer.replica.rider ~= nil and doer.replica.rider:IsRiding() then
			if not (target.replica.inventoryitem ~= nil and target.replica.inventoryitem:IsGrandOwner(doer)) then
				return
			end
			elseif doer.replica.inventory ~= nil and doer.replica.inventory:IsHeavyLifting() then
			return
		end
		if target:HasTag("ccs_wall") then
			table.insert(actions, ACTIONS.REPAIR)	
		end
	end
end)

-- AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(CCS_TREE_TWO, "doshortaction"))
-- AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(CCS_TREE_TWO, "doshortaction"))

--青蛙衣修复
local CCS_FROG_YF = GLOBAL.Action()
CCS_FROG_YF.id = "CCS_FROG_YF"  
CCS_FROG_YF.str = "修复"   

CCS_FROG_YF.fn = function(act) 
	local sewing = act.invobject
	local target = act.target
	if sewing.components.finiteuses then
		sewing.components.finiteuses:Use(1)
		target.components.armor:SetCondition(target.components.armor.condition + target.components.armor.maxcondition * 0.25)
	elseif sewing.components.stackable then
		sewing.components.stackable:Get(1):Remove()
		target.components.armor:SetCondition(target.components.armor.condition + target.components.armor.maxcondition * 0.25)
	end
	return true
end
AddAction(CCS_FROG_YF)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(ACTIONS.CCS_FROG_YF, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(ACTIONS.CCS_FROG_YF, "dolongaction"))

AddComponentAction("USEITEM", "sewing" , function(inst, doer, target, actions) 
	if target.prefab == "ccs_frog_yf" and inst then
		table.insert(actions, ACTIONS.CCS_FROG_YF)
	end
end)

--- 荡秋千
local SITSWING = Action({ priority = -1, encumbered_valid = true })
SITSWING.id = "SITSWING"
SITSWING.str = "坐上"
SITSWING.fn = function(act)
    if act.doer and act.target then
        if act.target:HasTag("isusing") then
            if act.doer.components.talker then
                act.doer.components.talker:Say("秋千已经坐满了，挤不下惹")
                return true
            end
        end
        act.doer.sg:GoToState("brc_sitswing")
        return true
    end
end

AddAction(SITSWING)

AddComponentAction("SCENE", "brc_swing", function(inst, doer, actions, right)
    if not inst:HasTag("isusing") then
        table.insert(actions, ACTIONS.SITSWING)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.SITSWING, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.SITSWING, "give"))



-- local CCS_REMOVE_THRONE = Action({ priority=3 })
-- CCS_REMOVE_THRONE.id = "CCS_REMOVE_THRONE"
-- CCS_REMOVE_THRONE.str = "叉起地毯"
-- CCS_REMOVE_THRONE.fn = function(act)
--     if act.invobject ~= nil and act.invobject.components.ccs_thronepuller ~= nil then
--         return act.invobject.components.ccs_thronepuller:DoIt(act:GetActionPoint(), act.doer)
--     end
-- end
-- AddAction(CCS_REMOVE_THRONE)

-- AddComponentAction("POINT", "ccs_thronepuller", function(inst, doer, pos, actions, right, target)
--     if right then
--         local x, y, z = pos:Get()
--         if #TheSim:FindEntities(x, y, z, 2, { "ccs_throne" }, { "INLIMBO" }, nil) > 0 then
--             table.insert(actions, ACTIONS.CCS_REMOVE_THRONE)
--         end
--     end
-- end)

-- AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.CCS_REMOVE_THRONE, "terraform"))
-- AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.CCS_REMOVE_THRONE, "terraform"))


local FLY_PICKUP_GOLD = Action({priority = 10, mount_valid = false})
FLY_PICKUP_GOLD.id = "FLY_PICKUP_GOLD"
FLY_PICKUP_GOLD.str = "强制拾取"  
FLY_PICKUP_GOLD.fn = function(act)
    if not act.doer or not act.doer:IsValid() then return false end
    if not act.target or not act.target:IsValid() then return false end
    if act.target.prefab ~= "goldnugget" then return false end
    if not act.doer:HasTag("ccs_isfly") then return false end

    local item = act.target
    if item.components.inventoryitem then
        act.doer.components.inventory:GiveItem(item)
        return true
    end
    return false
end
AddAction(FLY_PICKUP_GOLD)
--ACTIONS.FLY_PICKUP_GOLD.instant = true 

AddComponentAction("SCENE", "inventoryitem", function(inst, doer, actions, right)
    if right then return end  
    if not doer or not doer:IsValid() or not inst or not inst:IsValid() then return end
    if inst.prefab == "goldnugget" and doer:HasTag("ccs_isfly") then
        table.insert(actions, ACTIONS.FLY_PICKUP_GOLD)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.FLY_PICKUP_GOLD, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.FLY_PICKUP_GOLD, "doshortaction"))
