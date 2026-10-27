AddModRPCHandler("CCS", "CCS_SPEAL_MAGIC", function(player,boolen)
	if inst.components.playercontroller ~= nil then
		if boolen == true then
			inst.components.playercontroller:Enable(true)
		else
			inst.components.playercontroller:Enable(false)
		end
	end
end)

local skindata = {
    ccs_bow_skin_madoka = "magic_circle_madoko",
    ccs_magic_wand3_skins6 = "magic_circle_madoko",
    ccs_starstaff_skin1 = "magic_circle_madoko",
    ccs_sword_skins5 = "magic_circle_madoko",
    ccs_magic_wand3_skins5 = "magic_circle_madoko1",
    ccs_starstaff_skin_star = "magic_circle_star",
    ccs_magic_wand3_skins8 = "magic_circle_hudie",
    ccs_starstaff_skin2 = "magic_circle_hudie",
    ccs_starstaff_skin_skr = "magic_circle_skr",
    ccs_magic_wand3_skins10 = "magic_circle_skr",
    ccs_magic_wand3_skins11 = "magic_circle_huameng",
    ccs_starstaff_skin3 = "magic_circle_huameng",
    ccs_magic_wand3_skins12 = "magic_circle_xrzx",
    ccs_magic_wand3_skins13 = "magic_circle_dmxh",
    ccs_magic_wand3_skins7 = "magic_circle_hailuhua",
    ccs_starstaff_skin_blue = "magic_circle_hailuhua",
    ccs_magic_wand3_skins16 = "magic_circle_bs",
    ccs_magic_wand3_xdzz = "magic_circle_xdzz",
    ccs_magic_wand3_skin_xy = "magic_circle_lxy",
    ccs_magic_wand3_yueguitu = "ccs_magic_wand3_skin_xyfz",
    ccs_starstaff_skin_xdzz = "magic_circle_xdzz",
    ccs_bow_zwzj = "ccs_bow_skin_zwzj_fx",
    ccs_magic_wand3_skin_hyjl = "ccs_magic_wand3_skin_hyjl_cr",
    ccs_starstaff_skin_hyjl = "ccs_magic_wand3_skin_hyjl_cr",
    ccs_sword_skin_dieying = "magic_circle_dieying",
    ccs_magic_wand3_skin_yueguitu = "magic_circle_ygt",
    ccs_starstaff_skin_dll = "magic_circle_bh",
    ccs_magic_wand3_skin_xingyu = "magic_circle_xingyu",
    ccs_starstaff_skin_xingyu = "magic_circle_xingyu",
    ccs_magic_wand3_skin_xyym = "magic_circle_xyym",
    ccs_starstaff_skin_xyym = "magic_circle_xyym",
    ccs_starstaff_skin_hscs = "magic_circle_hscs",
    ccs_magic_wand3_skin_hscs = "magic_circle_hscs",
    ccs_magic_wand3_skins9 = "magic_circle_bh",
    ccs_magic_wand3_chenxingyuyue = "magic_circle_chenxingyuyue",
    ccs_starstaff_skin_pingguo = "magic_circle_pingguo",
}

AddStategraphState("wilson",
    State {
        name = "ccs_seal_magic",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)

			inst.components.health:SetInvincible(true)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end

            inst:AddTag("css_nodrown")
            
            inst.AnimState:SetDeltaTimeMultiplier(0.5)
            inst.AnimState:PlayAnimation("ccs_spell_pre",true)
            inst.AnimState:OverrideSymbol("card_fx", "ccs_spell_anim", "card_fx")
           

            inst.components.locomotor:Stop()

            local staff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local colour = staff ~= nil and staff.fxcolour or { 1, 1, 1 }

            inst.sg.statemem.stafffx = SpawnPrefab(inst.components.rider:IsRiding() and "staffcastfx_mount" or
            "staffcastfx")
            inst.sg.statemem.stafffx.entity:SetParent(inst.entity)
            inst.sg.statemem.stafffx:SetUp(colour)

            inst.sg.statemem.stafflight = SpawnPrefab("staff_castinglight")
            inst.sg.statemem.stafflight.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst.sg.statemem.stafflight:SetUp(colour, 1.9, .33)

            if staff ~= nil then
                inst.sg.statemem.castsound = staff.skin_castsound or staff.castsound or "dontstarve/wilson/use_gemstaff"
            else
                inst.sg.statemem.castsound = "dontstarve/wilson/use_gemstaff"
            end
            if staff then
                local build = staff.AnimState:GetBuild()
                local skin_build = staff:GetSkinBuild()
                if skin_build and skin_build == "ccs_magic_wand3_skins7" then
                    inst.sg.statemem.magic_Fx = SpawnPrefab("magic_circle_hailuhua")
                elseif skin_build and skin_build == "ccs_magic_wand3_skins10" then
                    inst.sg.statemem.magic_Fx = SpawnPrefab("magic_circle_skr")
                elseif skin_build and skin_build == "ccs_magic_wand3_yueguitu" then
                    inst.sg.statemem.magic_Fx = SpawnPrefab("ccs_magic_wand3_xyfz")
                elseif skin_build and skin_build == "ccs_magic_wand3_xy" then
                    inst.sg.statemem.magic_Fx = SpawnPrefab("ccs_magic_wand3_xyfz")
                elseif build and skindata[build] then
                    inst.sg.statemem.magic_Fx = SpawnPrefab(skindata[build])
                else
                    inst.sg.statemem.magic_Fx = SpawnPrefab("ccs_fx1")
                end
            end
            if inst.sg.statemem.magic_Fx == nil then
                inst.sg.statemem.magic_Fx = SpawnPrefab("ccs_fx1")
            end
            if inst.sg.statemem.magic_Fx.AnimState then
                inst.sg.statemem.magic_Fx.AnimState:SetSortOrder(-1)
            end
            inst.sg.statemem.magic_Fx.Transform:SetPosition(inst.Transform:GetWorldPosition())

            inst.sg:SetTimeout(3 * FRAMES)

        end,

        timeline =
        {
            TimeEvent(1 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound(inst.sg.statemem.castsound)
            end),
            TimeEvent(2 * FRAMES, function(inst)
                if inst.sg.statemem.targetfx ~= nil then
                    if inst.sg.statemem.targetfx:IsValid() then
                        OnRemoveCleanupTargetFX(inst)
                    end
                    inst.sg.statemem.targetfx = nil
                end
                inst.sg.statemem.stafffx = nil 
                inst.sg.statemem.stafflight = nil 
                inst:PerformBufferedAction()
            end),
            TimeEvent(1.1, function(inst)
                inst.AnimState:Pause()
            end),
            TimeEvent(3, function(inst)
                inst.AnimState:Resume() 
                inst.sg:GoToState("idle")
            end),
        },

        events =
        {
			--[[EventHandler("attacked", function(inst)
				inst.sg:GoToState("idle")
			end),--]]
        },

        onexit = function(inst)
			inst.components.health:SetInvincible(false)
            inst:RemoveTag("css_nodrown")
			inst.AnimState:Resume() 
            inst.AnimState:SetDeltaTimeMultiplier(1)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            if inst.sg.statemem.stafffx ~= nil and inst.sg.statemem.stafffx:IsValid() then
                inst.sg.statemem.stafffx:Remove()
            end
            if inst.sg.statemem.stafflight ~= nil and inst.sg.statemem.stafflight:IsValid() then
                inst.sg.statemem.stafflight:Remove()
            end
            if inst.sg.statemem.magic_Fx ~= nil and inst.sg.statemem.magic_Fx:IsValid() then
                inst.sg.statemem.magic_Fx:Remove()
            end
        end,
    }
)

AddStategraphState("wilson_client",
    State {
        name = "ccs_seal_magic",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:SetDeltaTimeMultiplier(.5)
            inst.AnimState:PlayAnimation("ccs_spell_pre",true)
            inst.AnimState:OverrideSymbol("card_fx", "ccs_spell_anim", "card_fx")

            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(3.1)
        end,

        --[[onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,--]]
		timeline =
        {
            TimeEvent(1.1, function(inst)
                inst.AnimState:Pause()
            end),
            TimeEvent(3, function(inst)
                inst.AnimState:Resume()
                inst.sg:GoToState("idle")
            end),
        },

        ontimeout = function(inst)
            inst:ClearBufferedAction()
			inst.AnimState:Resume()
            inst.sg:GoToState("idle")
        end,
    }
)

--弓
AddStategraphPostInit("wilson", function(sg)   
    local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
    sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action,...)
        local weapon = inst.components.combat:GetWeapon()
        if weapon then 
            if weapon:HasTag("ccs_bow") then     
                return "ccs_shoot"
            end
        end 
        return old_ATTACK(inst, action,...)
    end
	
end)

AddStategraphPostInit("wilson_client", function(sg)    
    local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
    sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action,...)
        local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon  then 
            if weapon:HasTag("ccs_bow") then       --
                return "ccs_shoot"
            end
        end 
        return old_ATTACK(inst, action,...)
    end
end)


AddStategraphState("wilson",State{
    name = "ccs_shoot",
    tags = {"attack"},

    onenter = function(inst)
        if inst.components.combat:InCooldown() then
            inst.sg:RemoveStateTag("abouttoattack")
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle", true)
            return
        end
        local buffaction = inst:GetBufferedAction()
        local target = buffaction ~= nil and buffaction.target or nil
        if target ~= nil and target:IsValid() then
            inst:ForceFacePoint(target.Transform:GetWorldPosition())
            inst.sg.statemem.attacktarget = target -- this is to allow repeat shooting at the same target
        end

        inst.sg.statemem.abouttoattack = true
        --inst.AnimState:PlayAnimation("slingshot_pre")
        inst.AnimState:PlayAnimation("slingshot")

        --if inst.sg.laststate == inst.sg.currentstate then
            inst.sg.statemem.chained = true
            --inst.AnimState:SetTime(3 * FRAMES)
        --end

        inst.components.combat:StartAttack()
        inst.components.combat:SetTarget(target)
        inst.components.locomotor:Stop()

        inst.sg:SetTimeout((inst.sg.statemem.chained and 15) * FRAMES)
    end,

    timeline =
    {
        TimeEvent(6 * FRAMES, function(inst)
            if inst.sg.statemem.chained then
                local buffaction = inst:GetBufferedAction()
                local target = buffaction ~= nil and buffaction.target or nil
                if not (target ~= nil and target:IsValid() and inst.components.combat:CanTarget(target)) then
                    inst:ClearBufferedAction()
                    inst.sg:GoToState("idle")
                end
            end
        end),

        TimeEvent(7 * FRAMES, function(inst) -- start of slingshot
            if inst.sg.statemem.chained then
                inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/stretch")
            end
        end),

        TimeEvent(8 * FRAMES, function(inst)
            if inst.sg.statemem.chained then
                local buffaction = inst:GetBufferedAction()
                local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if equip ~= nil and equip.components.weapon ~= nil and equip.components.weapon.projectile ~= nil then
                    local target = buffaction ~= nil and buffaction.target or nil
                    if target ~= nil and target:IsValid() and inst.components.combat:CanTarget(target) then
                        inst.sg.statemem.abouttoattack = false
                        inst:PerformBufferedAction()
                        local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                        if weapon and weapon:HasTag("ccs_bow") then
                            ---这里插入可以播放的音乐                            
                            inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/shoot")
                        end
                    else
                        inst:ClearBufferedAction()
                        inst.sg:GoToState("idle")
                    end
                else -- out of ammo
                    inst:ClearBufferedAction()
                    inst.components.talker:Say("箭矢不足无法攻击")
                    inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/no_ammo")
                end
            end
        end),
    },

    ontimeout = function(inst)
        inst.sg:RemoveStateTag("attack")
        inst.sg:AddStateTag("idle")
    end,

    events =
    {
        EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.components.combat:SetTarget(nil)
        if inst.sg.statemem.abouttoattack and inst.replica.combat ~= nil then
            inst.replica.combat:CancelAttack()
        end
    end,
})

AddStategraphState("wilson_client", State{
    name = "ccs_shoot",
    tags = { "attack"},

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("slingshot")
        --inst.AnimState:PlayAnimation("slingshot_pre")
        --inst.AnimState:PushAnimation("slingshot_lag", true)

        --if inst.sg.laststate == inst.sg.currentstate then
            inst.sg.statemem.chained = true
            --inst.AnimState:SetTime(3 * FRAMES)
        --end

        local buffaction = inst:GetBufferedAction()
        if buffaction ~= nil then
            if buffaction.target ~= nil and buffaction.target:IsValid() then
                inst:ForceFacePoint(buffaction.target:GetPosition())
                inst.sg.statemem.attacktarget = buffaction.target -- this is to allow repeat shooting at the same target
            end

            inst:PerformPreviewBufferedAction()
        end

        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst.sg.timeinstate >= (inst.sg.statemem.chained and 6)*FRAMES and inst.sg.statemem.flattened_time == nil and inst:HasTag("attack") then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg.statemem.flattened_time = inst.sg.timeinstate
                inst.sg:AddStateTag("idle")
                inst.sg:AddStateTag("canrotate")
                inst.entity:SetIsPredictingMovement(false) -- so the animation will come across
            end
        end

        if inst.bufferedaction == nil and inst.sg.statemem.flattened_time ~= nil and inst.sg.statemem.flattened_time < inst.sg.timeinstate then
            inst.sg.statemem.flattened_time = nil
            inst.entity:SetIsPredictingMovement(true)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.flattened_time ~= nil then
            inst.entity:SetIsPredictingMovement(true)
        end
    end,
})

AddStategraphState("wilson",State{

    name = "ccs_shipwrecked_portal_mounted",
    tags = {"busy", "pausepredict"},
    onenter = function(inst)
        inst.AnimState:PlayAnimation("dismount")
        inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
    end,

    events =
    {
        EventHandler("animover", function(inst)
            inst.components.rider:ActualDismount()
            inst.sg:GoToState("ccs_portal_shipwrecked_pre")
        end ),
    }
})

AddStategraphState("wilson",State{
    name = "ccs_shipwrecked_portal_pre",
    tags = {"doing","busy", "pausepredict"},

    onenter = function(inst)
        inst.AnimState:PlayAnimation("idle_loop")
        -- inst.sg:AddStateTag("temp_invincible")

        local ccs_shipwrecked = inst.ccs_shipwrecked
        inst.sg.statemem.onremoveshipwrecked = function()
            inst.sg.statemem.target = nil
            inst.sg:GoToState("idle", true)
        end
        inst:ListenForEvent("onremove", inst.sg.statemem.onremoveshipwrecked, ccs_shipwrecked)
        inst.sg:SetTimeout(3.5)
    end,

    timeline =
    {

        -- TimeEvent(30*FRAMES, function(inst)
        --     inst.DynamicShadow:Enable(false)
        -- end),
        TimeEvent(30*FRAMES, function(inst)
            inst.AnimState:PlayAnimation("jump")
            -- local portal = SpawnPrefab("wormhole_shipwrecked_fx")
            -- portal.Transform:SetPosition((inst:GetPosition() - (TheCamera:GetDownVec() * 0.1)):Get())
        end),
    },

    onexit = function(inst)
        inst.sg:RemoveStateTag("busy")
        local ccs_shipwrecked = inst.ccs_shipwrecked
        if ccs_shipwrecked ~= nil and ccs_shipwrecked:IsValid() then
            inst:RemoveEventCallback("onremove", inst.sg.statemem.onremoveshipwrecked, ccs_shipwrecked)
        end
    end,

    ontimeout = function(inst)
        inst.sg:GoToState("ccs_shipwrecked_portal_loop")
    end,
})

AddStategraphState("wilson",State{
    name = "ccs_shipwrecked_portal_loop",
    tags = {"canrotate", "pausepredict", "busy"},

    onenter = function(inst)

        -- inst.sg:AddStateTag("temp_invincible")
        inst.AnimState:AddOverrideBuild("ccs_portal_shipwrecked")
        inst.AnimState:PlayAnimation("shipwrecked_portal_pre")
        inst.AnimState:PushAnimation("shipwrecked_portal_loop", true)

        -- local target = GetClosestInstWithTag("ccs_shipwrecked", inst, 5)
        
        inst.sg.statemem.target = inst.ccs_shipwrecked

        inst.sg.statemem.target:Hide()
        ChangeToInventoryPhysics(inst.sg.statemem.target)
        inst.Transform:SetPosition(inst.sg.statemem.target:GetPosition():Get())

        local facepoint = (inst.sg.statemem.target:GetPosition() + TheCamera:GetRightVec())
        inst:ForceFacePoint(facepoint:Get())

        if inst.sg.statemem.onremoveshipwrecked == nil then
            inst.sg.statemem.onremoveshipwrecked = function()
                inst.sg.statemem.target = nil
                inst.sg:GoToState("idle", true)
            end
            inst:ListenForEvent("onremove", inst.sg.statemem.onremoveshipwrecked, inst.sg.statemem.target)
        end


        -- inst.SoundEmitter:PlaySound("ia/common/portal/sit")
        --     -- if false then
        -- inst.SoundEmitter:PlaySound("ia/common/portal/ride_LP", "ride_lp")

        -- inst.SoundEmitter:PlaySound("ia/common/portal/music_LP", "music_lp")
        --     -- if true then
        -- inst.SoundEmitter:PlaySound("ia/common/crafted/skyworthy/LP", "ride_lp")
    end,
    timeline =
    {
        TimeEvent(.2, function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("pausepredict")
            -- inst:PerformBufferedAction()
        end),
    },

    events =
		{
			EventHandler("locomote", function(inst, data)
				if data ~= nil and data.remoteoverridelocomote or inst.components.locomotor:WantsToMoveForward() then
					inst.sg:GoToState("idle", true)
				end
				return true
			end),

		},

    onexit = function(inst)

        -- ChangeToObstaclePhysics(inst.sg.statemem.target)
        -- inst.SoundEmitter:KillSound("music_lp")
        -- inst.SoundEmitter:KillSound("ride_lp")
        if inst.sg.statemem.target then
            inst.sg.statemem.target:Show()
            inst.sg.statemem.target:RemoveTag("ccsusing")
            if inst.sg.statemem.target.components.workable then
                inst.sg.statemem.target.components.workable:SetWorkable(true)
            end
            inst:RemoveEventCallback("onremove", inst.sg.statemem.onremoveshipwrecked, inst.sg.statemem.target)
            inst.sg.statemem.target = nil
        end
    end,
})


local brc_sitswing = GLOBAL.State {
    name = "brc_sitswing",
    tags = { "busy", "pausepredict" },
    --sg执行
    onenter = function(inst, data)
        local buffaction = inst:GetBufferedAction()
        local target = buffaction ~= nil and buffaction.target or nil

        if target ~= nil then
            if target.prefab == "brc_swing" then
                target.AnimState:SetBank("brc_swing_fast")
                target.AnimState:PlayAnimation("shake",true)
                target.AnimState:SetFrame(math.floor(inst.AnimState:GetCurrentAnimationNumFrames() / 5))
                target.passenger = inst
                target:AddTag("isusing")
                if inst.Follower then
                    inst.Follower:FollowSymbol(target.GUID, "zuowei", 0, 0, 0, true)
                    inst.Follower:FollowSymbol(target.GUID, "zuowei", 0, -50, 0, true)
                    -- inst.Follower:FollowSymbol(target.GUID, "zuowei", 0, 0, 0, true)
                    inst.swingprefab = target
                end
                inst:AddTag("sit_onswing")
                inst.Physics:SetActive(false)
                -----------------------------------------------------------------------------------
                inst.AnimState:PlayAnimation("brc_sit2_loop", true)
                -----------------------------------------------------------------------------------
            elseif target.prefab == "brc_swing_double" then
                if not target.AnimState:IsCurrentAnimation("shake") then
                    target.AnimState:PlayAnimation("shake",true)
                end
                target.AnimState:SetFrame(math.floor(inst.AnimState:GetCurrentAnimationNumFrames() / 5))
                if target.passengerA then
                    target.passengerB = inst
                    if inst.Follower then
                        inst.Follower:FollowSymbol(target.GUID, "qiuqian_zuo", 0, 0, 0, true)
                        inst.Follower:FollowSymbol(target.GUID, "qiuqian_zuo", 100, -50, 0, true)
                    end
                else
                    target.passengerA = inst
                    if inst.Follower then
                        inst.Follower:FollowSymbol(target.GUID, "qiuqian_zuo", 0, 0, 0, true)
                        inst.Follower:FollowSymbol(target.GUID, "qiuqian_zuo", -100, -50, 0, true)
                    end
                end
                inst.swingprefab = target
                inst:AddTag("sit_onswing")
                inst.Physics:SetActive(false)
                -----------------------------------------------------------------------------------
                inst.AnimState:PlayAnimation("brc_sit2_loop", true)
                -----------------------------------------------------------------------------------
            end
        end
    end,
    --sg结束
    timeline =
    {
        TimeEvent(.2, function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("pausepredict")
            inst:PerformBufferedAction()
        end),
    },

    events =
    {
        EventHandler("onremove", function(inst)
            if inst.swingprefab then
                inst.swingprefab.isusing = false
                inst.swingprefab = nil
            end

            if inst.Follower then
                inst.Follower:StopFollowing()
            end
        end),
    },

    onexit = function(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        inst:RemoveTag("sit_onswing")

        if inst.Physics then
            inst.Physics:SetActive(true)
            inst.Physics:Teleport(x, 0, z)
        end

        if inst.swingprefab and inst.swingprefab:IsValid() then
            if inst.swingprefab.prefab == "brc_swing" then
                inst.swingprefab.AnimState:SetBank("brc_swing")
                inst.swingprefab.AnimState:PlayAnimation("idle",true)
                inst.swingprefab:RemoveTag("isusing")
                inst.swingprefab.passenger = nil
            elseif inst.swingprefab.prefab == "brc_swing_double" then
                if inst.swingprefab.passengerA == inst then
                    inst.swingprefab.passengerA = nil
                end
                if inst.swingprefab.passengerB == inst then
                    inst.swingprefab.passengerB = nil
                end
                if inst.swingprefab.passengerA == nil and inst.swingprefab.passengerB == nil and not inst.swingprefab.AnimState:IsCurrentAnimation("idle") then
                    inst.swingprefab.AnimState:PlayAnimation("idle",true)
                end
            end
            inst.swingprefab = nil
        end

        if inst.Follower then
            inst.Follower:StopFollowing()
        end
    end,
}
--加入sg
AddStategraphState("wilson", brc_sitswing)
AddStategraphState("wilson_client", brc_sitswing)

local brc_sit_pre = State {
    name = "brc_sit_pre",
    tags = { "doing", "busy", "pausepredict", "nomorph", "nodangle" },
    onenter = function(inst)
        inst.sg:SetTimeout(0.75)
        inst.components.locomotor:Stop()
        if inst.bufferedaction ~= nil then
            inst.sg.statemem.action = inst.bufferedaction
            if inst.bufferedaction.action.actionmeter then
                inst.sg.statemem.actionmeter = true
                StartActionMeter(inst, 2)
            end
            if inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                inst.bufferedaction.target:PushEvent("startlongaction", inst)
            end
        end
    end,
    timeline = {
        TimeEvent(
            FRAMES,
            function(inst)
                inst.AnimState:PlayAnimation("brc_sit_pre", false)
                inst.AnimState:PushAnimation("brc_sit_jump", false)
                inst.AnimState:PushAnimation("brc_sit_loop_pre", false)
            end
        ),
    },
    ontimeout = function(inst)
        if inst.sg.statemem.actionmeter then
            inst.sg.statemem.actionmeter = nil
            StopActionMeter(inst, true)
        end
        inst.sg:RemoveStateTag("busy")
        inst:PerformBufferedAction()
    end,
    onexit = function(inst)
        if inst.sg.statemem.actionmeter then
            StopActionMeter(inst, false)
        end
        if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
            inst:ClearBufferedAction()
        end
    end
}

AddStategraphState("wilson", brc_sit_pre)
AddStategraphState("wilson_client", brc_sit_pre)


local brc_hotspring = GLOBAL.State {
    name = "brc_hotspring",
    tags = { "busy", "pausepredict" },
    --sg执行
    onenter = function(inst, data)
        local buffaction = inst:GetBufferedAction()
        local target = buffaction ~= nil and buffaction.target or nil

        if target ~= nil then
            if target.prefab == "brc_hotspring" then
                target.passenger = inst
                target:AddTag("isusing")
                local x, y, z = target.Transform:GetWorldPosition()
                inst.hotspringprefab = target
                if inst.Physics then
                    inst.Physics:SetActive(false)
                    inst.Physics:Teleport(x, 0, z)
                end
                -----------------------------------------------------------------------------------
                inst.AnimState:PlayAnimation("wenquan_idle", true)
                -----------------------------------------------------------------------------------
            end
        end
    end,
    --sg结束
    timeline =
    {
        TimeEvent(.2, function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("pausepredict")
            inst:PerformBufferedAction()
        end),
    },

    events =
    {
        EventHandler("onremove", function(inst)
            if inst.hotspringprefab then
                inst.hotspringprefab:RemoveTag("isusing")
                inst.hotspringprefab = nil
            end
        end),
    },

    onupdate = function(inst, dt)
        if GLOBAL.TheNet:GetIsServer() then
            if inst.components.health then
                inst.components.health:DoDelta(dt, true)
            end
            if inst.components.sanity then
                inst.components.sanity:DoDelta(dt, true)
            end
            if inst.components.hunger then
                inst.components.hunger:DoDelta(dt, true)
            end
        end
    end,

    onexit = function(inst)
        local x, y, z = inst.Transform:GetWorldPosition()

        if inst.Physics then
            inst.Physics:SetActive(true)
            inst.Physics:Teleport(x, 0, z)
        end

        if inst.hotspringprefab and inst.hotspringprefab:IsValid() then
            inst.hotspringprefab.passenger = nil
            inst.hotspringprefab:RemoveTag("isusing")
            inst.hotspringprefab = nil
        end
    end,
}
--加入sg
AddStategraphState("wilson", brc_hotspring)
AddStategraphState("wilson_client", brc_hotspring)


--- 荡秋千
local SITSWING = Action({ priority = 2, encumbered_valid = true })
SITSWING.id = "SITSWING"
SITSWING.str = "坐上"
SITSWING.fn = function(act)
    if act.doer and act.target then
        if act.target == "brc_swing" and act.target:HasTag("isusing") then
            if act.doer.components.talker then
                act.doer.components.talker:Say("秋千已经坐满了，挤不下惹")
            end
            return true
        elseif act.target == "brc_swing_double" and act.target.passengerA and act.passengerB then
            if act.doer.components.talker then
                act.doer.components.talker:Say("秋千已经坐满了，挤不下惹")
            end
            return true
        end
        act.doer.sg:GoToState("brc_sitswing")
        return true
    end
end

AddAction(SITSWING)

AddComponentAction("SCENE", "brc_swing", function(inst, doer, actions, right)
    if inst.prefab == "brc_swing" and not inst:HasTag("isusing") then
        table.insert(actions, ACTIONS.SITSWING)
    elseif inst.prefab == "brc_swing_double" then
        table.insert(actions, ACTIONS.SITSWING)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.SITSWING, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.SITSWING, "give"))


--- 泡温泉
local HOTSPRING = Action({ priority = 2, encumbered_valid = true })
HOTSPRING.id = "HOTSPRING"
HOTSPRING.str = "泡温泉"
HOTSPRING.fn = function(act)
    if act.doer and act.target then
        if act.target == "brc_swing" and act.target:HasTag("isusing") then
            if act.doer.components.talker then
                act.doer.components.talker:Say("温泉已经满了，挤不下惹")
            end
            return true
        end
        act.doer.sg:GoToState("brc_hotspring")
        return true
    end
end

AddAction(HOTSPRING)

AddComponentAction("SCENE", "brc_hotspring", function(inst, doer, actions, right)
    if not inst:HasTag("isusing") then
        table.insert(actions, ACTIONS.HOTSPRING)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.HOTSPRING, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.HOTSPRING, "give"))


-- 旧版灵魂跳跃sg
local function DoWortoxPortalTint(inst, val)
    if val > 0 then
        inst.components.colouradder:PushColour("portaltint", 154 / 255 * val, 23 / 255 * val, 19 / 255 * val, 0)
        val = 1 - val
        inst.AnimState:SetMultColour(val, val, val, 1)
    else
        inst.components.colouradder:PopColour("portaltint")
        inst.AnimState:SetMultColour(1, 1, 1, 1)
    end
end
AddStategraphState("wilson",State{
    name = "ccs_portal_jumpin",
    tags = { "busy", "pausepredict", "nodangle", "nomorph" },

    onenter = function(inst, data)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wortox_portal_jumpin")
        local x, y, z = inst.Transform:GetWorldPosition()
        SpawnPrefab("wortox_portal_jumpin_fx").Transform:SetPosition(x, y, z)
        inst.sg:SetTimeout(11 * FRAMES)
        inst.sg.statemem.from_map = data and data.from_map or nil
        local dest = data and data.dest or nil
        if dest ~= nil then
            inst.sg.statemem.dest = dest
            inst:ForceFacePoint(dest:Get())
        else
            inst.sg.statemem.dest = Vector3(x, y, z)
        end

        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:RemotePausePrediction()
        end
    end,

    onupdate = function(inst)
        if inst.sg.statemem.tints ~= nil then
            DoWortoxPortalTint(inst, table.remove(inst.sg.statemem.tints))
            if #inst.sg.statemem.tints <= 0 then
                inst.sg.statemem.tints = nil
            end
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/infection_post", nil, .7)
            inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
        end),
        TimeEvent(2 * FRAMES, function(inst)
            inst.sg.statemem.tints = { 1, .6, .3, .1 }
            PlayFootstep(inst)
        end),
        TimeEvent(4 * FRAMES, function(inst)
            inst.sg:AddStateTag("noattack")
            inst.components.health:SetInvincible(true)
            inst.DynamicShadow:Enable(false)
        end),
    },

    ontimeout = function(inst)
        inst.sg.statemem.portaljumping = true
        inst.sg:GoToState("portal_jumpout", {dest = inst.sg.statemem.dest, from_map = inst.sg.statemem.from_map})
    end,

    onexit = function(inst)
        if not inst.sg.statemem.portaljumping then
            inst.components.health:SetInvincible(false)
            inst.DynamicShadow:Enable(true)
            DoWortoxPortalTint(inst, 0)
        end
    end,
})

AddStategraphState("wilson",State{
    name = "ccs_portal_jumpout",
    tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },

    onenter = function(inst, data)
        ToggleOffPhysics(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wortox_portal_jumpout")
        inst:ResetMinimapOffset()
        if data and data.from_map then
            inst:SnapCamera()
        end
        local dest = data and data.dest or nil
        if dest ~= nil then
            inst.Physics:Teleport(dest:Get())
        else
            dest = inst:GetPosition()
        end
        SpawnPrefab("wortox_portal_jumpout_fx").Transform:SetPosition(dest:Get())
        inst.DynamicShadow:Enable(false)
        inst.sg:SetTimeout(14 * FRAMES)
        DoWortoxPortalTint(inst, 1)
        inst.components.health:SetInvincible(true)
        inst:PushEvent("soulhop")
    end,

    onupdate = function(inst)
        if inst.sg.statemem.tints ~= nil then
            DoWortoxPortalTint(inst, table.remove(inst.sg.statemem.tints))
            if #inst.sg.statemem.tints <= 0 then
                inst.sg.statemem.tints = nil
            end
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/hop_out") end),
        TimeEvent(5 * FRAMES, function(inst)
            inst.sg.statemem.tints = { 0, .4, .7, .9 }
        end),
        TimeEvent(7 * FRAMES, function(inst)
            inst.components.health:SetInvincible(false)
            inst.sg:RemoveStateTag("noattack")
            inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
        end),
        TimeEvent(8 * FRAMES, function(inst)
            inst.DynamicShadow:Enable(true)
            ToggleOnPhysics(inst)
        end),
    },

    ontimeout = function(inst)
        inst.sg:GoToState("idle", true)
    end,

    onexit = function(inst)
        inst.components.health:SetInvincible(false)
        inst.DynamicShadow:Enable(true)
        DoWortoxPortalTint(inst, 0)
        if inst.sg.statemem.isphysicstoggle then
            ToggleOnPhysics(inst)
        end
    end,
})

AddStategraphState("wilson_client", State{
    name = "ccs_portal_jumpin_pre",
    tags = { "busy" },
    server_states = { "ccs_portal_jumpin_pre", "ccs_portal_jumpin" },

    onenter = function(inst)
        inst.components.locomotor:Stop()

        inst.AnimState:PlayAnimation("wortox_portal_jumpin_pre")
        inst.AnimState:PushAnimation("wortox_portal_jumpin_lag", false)

        local buffaction = inst:GetBufferedAction()
        if buffaction ~= nil then
            inst:PerformPreviewBufferedAction()

            if buffaction.pos ~= nil then
                inst:ForceFacePoint(buffaction:GetActionPoint():Get())
            end
        end

        inst.sg:SetTimeout(TIMEOUT)
    end,

    onupdate = function(inst)
        if inst.sg:ServerStateMatches() then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
})
