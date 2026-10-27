local CCSUTL = require("utils/ccs_wanly_utils")
local upvaluehelper = require("utils/ccsupvaluehelper")

--不打滑
AddStategraphPostInit("wilson", function(sg)
    CCSUTL.ttlFnDecorator(sg.events["feetslipped"], "fn", function(inst)
        return nil,inst.components.ccs_flying and inst.components.ccs_flying.isfly 
    end)
end)

--不落水
AddComponentPostInit("drownable", function(self)
    local oldShouldX_InternalCheck = self.ShouldX_InternalCheck
	self.ShouldX_InternalCheck=function(self, ...)
		if self.inst:HasTag('css_nodrown') or self.inst:HasTag('css_nodrown_box') or self.inst.ccs_no_drown then
            return false
        end
		return oldShouldX_InternalCheck and oldShouldX_InternalCheck(self, ...)
	end
end)

--隐身
AddComponentPostInit("combat", function(self)
    local old_ttSetRetargetFunction = self.SetRetargetFunction
    function self:SetRetargetFunction(...)
        old_ttSetRetargetFunction(self, ...)
        if self.targetfn ~= nil then
            local old_targetfn = self.targetfn
            self.targetfn = function(...)
                local newtarget, forcechange = old_targetfn(...)
                if newtarget then
                    if newtarget:HasTag("css_yinsheng") then
                        newtarget = nil
                    end
                end
                return newtarget, forcechange
            end
        end
    end

    local old_ttShareTarget = self.ShareTarget
    function self:ShareTarget(target, ...)
        if target and target:HasTag("css_yinsheng") then
            return
        end
        old_ttShareTarget(self, target, ...)
    end
end)


-- local PICKUP_fn_old = ACTIONS.PICKUP.fn
-- ACTIONS.PICKUP.fn = function(act)
--     if act.invobject == nil and act.target ~= nil and act.doer and act.doer:HasTag("ccs_isfly") then
--         print("1111111")
--         if act.target.prefab == "goldnugget" then 
--             act.target:Remove()
--             print("2222222")
--             return true
--         end
--     end
--     return PICKUP_fn_old(act)
-- end


local ToggleOnPhysics = nil
AddStategraphPostInit("wilson", function(sg)
    if ToggleOnPhysics == nil then
		if sg.states.jumpout then
			local oldonexit = sg.states.jumpout.onexit
			if oldonexit ~= nil then
				ToggleOnPhysics = upvaluehelper.Get(oldonexit, "ToggleOnPhysics")
				if ToggleOnPhysics ~= nil then
					upvaluehelper.Set(oldonexit,"ToggleOnPhysics",function(inst)
						ToggleOnPhysics(inst)
						if inst and (inst.ccs_no_drown or inst:HasTag('css_nodrown') or inst:HasTag('css_nodrown_box') ) then
							CCSUTL.ttlSetTreadWaterCollides(inst,true)
						end
					end)
				end
			end
		end
	end
end)

local function CanAccess(inst, doer)
    local comp = inst.components.ccs_items or inst.replica.ccs_items
    if comp ~= nil then
        return comp:IsAllowed(doer)
    end
    return true 
end


AddComponentPostInit("container", function(self)
    local old_Open = self.Open
    function self:Open(doer, ...)
        if doer ~= nil and not CanAccess(self.inst, doer) then
            return false
        end
        return old_Open(self, doer, ...)
    end
end)

AddClassPostConstruct("components/container_replica", function(self)
    local old_CanBeOpened = self.CanBeOpened
    function self:CanBeOpened(...)
        if ThePlayer ~= nil and not CanAccess(self.inst, ThePlayer) then
            return false
        end
        return old_CanBeOpened(self, ...)
    end
end)


local function GetCOMPONENT_ACTIONS()
    local fn = EntityScript.CollectActions
    for i = 1, math.huge do
        local name, value = debug.getupvalue(fn, i)
        if not name then break end
        if name == "COMPONENT_ACTIONS" and type(value) == "table" then
            return value
        end
    end
end

AddGamePostInit(function()
    local COMPONENT_ACTIONS = GetCOMPONENT_ACTIONS()
    if not COMPONENT_ACTIONS then return end

    local old_container = COMPONENT_ACTIONS.SCENE.container
    if old_container then
        COMPONENT_ACTIONS.SCENE.container = function(inst, doer, actions, right)
            if not CanAccess(inst, doer) then
                return
            end
            return old_container(inst, doer, actions, right)
        end
    end
end)


AddComponentPostInit('combat', function(self, inst)
    -- 获取人物当前倍率
    function self:GetCompleteAttackerMultiplier_ccs(attacker, target, weapon, multiplier)
        if attacker == nil or attacker.components.combat == nil then
            return 1
        end

        local combat = attacker.components.combat

        -- 基础倍率
        local mult1 = combat.damagemultiplier or 1

        -- 外部倍率
        local mult2 = 1
        if combat.externaldamagemultipliers ~= nil then
            mult2 = combat.externaldamagemultipliers:Get() or 1
        end

        -- 伤害类型倍率
        local mult3 = 1
        if attacker.components.damagetypesbonus ~= nil and target ~= nil then
            mult3 = attacker.components.damagetypesbonus:GetBonus(target) or 1
        end

        -- 玩家伤害百分比
        local mult4 = 1
        if target ~= nil and (target.isplayer or target:HasTag("player_damagescale")) then
            mult4 = combat.playerdamagepercent or 1
        end

        -- PVP伤害修正
        local mult5 = 1
        if attacker.isplayer and target ~= nil and target.isplayer then
            mult5 = combat.pvp_damagemod or 1
        end

        -- 自定义倍率函数
        local mult6 = 1
        if combat.customdamagemultfn ~= nil then
            local mount = nil
            if attacker.components.rider ~= nil and attacker.components.rider:IsRiding() then
                mount = attacker.components.rider:GetMount()
            end
            mult6 = combat.customdamagemultfn(attacker, target, weapon, multiplier, mount) or 1
        end

        -- 7. 通过hh_player组件获取伤害加成的值
        local mult7 = 1
        if attacker.components.hh_player ~= nil then
            local damage_percent_bonus = attacker.components.hh_player:GetEffectValueByKey("addComDamagePercent")
            if damage_percent_bonus ~= nil then
                mult7 = damage_percent_bonus / 100 + 1
            end
        end

        -- 额外乘数
        local mult8 = multiplier or 1

        -- 计算总倍率
        local total_multiplier = mult1 * mult2 * mult3 * mult4 * mult5 * mult6 * mult7 * mult8
        return total_multiplier
    end
end)


AddClientModRPCHandler("CCS", "PushWhisper", function(params_json)
    local params = json.decode(params_json)
    if params and params.message then
        params.flag = "CCS"
        ChatHistory:AddToHistory(params)
    end
end)


-- Hook ChatHistory 以支持自定义颜色/图标
local old_Generate = ChatHistory.GenerateChatMessage
ChatHistory.GenerateChatMessage = function(self, chat_type, sender_userid, sender_netid, sender_name, message, colour, icondata, whisper, localonly, text_filter_context)
    local custom = {}
    if type(chat_type) == "table" and chat_type.flag == "CCS" then
        custom = chat_type
        chat_type = custom.ChatType or ChatTypes.Message
        localonly = true
        icondata = custom.icondata or "default"
        sender_name = custom.sender_name or sender_name
        message = custom.message or message
        colour = custom.s_colour or custom.m_colour or {1,1,1}
    end

    local ret = old_Generate(self, chat_type, sender_userid, sender_netid, sender_name, message, colour, icondata, whisper, localonly, text_filter_context)
    if custom.flag == "CCS" then
        if custom.m_colour then ret.m_colour = custom.m_colour end
        if custom.s_colour then ret.s_colour = custom.s_colour end
    end
    return ret
end

-- 全局调用函数
function TOTORIA_Whisper(target_player, params)
    if target_player == nil then
        -- 广播给所有玩家
        if TheWorld.ismastersim then
            local json_params = json.encode(params)
            for _, player in ipairs(AllPlayers) do
                if player.userid then
                    SendModRPCToClient(CLIENT_MOD_RPC["CCS"]["PushWhisper"], player.userid, json_params)
                end
            end
        elseif not TheNet:IsDedicated() and ThePlayer then
            -- 纯客户端（单人）直接显示
            params.flag = "CCS"
            ChatHistory:AddToHistory(params)
        end
    else
        local player = target_player
        if type(target_player) == "string" then
            -- userid 转玩家实体
            for _, v in ipairs(AllPlayers) do
                if v.userid == target_player then
                    player = v
                    break
                end
            end
        end
        if player then
            if TheWorld.ismastersim then
                local json_params = json.encode(params)
                SendModRPCToClient(CLIENT_MOD_RPC["CCS"]["PushWhisper"], player.userid, json.encode(params))
            elseif player == ThePlayer then
                params.flag = "CCS"
                ChatHistory:AddToHistory(params)
            end
        end
    end
end

GLOBAL.CCSWHISPER = TOTORIA_Whisper 


AddStategraphPostInit("wilson", function(self)
    self.states.death.onexit = function(inst) end
end)


---------------------------------------------------------------------------------------------------
-- 减防禁疗
---------------------------------------------------------------------------------------------------
AddComponentPostInit("health", function(self)
    local _DoDelta = self.DoDelta
    local _SetVal = self.SetVal
    local _SetCurrentHealth = self.SetCurrentHealth
    local _SetMaxHealth = self.SetMaxHealth


    local function HasStrictTag(inst)
        return inst:HasTag("ccs_nohealth_x")
    end

    function self:DoDelta(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, ...)
        if amount > 0 and self.inst:HasTag("ccs_nohealth") then
            return 0
        end

        -- if amount < 0 and not ignore_absorb and self.inst:HasTag("ccs_armor_break") then
        --     local reduce_factor = 0.4

        --     local old_absorb = self.absorb
        --     local old_playerabsorb = self.playerabsorb

        --     self.absorb = self.absorb * reduce_factor
        --     self.playerabsorb = self.playerabsorb * reduce_factor

        --     local result = _DoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, ...)

        --     self.absorb = old_absorb
        --     self.playerabsorb = old_playerabsorb

        --     return result
        -- end
        
        return _DoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, ...)
    end

    function self:SetVal(val, cause, afflicter)
        if HasStrictTag(self.inst) and val > self.currenthealth then
            return
        end
        _SetVal(self, val, cause, afflicter)
    end

    function self:SetCurrentHealth(amount)
        if HasStrictTag(self.inst) and amount > self.currenthealth then
            return
        end
        _SetCurrentHealth(self, amount)
    end

    function self:SetMaxHealth(amount)
        if HasStrictTag(self.inst) then
            local old_health = self.currenthealth
            _SetMaxHealth(self, amount)
            if old_health < self.maxhealth then
                _SetCurrentHealth(self, old_health)
            end
            self:ForceUpdateHUD(true)
            return
        end
        _SetMaxHealth(self, amount)
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
            if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_loop", true)
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
            if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pre")
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
             if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pst")
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
             if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_loop", true)
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
			 if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pre")
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
			 if inst:HasTag("ccs_cgl") then  
				inst.AnimState:PlayAnimation("Tomiya_Rin_fly_pst")
                --inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.01)
            end
        end
    end
end)

--修复克雷容器残留问题
local ContainerWidget = require "widgets/containerwidget"
local oldClose = ContainerWidget.Close
function ContainerWidget:Close(...)
    if self.isopen then
        if self.bgimage.texture then
        else
            self.bganim.inst:ListenForEvent("animover", function()
                self.bganim:Hide()
                --理论上正常来说.3的时候应该被移除了，但快速装卸背包会导致可能不被正常移除
                --这里把它移除掉
                self.bganim.inst:DoSimTaskInTime(.3, function()
                    self:Kill()
                end)
            end)
        end
    end
    return oldClose(self, ...)
end


--栅栏击剑旋转
AddComponentPostInit("fencerotator", function(self)
	local oldRotate = self.Rotate
	self.Rotate=function(self, target, delta, ...)
		--自定义旋转角度，转出风采，转出水平！
		if target ~= nil and target.fencerotator_delta then
			delta = target.fencerotator_delta
		end
		if oldRotate then
			oldRotate(self, target, delta, ...)
		end
	end
end)


AddClassPostConstruct('widgets/containerwidget', function(self, ...)
    
    local old_Open = self.Open
    
    function self:Open(container, doer, ...)
        if old_Open then
            old_Open(self, container, doer, ...)
        end

        if container and container.replica and container.replica.container then
            local widget = container.replica.container:GetWidget()
            if widget and widget.animbuild == "ui_ccs_sb_item_baozi" then
                local bg = self.bganim or self.bg
                if bg then
                    bg:SetScale(1.15, 1.15, 1)
                end
            end

            if widget and widget.animbuild == "ui_huihui_bag_2x9" then
                local bg = self.bganim or self.bg
                if bg then
                    bg:SetScale(0.95, 0.95, 1)
                end
            end

        end
        
    end
end)


-- checkfn = function(inventory, name)
--     --return CCSAPI.CcsSkinCheckFn(inventory, "ccs_sb_item_skin_baozi")
--     return true
-- end,
-- checkclientfn = function(inventory, userid, name)
--     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_sb_item_skin_baozi")
--     return true
-- end
