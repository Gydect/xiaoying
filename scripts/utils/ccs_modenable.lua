local moddir = KnownModIndex:GetModsToLoad(true)
local enablemods = {}

for k, dir in pairs(moddir) do  --遍历mod的加载列表
    local info = KnownModIndex:GetModInfo(dir)  
    local name = info and info.name or "unknow"
    enablemods[dir] = name   --把mod名字存在表里
end

-- MOD是否开启
local function modenable(name)
    for k, v in pairs(enablemods) do
        if v and (k:match(name) or v:match(name)) then return true end
    end
    return false
end
local ModEnable = Class(function()
    
end)
function ModEnable:SoraEnable() --穹
    if modenable("Sora") then
        return true
    elseif modenable("小穹") then
        return true
    elseif modenable("workshop%-1638724235") then
        return true
    elseif modenable("workshop%-2199027653598519351") then
        return true
    end
    
    return false
end

function ModEnable:YuanziEnable() --乃木园子
    if modenable("乃木园子") then
        return true
    elseif modenable("workshop%-1645013096") then
        return true
    elseif modenable("workshop%-2199027653598519797") then
        return true
    end
    return false
end
function ModEnable:SeeleEnable() --希儿
    if modenable("Seele") then
        return true
    elseif modenable("workshop%-1757943227") then
        return true
    elseif modenable("workshop%-2199027653598521289") then
        return true
    end
    return false
end
function ModEnable:EirudyEnable() --艾露迪
    if modenable("Eirudy[Beta]") then
        return true
    elseif modenable("workshop%-2738170176") then
        return true
    end
    return false
end

function ModEnable:MythEnable() --神话
    if modenable("Myth Words") then
        return true
    elseif modenable("%[DST%] 神话书说") then
        return true
    elseif modenable("workshop%-1991746508") then
        return true
    elseif modenable("workshop%-2199027653598524334") then
        return true
    end
    return false
end

function ModEnable:MythEnable_p() --神话人物
    if modenable("Myth Words112354") then
        return true
    elseif modenable("%[DST%] 神话书说112351") then
        return true
    elseif modenable("workshop%-1699194522") then
        return true
    elseif modenable("workshop%-2199027653598524334") then
        return true
    end
    return false
end

function ModEnable:LegionEnable() --棱镜
    if modenable("[DST] Legion") then
        return true
    elseif modenable("[DST] 棱镜") then
        return true
    elseif modenable("workshop%-1392778117") then
        return true
    elseif modenable("workshop%-2199027653598521852") then
        return true
    end
    return false
end

function ModEnable:MedalEnable() --勋章
    if modenable("Functional Medal") then
        return true
    elseif modenable("能力勋章") then
        return true
    elseif modenable("workshop%-1909182187") then
        return true
    elseif modenable("workshop%-2199027653598522135") then
        return true
    end
    return false
end

function ModEnable:MiniSignEnable() --小木牌
    if modenable("Smart Minisign") then
        return true
    elseif modenable("workshop%-1595631294") then
        return true
    end
    return false
end

function ModEnable:AriaEnable() --艾丽娅
    if modenable("Aria Crystal (Rebuild)") then
        return true
    elseif modenable("workshop%-2418617371") then
        return true
    elseif modenable("workshop%-2199027653598532796") then
        return true
    end
    return false
end

function ModEnable:AsoulEnable() --枝江往事
    if modenable("枝江往事") then
        return true
    elseif modenable("workshop%-2992200942") then
        return true
    elseif modenable("workshop%-2199027653598542322") then
        return true
    end
    return false
end
function ModEnable:SWEnable() --海难
    if modenable("岛屿冒险") then
        return true
    elseif modenable("workshop%-1467214795") then
        return true
    elseif modenable("workshop%-2199027653598536472") then
        return true
    end
    return false
end
function ModEnable:CcsEnable() --小樱
    if modenable("魔卡少女小樱（百变小樱）") then
        return true
    elseif modenable("workshop%-3043439883") then
        return true
    elseif modenable("workshop%-2199027653598543454") then
        return true
    end
    return false
end

function ModEnable:WeaponUpEnable() --武器成长
    if modenable("武器升级(武器成长)") then
        return true
    elseif modenable("workshop%-3062833647") then
        return true
    end
    return false
end

function ModEnable:DengXianEnable() --登仙
    if  modenable("workshop%-3235319974") then 
        return true
    elseif modenable("workshop%-2199027653598545361") then
        return true
    
    elseif modenable("workshop%-3416217571") then
        return true
    end
    return false
end

function ModEnable:FuMoEnable() --附魔
    if  modenable("workshop%-3096210166") then
        return true
    elseif modenable("workshop%-2199027653598544466") then
        return true
    end
    return false
end

function ModEnable:xinjieEnable() --永恒新界
    if  modenable("workshop%-3191348907") then
        return true
    end
    return false
end

function ModEnable:fengyunEnable() --丰耘
    if  modenable("workshop%-3609964985") then
        return true
    end
    return false
end

function ModEnable:mcwEnable() --mcw
    if  modenable("workshop%-3152056502") then
        return true
    end
    return false
end

function ModEnable:mushaEnable() --musha
    if  modenable("workshop%-3435492827") then
        return true
    elseif modenable("workshop%-3481406649") then
        return true
    end
    return false
end

function ModEnable:weishuangEnable() --为爽
    if  modenable("workshop%-2886753796") then
        return true
    end
    return false
end

function ModEnable:lolweaponEnable() --英雄联盟武器
    if  modenable("workshop%-3319931009") then
        return true
    end
    return false
end

function ModEnable:gentlenessEnable() --悠
    if  modenable("workshop%-3283650699") then
        return true
    end
    return false
end

function ModEnable:tastefunEnable() --趣味食物
    if  modenable("workshop%-3347972161") then
        return true
    end
    return false
end

function ModEnable:taopiEnable() --套皮
    if  modenable("workshop%-3612137133") then
        return true
    end
    return false
end

function ModEnable:hualuoEnable() --华洛
    if  modenable("workshop%-3672049393") then
        return true
    end
    return false
end

function ModEnable:tbatEnable() --万物书
    if  modenable("workshop%-3544387985") then
        return true
    end
    return false
end


return ModEnable