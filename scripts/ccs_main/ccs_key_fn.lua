--by : う丶青木
--ps : 转载请注明出处
local SAFE_CHARS =
"\65\66\67\68\69\70\71\72\73\74\75\76\77\78\79\80\81\82\83\84\85\86\87\88\89\90\97\98\99\100\101\102\103\104\105\106\107\108\109\110\111\112\113\114\115\116\117\118\119\120\121\122\48\49\50\51\52\53\54\55\56\57\44\95\45"
local CHAR_COUNT = #SAFE_CHARS
local keyfn = {}
local function round_down_to_nearest_ten(num) return math["\102\108\111\111\114"](num / 0xA) * 0xA end
local function getNumberLength(num)
    local numStr = tostring(num)
    if numStr:sub(0x1, 0x1) == "\45" then numStr = numStr:sub(0x2) end
    return #numStr
end
keyfn["\71\101\116\107\101\121"] = function()
    local time = os["\100\97\116\101"]("\37\89\45\37\109\45\37\100\32\37\72\58\37\77\58\37\83")
    local timeTable = { year = string["\115\117\98"](time, 0x1, 0x4), month = string["\115\117\98"](time, 0x6, 0x7), day =
    string["\115\117\98"](time, 0x9, 0xA), hour = string["\115\117\98"](time, 0xC, 0xD), min = round_down_to_nearest_ten(
    string["\115\117\98"](time, 0xF, 0x10)), sec = 0x0 }
    return os["\116\105\109\101"](timeTable)
end
keyfn["\100\101\99\114\121\112\116"] = function(str, decryptkeykey)
    if str == nil then return "" end
    local key = decryptkeykey or keyfn["\71\101\116\107\101\121"]()
    local decrypted = ""
    local keyLen = getNumberLength(key)
    for i = 0x1, #str do
        local char = string["\115\117\98"](str, i, i)
        local keyChar = string["\115\117\98"](key, ((i - 0x1) % keyLen) + 0x1, ((i - 0x1) % keyLen) + 0x1)
        local charIndex = string["\102\105\110\100"](SAFE_CHARS, char)
        local keyIndex = string["\102\105\110\100"](SAFE_CHARS, keyChar)
        if charIndex and keyIndex then
            local newIndex = ((charIndex - 0x1 - (keyIndex - 0x1) + CHAR_COUNT) % CHAR_COUNT) + 0x1
            decrypted = decrypted .. string["\115\117\98"](SAFE_CHARS, newIndex, newIndex)
        end
    end
    return decrypted
end
local messages = {}
local PopupDialogScreen = require "\115\99\114\101\101\110\115\47\114\101\100\117\120\47\112\111\112\117\112\100\105\97\108\111\103"
local function CcsPushPopupDialog2(title, message, button, fn)
    if not (ThePlayer and ThePlayer["\72\85\68"] and ThePlayer["\72\85\68"]["\99\111\110\116\114\111\108\115"]) then
        table["\105\110\115\101\114\116"](messages, { title, message, button, fn }) end
    local buttonstr = button or STRINGS["\85\73"]["\80\79\80\85\80\68\73\65\76\79\71"]["\79\75"]
    local scr
    local function doclose() TheFrontEnd:PopScreen(scr) end
    scr = PopupDialogScreen(title, message, { { text = buttonstr, cb = function()
        doclose()
        if fn then fn() end
    end } })
    TheFrontEnd:PushScreen(scr)
    local screen = TheFrontEnd:GetActiveScreen()
    if screen then screen:Enable() end
    return scr
end
keyfn["\85\115\101\83\107\105\110\67\68\75"] = function(cdk2, selfid, tile, key)
    local cdk = keyfn["\100\101\99\114\121\112\116"](cdk2, key)
    local playerid = string["\115\117\98"](cdk, 0x1, 11)
    local modname = string["\115\117\98"](cdk, 0xD, 18)
    local skins = string["\115\117\98"](cdk, 0x13, #cdk)
    local result = false
    local skins_tab = {}
    if modname == "\109\102\115\110\120\121" then if playerid == selfid then
            for i in string["\103\109\97\116\99\104"](skins, "\91\94\44\93\43") do table["\105\110\115\101\114\116"](
                skins_tab, i) end
            result = true
            if tile then CcsPushPopupDialog2(
                "\229\176\143\230\168\177\231\154\132\230\184\169\233\166\168\230\143\144\231\164\186",
                    "\230\155\180\230\150\176\229\183\178\230\139\165\230\156\137\231\154\174\232\130\164\230\136\144\229\138\159") end
        else if tile then CcsPushPopupDialog2(
                "\229\176\143\230\168\177\231\154\132\230\184\169\233\166\168\230\143\144\231\164\186",
                    "\233\148\153\232\175\175\239\188\154\52\52\52\52\52\52") end end else if tile then
            CcsPushPopupDialog2("\229\176\143\230\168\177\231\154\132\230\184\169\233\166\168\230\143\144\231\164\186",
                "\233\148\153\232\175\175\239\188\154\51\51\51\51\51\51") end end
    return result, skins_tab
end
keyfn["\85\115\101\83\107\105\110\67\68\75\50"] = function(cdk2, selfid)
    local cdk = keyfn["\100\101\99\114\121\112\116"](cdk2)
    local playerid = string["\115\117\98"](cdk, 0x1, 11)
    local modname = string["\115\117\98"](cdk, 0xD, 26)
    local skins = string["\115\117\98"](cdk, 0x1B, #cdk)
    local skins_tab = {}
    if modname == "\101\108\97\105\110\97\95\99\111\110\118\101\114\116" then if playerid == selfid then for i in string["\103\109\97\116\99\104"](skins, "\91\94\44\93\43") do
                table["\105\110\115\101\114\116"](skins_tab, i) end end end
    return skins_tab
end
return keyfn
