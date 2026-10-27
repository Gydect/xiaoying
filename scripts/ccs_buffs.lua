-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------地---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
	
-- 	target.components.combat.externaldamagemultipliers:SetModifier("ccs_card_dp", 1.35) 		
-- 	target.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_dp",0.65)	
	
-- 	if inst._fx ~= nil then
-- 		inst._fx:kill_fx()
-- 	end
		
-- 	inst._fx = SpawnPrefab("forcefieldfx")
-- 	inst._fx.AnimState:SetBuild("ccs_shield_fx")
-- 	inst._fx.entity:SetParent(target.entity)
-- 	inst._fx.Transform:SetPosition(0, 0.2, 0)
-- end

-- local function OnDetached(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("地牌强化失效")
-- 		target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
-- 		target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
-- 		if inst._fx ~= nil then
-- 			inst._fx:kill_fx()
-- 			inst._fx = nil
-- 		end
-- 	end
-- 	inst:Remove()
-- end

-- local function OnTimerDone(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_dp")
-- 		end
-- 	end
-- end

-- local function OnExtended(inst,target)
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 480)
-- end


-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------带特效的地---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- local function OnAttached_1(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
	
-- 	target.components.combat.externaldamagemultipliers:SetModifier("ccs_card_dp", 1.35)
-- 	target.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_dp", 0.65)
	
-- 	if inst._fx ~= nil then
-- 		inst._fx:Remove()
-- 		inst._fx = nil
-- 	end
		
-- 	inst._fx = SpawnPrefab("ccs_lizifx_ranibowspark")
-- 	inst._fx.entity:AddFollower()
-- 	inst._fx.entity:SetParent(target.entity)
-- 	inst._fx.Follower:FollowSymbol(target.GUID, 'swap_body', 0, -30, 0)
-- end

-- local function OnDetached_1(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("地牌强化失效")
-- 		target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
-- 		target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
-- 		if inst._fx ~= nil then
-- 			inst._fx:Remove()
-- 			inst._fx = nil
-- 		end
-- 	end
-- 	inst:Remove()
-- end

-- local function OnTimerDone_1(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_dp1")
-- 		end
-- 	end
-- end

-- local function OnExtended_1(inst,target)
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 480)
-- end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------带特效的地2号---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- local function Tick1(inst)
-- 	if not inst:HasTag("playerghost") and inst.components.locomotor then
-- 		if inst.components.locomotor.wantstomoveforward then
-- 			local x, y, z = inst.Transform:GetWorldPosition()
-- 			SpawnPrefab(inst._ccsfxflag and "ccs_dripfx_purpleflower" or "ccs_dripfx_yellowflower").Transform:SetPosition(x, y, z)
-- 			if inst._ccsfxflag then
-- 				inst._ccsfxflag = false
-- 			else
-- 				inst._ccsfxflag = true
-- 			end
-- 		end
-- 	end
-- end
-- local function OnAttached_2(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
	
-- 	target.components.combat.externaldamagemultipliers:SetModifier("ccs_card_dp", 1.35)
-- 	target.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_dp", 0.65)
	
-- 	if target._fx ~= nil then
-- 		target._fx:Cancel()
-- 		target._fx = nil
-- 	end
		
-- 	target._fx = target:DoPeriodicTask(.25, Tick1)
-- 	if target._ccsbondlevel then
-- 		if not target._ccsbondlevel:value() then
-- 			target._ccsbondlevel:set(true)
-- 		else
-- 			target._ccsbondlevel:set(false)
-- 		end
-- 	end
-- 	target:DoTaskInTime(3, function()
-- 		if target and target:IsValid() and target._ccsbondlevel then
-- 			if not target._ccsbondlevel:value() then
-- 				target._ccsbondlevel:set(true)
-- 			else
-- 				target._ccsbondlevel:set(false)
-- 			end
-- 		end
-- 	end)
-- end

-- local function OnDetached_2(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("地牌强化失效")
-- 		target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
-- 		target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
-- 		if target._fx ~= nil then
-- 			target._fx:Cancel()
-- 			target._fx = nil
-- 		end
-- 	end
-- 	inst:Remove()
-- end

-- local function OnTimerDone_2(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_dp2")
-- 		end
-- 	end
-- end

-- local function OnExtended_2(inst,target)
-- 	if target._ccsbondlevel then
-- 		if not target._ccsbondlevel:value() then
-- 			target._ccsbondlevel:set(true)
-- 		else
-- 			target._ccsbondlevel:set(false)
-- 		end
-- 	end
-- 	target:DoTaskInTime(3, function()
-- 		if target and target:IsValid() and target._ccsbondlevel then
-- 			if not target._ccsbondlevel:value() then
-- 				target._ccsbondlevel:set(true)
-- 			else
-- 				target._ccsbondlevel:set(false)
-- 			end
-- 		end
-- 	end)
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 480)
-- end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------带特效的地3号---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- local function OnAttached_3(inst, target)
-- 	inst.entity:SetParent(target.entity)
-- 	inst.Transform:SetPosition(0, 0, 0) --in case of loading

-- 	target.components.combat.externaldamagemultipliers:SetModifier("ccs_card_dp", 1.35)
-- 	target.components.combat.externaldamagetakenmultipliers:SetModifier("ccs_card_dp", 0.65)

-- 	if inst._fx ~= nil then
-- 		inst._fx:Remove()
-- 		inst._fx = nil
-- 	end

-- 	inst._fx = SpawnPrefab("cane_candy_fx")
-- 	inst._fx.entity:AddFollower()
-- 	inst._fx.entity:SetParent(target.entity)
-- 	inst._fx.Follower:FollowSymbol(target.GUID, 'swap_body', 0, -30, 0)
-- end

-- local function OnDetached_3(inst)
-- 	local target = inst.entity:GetParent()
-- 	if target then
-- 		target.components.talker:Say("地牌强化失效")
-- 		target.components.combat.externaldamagemultipliers:RemoveModifier("ccs_card_dp")
-- 		target.components.combat.externaldamagetakenmultipliers:RemoveModifier("ccs_card_dp")
-- 		if inst._fx ~= nil then
-- 			inst._fx:Remove()
-- 			inst._fx = nil
-- 		end
-- 	end
-- 	inst:Remove()
-- end

-- local function OnTimerDone_3(inst, data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_dp3")
-- 		end
-- 	end
-- end

-- local function OnExtended_3(inst, target)
-- 	inst.components.timer:StopTimer("buffover")
-- 	inst.components.timer:StartTimer("buffover", 480)
-- end
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------冰---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- local function attacked(inst,data)
-- 	if data.attacker and data.attacker.components.freezable ~= nil then
-- 		data.attacker.components.freezable:AddColdness(99999, 480)
-- 	end
-- end

-- local function OnAttached2(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
	
-- 	target:ListenForEvent("attacked",attacked)	
-- end

-- local function OnDetached2(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("冰牌强化失效")
-- 		target:RemoveEventCallback("attacked",attacked)
-- 	end
-- 	inst:Remove()
-- end

-- local function OnTimerDone2(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_bp")
-- 		end
-- 	end
-- end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- ---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

-- --1级浮牌
-- local function OnAttached3(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
-- 	target.components.locomotor:SetExternalSpeedMultiplier(inst, "ccs_card_fp", 1.1)	
-- end

-- local function OnDetached3(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("浮牌强化失效")
-- 		target.components.locomotor:RemoveExternalSpeedMultiplier(target, "ccs_card_fp")
-- 	end
-- 	inst:Remove()
-- end

-- --2级浮牌
-- local function OnAttached4(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0) --in case of loading
-- 	target.components.locomotor:SetExternalSpeedMultiplier(inst, "ccs_card_fp", 1.1)	
-- 	if target.components.drownable then	--可以在水面行走
-- 		target.components.drownable.enabled = false
-- 	end
-- 	if inst._fx ~= nil then
-- 		inst._fx:kill_fx()
-- 	end
-- 	inst._fx = SpawnPrefab("forcefieldfx")
-- 	inst._fx.AnimState:SetBuild("ccs_shield_fx")
-- 	inst._fx.entity:SetParent(target.entity)
-- 	inst._fx.Transform:SetPosition(0, 0.2, 0)
-- 	inst._fx.AnimState:SetAddColour(0/255, 212/255, 255/255, 1 )
-- 	RemovePhysicsColliders(target)
-- end

-- local function OnDetached4(inst)
-- 	local target = inst.entity:GetParent()		
-- 	if target then
-- 		target.components.talker:Say("浮牌强化失效")
-- 		target.components.locomotor:RemoveExternalSpeedMultiplier(target, "ccs_card_fp")
-- 		if target.components.drownable then
-- 			target.components.drownable.enabled = true
-- 		end
-- 		ChangeToCharacterPhysics(target)
-- 	end
-- 	if inst._fx ~= nil then
-- 		inst._fx:kill_fx()
-- 		inst._fx = nil
-- 	end
-- 	inst:Remove()
-- end

-- --重复增加buff与倒计时结束
-- local function OnTimerDone_3_fp1(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_fp")
-- 		end
-- 	end
-- end

-- local function OnTimerDone3_fp2(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_fp2")
-- 		end
-- 	end
-- end

-- local function OnTimerDone3_fp3(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_fp3")
-- 		end
-- 	end
-- end

-- local function OnTimerDone3_fp4(inst,data)
-- 	if data.name == "buffover" then
-- 		local target = inst.entity:GetParent()	
-- 		if target then
-- 			target.components.debuffable:RemoveDebuff("ccs_card_fp4")
-- 		end
-- 	end
-- end


-- local function OnExtended_fp1(inst,target)
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 240)
-- end

-- local function OnExtended_fp3(inst,target)
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 480)
-- end

-- local function OnExtended_fp4(inst,target) 
--     inst.components.timer:StopTimer("buffover")
--     inst.components.timer:StartTimer("buffover", 960)
-- end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- ---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

-- local ccs_buffs = 
-- {
-- 	ccs_card_dp = 		
-- 	{
-- 		chname = "地牌强化",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended,	--设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone
-- 	},
-- 	ccs_card_dp1 = 		
-- 	{
-- 		chname = "地牌强化",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached_1, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached_1,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended_1,	--设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone_1
-- 	},
-- 	ccs_card_dp2 =
-- 	{
-- 		chname = "地牌强化",
-- 		tag = { "time" },
-- 		OnAttached = OnAttached_2, --设置附加Buff时执行的函数
-- 		OnDetached = OnDetached_2, --设置解除buff时执行的函数
-- 		OnExtended = OnExtended_2, --设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone_2
-- 	},
-- 	ccs_card_dp3 =
-- 	{
-- 		chname = "地牌强化",
-- 		tag = { "time" },
-- 		OnAttached = OnAttached_3, --设置附加Buff时执行的函数
-- 		OnDetached = OnDetached_3, --设置解除buff时执行的函数
-- 		OnExtended = OnExtended_3, --设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone_3
-- 	},

-- 	ccs_card_bp = 		
-- 	{
-- 		chname = "冰牌强化",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached2, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached2,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended,	--设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone2
-- 	},
-- 	ccs_card_fp1 = 		
-- 	{
-- 		chname = "浮牌强化-1级",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached3, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached3,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended_fp1,	--设置延长buff时执行的函数
-- 		time = 240,
-- 		OnTimerDone = OnTimerDone_3_fp1
-- 	},
-- 	ccs_card_fp2 = 		
-- 	{
-- 		chname = "浮牌强化-2级",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached4, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached4,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended_fp1,	--设置延长buff时执行的函数
-- 		time = 240,
-- 		OnTimerDone = OnTimerDone3_fp2
-- 	},
-- 	ccs_card_fp3 = 		
-- 	{
-- 		chname = "浮牌强化-3级",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached4, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached4,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended_fp3,	--设置延长buff时执行的函数
-- 		time = 480,
-- 		OnTimerDone = OnTimerDone3_fp3
-- 	},
-- 	ccs_card_fp4 = 		
-- 	{
-- 		chname = "浮牌强化-4级",
-- 		tag = {"time"},
-- 		OnAttached = OnAttached4, 	--设置附加Buff时执行的函数
-- 		OnDetached = OnDetached4,	--设置解除buff时执行的函数
-- 		OnExtended = OnExtended_fp4,	--设置延长buff时执行的函数
-- 		time = 960,
-- 		OnTimerDone = OnTimerDone3_fp4
-- 	},
-- }

-- for k, v in pairs(ccs_buffs) do
--     v.name = k
-- 	STRINGS.NAMES[string.upper(k)] = v.chname
-- end

-- return ccs_buffs