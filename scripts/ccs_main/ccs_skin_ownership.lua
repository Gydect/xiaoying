

-- 服务端记录每个玩家拥有的永久皮肤。
local skinowner = {}
-- 本机玩家拥有的永久皮肤，用于客户端本地鉴权。
local selfowner = {}
-- 服务端记录每个玩家拥有的限时皮肤。
local skinowner_tmp = {}
-- 本机玩家拥有的限时皮肤，用于客户端本地鉴权。
local selfowner_tmp = {}

local selfid = TheNet:GetUserID()
local modtype = "mfsnxy"
local skinapi = require("ccs_main/ccs_skin_extend")

local function IsTmpSkinTime(time)
    return time ~= nil and time ~= false and time ~= 0 and time ~= "0"
end

function IsDefaultCharacterSkin(item_key)
    return string.sub(item_key, -5) == "_none"
end
local test = false
function CcsSkinCheckFn(inventory, name)
    if test then
        return true
    end
    return IsDefaultCharacterSkin(name) or (selfowner[name] or selfowner_tmp[name]) and true or false
end

function CcsSkinCheckClientFn(inventory, userid, name)
    if test then
        return true
    end

    if userid and name then
        if skinowner[userid] and skinowner[userid][name] then
            return true
        end
        if skinowner_tmp[userid] and skinowner_tmp[userid][name] then
            return true
        end
    end
    if IsDefaultCharacterSkin(name) then
        return true
    end
    return  false
end

local cache = "CcsSkinCache_New2"
local rawcache = cache .. "_raw"
local servercache = cache .. "_server"
local MAX_SKIN_API_FAILURES = 3
local MAX_SKIN_API_RAW_LENGTH = 9999
local skin_api_failures = 0
local skin_api_requesting = false

-- 代理返回的 raw 可能使用时间 key；本地缓存和 RPC 统一改用固定 key raw，时间戳没用因为代理不是持久代理。
local function SaveVerifiedSkinApiCache(raw, ownerid)
    if TheNet:IsDedicated() or ownerid ~= selfid then
        return
    end

    if type(raw) == "string" and raw ~= "" and string.len(raw) <= MAX_SKIN_API_RAW_LENGTH then
        TheSim:SetPersistentString(rawcache, raw, true)
    end
end

-- 已经校验通过的数据重新打包为固定 key raw。
-- 优先复用解密出的明文，避免不同数据结构在重建明文时丢字段。
local function BuildCanonicalSkinApiRaw(ownerid, data, plain)
    if type(skinapi.BuildCanonicalRaw) ~= "function" then
        return nil
    end

    local raw = skinapi.BuildCanonicalRaw(ownerid, data, plain, modtype)
    if type(raw) ~= "string" or raw == "" or string.len(raw) > MAX_SKIN_API_RAW_LENGTH then
        return nil
    end

    return raw
end

local function SaveServerSkin(userid, raw)
    if type(userid) ~= "string" or userid == "" or type(raw) ~= "string" or raw == "" then
        return false
    end

    if string.len(raw) > MAX_SKIN_API_RAW_LENGTH then
        return false
    end

    local ok, data, plain, usedkey, err, ownerid = skinapi.DecodeResponse(raw, modtype, nil, userid)
    if not (ok and type(data) == "table" and ownerid == userid) then
        return false
    end

    skinowner[userid] = {}
    skinowner_tmp[userid] = {}

    local function addskin(skinname, istmp)
        if not skinapi.IsValidSkinCode(skinname) then
            return
        end
        if istmp then
            skinowner_tmp[userid][skinname] = 1
        else
            skinowner[userid][skinname] = 1
        end
    end

    local function addvalue(value, istmp)
        if type(value) == "string" then
            addskin(value, istmp)
        elseif type(value) == "table" then
            addskin(value.skincode or value.skin or value.name or value.code, istmp or IsTmpSkinTime(value.time))
        end
    end

    if type(data.items) == "table" or type(data.temps) == "table" then
        for _, v in pairs(data.items or {}) do
            addvalue(v, false)
        end
        for _, v in pairs(data.temps or {}) do
            addvalue(v, true)
        end
    else
        for k, v in pairs(data) do
            if type(v) == "string" or type(v) == "table" then
                addvalue(v, false)
            elseif type(k) == "string" and v == 1 then
                addskin(k, false)
            end
        end
    end

    SaveSkinCache()
    return true
end

if TheNet:GetIsServer() then
    TheSim:GetPersistentString(servercache, function(load_success, str)
        if load_success then
            local r, j = pcall(json.decode, str)
            if r and type(j) == "table" then
                local function restorecache(src)
                    local dst = {}
                    for skinname, value in pairs(src) do
                        if type(skinname) == "string" and value == 1 then
                            dst[skinname] = 1
                        end
                    end
                    return dst
                end

                if type(j.owner) == "table" then
                    for userid, owner in pairs(j.owner) do
                        if type(userid) == "string" and type(owner) == "table" then
                            skinowner[userid] = restorecache(owner)
                        end
                    end
                end
                if type(j.tmp) == "table" then
                    for userid, tmp in pairs(j.tmp) do
                        if type(userid) == "string" and type(tmp) == "table" then
                            skinowner_tmp[userid] = restorecache(tmp)
                        end
                    end
                end
            end
        end
    end)
end

AddModRPCHandler("Ccs", 'SetCcsKey', function(player,str)
    if player ~= nil and type(player.userid) == "string" and type(str) == "string" and SaveServerSkin(player.userid, str) then
        SendModRPCToShard(GetShardModRPC("Ccs", "SetCcsKeyShard"), nil, player.userid, str)
    end
end)

AddShardModRPCHandler("Ccs", "SetCcsKeyShard", function(worldid, userid, str)
    local shardid = TheShard ~= nil and TheShard:GetShardId() or nil
    if shardid == nil or tostring(shardid) ~= tostring(worldid) then
        SaveServerSkin(userid, str)
    end
end)


function SaveSkinCache()
    if not TheNet:GetIsServer() then
        return
    end

    local r, j = pcall(json.encode, {
        owner = skinowner,
        tmp = skinowner_tmp
    })
    if r then
        TheSim:SetPersistentString(servercache, j, true)
    end
end


-- 不在收藏界面展示未拥有的特殊皮肤。
local black = {
    ccs_skins5 = 1,
	ccs_skins6 = 1,
    ccs_skins8 = 1,
    ccs_skins_madoka = 1,
    ccs_skins_madoka1 = 1,
    shiranui = 1,
    ccs_skins_bronya = 1,
    ccs_skins_qqj = 1,
    daji = 1,
    zhishi = 1,
    ccs_skins_haiyu = 1,
    ccs_skins_kioku = 1,
    ccs_skins_chuqing = 1,
    ccs_skins_chuqing2 = 1,
    ccs_skins_afu = 1,
    ccs_skins_sea = 1,
    ccs_kinomoto = 1,
    ccs_naxida1 = 1,
    ccs_naxida2 = 1,
    ccs_skins_xhqj = 1,
    ccs_skins_fhyy = 1,
    ccs_skins_hyly = 1,
    ccs_skins_cbgy = 1,
    ccs_skins_gjzx = 1,
    ccs_skins_xd2 = 1,
    ccs_skins_qfqx = 1,
    ccs_skins_bsem = 1,
    ccs_skins_fbhl = 1,
    ccs_skins_zxyy =1,
    ccs_skins_xgm = 1,
    ccs_skins_mm = 1,
    ccs_skins_mls = 1,
    ccs_skins_bs = 1,
    ccs_skins_ylxm = 1,
    ccs_skins_rb = 1,
    ccs_skins_kq = 1,
    ccs_skins_hlh = 1,
    ccs_skins_hj = 1,
    ccs_skins_byb = 1,
    ccs_skins_hqfa = 1,
    ccs_skins_dzm = 1,
    ccs_skin_cgm = 1,
    ccs_skin_msnzs = 1,
    ccs_skin_yxxc = 1,
    ccs_moyuxuanli_xjlw = 1,
    ccs_skin_xnylh = 1,
    ccs_skins_adastra = 1,
    ccs_skins_mika = 1,
    ccs_skins_maho = 1,
    ccs_skins_alxy = 1,
    ccs_skins_cbem = 1,
    ccs_skins_xin = 1,
    ccs_skin_xuechuyin = 1,
    ccs_skin_glby = 1,
    ccs_skin_mlby = 1,
    ccs_skins_xiyacha  = 1,
    ccs_skins_xiyadai  = 1,
    ccs_skin_bylf  = 1,
    ccs_skin_aiyfl  = 1,
    ccs_skins_fhyya = 1
}

AddSimPostInit(function()
    if test then
        return true
    end
    local old = ShouldDisplayItemInCollection
    GLOBAL.ShouldDisplayItemInCollection = function(str, ...)
        if (black[str] or str:match("^ccs_.+_tmp$")) and not CcsSkinCheckFn(TheInventory, str) then
            return false
        end
        return old(str, ...)
    end
end)

-- 把解密后的皮肤列表写入权限表；本机玩家同时刷新 selfowner 表。
local function ApplySkinApiData(userid, data)
    skinowner[userid] = {}
    skinowner_tmp[userid] = {}

    if userid == selfid then
        selfowner = {}
        selfowner_tmp = {}
    end

    local count = 0
    local function addskin(skinname, istmp)
        if not skinapi.IsValidSkinCode(skinname) then
            return
        end
        if istmp then
            skinowner_tmp[userid][skinname] = 1
            if userid == selfid then
                selfowner_tmp[skinname] = 1
            end
        else
            skinowner[userid][skinname] = 1
            if userid == selfid then
                selfowner[skinname] = 1
            end
        end
        count = count + 1
    end

    if type(data) ~= "table" then
        return count
    end

    local function addvalue(value, istmp)
        if type(value) == "string" then
            addskin(value, istmp)
        elseif type(value) == "table" then
            addskin(value.skincode or value.skin or value.name or value.code, istmp or IsTmpSkinTime(value.time))
        end
    end

    if type(data.items) == "table" or type(data.temps) == "table" then
        for _, v in pairs(data.items or {}) do
            addvalue(v, false)
        end
        for _, v in pairs(data.temps or {}) do
            addvalue(v, true)
        end
        return count
    end

    for k, v in pairs(data) do
        if type(v) == "string" or type(v) == "table" then
            addvalue(v, false)
        elseif type(k) == "string" and v == 1 then
            addskin(k, false)
        end
    end

    return count
end

local function SendCachedSkinApiDataToServer(raw)
    if TheNet:IsDedicated() or type(raw) ~= "string" or raw == "" then
        return false
    end

    if TheNet:GetIsServer() then
        return SaveServerSkin(selfid, raw)
    end

    if ThePlayer == nil then
        return false
    end

    SendModRPCToServer(MOD_RPC["Ccs"]["SetCcsKey"], raw)
    return true
end


local function SyncRawSkinApiDataToServer(raw, save_cache, skip_rpc)
    if TheNet:IsDedicated() or type(raw) ~= "string" or raw == "" then
        return false
    end
    if string.len(raw) > MAX_SKIN_API_RAW_LENGTH then
        return false
    end

    local ok, data, plain, usedkey, err, ownerid = skinapi.DecodeResponse(raw, modtype, nil, selfid)
    if not (ok and ownerid == selfid) then
        return false
    end

    local canonicalraw = BuildCanonicalSkinApiRaw(ownerid, data, plain)
    if (save_cache or not skip_rpc) and canonicalraw == nil then
        return false
    end
    if canonicalraw ~= nil then
        local canonical_ok, _, _, _, _, canonical_ownerid = skinapi.DecodeResponse(canonicalraw, modtype, nil, selfid)
        if not (canonical_ok and canonical_ownerid == selfid) then
            return false
        end
    end

    if save_cache then
        SaveVerifiedSkinApiCache(canonicalraw, ownerid)
    end

    ApplySkinApiData(ownerid, data)
    if not skip_rpc then
        SendCachedSkinApiDataToServer(canonicalraw)
    end
    return true
end

-- 请求本地代理。自动请求连续失败三次后停止；force 用于手动刷新。
local function RequestSelfSkinApiRaw(force, autoretry)
    if TheNet:IsDedicated() then
        return false
    end
    if skin_api_requesting then
        return false
    end
    if not force and skin_api_failures >= MAX_SKIN_API_FAILURES then
        return false
    end

    if type(selfid) ~= "string" or selfid == "" then
        return false
    end

    skin_api_requesting = true
    local url = "http://localhost:12024/skin/getSkin?kleiid=" .. selfid .. "&type=" .. modtype
    TheSim:QueryServer(url, function(str, succ, code)
        skin_api_requesting = false
        if succ and code == 200 and SyncRawSkinApiDataToServer(str, true, false) then
            skin_api_failures = 0
        else
            skin_api_failures = skin_api_failures + 1
            if autoretry and skin_api_failures < MAX_SKIN_API_FAILURES and TheWorld ~= nil then
                TheWorld:DoTaskInTime(2, function()
                    RequestSelfSkinApiRaw(false, true)
                end)
            end
        end
    end, 'GET')
    return true
end

-- 客户端启动流程：先读 raw 缓存恢复权限，可选同步服务器和继续请求代理。
local function StartupSelfSkinApi(sync_server, request_proxy)
    if TheNet:IsDedicated() then
        return false
    end

    if type(selfid) ~= "string" or selfid == "" then
        return false
    end

    if skinowner[selfid] == nil then
        skinowner[selfid] = {}
    end
    if skinowner_tmp[selfid] == nil then
        skinowner_tmp[selfid] = {}
    end

    TheSim:GetPersistentString(rawcache, function(load_success, str)
        if load_success and type(str) == "string" and str ~= "" then
            -- 旧缓存如果还能解密，会在这里顺手升级成固定 key raw。
            SyncRawSkinApiDataToServer(str, true, not sync_server)
        end
        if request_proxy then
            RequestSelfSkinApiRaw(false, true)
        end
    end)
    return true
end

-- 只允许本机玩家手动强制刷新一次代理数据。
function CcsGetSkins(userid, skintab)
    if type(userid) ~= "string" or userid == "" then
        return
    end
    if not skinowner[userid] then skinowner[userid] = {} end
    if not skinowner_tmp[userid] then skinowner_tmp[userid] = {} end
    if userid ~= selfid or TheNet:IsDedicated() then
        return
    end

    RequestSelfSkinApiRaw(true)
end

if TheNet:GetIsServer() then
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(1, function()
            if not inst.userid then
                return
            end
            if skinowner[inst.userid] == nil then
                skinowner[inst.userid] = {}
            end
            if skinowner_tmp[inst.userid] == nil then
                skinowner_tmp[inst.userid] = {}
            end
        end)
    end)
end

if not TheNet:IsDedicated() then
    StartupSelfSkinApi(false, false)
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(1, function(player)
            if not inst.userid then
                return
            end

            if type(selfid) ~= "string" or selfid == "" then
                selfid = inst.userid
            end

            if inst.userid ~= selfid then
                return
            end

            if skinowner[selfid] == nil then
                skinowner[selfid] = {}
            end
            if skinowner_tmp[selfid] == nil then
                skinowner_tmp[selfid] = {}
            end

            StartupSelfSkinApi(true, true)
        end)
    end)
end

if TheNet:GetIsServer() then
    AddPrefabPostInit("ccs", function(inst)
        local skin = inst.components.skinner.skin_name
        if skin:find("none") and skin ~= "ccs_none" then
            inst.components.skinner:SetSkin("ccs_none")
        end
    end)
end


-- _G.ccs_skin_decrypt_debug = function(str, decryptkey)
--     print("[CCS_SKIN_API] raw=" .. tostring(str))
--     local plain, skins, usedkey, err, first_plain, ownerid = skinapi.DecodeEncryptedString(str, decryptkey, modtype)
--     print("[CCS_SKIN_API] key=" .. tostring(usedkey or decryptkey or skinapi.GetKey()))
--     print("[CCS_SKIN_API] owner=" .. tostring(ownerid or ""))
--     print("[CCS_SKIN_API] decrypted=" .. tostring(plain or first_plain or ""))
--     if skins then
--         local r, js = pcall(json.encode, skins)
--         print("[CCS_SKIN_API] skins=" .. tostring(r and js or "json encode failed"))
--     else
--         print("[CCS_SKIN_API] error=" .. tostring(err))
--     end
--     return plain, skins, usedkey, ownerid
-- end

-- _G.ccs_skin_encrypt_debug = function(plain, encryptkey)
--     local key = encryptkey or skinapi.GetKey()
--     local encrypted = skinapi.EncryptString(plain, key)
--     print("[CCS_SKIN_API] key=" .. tostring(key))
--     print("[CCS_SKIN_API] plain=" .. tostring(plain))
--     print("[CCS_SKIN_API] encrypted=" .. tostring(encrypted))
--     return encrypted, key
-- end

local function DebugTableInfo(name, tab)
    local count = 0
    local samples = {}
    if type(tab) == "table" then
        for k, v in pairs(tab) do
            count = count + 1
            if #samples < 8 then
                samples[#samples + 1] = tostring(k) .. "=" .. tostring(v)
            end
        end
    end
    print("[CCS_SKIN_API] " .. name .. "_count=" .. tostring(count) .. " samples=" .. table.concat(samples, "|"))
    return count
end

local function DebugRawInfo(label, raw, expected_userid)
    print("[CCS_SKIN_API] " .. label .. "_exists=" .. tostring(type(raw) == "string" and raw ~= ""))
    print("[CCS_SKIN_API] " .. label .. "_len=" .. tostring(type(raw) == "string" and string.len(raw) or 0))
    if type(raw) ~= "string" or raw == "" then
        return false
    end

    print("[CCS_SKIN_API] " .. label .. "_head=" .. string.sub(raw, 1, 80))
    local ok, data, plain, usedkey, err, ownerid = skinapi.DecodeResponse(raw, modtype, nil, expected_userid)
    print("[CCS_SKIN_API] " .. label .. "_ok=" .. tostring(ok))
    print("[CCS_SKIN_API] " .. label .. "_owner=" .. tostring(ownerid or ""))
    print("[CCS_SKIN_API] " .. label .. "_expected=" .. tostring(expected_userid or ""))
    print("[CCS_SKIN_API] " .. label .. "_key=" .. tostring(usedkey or ""))
    print("[CCS_SKIN_API] " .. label .. "_err=" .. tostring(err or ""))
    print("[CCS_SKIN_API] " .. label .. "_plain_head=" .. tostring(plain and string.sub(plain, 1, 120) or ""))
    DebugTableInfo(label .. "_skins", data)
    if ok then
        local canonicalraw = BuildCanonicalSkinApiRaw(ownerid, data, plain)
        print("[CCS_SKIN_API] " .. label .. "_canonical_exists=" .. tostring(type(canonicalraw) == "string" and canonicalraw ~= ""))
        print("[CCS_SKIN_API] " .. label .. "_canonical_len=" .. tostring(type(canonicalraw) == "string" and string.len(canonicalraw) or 0))
        if type(canonicalraw) == "string" and canonicalraw ~= "" then
            local cok, cdata, cplain, cusedkey, cerr, cownerid = skinapi.DecodeResponse(canonicalraw, modtype, nil, expected_userid)
            print("[CCS_SKIN_API] " .. label .. "_canonical_ok=" .. tostring(cok))
            print("[CCS_SKIN_API] " .. label .. "_canonical_owner=" .. tostring(cownerid or ""))
            print("[CCS_SKIN_API] " .. label .. "_canonical_key=" .. tostring(cusedkey or ""))
            print("[CCS_SKIN_API] " .. label .. "_canonical_err=" .. tostring(cerr or ""))
            DebugTableInfo(label .. "_canonical_skins", cdata)
        end
    end
    return ok, data, ownerid
end

-- _G.ccs_skin_request_debug = function(userid, apply)
--     userid = userid or selfid
--     local url = "http://localhost:12024/skin/getSkin?kleiid=" .. tostring(userid) .. "&type=" .. modtype
--     print("[CCS_SKIN_API] request=" .. url)
--     TheSim:QueryServer(url, function(str, succ, code)
--         print("[CCS_SKIN_API] succ=" .. tostring(succ) .. " code=" .. tostring(code))
--         print("[CCS_SKIN_API] raw=" .. tostring(str))
--         if succ and code == 200 then
--             DebugRawInfo("request_raw", str, userid)
--             if apply then
--                 print("[CCS_SKIN_API] request_apply=" .. tostring(SyncRawSkinApiDataToServer(str, true, false)))
--                 DebugTableInfo("selfowner_after_apply", selfowner)
--                 DebugTableInfo("selfowner_tmp_after_apply", selfowner_tmp)
--                 DebugTableInfo("skinowner_self_after_apply", skinowner[selfid])
--                 DebugTableInfo("skinowner_tmp_self_after_apply", skinowner_tmp[selfid])
--             end
--         end
--     end, 'GET')
-- end

-- _G.ccs_skin_force_refresh_debug = function(userid)
--     userid = userid or selfid
--     if userid ~= selfid then
--         print("[CCS_SKIN_API] force_refresh_refused expected_selfid=" .. tostring(selfid) .. " got=" .. tostring(userid))
--         return false
--     end
--     skin_api_failures = 0
--     return RequestSelfSkinApiRaw(true, false)
-- end

-- _G.css_skin_debug = function ()
--     print("[CCS_SKIN_API] selfid=" .. tostring(selfid))
--     print("[CCS_SKIN_API] dedicated=" .. tostring(TheNet:IsDedicated()) .. " is_server=" .. tostring(TheNet:GetIsServer()))
--     print("[CCS_SKIN_API] failures=" .. tostring(skin_api_failures) .. " requesting=" .. tostring(skin_api_requesting))
--     print("[CCS_SKIN_API] rawcache=" .. tostring(rawcache) .. " servercache=" .. tostring(servercache))
--     DebugTableInfo("selfowner", selfowner)
--     DebugTableInfo("selfowner_tmp", selfowner_tmp)
--     DebugTableInfo("skinowner_self", skinowner[selfid])
--     DebugTableInfo("skinowner_tmp_self", skinowner_tmp[selfid])
--     DebugTableInfo("skinowner_userids", skinowner)
--     DebugTableInfo("skinowner_tmp_userids", skinowner_tmp)

--     TheSim:GetPersistentString(rawcache, function(load_success, str)
--         print("[CCS_SKIN_API] cache_load_success=" .. tostring(load_success))
--         DebugRawInfo("cache_raw", str, selfid)
--     end)

--     if TheNet:GetIsServer() then
--         TheSim:GetPersistentString(servercache, function(load_success, str)
--             print("[CCS_SKIN_API] server_cache_load_success=" .. tostring(load_success))
--             print("[CCS_SKIN_API] server_cache_len=" .. tostring(type(str) == "string" and string.len(str) or 0))
--             if load_success and type(str) == "string" and str ~= "" then
--                 local ok, data = pcall(json.decode, str)
--                 print("[CCS_SKIN_API] server_cache_json_ok=" .. tostring(ok and type(data) == "table"))
--                 if ok and type(data) == "table" then
--                     DebugTableInfo("server_cache_owner_userids", data.owner)
--                     DebugTableInfo("server_cache_tmp_userids", data.tmp)
--                     if type(data.owner) == "table" then
--                         DebugTableInfo("server_cache_owner_self", data.owner[selfid])
--                     end
--                     if type(data.tmp) == "table" then
--                         DebugTableInfo("server_cache_tmp_self", data.tmp[selfid])
--                     end
--                 end
--             end
--         end)
--     end
-- end
