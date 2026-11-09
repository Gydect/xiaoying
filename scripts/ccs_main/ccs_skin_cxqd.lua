-- 定制人物皮肤：春夏秋冬（ccs_skins_cxqd）
-- 一个皮肤格子对应四套季节材质，默认（选人界面、新穿上时）为秋天。
-- 只有穿着春夏秋冬皮肤才能在人物栏制作“举牌”（ccs_cxqd 标签），举牌时播放专属动作；
-- 当前材质与世界季节不符时，举牌 5 秒后面前出现旺达的传送门，
-- 玩家自己点击跳进去（其他玩家不能跳），换成当前季节的材质后像旺达一样利索地落地。

local CXQD_SKIN = "ccs_skins_cxqd"
local CXQD_DEFAULT_SEASON = "autumn"
local CXQD_SEASON_BUILDS = {
    spring = "ccs_skins_cxqd_spring",
    summer = "ccs_skins_cxqd_summer",
    autumn = "ccs_skins_cxqd_autumn",
    winter = "ccs_skins_cxqd_winter",
}
local PAIZI_BUILD = "ccs_skins_cxqd_paizi"
local PAIZI_TIME = 5 -- 举牌多久后检查是否换季
local CXQD_BUILDER_TAG = "ccs_cxqd" -- 举牌配方的 builder_tag，穿着春夏秋冬时才有

STRINGS.NAMES.CCS_SKINS_CXQD_PAIZI = "举牌"
STRINGS.RECIPE_DESC.CCS_SKINS_CXQD_PAIZI = "举起牌子。举久一点，会换上当前季节的衣服。"

local function GetSeasonBuild(inst)
    return CXQD_SEASON_BUILDS[inst.ccs_cxqd_season] or CXQD_SEASON_BUILDS[CXQD_DEFAULT_SEASON]
end

local function IsWearingCxqd(inst)
    local skinner = inst.components.skinner
    return skinner ~= nil and skinner.skin_name == CXQD_SKIN
end

-- 举牌配方靠 ccs_cxqd 标签开放。标签变化本身不会让制作栏刷新，
-- 所以同时改一个网络变量：服务端（主机玩家）直接刷新，客户端收到同步后刷新。
local function RefreshCrafting(inst)
    if inst:IsValid() and inst.HUD ~= nil then
        inst:PushEvent("refreshcrafting")
    end
end

local function SetCxqdCrafting(inst, wearing)
    if inst:HasTag(CXQD_BUILDER_TAG) == wearing then
        return
    end
    if wearing then
        inst:AddTag(CXQD_BUILDER_TAG)
    else
        inst:RemoveTag(CXQD_BUILDER_TAG)
    end
    if inst._ccs_cxqd_crafting ~= nil then
        inst._ccs_cxqd_crafting:set(wearing)
    end
    RefreshCrafting(inst)
end

-- 春夏秋冬皮肤的基础材质按当前季节形态替换；其他皮肤不受影响
AddComponentPostInit("skinner", function(self)
    local old_SetSkinName = self.SetSkinName
    function self:SetSkinName(skin_name, skip_beard_setup, skip_skins_set)
        old_SetSkinName(self, skin_name, skip_beard_setup, true)
        SetCxqdCrafting(self.inst, self.skin_name == CXQD_SKIN)
        if self.skin_name == CXQD_SKIN and self.skin_data ~= nil then
            self.skin_data.normal_skin = GetSeasonBuild(self.inst)
        end
        if not skip_skins_set then
            self:SetSkinMode()
        end
    end
end)

local function SetCxqdSeason(inst, season)
    inst.ccs_cxqd_season = season
    local skinner = inst.components.skinner
    if IsWearingCxqd(inst) and skinner.skin_data ~= nil then
        skinner.skin_data.normal_skin = GetSeasonBuild(inst)
        if skinner:GetSkinMode() == "normal_skin" then
            skinner:SetSkinMode()
        end
    end
end

local function NeedsSeasonChange(inst)
    return IsWearingCxqd(inst)
        and CXQD_SEASON_BUILDS[TheWorld.state.season] ~= nil
        and (inst.ccs_cxqd_season or CXQD_DEFAULT_SEASON) ~= TheWorld.state.season
end

AddPrefabPostInit("ccs", function(inst)
    inst._ccs_cxqd_crafting = net_bool(inst.GUID, "ccs_cxqd.crafting", "ccs_cxqd_craftingdirty")
    if not TheWorld.ismastersim then
        -- 等一帧，确保标签和网络变量都已同步到客户端再刷新
        inst:ListenForEvent("ccs_cxqd_craftingdirty", function(inst)
            inst:DoTaskInTime(0, RefreshCrafting)
        end)
        return
    end
    local old_OnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        if old_OnSave ~= nil then
            old_OnSave(inst, data)
        end
        data.ccs_cxqd_season = inst.ccs_cxqd_season
    end
    local old_OnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data, ...)
        if old_OnLoad ~= nil then
            old_OnLoad(inst, data, ...)
        end
        if data ~= nil and data.ccs_cxqd_season ~= nil then
            SetCxqdSeason(inst, data.ccs_cxqd_season)
        end
    end
end)

-------------------------------------------------------------------------------
-- 换季：在脚下打开旺达的传送门，跳进去后换成当前季节的材质，从原地落出

local function ClosePortalSoon(portal, delay)
    if portal:IsValid() and portal.components.timer ~= nil and portal.components.timer:TimerExists("closeportal") then
        portal.components.timer:SetTimeLeft("closeportal", delay)
    end
end

local PORTAL_DIST = 2.5      -- 传送门开在角色面前的距离
local PORTAL_OPEN_TIME = 15  -- 传送门开着等玩家点击的时间

-- 换季传送门只有开门的玩家能跳：客户端不显示其他玩家的“跳入”，服务端也拒绝
local function IsPortalOwner(portal, doer)
    local owner = portal._ccs_cxqd_owner ~= nil and portal._ccs_cxqd_owner:value() or ""
    return owner == "" or (doer ~= nil and doer.userid == owner)
end

AddPrefabPostInit("pocketwatch_portal_entrance", function(inst)
    inst._ccs_cxqd_owner = net_string(inst.GUID, "ccs_cxqd_portal._owner")

    local old_CollectActions = inst.CollectActions
    inst.CollectActions = function(self, actiontype, doer, actions, ...)
        old_CollectActions(self, actiontype, doer, actions, ...)
        if actiontype == "SCENE" and type(actions) == "table" and not IsPortalOwner(self, doer) then
            for i = #actions, 1, -1 do
                if actions[i] == ACTIONS.JUMPIN then
                    table.remove(actions, i)
                end
            end
        end
    end
end)

local old_JUMPIN_fn = ACTIONS.JUMPIN.fn
ACTIONS.JUMPIN.fn = function(act)
    if act.target ~= nil and act.target.prefab == "pocketwatch_portal_entrance" and not IsPortalOwner(act.target, act.doer) then
        -- 和官方跳不进去时一样回到待机，免得停在 jumpin_pre
        if act.doer ~= nil and act.doer.sg ~= nil and act.doer.sg.currentstate.name == "jumpin_pre" then
            act.doer.sg:GoToState("idle")
        end
        return false
    end
    return old_JUMPIN_fn(act)
end

local function OnPortalActivate(portal, doer)
    if doer.components.talker ~= nil then
        doer.components.talker:ShutUp()
    end
    -- 点击传送门时再判断一次，期间季节或皮肤变了就只是普通传送
    if NeedsSeasonChange(doer) then
        SetCxqdSeason(doer, TheWorld.state.season)
    end
    ClosePortalSoon(portal, 1)
end

-- 落地后不说官方传送门的台词（非旺达会抱怨摔疼），只保留官方对位移记录的重置
local function OnExitDoneTeleporting(exit, obj)
    if obj ~= nil and obj.components.positionalwarp ~= nil then
        obj.components.positionalwarp:Reset()
    end
end

local function OpenSeasonPortal(inst)
    inst.sg.statemem.portaltask = nil
    if not NeedsSeasonChange(inst) or (inst.components.rider ~= nil and inst.components.rider:IsRiding()) then
        return
    end
    -- 同一个玩家同时只开一个换季传送门
    if inst._ccs_cxqd_portal ~= nil and inst._ccs_cxqd_portal:IsValid() then
        return
    end
    -- 传送门开在角色面前，找不到能走的位置就随便换个方向
    local pos = inst:GetPosition()
    local facing = -inst.Transform:GetRotation() * DEGREES
    local offset = FindWalkableOffset(pos, facing, PORTAL_DIST, 8, true, false)
        or FindWalkableOffset(pos, math.random() * TWOPI, PORTAL_DIST, 12, true, false)
    if offset == nil then
        return
    end
    local x, z = pos.x + offset.x, pos.z + offset.z
    local portal = SpawnPrefab("pocketwatch_portal_entrance")
    portal.Transform:SetPosition(x, 0, z)
    portal:SpawnExit(nil, x, 0, z)
    -- 从传送门正下方落出；落地用旺达的利索动作而不是摔出来
    local exit = portal.components.teleporter.targetTeleporter
    if exit ~= nil and exit.components.teleporter ~= nil then
        exit.components.teleporter.offset = 0
        exit.components.teleporter.trynooffset = false
        exit.components.teleporter.overrideteleportarrivestate = "ccs_cxqd_portal_land"
        exit.components.teleporter.OnDoneTeleporting = OnExitDoneTeleporting
    end
    -- 换季的传送门不扣理智，只负责切换材质；等玩家自己左键点击跳入
    portal.components.teleporter.onActivate = OnPortalActivate
    portal._ccs_cxqd_owner:set(inst.userid or "")
    ClosePortalSoon(portal, PORTAL_OPEN_TIME)
    inst._ccs_cxqd_portal = portal
end

-------------------------------------------------------------------------------
-- 举牌动作：制作栏里制作“举牌”后触发，移动或做其他动作即结束

AddStategraphState("wilson", State {
    name = "ccs_cxqd_paizi",
    tags = { "busy", "pausepredict" },

    onenter = function(inst, data)
        inst.components.locomotor:Stop()
        inst:ClearBufferedAction()

        inst.AnimState:OverrideSymbol("paizi", data ~= nil and data.paizi_build or PAIZI_BUILD, "paizi")
        inst.AnimState:OverrideSymbol("star_fx", PAIZI_BUILD, "star_fx")
        inst.AnimState:PlayAnimation("paizi_pre")
        inst.AnimState:PushAnimation("paizi_loop", true)

        if NeedsSeasonChange(inst) then
            inst.sg.statemem.portaltask = inst:DoTaskInTime(PAIZI_TIME, OpenSeasonPortal)
        end

        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:RemotePausePrediction()
        end
    end,

    timeline =
    {
        TimeEvent(.5, function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("pausepredict")
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.portaltask ~= nil then
            inst.sg.statemem.portaltask:Cancel()
            inst.sg.statemem.portaltask = nil
        end
        inst.AnimState:ClearOverrideSymbol("paizi")
        inst.AnimState:ClearOverrideSymbol("star_fx")
    end,
})

-- 从换季传送门落出：照搬官方 pocketwatch_portal_land（旺达的利索落地），去掉“只有旺达”的判断
-- jumpportal_out 动画在所有角色共用的 player_pocketwatch_portal 里
local function StartTeleporting(inst)
    inst.sg.statemem.isteleporting = true
    inst.components.health:SetInvincible(true)
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(false)
    end
    inst:Hide()
    inst.DynamicShadow:Enable(false)
end

local function DoneTeleporting(inst)
    inst.sg.statemem.isteleporting = false
    inst.components.health:SetInvincible(false)
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(true)
    end
    inst:Show()
    inst.DynamicShadow:Enable(true)
end

AddStategraphState("wilson", State {
    name = "ccs_cxqd_portal_land",
    tags = { "busy", "nopredict", "nomorph", "nodangle", "jumping", "noattack" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        StartTeleporting(inst)

        inst.AnimState:PlayAnimation("jumpportal_out")

        local x, y, z = inst.Transform:GetWorldPosition()
        local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
        fx.Transform:SetPosition(x, 4, z)
    end,

    timeline =
    {
        TimeEvent(16 * FRAMES, function(inst)
            inst:Show() -- StartTeleporting 隐藏了角色
        end),
        TimeEvent(17 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
        end),
        TimeEvent(20 * FRAMES, function(inst)
            inst.DynamicShadow:Enable(true)
        end),
        TimeEvent(22 * FRAMES, function(inst)
            PlayFootstep(inst)
        end),
        TimeEvent(28 * FRAMES, function(inst)
            inst.sg:RemoveStateTag("jumping")
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("nomorph")
            inst.sg:RemoveStateTag("noattack")
            DoneTeleporting(inst)
        end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.isteleporting then
            DoneTeleporting(inst)
        end
    end,
})

-- 由“举牌”配方的产物调用；paizi_skin 为制作栏选中的牌子皮肤
function CcsCxqdStartPaizi(inst, paizi_skin)
    if inst == nil or not inst:IsValid() or inst.sg == nil
        or (inst.components.health ~= nil and inst.components.health:IsDead())
        or inst:HasTag("playerghost") then
        return
    end
    inst.sg:GoToState("ccs_cxqd_paizi", { paizi_build = paizi_skin })
end
