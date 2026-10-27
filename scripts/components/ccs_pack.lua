--出自风铃大佬的打包
local function canshrink(target)
    if target then
        if TUNING.CCS_PACK2 then
            return true
        else
            return not target.components.combat or
                       target.components.combat.defaultdamage == 0
        end
    end
end
-- require "config/debug"
local Ccs_pack = Class(function(self, inst)
    self.inst = inst
    self.canpackfn = canshrink
    self.item = nil
end)

function Ccs_pack:HasPackage() return self.item ~= nil end

function Ccs_pack:SetCanPackFn(fn) self.canpackfn = fn end
local cantpack = {}
function Ccs_pack:DefaultCanPackTest(target) -- 目标待改
    if target and target:HasTag("soracantpack") then return false end
    if target and target:HasTag("cantpack") then return false end
    if cantpack[target.prefab] then return false end
    if target.prefab:match("_bell$") then return false end
    if TUNING.CCS_PACK then
        return target and
                   not (target:HasTag("teleportato") -- or target:HasTag("irreplaceable")
            or target:HasTag("player") or target:HasTag("nonpackable") or
                       target:HasTag("companion") or target:HasTag("character") -- or target.prefab == "wormhole"--虫洞
            -- or target.prefab == "beequeenhivegrown"--蜂王窝-底座
            -- or target.prefab =="beequeenhive"--蜂王窝
            -- or target.prefab =="cave_entrance"--虫洞入口
            -- or target.prefab =="cave_entrance_ruins"
            -- or target.prefab =="cave_entrance_open"
            -- or target.prefab == "multiplayer_portal"
            -- or target.prefab == "tentacle_pillar_hole"
            -- or target.prefab == "tentacle_pillar"
            )
    else
        return target and target:IsValid() and
                   not (target:HasTag("teleportato") or target:HasTag("player") or
                       target:HasTag("nonpackable") or
                       target:HasTag("companion") or target:HasTag("character") -- or target.prefab == "wormhole"--虫洞
            -- or target.prefab == "beequeenhivegrown"--蜂王窝-底座
            or target.prefab == "beequeenhive" -- 蜂王窝
            or target.prefab == "cave_entrance" -- 虫洞入口
            or target.prefab == "cave_entrance_ruins" or target.prefab ==
                       "cave_entrance_open" or target.prefab ==
                       "multiplayer_portal" -- or target.prefab == "tentacle_pillar_hole"
            -- or target.prefab == "tentacle_pillar"
            )
    end

end

function Ccs_pack:CanPack(target)
    return self.inst:IsValid() and not self:HasPackage() and
               self:DefaultCanPackTest(target) and
               (not self.canpackfn or self.canpackfn(target, self.inst)) and
               not (target.components.container and
                   target.components.container.openner)
end

local function get_name(target)
    local name = target:GetDisplayName() or
                     (target.components.named and target.components.named.name)
    if not name or name == "MISSING NAME" then return "空的打包盒" end

    local adj = target:GetAdjective()
    if adj then name = adj .. " " .. name end

    if target.components.stackable then
        local size = target.components.stackable:StackSize()
        if size > 1 then name = name .. " x" .. tostring(size) end
    end

    return "打包的" .. name
end

function Ccs_pack:Pack(target, doer, MustPack)
    if not MustPack and not self:CanPack(target) then
        if doer and doer.components and doer.components.talker then
            doer.components.talker:Say("这个不能打包")
        end
        return false
    end
    if target and target.ownerlist and target.ownerlist.master and doer and
        target.ownerlist.master ~= doer.userid then
        if doer and doer.components and doer.components.talker then
            doer.components.talker:Say("不能打包别人的东西")
        end
        return false
    end
    local debugstring = target.entity:GetDebugString()

    local bank, build, anim = debugstring:match(
                                  "bank: (.+) build: (.+) anim: .+:(.+) Frame")
    if (not bank) or (bank:find("FROMNUM")) then
        bank = target.prefab -- 抢救一下吧
    end
    if (not build) or (build:find("FROMNUM")) then
        build = target.prefab -- 抢救一下吧
    end
    if target.skinname and not Prefabs[target.prefab .. "_placer"] then
        local debuginst = SpawnPrefab(target.prefab)
        debugstring = debuginst.entity:GetDebugString()
        bank, build, anim = debugstring:match(
                                "bank: (.+) build: (.+) anim: .+:(.+) Frame")
        debuginst:Remove()
    end
    if target and target.components.container and target.components.container:IsOpen() then
        target.components.container:Close()
    end
    self.item = {
        item = target:GetSaveRecord(),
        irreplaceable = target:HasTag("irreplaceable"),
        origin = TheWorld.meta.session_identifier,
        bank = bank or "",
        build = build or "",
        anim = anim or "",
        -- scale = target:GetScale(),        --取不到 先不管了
        name = get_name(target)
    }
    self.inst.replica.ccs_pack:SetPlacer(target.prefab, bank, build, anim) -- 丢给客机
    if target.components.teleporter and
        target.components.teleporter.targetTeleporter then
        self.item.item2 =
            target.components.teleporter.targetTeleporter:GetSaveRecord()
        target.components.teleporter.targetTeleporter:Remove()
    end
    -- self.item.data, self.item.refs = target:GetPersistData()
    if not self.inst.components.named then self.inst:AddComponent("named") end
    self.inst.components.named:SetName(self.item.name)
    self.inst.components.inspectable:SetDescription("这是" .. self.item.name)
    target:Remove()
    self.inst:AddTag("Ccs_pack_full")

    return true
end

function Ccs_pack:GetName() return self.item and self.item.name end

function Ccs_pack:Unpack(pos)
    inGamePlay = false -- 骗过系统 告诉他我们还在读档
    if self.item and self.item.item then
        local v = self.item.item
        local item = SpawnSaveRecord(v) -- , v.skin_id, creator
        -- item:SetPersistData(v.data)
        if item ~= nil and item:IsValid() then
            if item.Physics ~= nil then
                item.Physics:Teleport(pos:Get())
            else
                item.Transform:SetPosition(pos:Get())
            end
            if item.components.inventoryitem ~= nil then
                item.components.inventoryitem:OnDropped(true, .5)
            end
        end
        if self.item.item2 then
            local item2 = SpawnSaveRecord(self.item.item2)
            if item2 and item.components.teleporter and
                item2.components.teleporter then
                item2.components.teleporter:Target(item)
                item.components.teleporter:Target(item2)
            end
        end
    end
    inGamePlay = true -- 结束了 不用骗了
end

function Ccs_pack:Unpackbuild(pos)
    -- local creator = self.item.origin ~= nil and TheWorld.meta.session_identifier ~= self.item.origin and { sessionid = self.item.origin } or nil
    self:Unpack(pos)
end

function Ccs_pack:OnSave()
    return self.item ~= nil and {item = self.item} or nil
end

function Ccs_pack:OnLoad(data)
    if data and data.item then
        self.item = data.item
        if not self.inst.components.named then
            self.inst:AddComponent("named")
        end
        self.inst.components.named:SetName(self.item.name)
        self.inst.components.inspectable:SetDescription(
            "这是" .. self.item.name)
        self.inst:AddTag("Ccs_pack_full")
        self.inst.replica.ccs_pack:SetPlacer(self.item.item.prefab,
                                               self.item.bank, self.item.build,
                                               self.item.anim)
    end
end

return Ccs_pack
