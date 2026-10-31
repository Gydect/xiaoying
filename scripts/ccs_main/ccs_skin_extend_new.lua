-- 由 ccs_skin_extend.lua 恢复的明文版本；原文件和加载入口保持不变。
-- 保留原协议、字段名（包括 iems）以及各函数的多返回值顺序。
local skinapi = {}

-- 原协议使用 65 个字符；不能替换成标准 Base64 字符表。
local ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,_-"
local ALPHABET_SIZE = #ALPHABET
local CHARACTER_INDEX = {}
local CACHE_KEY = "ccs_skin_api_cache_v1"
local TIME_KEY_STEP = 600
local TIME_KEY_RANGE = 3600

for index = 1, ALPHABET_SIZE do
    CHARACTER_INDEX[string.sub(ALPHABET, index, index)] = index - 1
end

function skinapi.GetKey()
    return CACHE_KEY
end

local function AddUniqueKey(keys, seen, key)
    if key == nil then
        return
    end
    key = tostring(key)
    if key == "" or seen[key] then
        return
    end
    seen[key] = true
    table.insert(keys, key)
end

-- 兼容旧接口：以本地时间的十分钟边界生成时间戳 key。
function skinapi.GetLegacyTimeKey(offset)
    if os == nil or os.date == nil or os.time == nil then
        return nil
    end
    local now = os.date("%Y-%m-%d %H:%M:%S")
    local minute = math.floor((tonumber(string.sub(now, 15, 16)) or 0) / 10) * 10
    local timestamp = os.time({
        year = tonumber(string.sub(now, 1, 4)),
        month = tonumber(string.sub(now, 6, 7)),
        day = tonumber(string.sub(now, 9, 10)),
        hour = tonumber(string.sub(now, 12, 13)),
        min = minute,
        sec = 0,
    })
    if timestamp == nil then
        return nil
    end
    return timestamp + (offset or 0)
end

function skinapi.GetDecodeKeys(key)
    if key then
        return { key }
    end
    local keys, seen = {}, {}
    AddUniqueKey(keys, seen, skinapi.GetKey())
    AddUniqueKey(keys, seen, skinapi.GetLegacyTimeKey(0))
    for offset = TIME_KEY_STEP, TIME_KEY_RANGE, TIME_KEY_STEP do
        AddUniqueKey(keys, seen, skinapi.GetLegacyTimeKey(-offset))
        AddUniqueKey(keys, seen, skinapi.GetLegacyTimeKey(offset))
    end
    return keys
end

-- 只处理字符表内的字符；原实现会跳过其他字符，且不推进 key 下标。
function skinapi.DecryptString(text, key)
    if type(text) ~= "string" then
        return ""
    end
    key = tostring(key or skinapi.GetKey())
    local key_length = #key
    if key_length <= 0 then
        return ""
    end
    local result, key_index = {}, 1
    for index = 1, #text do
        local character = string.sub(text, index, index)
        local character_index = CHARACTER_INDEX[character]
        local key_position = (key_index - 1) % key_length + 1
        local key_character = string.sub(key, key_position, key_position)
        local shift = CHARACTER_INDEX[key_character]
        if character_index and shift then
            local decoded_index = (character_index - shift + ALPHABET_SIZE) % ALPHABET_SIZE + 1
            result[#result + 1] = string.sub(ALPHABET, decoded_index, decoded_index)
            key_index = key_index + 1
        end
    end
    return table.concat(result)
end

function skinapi.EncryptString(text, key)
    if type(text) ~= "string" then
        return ""
    end
    key = tostring(key or skinapi.GetKey())
    local key_length = #key
    if key_length <= 0 then
        return ""
    end
    local result, key_index = {}, 1
    for index = 1, #text do
        local character = string.sub(text, index, index)
        local character_index = CHARACTER_INDEX[character]
        local key_position = (key_index - 1) % key_length + 1
        local key_character = string.sub(key, key_position, key_position)
        local shift = CHARACTER_INDEX[key_character]
        if character_index and shift then
            local encoded_index = (character_index + shift) % ALPHABET_SIZE + 1
            result[#result + 1] = string.sub(ALPHABET, encoded_index, encoded_index)
            key_index = key_index + 1
        end
    end
    return table.concat(result)
end

function skinapi.IsUserID(userid)
    return type(userid) == "string" and string.match(userid, "^KU_[A-Za-z0-9_%-]+$") ~= nil
end

function skinapi.IsValidSkinCode(code)
    if type(code) ~= "string" or code == "" or #code > 128 then
        return false
    end
    if not string.match(code, "^[A-Za-z0-9_%-]+$") or skinapi.IsUserID(code) then
        return false
    end
    local lower = string.lower(code)
    if lower == "undefined" or lower == "null" or lower == "nil"
        or lower == "true" or lower == "false" then
        return false
    end
    if lower == "mfsnxy" or lower == "cspfxy" then
        return false
    end
    if string.find(lower, "undefined", 1, true) or string.find(lower, "null", 1, true) then
        return false
    end
    return true
end

local function MatchesUserID(userid, expected_userid)
    return expected_userid == nil or expected_userid == "" or userid == expected_userid
end

-- 第一个非空逗号分段可以是玩家 ID，后续有效分段作为皮肤代码。
function skinapi.ParsePayload(text)
    local skins, userid = {}, nil
    if type(text) ~= "string" then
        return skins, userid
    end
    local first = true
    for segment in string.gmatch(text, "[^,]+") do
        local value = string.match(segment, "^%s*(.-)%s*$") or segment
        if first and skinapi.IsUserID(value) then
            userid = value
        elseif skinapi.IsValidSkinCode(value) then
            table.insert(skins, value)
        end
        first = false
    end
    return skins, userid
end

function skinapi.ParseList(text)
    local skins = skinapi.ParsePayload(text)
    return skins
end

function skinapi.BuildPlainText(userid, skins, extra)
    local values = {}
    if skinapi.IsUserID(userid) then
        table.insert(values, userid)
    end
    if type(skins) == "table" then
        for _, code in ipairs(skins) do
            if skinapi.IsValidSkinCode(code) then
                table.insert(values, code)
            end
        end
    elseif type(skins) == "string" then
        for code in string.gmatch(skins, "[^,]+") do
            code = string.match(code, "^%s*(.-)%s*$") or code
            if skinapi.IsValidSkinCode(code) then
                table.insert(values, code)
            end
        end
    end
    if type(extra) == "string" and extra ~= "" then
        extra = string.match(extra, "^%s*(.-)%s*$") or extra
        if skinapi.IsValidSkinCode(extra) then
            table.insert(values, extra)
        end
    end
    return table.concat(values, ",")
end

local function LooksLikePlainPayload(text, modtype)
    if type(text) ~= "string" or text == "" then
        return false
    end
    local skins, userid = skinapi.ParsePayload(text)
    if userid and (#skins > 0
        or string.find(text, "cspfxy", 1, true)
        or string.find(text, "mfsnxy", 1, true)
        or (modtype and string.find(text, modtype, 1, true))) then
        return true
    end
    return false
end

-- 返回：明文、皮肤列表、使用的 key、错误、首次解密结果、玩家 ID。
function skinapi.DecodeEncryptedString(text, key, modtype, expected_userid)
    if type(text) ~= "string" then
        return nil, nil, nil, "payload not string"
    end
    text = string.match(text, "^%s*(.-)%s*$") or text
    if text == "" then
        return "", {}, key or "plain", nil, nil, nil
    end
    local keys = skinapi.GetDecodeKeys(key)
    local first_plain
    for _, candidate in ipairs(keys) do
        local plain = skinapi.DecryptString(text, candidate)
        first_plain = first_plain or plain
        if LooksLikePlainPayload(plain, modtype) then
            local skins, userid = skinapi.ParsePayload(plain)
            if MatchesUserID(userid, expected_userid) then
                return plain, skins, candidate, nil, nil, userid
            end
        end
    end
    return nil, nil, nil, "decrypt failed", first_plain
end

-- 返回：皮肤数据、明文、使用的 key、错误、首次解密结果、玩家 ID。
function skinapi.NormalizeData(payload, modtype, key, expected_userid)
    if type(payload) == "table" then
        local text = payload.data or payload.skin or payload.skins or payload.iems
        if type(text) == "string" then
            text = string.match(text, "^%s*(.-)%s*$") or text
            if text == "" then
                return {}, "", "plain", nil, nil, nil
            end
            if key == nil and LooksLikePlainPayload(text, modtype) then
                local skins, userid = skinapi.ParsePayload(text)
                if MatchesUserID(userid, expected_userid) then
                    return skins, text, "plain", nil, nil, userid
                end
            end
            local plain, skins, usedkey, err, first_plain =
                skinapi.DecodeEncryptedString(text, key, modtype, expected_userid)
            if plain then
                local _, userid = skinapi.ParsePayload(plain)
                return skins, plain, usedkey, nil, nil, userid
            end
            return nil, nil, nil, err, first_plain
        end
        if type(payload.data) == "table" then
            return payload.data
        elseif type(payload.skin) == "table" then
            return payload.skin
        elseif type(payload.skins) == "table" then
            return payload.skins
        end
        return payload
    elseif type(payload) == "string" then
        payload = string.match(payload, "^%s*(.-)%s*$") or payload
        if payload == "" then
            return {}, "", "plain", nil, nil, nil
        end
        if key == nil and LooksLikePlainPayload(payload, modtype) then
            local skins, userid = skinapi.ParsePayload(payload)
            if MatchesUserID(userid, expected_userid) then
                return skins, payload, "plain", nil, nil, userid
            end
        end
        local plain, skins, usedkey, err, first_plain =
            skinapi.DecodeEncryptedString(payload, key, modtype, expected_userid)
        if plain then
            local _, userid = skinapi.ParsePayload(plain)
            return skins, plain, usedkey, nil, nil, userid
        end
        return nil, nil, nil, err, first_plain
    end
    return nil, nil, nil, "unsupported payload"
end

-- 返回：成功标记、皮肤数据、明文（失败时为首次解密结果）、key、错误、玩家 ID。
function skinapi.DecodeResponse(raw, modtype, key, expected_userid)
    local text = raw or ""
    if json ~= nil and json.decode ~= nil then
        local json_ok, decoded = pcall(json.decode, text)
        if json_ok and (type(decoded) == "table" or type(decoded) == "string") then
            local skins, plain, usedkey, err, first_plain, userid =
                skinapi.NormalizeData(decoded, modtype, key, expected_userid)
            if skins then
                return true, skins, plain, usedkey, nil, userid
            end
            return false, nil, first_plain, nil, err or "decrypt failed"
        end
    end
    local skins, plain, usedkey, err, first_plain, userid =
        skinapi.NormalizeData(text, modtype, key, expected_userid)
    if skins then
        return true, skins, plain, usedkey, nil, userid
    end
    return false, nil, first_plain, nil, err or "decrypt failed"
end

-- 使用固定 key 生成缓存格式，并按原逻辑重新校验归属。
function skinapi.BuildCanonicalRaw(userid, skins, plain, modtype)
    if not skinapi.IsUserID(userid) then
        return nil, "invalid userid"
    end
    if type(plain) ~= "string" or plain == "" then
        plain = skinapi.BuildPlainText(userid, skins)
    end
    if type(plain) ~= "string" or plain == "" then
        return nil, "invalid plain"
    end
    local raw = skinapi.EncryptString(plain, skinapi.GetKey())
    if type(raw) ~= "string" or raw == "" then
        return nil, "encrypt failed"
    end
    local ok, _, _, usedkey, err, ownerid =
        skinapi.DecodeResponse(raw, modtype, skinapi.GetKey(), userid)
    if not (ok and ownerid == userid and usedkey == skinapi.GetKey()) then
        return nil, err or "canonical verify failed"
    end
    return raw, nil, plain
end

return skinapi
