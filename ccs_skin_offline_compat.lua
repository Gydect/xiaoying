-- 离线缓存兼容：仅额外识别本文件指定的离线账号，不改变皮肤授权判断。
-- 在 modmain.lua 的 ccs_skin_ownership 导入之前添加：
-- modimport("ccs_skin_offline_compat.lua")
-- 保留此文件在模组根目录；删除上述导入即可停用兼容。
local OFFLINE_USERID = "OU_76561198150749952"
local skinapi = require("ccs_main/ccs_skin_extend")

assert(type(skinapi.IsUserID) == "function", "ccs skin API: IsUserID is missing")

if skinapi._xiaoying_offline_userid ~= OFFLINE_USERID then
    local original = skinapi.IsUserID
    skinapi.IsUserID = function(userid)
        return userid == OFFLINE_USERID or original(userid)
    end
    skinapi._xiaoying_offline_userid = OFFLINE_USERID
end
