local function CcsItemSkin2(item, name, data, notemp)
    local d = {}
    d.rarity = "木之本樱"
    d.rarityorder = 2
    d.raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 }
    d.release_group = -1001
    -- d.checkfn = CCSAPI.CcsSkinCheckFn
    -- d.checkclientfn = CCSAPI.CcsSkinCheckClientFn
    d.FrameSymbol = "Reward"
    for k, v in pairs(data) do
        d[k] = v
    end
    CCSAPI.MakeItemSkin(item, name, d)
    -- if not notemp then
    --     local d2 = shallowcopy(d)
    --     d2.rarity = "限时体验"
    --     d2.rarityorder = 80
    --     d2.raritycorlor = {0.957, 0.769, 0.188, 1}
    --     d2.FrameSymbol = "heirloom"
    --     d2.name = data.name .. "(限时)"
    --     CCSAPI.MakeItemSkin(item, name .. "_tmp", d2)
    -- end
end

local function CcsItemSkin(item, name, data, notemp)
    local d = {}
    d.rarity = "木之本樱"
    d.rarityorder = 2
    d.raritycorlor = { 0 / 255, 255 / 255, 249 / 255, 1 }
    d.release_group = -1001
    d.FrameSymbol = "Reward"
    d.checkfn = CCSAPI.CcsSkinCheckFn
    d.checkclientfn = CCSAPI.CcsSkinCheckClientFn
    for k, v in pairs(data) do
        d[k] = v
    end
    CCSAPI.MakeItemSkin(item, name, d)
end

CcsItemSkin("ccs_hat1", "ccs_hat1_skins1", {
    name = "学生帽",
    atlas = "images/inventoryimages/ccs_hat1_skins1.xml",
    image = "ccs_hat1_skins1",
    build = "ccs_hat1_skins1",
    bank = "ccs_hat1_skins1",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin2("ccs_hat1", "ccs_hat1_skins2_yx", {
    name = "隐形帽子",
    atlas = "images/inventoryimages/ccs_hat1.xml",
    image = "ccs_hat1",
    build = "ccs_hat1",
    bank = "ccs_hat1",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CCSAPI.MakeItemSkin("ccs_light", "ccs_light_skins1", {
    name = "",
    atlas = "images/inventoryimages/ccs_light.xml",
    image = "ccs_light",
    build = "ccs_light_skins1",
    bank = "ccs_light_skins1",
    basebuild = "ccs_light",
    basebank = "ccs_light",
})

CCSAPI.MakeItemSkin("ccs_light2", "ccs_light2_skins1", {
    name = "",
    atlas = "images/inventoryimages/ccs_light.xml",
    image = "ccs_light",
    build = "ccs_light_skins1",
    bank = "ccs_light_skins1",
    basebuild = "ccs_light",
    basebank = "ccs_light",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_bag', 'images/inventoryimages/ccs_bag.xml', 'ccs_bag')
CcsItemSkin("ccs_bag", "ccs_bag_skins1", {
    name = "友枝学校背包",
    atlas = "images/inventoryimages/ccs_bag_skins1.xml",
    image = "ccs_bag_skins1",
    build = "ccs_bag_skins1",
    bank = "ccs_bag_skins1",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_bag", "ccs_bag_skins2", {
    name = "樱花之翼",
    atlas = "images/inventoryimages/ccs_bag_skins2.xml",
    image = "ccs_bag_skins2",
    build = "ccs_bag_skins2",
    bank = "ccs_bag_skins2",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_bag", "shiranui_fan", {
    name = "定制-不知火",
    atlas = "images/inventoryimages/shiranui_fan.xml",
    image = "shiranui_fan",
    build = "shiranui_fan",
    bank = "shiranui_fan",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_limao", {
    name = "礼帽",
    atlas = "images/inventoryimages/ccs_bag_skin_limao.xml",
    image = "ccs_bag_skin_limao",
    build = "ccs_bag_skin_limao",
    bank = "ccs_bag_skin_limao",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_white", {
    name = "白色蝴蝶结",
    atlas = "images/inventoryimages/ccs_bag_skin_white.xml",
    image = "ccs_bag_skin_white",
    build = "ccs_bag_skin_white",
    bank = "ccs_bag_skin_white",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_bybb", {
    name = "冰樱啵啵",
    atlas = "images/inventoryimages/ccs_bag_skin_bybb.xml",
    image = "ccs_bag_skin_bybb",
    build = "ccs_bag_skin_bybb",
    bank = "ccs_bag_skin_bybb",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_typp", {
    name = "桃樱泡泡",
    atlas = "images/inventoryimages/ccs_bag_skin_typp.xml",
    image = "ccs_bag_skin_typp",
    build = "ccs_bag_skin_typp",
    bank = "ccs_bag_skin_typp",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_magic_wand1", "ccs_magic_wand1_skins1", {
    name = "知世的手杖",
    atlas = "images/inventoryimages/ccs_magic_wand1_skins1.xml",
    image = "ccs_magic_wand1_skins1",
    build = "ccs_magic_wand1_skins1",
    bank = "ccs_magic_wand1_skins1",
    basebuild = "ccs_magic_wand1",
    basebank = "ccs_magic_wand1",
})
CcsItemSkin("ccs_magic_wand1", "ccs_magic_wand1_skin_moon", {
    name = "定制：夜含",
    atlas = "images/inventoryimages/ccs_magic_wand1_skin_moon.xml",
    image = "ccs_magic_wand1_skin_moon",
    build = "ccs_magic_wand1_skin_moon",
    bank = "ccs_magic_wand1_skin_moon",
    basebuild = "ccs_magic_wand1",
    basebank = "ccs_magic_wand1",
})
CCSAPI.MakeItemSkin(
    'ccs_magic_wand1',
    'ccs_magic_wand1_skin_cat',
    {
        name = "定制：玲珑",
        atlas = "images/inventoryimages/ccs_magic_wand2_skin_cat.xml",
        image = "ccs_magic_wand2_skin_cat",
        build = "ccs_magic_wand1_skin_cat",
        bank = "ccs_magic_wand1_skin_cat",
        basebuild = "ccs_magic_wand1",
        basebank = "ccs_magic_wand1",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand2_skin_cat")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand2_skin_cat")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_magic_wand1',
    'ccs_magic_wand1_skin_star',
    {
        name = "定制：天使之翼",
        atlas = "images/inventoryimages/ccs_magic_wand1_skin_star.xml",
        image = "ccs_magic_wand1_skin_star",
        build = "ccs_magic_wand1_skin_star",
        bank = "ccs_magic_wand1_skin_star",
        basebuild = "ccs_magic_wand1",
        basebank = "ccs_magic_wand1",
        clear_fn = function(inst)
            inst:RemoveTag("snowlizifx")
        end,
        init_fn = function(inst)
            inst:AddTag("snowlizifx")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand2_skin_stara")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand2_skin_stara")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_magic_wand1',
    'ccs_magic_wand1_skin_strawberry',
    {
        name = "定制：醉花荫",
        atlas = "images/inventoryimages/ccs_magic_wand1_skin_strawberry.xml",
        image = "ccs_magic_wand1_skin_strawberry",
        build = "ccs_magic_wand1_skin_strawberry",
        bank = "ccs_magic_wand1_skin_strawberry",
        basebuild = "ccs_magic_wand1",
        basebank = "ccs_magic_wand1",
        clear_fn = function(inst)
            inst:RemoveTag("victorianfx")
        end,
        init_fn = function(inst)
            inst:AddTag("victorianfx")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand2_skin_strawberry")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand2_skin_strawberry")
        end
    }
)

CcsItemSkin("ccs_magic_wand1", "ccs_magic_wand1_skin_snx", {
    name = "少年行",
    atlas = "images/inventoryimages/ccs_magic_wand2_snx.xml",
    image = "ccs_magic_wand2_snx",
    build = "ccs_magic_wand2_snx",
    bank = "ccs_magic_wand2_snx",
    basebuild = "ccs_magic_wand1",
    basebank = "ccs_magic_wand1",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand2_snx")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand2_snx")
    end
})
CcsItemSkin("ccs_magic_wand1", "ccs_magic_wand1_skin_yzy", {
    name = "云中桜",
    atlas = "images/inventoryimages/ccs_magic_wand2_yzy.xml",
    image = "ccs_magic_wand2_yzy",
    build = "ccs_magic_wand2_yzy",
    bank = "ccs_magic_wand2_yzy",
    basebuild = "ccs_magic_wand1",
    basebank = "ccs_magic_wand1",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand2_yzy")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand2_yzy")
    end
})

CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand1_skin_lmz", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand1_skin_lmz", {
    name = "定制：柠檬揍",
    atlas = "images/inventoryimages/ccs_magic_wand1_skin_lmz.xml",
    image = "ccs_magic_wand1_skin_lmz",
    build = "ccs_magic_wand1_skin_lmz",
    bank = "ccs_magic_wand1_skin_lmz",
    basebuild = "ccs_magic_wand1",
    basebank = "ccs_magic_wand1",
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skins1", {
    name = "樱花法杖",
    atlas = "images/inventoryimages/ccs_magic_wand2_skins1.xml",
    image = "ccs_magic_wand2_skins1",
    build = "ccs_magic_wand2_skins1",
    bank = "ccs_magic_wand2_skins1",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_cat", {
    name = "定制：玲珑",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_cat.xml",
    image = "ccs_magic_wand2_skin_cat",
    build = "ccs_magic_wand2_skin_cat",
    bank = "ccs_magic_wand2_skin_cat",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_yingcao", {
    name = "定制：萤草",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_yingcao.xml",
    image = "ccs_magic_wand2_skin_yingcao",
    build = "ccs_magic_wand2_skin_yingcao",
    bank = "ccs_magic_wand2_skin_yingcao",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_umbrella", {
    name = "定制：微雨栀落",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_umbrella.xml",
    image = "ccs_magic_wand2_skin_umbrella",
    build = "ccs_magic_wand2_skin_umbrella",
    bank = "ccs_magic_wand2_skin_umbrella",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
    clear_fn = function(inst)
        inst:RemoveTag("snowlizifx")
    end,
    init_fn = function(inst)
        inst:AddTag("snowlizifx")
    end
})
CCSAPI.MakeItemSkin(
    'ccs_magic_wand2',
    'ccs_magic_wand2_skin_moon',
    {
        name = "定制：夜含",
        atlas = "images/inventoryimages/ccs_magic_wand1_skin_moon.xml",
        image = "ccs_magic_wand1_skin_moon",
        build = "ccs_magic_wand2_skin_moon",
        bank = "ccs_magic_wand2_skin_moon",
        basebuild = "ccs_magic_wand2",
        basebank = "ccs_magic_wand2",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand1_skin_moon")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand1_skin_moon")
        end
    }
)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_stara", {
    name = "定制：天使之翼",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_star.xml",
    image = "ccs_magic_wand2_skin_star",
    build = "ccs_magic_wand2_skin_star",
    bank = "ccs_magic_wand2_skin_star",
    build_name_override = "ccs_magic_wand2_skin_star",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
    clear_fn = function(inst)
        inst:RemoveTag("snowlizifx")
    end,
    init_fn = function(inst)
        inst:AddTag("snowlizifx")
    end
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_zt", {
    name = "定制：金格纹枕头",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_zt.xml",
    image = "ccs_magic_wand2_skin_zt",
    build = "ccs_magic_wand2_skin_zt",
    bank = "ccs_magic_wand2_skin_zt",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_strawberry", {
    name = "定制：醉花荫",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_strawberry.xml",
    image = "ccs_magic_wand2_skin_strawberry",
    build = "ccs_magic_wand2_skin_strawberry",
    bank = "ccs_magic_wand2_skin_strawberry",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
    clear_fn = function(inst)
        inst:RemoveTag("victorianfx")
    end,
    init_fn = function(inst)
        inst:AddTag("victorianfx")
    end
})
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_bwb", {
    name = "黑白伞",
    atlas = "images/inventoryimages/ccs_magic_wand2_bwb.xml",
    image = "ccs_magic_wand2_bwb",
    build = "ccs_magic_wand2_bwb",
    bank = "ccs_magic_wand2_bwb",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_snx", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_snx", {
    name = "少年行",
    atlas = "images/inventoryimages/ccs_magic_wand2_snx.xml",
    image = "ccs_magic_wand2_snx",
    build = "ccs_magic_wand2_snx",
    bank = "ccs_magic_wand2_snx",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_yzy", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_yzy", {
    name = "云中桜",
    atlas = "images/inventoryimages/ccs_magic_wand2_yzy.xml",
    image = "ccs_magic_wand2_yzy",
    build = "ccs_magic_wand2_yzy",
    bank = "ccs_magic_wand2_yzy",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_blue", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_blue", {
    name = "定制-小蓝伞",
    atlas = "images/inventoryimages/ccs_magic_wand2_blue.xml",
    image = "ccs_magic_wand2_blue",
    build = "ccs_magic_wand2_blue",
    bank = "ccs_magic_wand2_blue",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_skin_xinyao", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_xinyao", {
    name = "定制-心钥",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_xinyao.xml",
    image = "ccs_magic_wand2_skin_xinyao",
    build = "ccs_magic_wand2_skin_xinyao",
    bank = "ccs_magic_wand2_skin_xinyao",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
    clear_fn = function(inst)
        inst:RemoveTag("snowlizifx")
    end,
    init_fn = function(inst)
        inst:AddTag("snowlizifx")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_skin_guyu", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_skin_guyu", {
    name = "定制-古语",
    atlas = "images/inventoryimages/ccs_magic_wand2_skin_guyu.xml",
    image = "ccs_magic_wand2_skin_guyu",
    build = "ccs_magic_wand2_skin_guyu",
    bank = "ccs_magic_wand2_skin_guyu",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})

CCSAPI.CcsItemAssets(Assets, "ccs_homesign_skin_nangua", true, true)
CcsItemSkin("ccs_homesign", "ccs_homesign_skin_nangua", {
    name = "南瓜橱",
    atlas = "images/inventoryimages/ccs_homesign_skin_nangua.xml",
    image = "ccs_homesign_skin_nangua",
    build = "ccs_homesign_skin_nangua",
    bank = "ccs_homesign_skin_nangua",
    basebuild = "ccs_homesign",
    basebank = "ccs_homesign",
})
CcsItemSkin("ccs_bag", "ccs_bag_skins3", {
    name = "知世做的翅膀",
    atlas = "images/inventoryimages/ccs_bag_skins3.xml",
    image = "ccs_bag_skins3",
    build = "ccs_bag_skins3",
    bank = "ccs_bag_skins3",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_bag", "ccs_bag_skins4", {
    name = "天使之翼",
    atlas = "images/inventoryimages/ccs_bag_skins4.xml",
    image = "ccs_bag_skins4",
    build = "ccs_bag_skins4",
    bank = "ccs_bag_skins4",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_bag", "ccs_bag_skins5", {
    name = "桃花包",
    atlas = "images/inventoryimages/ccs_bag_skins5.xml",
    image = "ccs_bag_skins5",
    build = "ccs_bag_skins5",
    bank = "ccs_bag_skins5",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_dinosaur", {
    name = "定制：恐龙扛喵",
    atlas = "images/inventoryimages/ccs_bag_skin_dinosaur.xml",
    image = "ccs_bag_skin_dinosaur",
    build = "ccs_bag_skin_dinosaur",
    bank = "ccs_bag_skin_dinosaur",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ccs_dinosaur_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})

CcsItemSkin("ccs_bag", "ccs_bag_skin_hanbao", {
    name = "定制：憨包",
    atlas = "images/inventoryimages/ccs_bag_skin_hanbao.xml",
    image = "ccs_bag_skin_hanbao",
    build = "ccs_bag_skin_hanbao",
    bank = "ccs_bag_skin_hanbao",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ccs_hanbao_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_chikawa1", {
    name = "chikawa1",
    atlas = "images/inventoryimages/ccs_bag_skin_chikawa1.xml",
    image = "ccs_bag_skin_chikawa1",
    build = "ccs_bag_skin_chikawa1",
    bank = "ccs_bag_skin_chikawa1",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_chikawa2", {
    name = "chikawa2",
    atlas = "images/inventoryimages/ccs_bag_skin_chikawa2.xml",
    image = "ccs_bag_skin_chikawa2",
    build = "ccs_bag_skin_chikawa2",
    bank = "ccs_bag_skin_chikawa2",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_chikawa3", {
    name = "chikawa3",
    atlas = "images/inventoryimages/ccs_bag_skin_chikawa3.xml",
    image = "ccs_bag_skin_chikawa3",
    build = "ccs_bag_skin_chikawa3",
    bank = "ccs_bag_skin_chikawa3",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_strawberry", {
    name = "定制-草莓背包",
    atlas = "images/inventoryimages/ccs_bag_skin_strawberry.xml",
    image = "ccs_bag_skin_strawberry",
    build = "ccs_bag_skin_strawberry",
    bank = "ccs_bag_skin_strawberry",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CcsItemSkin("ccs_bag", "ccs_bag_skin_xgm", {
    name = "定制-双鱼-星宫莓",
    atlas = "images/inventoryimages/ccs_bag_skin_xgm.xml",
    image = "ccs_bag_skin_xgm",
    build = "ccs_bag_skin_xgm",
    bank = "ccs_bag_skin_xgm",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})

CcsItemSkin("ccs_bag", "ccs_bag_skin_ylxm", {
    name = "定制：雨落星芒",
    atlas = "images/inventoryimages/ccs_bag_skin_ylxm.xml",
    image = "ccs_bag_skin_ylxm",
    build = "ccs_bag_skin_ylxm",
    bank = "ccs_bag_skin_ylxm",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_dzm", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_dzm", {
    name = "定制：蝶之梦",
    atlas = "images/inventoryimages/ccs_bag_skin_dzm.xml",
    image = "ccs_bag_skin_dzm",
    build = "ccs_bag_skin_dzm",
    bank = "ccs_bag_skin_dzm",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_jgzw", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_jgzw", {
    name = "定制：极光之吻",
    atlas = "images/inventoryimages/ccs_bag_skin_jgzw.xml",
    image = "ccs_bag_skin_jgzw",
    build = "ccs_bag_skin_jgzw",
    bank = "ccs_bag_skin_jgzw",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_xiaotu", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_xiaotu", {
    name = "定制：小兔背包",
    atlas = "images/inventoryimages/ccs_bag_skin_xiaotu.xml",
    image = "ccs_bag_skin_xiaotu",
    build = "ccs_bag_skin_xiaotu",
    bank = "ccs_bag_skin_xiaotu",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(4)
            inst.components.container:WidgetSetup("ccs_xiaotu_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})

CcsItemSkin("ccs_bag", "ccs_bag_skin_emo", {
    name = "定制：冕冕",
    atlas = "images/inventoryimages/ccs_bag_skin_emo.xml",
    image = "ccs_bag_skin_emo",
    build = "ccs_bag_skin_emo",
    bank = "ccs_bag_skin_emo",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(12)
            inst.components.container:WidgetSetup("ccs_huihui_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})

CcsItemSkin("ccs_bag", "ccs_bag_skin_huayu", {
    name = "剪纸花语",
    atlas = "images/inventoryimages/ccs_bag_skin_huayu.xml",
    image = "ccs_bag_skin_huayu",
    build = "ccs_bag_skin_huayu",
    bank = "ccs_bag_skin_huayu",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(5)
            inst.components.container:WidgetSetup("ccs_huayu_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_xxcb", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_xxcb", {
    name = "定制：星星翅膀",
    atlas = "images/inventoryimages/ccs_bag_skin_xxcb.xml",
    image = "ccs_bag_skin_xxcb",
    build = "ccs_bag_skin_xxcb",
    bank = "ccs_bag_skin_xxcb",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(6)
            inst.components.container:WidgetSetup("ccs_xxcb_bag")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_hana", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_hana", {
    name = "定制-hana",
    atlas = "images/inventoryimages/ccs_bag_skin_hana.xml",
    image = "ccs_bag_skin_hana",
    build = "ccs_bag_skin_hana",
    bank = "ccs_bag_skin_hana",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(7)
            inst.components.container:WidgetSetup("ccs_bag_skin_hana_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
    -- checkfn = function(inventory, name)
	-- 	return true
	-- end,
	-- checkclientfn = function(inventory, userid, name)
	-- 	return true
	-- end
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_xiaotucha", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_xiaotucha", {
    name = "定制：小兔茶",
    atlas = "images/inventoryimages/ccs_bag_skin_xiaotucha.xml",
    image = "ccs_bag_skin_xiaotucha",
    build = "ccs_bag_skin_xiaotucha",
    bank = "ccs_bag_skin_xiaotucha",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(8)
            inst.components.container:WidgetSetup("ccs_bag_skin_xiaotucha_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_wuxia", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_wuxia", {
    name = "定制：无暇",
    atlas = "images/inventoryimages/ccs_bag_skin_wuxia.xml",
    image = "ccs_bag_skin_wuxia",
    build = "ccs_bag_skin_wuxia",
    bank = "ccs_bag_skin_wuxia",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(9)
            inst.components.container:WidgetSetup("ccs_bag_skin_wuxia_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_yyb", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_yyb", {
    name = "定制：羊羊包",
    atlas = "images/inventoryimages/ccs_bag_yyb.xml",
    image = "ccs_bag_yyb",
    build = "ccs_bag_yyb",
    bank = "ccs_bag_yyb",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(10)
            inst.components.container:WidgetSetup("ccs_bag_yyb_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_bag_skin_xiaohuanghua", true, true)
CcsItemSkin("ccs_bag", "ccs_bag_skin_xiaohuanghua", {
    name = "定制：送你一朵小黄花",
    atlas = "images/inventoryimages/ccs_bag_skin_xiaohuanghua.xml",
    image = "ccs_bag_skin_xiaohuanghua",
    build = "ccs_bag_skin_xiaohuanghua",
    bank = "ccs_bag_skin_xiaohuanghua",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(11)
            inst.components.container:WidgetSetup("ccs_bag_skin_xiaohuanghua_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_bag")
        inst.components.container:Close()
    end,
})
-- CcsItemSkin("ccs_hat1","ccs_hat1_skins2",{
--             name = "魔女战斗帽",
--             atlas = "images/inventoryimages/ccs_hat1_skins2.xml",
--             image = "ccs_hat1_skins2",
--             build = "ccs_hat1_skins2",
--             bank =  "ccs_hat1_skins2",
--             basebuild = "ccs_hat1",
--             basebank =  "ccs_hat1",
--         })
CCSAPI.MakeItemSkinDefaultImage('ccs_starstaff', 'images/inventoryimages/ccs_starstaff.xml', 'ccs_starstaff')
CcsItemAssets(Assets, "ccs_starstaff_skin_pingguo", true, true)
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_pingguo", {
    name = "定制：苹果",
    atlas = "images/inventoryimages/ccs_starstaff_skin_pingguo.xml",
    image = "ccs_starstaff_skin_pingguo",
    build = "ccs_starstaff_skin_pingguo",
    bank = "ccs_starstaff_skin_pingguo",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_flower", {
    name = "花朵法杖",
    atlas = "images/inventoryimages/ccs_starstaff_skin_flower.xml",
    image = "ccs_starstaff_skin_flower",
    build = "ccs_starstaff_skin_flower",
    bank = "ccs_starstaff_skin_flower",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin1", {
    name = "定制-胡桃夹子",
    atlas = "images/inventoryimages/ccs_starstaff_skin1.xml",
    image = "ccs_starstaff_skin1",
    build = "ccs_starstaff_skin1",
    bank = "ccs_starstaff_skin1",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_snow", {
    name = "定制-凝霜",
    atlas = "images/inventoryimages/ccs_starstaff_skin_snow.xml",
    image = "ccs_starstaff_skin_snow",
    build = "ccs_starstaff_skin_snow",
    bank = "ccs_starstaff_skin_snow",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("snowlizifx")
    end,
    init_fn = function(inst)
        inst:AddTag("snowlizifx")
    end
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_star", {
    name = "定制-喵",
    atlas = "images/inventoryimages/ccs_starstaff_skin_star.xml",
    image = "ccs_starstaff_skin_star",
    build = "ccs_starstaff_skin_star",
    bank = "ccs_starstaff_skin_star",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("victorianfx")
    end,
    init_fn = function(inst)
        inst:AddTag("victorianfx")
    end
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_skr", {
    name = "定制-樱の恋",
    atlas = "images/inventoryimages/ccs_starstaff_skin_skr.xml",
    image = "ccs_starstaff_skin_skr",
    build = "ccs_starstaff_skin_skr",
    bank = "ccs_starstaff_skin_skr",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("rosefx")
    end,
    init_fn = function(inst)
        inst:AddTag("rosefx")
    end
})
CcsItemSkin("ccs_starstaff", "ccs_magic_wand3_skins9a", {
    name = "定制-知更鸟法杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins9.xml",
    image = "ccs_magic_wand3_skins9",
    build = "ccs_magic_wand3_skins9",
    bank = "ccs_magic_wand3_skins9",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    build_name_override = "ccs_magic_wand3_skins9",
    clear_fn = function(inst)
        inst:RemoveTag("rainbowfx")
    end,
    init_fn = function(inst)
        inst:AddTag("rainbowfx")
    end
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_dieyu", {
    name = "蝶语",
    atlas = "images/inventoryimages/ccs_starstaff_skin_dieyu.xml",
    image = "ccs_starstaff_skin_dieyu",
    build = "ccs_starstaff_skin_dieyu",
    bank = "ccs_starstaff_skin_dieyu",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
local PLANTS_RANGE = 1.5
local MAX_PLANTS = 18
local plantpool = { 1, 2, 3, 4 }
local PLANTFX_TAGS = { "wormwood_plant_fx" }
local function PlantTick(inst)
    if not inst or not inst:IsValid() then
        return
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    if #TheSim:FindEntities(x, y, z, PLANTS_RANGE, PLANTFX_TAGS) < MAX_PLANTS then
        local map = TheWorld.Map
        local pt = Vector3(0, 0, 0)
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * PLANTS_RANGE,
            3,
            function(offset)
                pt.x = x + offset.x
                pt.z = z + offset.z
                return map:CanPlantAtPoint(pt.x, 0, pt.z)
                    and #TheSim:FindEntities(pt.x, 0, pt.z, .5, PLANTFX_TAGS) < 3
                    and map:IsDeployPointClear(pt, nil, .5)
                    and not map:IsPointNearHole(pt, .4)
            end
        )
        if offset then
            local plant = SpawnPrefab("wormwood_plant_fx")
            plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
            --randomize, favoring ones that haven't been used recently
            local rnd = math.random()
            rnd = table.remove(plantpool, math.clamp(math.ceil(rnd * rnd * #plantpool), 1, #plantpool))
            table.insert(plantpool, rnd)
            plant:SetVariation(rnd)
        end
    end
end
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_blue", {
    name = "定制-花香故里",
    atlas = "images/inventoryimages/ccs_starstaff_skin_blue.xml",
    image = "ccs_starstaff_skin_blue",
    build = "ccs_starstaff_skin_blue",
    bank = "ccs_starstaff_skin_blue",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    init_fn = function(inst)
        if not inst.planttask then
            inst.planttask = inst:DoPeriodicTask(.1, PlantTick)
        end
    end,
    clear_fn = function(inst)
        if inst.planttask then
            inst.planttask:Cancel()
            inst.planttask = nil
        end
    end
})
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_redheart", {
    name = "深红心杖",
    atlas = "images/inventoryimages/ccs_starstaff_skin_redheart.xml",
    image = "ccs_starstaff_skin_redheart",
    build = "ccs_starstaff_skin_redheart",
    bank = "ccs_starstaff_skin_redheart",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_goldwing',
    {
        name = "定制：炽天使之翎",
        atlas = "images/inventoryimages/ccs_magic_wand3_skin_goldwing.xml",
        image = "ccs_magic_wand3_skin_goldwing",
        build = "ccs_magic_wand3_skin_goldwing",
        bank = "ccs_magic_wand3_skin_goldwing",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_goldwing")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_goldwing")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_dll", true, true)
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_dll", {
    name = "定制：叮铃铃",
    atlas = "images/inventoryimages/ccs_starstaff_skin_dll.xml",
    image = "ccs_starstaff_skin_dll",
    build = "ccs_starstaff_skin_dll",
    bank = "ccs_starstaff_skin_dll",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("rainbowfx")
    end,
    init_fn = function(inst)
        inst:AddTag("rainbowfx")
    end
})
CCSAPI.MakeItemSkinDefaultImage('ccs_magic_wand3', 'images/inventoryimages/ccs_magic_wand3.xml', 'ccs_magic_wand3')
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins1", {
    name = "星光法杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins1.xml",
    image = "ccs_magic_wand3_skins1",
    build = "ccs_magic_wand3_skins1",
    bank = "ccs_magic_wand3_skins1",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})

CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins2", {
    name = "星月法杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins2.xml",
    image = "ccs_magic_wand3_skins2",
    build = "ccs_magic_wand3_skins2",
    bank = "ccs_magic_wand3_skins2",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})

CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins3", {
    name = "玉桂伞",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins3.xml",
    image = "ccs_magic_wand3_skins3",
    build = "ccs_magic_wand3_skins3",
    bank = "ccs_magic_wand3_skins3",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})

CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_zhenyin", {
    name = "珍樱杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_zhenyin.xml",
    image = "ccs_magic_wand3_zhenyin",
    build = "ccs_magic_wand3_zhenyin",
    bank = "ccs_magic_wand3_zhenyin",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})

CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins4", {
    name = "定制-绝代制杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins4.xml",
    image = "ccs_magic_wand3_skins4",
    build = "ccs_magic_wand3_skins4",
    bank = "ccs_magic_wand3_skins4",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("greenleaffx")
    end,
    init_fn = function(inst)
        inst:AddTag("greenleaffx")
    end
})

CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins5", {
    name = "定制-心向标仪",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins5.xml",
    image = "ccs_magic_wand3_skins5",
    build = "ccs_magic_wand3_skins5",
    bank = "ccs_magic_wand3_skins5",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins6", {
    name = "定制-救济",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins6.xml",
    image = "ccs_magic_wand3_skins6",
    build = "ccs_magic_wand3_skins6",
    bank = "ccs_magic_wand3_skins6",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins7", {
    name = "定制-朝露",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins7.xml",
    image = "ccs_magic_wand3_skins7",
    build = "ccs_magic_wand3_skins7",
    bank = "ccs_magic_wand3_skins7",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("bubblefx")
    end,
    init_fn = function(inst)
        inst:AddTag("bubblefx")
    end
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_xyym", {
    name = "定制：星月樱梦",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_xyym.xml",
    image = "ccs_magic_wand3_skin_xyym",
    build = "ccs_magic_wand3_skin_xyym",
    bank = "ccs_magic_wand3_skin_xyym",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_xyym',
    {
        name = "定制-星月樱梦",
        atlas = "images/inventoryimages/ccs_starstaff_skin_xyym.xml",
        image = "ccs_starstaff_skin_xyym",
        build = "ccs_starstaff_skin_xyym",
        bank = "ccs_starstaff_skin_xyym",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_xyym")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_xyym")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_hscs", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_hscs", {
    name = "定制：花式传说",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_hscs.xml",
    image = "ccs_magic_wand3_skin_hscs",
    build = "ccs_magic_wand3_skin_hscs",
    bank = "ccs_magic_wand3_skin_hscs",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_hscs", true, true)
CcsItemSkin("ccs_starstaff", "ccs_starstaff_skin_hscs", {
    name = "定制：花式传说",
    atlas = "images/inventoryimages/ccs_starstaff_skin_hscs.xml",
    image = "ccs_starstaff_skin_hscs",
    build = "ccs_starstaff_skin_hscs",
    bank = "ccs_starstaff_skin_hscs",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})

CcsItemSkin("ccs_starstaff", "ccs_starstaff_zhenyin", {
    name = "珍樱杖",
    atlas = "images/inventoryimages/ccs_starstaff_zhenyin.xml",
    image = "ccs_starstaff_zhenyin",
    build = "ccs_starstaff_zhenyin",
    bank = "ccs_starstaff_zhenyin",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins8", {
    name = "定制-天使的花束",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins8.xml",
    image = "ccs_magic_wand3_skins8",
    build = "ccs_magic_wand3_skins8",
    bank = "ccs_magic_wand3_skins8",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin2',
    {
        name = "定制-天使的花束",
        atlas = "images/inventoryimages/ccs_magic_wand3_skins8.xml",
        image = "ccs_magic_wand3_skins8",
        build = "ccs_starstaff_skin2",
        bank = "ccs_starstaff_skin2",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins8")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins8")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin3',
    {
        name = "花梦",
        atlas = "images/inventoryimages/ccs_starstaff_skin3.xml",
        image = "ccs_starstaff_skin3",
        build = "ccs_starstaff_skin3",
        bank = "ccs_starstaff_skin3",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins11")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins11")
        end
    }
)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins10", {
    name = "花雾星芒",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins10.xml",
    image = "ccs_magic_wand3_skins10",
    build = "ccs_magic_wand3_skins10",
    bank = "ccs_magic_wand3_skins10",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("rosefx")
    end,
    init_fn = function(inst)
        inst:AddTag("rosefx")
    end
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins11", {
    name = "花梦",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins11.xml",
    image = "ccs_magic_wand3_skins11",
    build = "ccs_magic_wand3_skins11",
    bank = "ccs_magic_wand3_skins11",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins12", {
    name = "定制：旭日之心",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins12.xml",
    image = "ccs_magic_wand3_skins12",
    build = "ccs_magic_wand3_skins12",
    bank = "ccs_magic_wand3_skins12",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_starstaff", "ccs_magic_wand3_skins13", {
    name = "定制：蝶梦星河",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins13.xml",
    image = "ccs_magic_wand3_skins13",
    build = "ccs_magic_wand3_skins13",
    bank = "ccs_magic_wand3_skins13",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("bluebutterlfyfx")
    end,
    init_fn = function(inst)
        inst:AddTag("bluebutterlfyfx")
    end
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins_heart", {
    name = "定制：心语",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins_heart.xml",
    image = "ccs_magic_wand3_skins_heart",
    build = "ccs_magic_wand3_skins_heart",
    bank = "ccs_magic_wand3_skins_heart",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins14", {
    name = "花朵和月亮",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins14.xml",
    image = "ccs_magic_wand3_skins14",
    build = "ccs_magic_wand3_skins14",
    bank = "ccs_magic_wand3_skins14",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins15", {
    name = "花朵和月亮",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins15.xml",
    image = "ccs_magic_wand3_skins15",
    build = "ccs_magic_wand3_skins15",
    bank = "ccs_magic_wand3_skins15",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins16", {
    name = "定制：浮梦冰华·瑶光",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins16.xml",
    image = "ccs_magic_wand3_skins16",
    build = "ccs_magic_wand3_skins16",
    bank = "ccs_magic_wand3_skins16",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
})
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skins17", {
    name = "定制：纯雪番",
    atlas = "images/inventoryimages/ccs_magic_wand3_skins17.xml",
    image = "ccs_magic_wand3_skins17",
    build = "ccs_magic_wand3_skins17",
    bank = "ccs_magic_wand3_skins17",
    basebuild = "ccs_starstaff",
    basebank = "ccs_starstaff",
    clear_fn = function(inst)
        inst:RemoveTag("canlightglow")
    end,
    init_fn = function(inst)
        inst:AddTag("canlightglow")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_xdzz", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_xdzz", {
    name = "定制：选定之杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_xdzz.xml",
    image = "ccs_magic_wand3_xdzz",
    build = "ccs_magic_wand3_xdzz",
    bank = "ccs_magic_wand3_xdzz",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_xy", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_xy", {
    name = "定制：月上银丝",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_xy.xml",
    image = "ccs_magic_wand3_skin_xy",
    build = "ccs_magic_wand3_skin_xy",
    bank = "ccs_magic_wand3_skin_xy",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("canlightglow")
    end,
    init_fn = function(inst)
        inst:AddTag("canlightglow")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_alxy", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_alxy", {
    name = "定制：爱莉希雅的法杖",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_alxy.xml",
    image = "ccs_magic_wand3_skin_alxy",
    build = "ccs_magic_wand3_skin_alxy",
    bank = "ccs_magic_wand3_skin_alxy",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_alxy", true, true)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_alxy',
    {
        name = "定制：爱莉希雅的法杖",
        atlas = "images/inventoryimages/ccs_starstaff_skin_alxy.xml",
        image = "ccs_starstaff_skin_alxy",
        build = "ccs_starstaff_skin_alxy",
        bank = "ccs_starstaff_skin_alxy",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_alxy")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_alxy")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_hyjl", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_hyjl", {
    name = "定制-寰宇祭灵",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_hyjl.xml",
    image = "ccs_magic_wand3_skin_hyjl",
    build = "ccs_magic_wand3_skin_hyjl",
    bank = "ccs_magic_wand3_skin_hyjl",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_hyjl", true, true)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_hyjl',
    {
        name = "定制：寰宇祭灵",
        atlas = "images/inventoryimages/ccs_starstaff_skin_hyjl.xml",
        image = "ccs_starstaff_skin_hyjl",
        build = "ccs_starstaff_skin_hyjl",
        bank = "ccs_starstaff_skin_hyjl",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_hyjl")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_hyjl")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_gulian", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_gulian", {
    name = "定制-骨念",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_gulian.xml",
    image = "ccs_magic_wand3_skin_gulian",
    build = "ccs_magic_wand3_skin_gulian",
    bank = "ccs_magic_wand3_skin_gulian",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_gulian", true, true)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_gulian',
    {
        name = "定制：骨念",
        atlas = "images/inventoryimages/ccs_starstaff_skin_gulian.xml",
        image = "ccs_starstaff_skin_gulian",
        build = "ccs_starstaff_skin_gulian",
        bank = "ccs_starstaff_skin_gulian",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_hyjl")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_hyjl")
        end
    }
)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_yueguitu", {
    name = "定制：月桂兔",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_yueguitu.xml",
    image = "ccs_magic_wand3_skin_yueguitu",
    build = "ccs_magic_wand3_skin_yueguitu",
    bank = "ccs_magic_wand3_skin_yueguitu",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_xdzz", true, true)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_xdzz',
    {
        name = "定制：选定之杖",
        atlas = "images/inventoryimages/ccs_starstaff_skin_xdzz.xml",
        image = "ccs_starstaff_skin_xdzz",
        build = "ccs_starstaff_skin_xdzz",
        bank = "ccs_starstaff_skin_xdzz",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_xdzz")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_xdzz")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skins_heart',
    {
        name = "定制：心语",
        atlas = "images/inventoryimages/ccs_starstaff_skins_heart.xml",
        image = "ccs_starstaff_skins_heart",
        build = "ccs_starstaff_skins_heart",
        bank = "ccs_starstaff_skins_heart",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins_heart")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins_heart")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_magic_wand3_skins16',
    {
        name = "定制：浮梦冰华·瑶光",
        atlas = "images/inventoryimages/ccs_magic_wand3_skins16.xml",
        image = "ccs_magic_wand3_skins16",
        build = "ccs_magic_wand3_skins16",
        bank = "ccs_magic_wand3_skins16",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins16")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins16")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_xingyu", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_xingyu", {
    name = "定制-星语",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_xingyu.xml",
    image = "ccs_magic_wand3_skin_xingyu",
    build = "ccs_magic_wand3_skin_xingyu",
    bank = "ccs_magic_wand3_skin_xingyu",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("greenleaffx")
    end,
    init_fn = function(inst)
        inst:AddTag("greenleaffx")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_chenxingyuyue", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_chenxingyuyue", {
    name = "定制：晨星与月",
    atlas = "images/inventoryimages/ccs_magic_wand3_chenxingyuyue.xml",
    image = "ccs_magic_wand3_chenxingyuyue",
    build = "ccs_magic_wand3_chenxingyuyue",
    bank = "ccs_magic_wand3_chenxingyuyue",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
    clear_fn = function(inst)
        inst:RemoveTag("snowlizifx")
    end,
    init_fn = function(inst)
        inst:AddTag("snowlizifx")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand3_skin_goldwing", true, true)
CcsItemSkin("ccs_magic_wand3", "ccs_magic_wand3_skin_goldwing", {
    name = "定制：炽天使之翎",
    atlas = "images/inventoryimages/ccs_magic_wand3_skin_goldwing.xml",
    image = "ccs_magic_wand3_skin_goldwing",
    build = "ccs_magic_wand3_skin_goldwing",
    bank = "ccs_magic_wand3_skin_goldwing",
    basebuild = "ccs_magic_wand3",
    basebank = "ccs_magic_wand3",
})
CCSAPI.CcsItemAssets(Assets, "ccs_magic_wand2_xiawucha", true, true)
CcsItemSkin("ccs_magic_wand2", "ccs_magic_wand2_xiawucha", {
    name = "定制：下午茶话会",
    atlas = "images/inventoryimages/ccs_magic_wand2_xiawucha.xml",
    image = "ccs_magic_wand2_xiawucha",
    build = "ccs_magic_wand2_xiawucha",
    bank = "ccs_magic_wand2_xiawucha",
    basebuild = "ccs_magic_wand2",
    basebank = "ccs_magic_wand2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_starstaff_skin_xingyu", true, true)
CCSAPI.MakeItemSkin(
    'ccs_starstaff',
    'ccs_starstaff_skin_xingyu',
    {
        name = "定制：星语",
        atlas = "images/inventoryimages/ccs_starstaff_skin_xingyu.xml",
        image = "ccs_starstaff_skin_xingyu",
        build = "ccs_starstaff_skin_xingyu",
        bank = "ccs_starstaff_skin_xingyu",
        basebuild = "ccs_starstaff",
        basebank = "ccs_starstaff",
        clear_fn = function(inst)
            inst:RemoveTag("greenleaffx")
        end,
        init_fn = function(inst)
            inst:AddTag("greenleaffx")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skin_xingyu")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skin_xingyu")
        end
    }
)
CCSAPI.MakeItemSkinDefaultImage('ccs_xk_item', 'images/inventoryimages/ccs_pack_gift.xml', 'ccs_pack_gift')
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins1", {
    name = "甜品小可",
    atlas = "images/inventoryimages/ccs_xk_skins1.xml",
    image = "ccs_xk_skins1",
    build = "ccs_xk_item_skins1",
    bank = "ccs_xk_item_skins1",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins2", {
    name = "游戏机小可",
    atlas = "images/inventoryimages/ccs_xk_item_skins2.xml",
    image = "ccs_xk_item_skins2",
    build = "ccs_xk_item_skins2",
    bank = "ccs_xk_item_skins2",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins3", {
    name = "天使小可",
    atlas = "images/inventoryimages/ccs_xk_item_skins2.xml",
    image = "ccs_xk_item_skins2",
    build = "ccs_xk_item_skins2",
    bank = "ccs_xk_item_skins2",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins10", {
    name = "定制-天之幼子",
    atlas = "images/inventoryimages/ccs_sb_item_skins10.xml",
    image = "ccs_sb_item_skins10",
    build = "ccs_sb_item_skins10",
    bank = "ccs_sb_item_skins10",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins11", {
    name = "定制-大耳兽",
    atlas = "images/inventoryimages/ccs_xk_item_skins11.xml",
    image = "ccs_xk_item_skins11",
    build = "ccs_sb_item_skins11",
    bank = "ccs_sb_item_skins11",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins12", {
    name = "定制-火灵",
    atlas = "images/inventoryimages/ccs_xk_item_skins12.xml",
    image = "ccs_xk_item_skins12",
    build = "ccs_sb_item_skins12",
    bank = "ccs_sb_item_skins12",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins13", {
    name = "定制-人鱼之歌",
    atlas = "images/inventoryimages/ccs_xk_item_skins13.xml",
    image = "ccs_xk_item_skins13",
    build = "ccs_sb_item_skins13",
    bank = "ccs_sb_item_skins13",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins14", {
    name = "定制-熊仔",
    atlas = "images/inventoryimages/ccs_xk_item_skins14.xml",
    image = "ccs_xk_item_skins14",
    build = "ccs_xk_item_skins14",
    bank = "ccs_xk_item_skins14",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins15", {
    name = "定制-蔡文姬",
    atlas = "images/inventoryimages/ccs_xk_item_skins15.xml",
    image = "ccs_xk_item_skins15",
    build = "ccs_sb_item_skins15",
    bank = "ccs_sb_item_skins15",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins16", {
    name = "定制-瑶",
    atlas = "images/inventoryimages/ccs_xk_item_skins16.xml",
    image = "ccs_xk_item_skins16",
    build = "ccs_sb_item_skins16",
    bank = "ccs_sb_item_skins16",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins17", {
    name = "定制-海獭",
    atlas = "images/inventoryimages/ccs_xk_item_skins17.xml",
    image = "ccs_xk_item_skins17",
    build = "ccs_sb_item_skins17",
    bank = "ccs_sb_item_skins17",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins18", {
    name = "定制-喵鲨",
    atlas = "images/inventoryimages/ccs_xk_item_skins18.xml",
    image = "ccs_xk_item_skins18",
    build = "ccs_sb_item_skins18",
    bank = "ccs_sb_item_skins18",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins21", {
    name = "定制：莓莓",
    atlas = "images/inventoryimages/ccs_xk_item_skins21.xml",
    image = "ccs_xk_item_skins21",
    build = "ccs_sb_item_skins21",
    bank = "kitcoon",
    anim = "idle_loop",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins22", {
    name = "定制：鳕鳕",
    atlas = "images/inventoryimages/ccs_xk_item_skins22.xml",
    image = "ccs_xk_item_skins22",
    build = "ccs_sb_item_skins22",
    bank = "kitcoon",
    anim = "idle_loop",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins23", {
    name = "定制-吟灵悦",
    atlas = "images/inventoryimages/ccs_xk_item_skins23.xml",
    image = "ccs_xk_item_skins23",
    build = "ccs_sb_item_skins23",
    bank = "ccs_sb_item_skins23",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins24", {
    name = "定制：融融月色",
    atlas = "images/inventoryimages/ccs_xk_item_skins24.xml",
    image = "ccs_xk_item_skins24",
    build = "ccs_sb_item_skins24",
    bank = "ccs_sb_item_skins24",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins25", {
    name = "定制：魔法甜兔",
    atlas = "images/inventoryimages/ccs_xk_item_skins25.xml",
    image = "ccs_xk_item_skins25",
    build = "ccs_sb_item_skins25",
    bank = "ccs_sb_item_skins25",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins26", {
    name = "定制：Dolltoy",
    atlas = "images/inventoryimages/ccs_xk_item_skins26.xml",
    image = "ccs_xk_item_skins26",
    build = "ccs_sb_item_skins26",
    bank = "ccs_sb_item_skins26",
    anim = "idle_loop",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_daergou", {
    name = "定制：大耳帽兜",
    atlas = "images/inventoryimages/ccs_xk_item_skin_daergou.xml",
    image = "ccs_xk_item_skin_daergou",
    build = "ccs_sb_item_skin_daergoudimian",
    bank = "moonrock_seed",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_baihe", true, true)
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_baihe", {
    name = "定制：百合少女",
    atlas = "images/inventoryimages/ccs_sb_item_skin_baihe.xml",
    image = "ccs_sb_item_skin_baihe",
    build = "ccs_sb_item_skin_baihe",
    bank = "ccs_sb_item_skin_baihe",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_rzym", true, true)
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_rzym", {
    name = "定制：睿智悠米",
    atlas = "images/inventoryimages/ccs_sb_item_skin_rzym.xml",
    image = "ccs_sb_item_skin_rzym",
    build = "ccs_sb_item_skin_rzym",
    bank = "ccs_sb_item_skin_rzym",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_rzym", {
    name = "定制：睿智悠米",
    atlas = "images/inventoryimages/ccs_sb_item_skin_rzym.xml",
    image = "ccs_sb_item_skin_rzym",
    build = "ccs_sb_item_skin_rzym",
    bank = "ccs_sb_item_skin_rzym",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})


CcsItemSkin("ccs_sb_item", "ccs_sb_item_skinsdilu", {
    name = "定制：迪路兽",
    atlas = "images/inventoryimages/ccs_sb_item_skinsdilu.xml",
    image = "ccs_sb_item_skinsdilu",
    build = "ccs_sb_item_skinsdilu",
    bank = "ccs_sb_item_skinsdilu",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    -- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins6")
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins6")
    --     return true
    -- end
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skinsbada", {
    name = "定制：八达兽",
    atlas = "images/inventoryimages/ccs_sb_item_skinsbada.xml",
    image = "ccs_sb_item_skinsbada",
    build = "ccs_sb_item_skinsbada",
    bank = "ccs_sb_item_skinsbada",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    -- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins6")
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins6")
    --     return true
    -- end
})


CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_baozi", true, true)
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_baozi", {
    name = "定制：包包吃包子",
    atlas = "images/inventoryimages/ccs_sb_item_skin_baozi.xml",
    image = "ccs_sb_item_skin_baozi",
    build = "ccs_sb_item_skin_baozi",
    bank = "ccs_sb_item_skin_baozi",
    anim = "animation",
    animloop = true,
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_baozi", {
    name = "定制：包包吃包子",
    atlas = "images/inventoryimages/ccs_sb_item_skin_baozi.xml",
    image = "ccs_sb_item_skin_baozi",
    build = "ccs_sb_item_skin_baozi",
    bank = "ccs_sb_item_skin_baozi",
    anim = "animation",
    animloop = true,
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_daohe", true, true)
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_daohe", {
    name = "定制：稻荷",
    atlas = "images/inventoryimages/ccs_sb_item_skin_daohe.xml",
    image = "ccs_sb_item_skin_daohe",
    build = "ccs_sb_item_skin_daohe",
    bank = "ccs_sb_item_skin_daohe",
    anim = "idle_loop",
    animloop = true,
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetScale(0.5, 0.5, 0.5)
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(1, 1, 1)
    end,
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_daohe", {
    name = "定制：稻荷",
    atlas = "images/inventoryimages/ccs_sb_item_skin_daohe.xml",
    image = "ccs_sb_item_skin_daohe",
    build = "ccs_sb_item_skin_daohe",
    bank = "ccs_sb_item_skin_daohe",
    anim = "idle_loop",
    animloop = true,
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetScale(0.5, 0.5, 0.5)
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(1, 1, 1)
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_xingye", true, true)
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_xingye", {
    name = "定制：星夜",
    atlas = "images/inventoryimages/ccs_sb_item_skin_xingye.xml",
    image = "ccs_sb_item_skin_xingye",
    build = "ccs_sb_item_skin_xingye",
    bank = "kitcoon",
    anim = "idle_loop",
    animloop = true,
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_xingye", {
    name = "定制：星夜",
    atlas = "images/inventoryimages/ccs_sb_item_skin_xingye.xml",
    image = "ccs_sb_item_skin_xingye",
    build = "ccs_sb_item_skin_xingye",
    bank = "kitcoon",
    anim = "idle_loop",
    animloop = true,
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_skin_ckln", true, true)
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_ckln", {
    name = "定制：春困狸奴",
    atlas = "images/inventoryimages/ccs_sb_item_skin_ckln.xml",
    image = "ccs_sb_item_skin_ckln",
    build = "ccs_sb_item_skin_ckln",
    bank = "ccs_sb_item_skin_ckln",
    anim = "animation",
    animloop = true,
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_ckln", {
    name = "定制：春困狸奴",
    atlas = "images/inventoryimages/ccs_sb_item_skin_ckln.xml",
    image = "ccs_sb_item_skin_ckln",
    build = "ccs_sb_item_skin_ckln",
    bank = "ccs_sb_item_skin_ckln",
    anim = "animation",
    animloop = true,
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CCSAPI.CcsItemAssets(Assets, "ccs_xk_item_skin_xuekeke", true, true)
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skin_xuekeke", {
    name = "定制：雪可可",
    atlas = "images/inventoryimages/ccs_xk_item_skin_xuekeke.xml",
    image = "ccs_xk_item_skin_xuekeke",
    build = "ccs_xk_item_skin_xuekeke",
    bank = "ccs_xk_item_skin_xuekeke",
    anim = "animation",
    animloop = true,
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
    baseanim = "idle",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins_balloon", {
    name = "定制-春日姬",
    atlas = "images/inventoryimages/ccs_xk_item_skins_balloon.xml",
    image = "ccs_xk_item_skins_balloon",
    build = "ccs_xk_item_skins_balloon",
    bank = "ccs_xk_item_skins_balloon",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins_snowy", {
    name = "定制-雪丘丘",
    atlas = "images/inventoryimages/ccs_xk_item_skins_snowy.xml",
    image = "ccs_xk_item_skins_snowy",
    build = "ccs_xk_item_skins_snowy",
    bank = "ccs_xk_item_skins_snowy",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins_fox", {
    name = "定制-桃花姬",
    atlas = "images/inventoryimages/ccs_sb_item_skins_fox.xml",
    image = "ccs_sb_item_skins_fox",
    build = "ccs_sb_item_skins_fox",
    bank = "ccs_sb_item_skins_fox",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins_windbell", {
    name = "定制-梦蝶星喵",
    atlas = "images/inventoryimages/ccs_sb_item_skins_windbell.xml",
    image = "ccs_sb_item_skins_windbell",
    build = "ccs_sb_item_skins_windbell",
    bank = "ccs_sb_item_skins_windbell",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CCSAPI.MakeItemSkinDefaultImage('ccs_sb_item', 'images/inventoryimages/ccs_sb_item.xml', 'ccs_sb_item')
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins1", {
    name = "宝石斯比",
    atlas = "images/inventoryimages/ccs_sb_skins1.xml",
    image = "ccs_sb_skins1",
    build = "ccs_sb_item_skins1",
    bank = "ccs_sb_item_skins1",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins2", {
    name = "恶魔斯比",
    atlas = "images/inventoryimages/ccs_sb_item_skins2.xml",
    image = "ccs_sb_item_skins2",
    build = "ccs_sb_item_skins2",
    bank = "ccs_sb_item_skins2",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins3", {
    name = "大恶魔斯比",
    atlas = "images/inventoryimages/ccs_sb_item_skins2.xml",
    image = "ccs_sb_item_skins2",
    build = "ccs_sb_item_skins2",
    bank = "ccs_sb_item_skins2",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins10", {
    name = "定制-天之幼子",
    atlas = "images/inventoryimages/ccs_sb_item_skins10.xml",
    image = "ccs_sb_item_skins10",
    build = "ccs_sb_item_skins10",
    bank = "ccs_sb_item_skins10",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins11", {
    name = "定制-大耳兽",
    atlas = "images/inventoryimages/ccs_sb_item_skins11.xml",
    image = "ccs_sb_item_skins11",
    build = "ccs_sb_item_skins11",
    bank = "ccs_sb_item_skins11",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins12", {
    name = "定制-火灵",
    atlas = "images/inventoryimages/ccs_sb_item_skins12.xml",
    image = "ccs_sb_item_skins12",
    build = "ccs_sb_item_skins12",
    bank = "ccs_sb_item_skins12",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins13", {
    name = "定制-人鱼之歌",
    atlas = "images/inventoryimages/ccs_sb_item_skins13.xml",
    image = "ccs_sb_item_skins13",
    build = "ccs_sb_item_skins13",
    bank = "ccs_sb_item_skins13",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins14", {
    name = "定制-瑞兔",
    atlas = "images/inventoryimages/ccs_sb_item_skins14.xml",
    image = "ccs_sb_item_skins14",
    build = "ccs_sb_item_skins14",
    bank = "ccs_sb_item_skins14",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins15", {
    name = "定制-蔡文姬",
    atlas = "images/inventoryimages/ccs_sb_item_skins15.xml",
    image = "ccs_sb_item_skins15",
    build = "ccs_sb_item_skins15",
    bank = "ccs_sb_item_skins15",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins16", {
    name = "定制-瑶",
    atlas = "images/inventoryimages/ccs_sb_item_skins16.xml",
    image = "ccs_sb_item_skins16",
    build = "ccs_sb_item_skins16",
    bank = "ccs_sb_item_skins16",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins17", {
    name = "定制-海獭",
    atlas = "images/inventoryimages/ccs_sb_item_skins17.xml",
    image = "ccs_sb_item_skins17",
    build = "ccs_sb_item_skins17",
    bank = "ccs_sb_item_skins17",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins18", {
    name = "定制-喵鲨",
    atlas = "images/inventoryimages/ccs_sb_item_skins18.xml",
    image = "ccs_sb_item_skins18",
    build = "ccs_sb_item_skins18",
    bank = "ccs_sb_item_skins18",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins19", {
    name = "小小樱-你瞅啥",
    atlas = "images/inventoryimages/ccs_sb_item_skins19.xml",
    image = "ccs_sb_item_skins19",
    build = "ccs_sb_item_skins19",
    bank = "ccs_sb_item_skins19",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins20", {
    name = "小小樱-哼 鬼东西",
    atlas = "images/inventoryimages/ccs_sb_item_skins20.xml",
    image = "ccs_sb_item_skins20",
    build = "ccs_sb_item_skins20",
    bank = "ccs_sb_item_skins20",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_appale", {
    name = "定制：太阳果",
    atlas = "images/inventoryimages/ccs_sb_item_skins_appale.xml",
    image = "ccs_sb_item_skins_appale",
    build = "ccs_sb_item_skins_appale",
    bank = "ccs_sb_item_skins_appale",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_appale2", {
    name = "定制：开心果",
    atlas = "images/inventoryimages/ccs_sb_item_skins_appale2.xml",
    image = "ccs_sb_item_skins_appale2",
    build = "ccs_sb_item_skins_appale2",
    bank = "ccs_sb_item_skins_appale2",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins21", {
    name = "定制：莓莓",
    atlas = "images/inventoryimages/ccs_sb_item_skins21.xml",
    image = "ccs_sb_item_skins21",
    build = "ccs_sb_item_skins21",
    bank = "kitcoon",
    anim = "idle_loop",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skinsleo", {
    name = "定制：翼王里奥",
    atlas = "images/inventoryimages/ccs_sb_item_skinsleo.xml",
    image = "ccs_sb_item_skinsleo",
    build = "ccs_sb_item_skinsleo",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
    -- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins6")
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins6")
    --     return true
    -- end
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skinskuleo", {
    name = "定制：哭哭里奥",
    atlas = "images/inventoryimages/ccs_sb_item_skinskuleo.xml",
    image = "ccs_sb_item_skinskuleo",
    build = "ccs_sb_item_skinskuleo",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
    -- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins6")
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins6")
    --     return true
    -- end
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins22", {
    name = "定制：鳕鳕",
    atlas = "images/inventoryimages/ccs_sb_item_skins22.xml",
    image = "ccs_sb_item_skins22",
    build = "ccs_sb_item_skins22",
    bank = "kitcoon",
    anim = "idle_loop",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
    init_fn = function(inst)
        inst.Transform:SetSixFaced()
    end,
    clear_fn = function(inst)
        inst.Transform:SetTwoFaced()
    end,
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_balloon", {
    name = "定制-春日姬",
    atlas = "images/inventoryimages/ccs_xk_item_skins_balloon.xml",
    image = "ccs_xk_item_skins_balloon",
    build = "ccs_xk_item_skins_balloon",
    bank = "ccs_xk_item_skins_balloon",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_snowy", {
    name = "定制-雪丘丘",
    atlas = "images/inventoryimages/ccs_xk_item_skins_snowy.xml",
    image = "ccs_xk_item_skins_snowy",
    build = "ccs_xk_item_skins_snowy",
    bank = "ccs_xk_item_skins_snowy",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_fox", {
    name = "定制-桃花姬",
    atlas = "images/inventoryimages/ccs_sb_item_skins_fox.xml",
    image = "ccs_sb_item_skins_fox",
    build = "ccs_sb_item_skins_fox",
    bank = "ccs_sb_item_skins_fox",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_windbell", {
    name = "定制-梦蝶星喵",
    atlas = "images/inventoryimages/ccs_sb_item_skins_windbell.xml",
    image = "ccs_sb_item_skins_windbell",
    build = "ccs_sb_item_skins_windbell",
    bank = "ccs_sb_item_skins_windbell",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins23", {
    name = "定制-吟灵悦",
    atlas = "images/inventoryimages/ccs_sb_item_skins23.xml",
    image = "ccs_sb_item_skins23",
    build = "ccs_sb_item_skins23",
    bank = "ccs_sb_item_skins23",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins24", {
    name = "定制：融融月色",
    atlas = "images/inventoryimages/ccs_sb_item_skins24.xml",
    image = "ccs_sb_item_skins24",
    build = "ccs_sb_item_skins24",
    bank = "ccs_sb_item_skins24",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins25", {
    name = "定制：魔法甜兔",
    atlas = "images/inventoryimages/ccs_sb_item_skins25.xml",
    image = "ccs_sb_item_skins25",
    build = "ccs_sb_item_skins25",
    bank = "ccs_sb_item_skins25",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins26", {
    name = "定制：Dolltoy",
    atlas = "images/inventoryimages/ccs_sb_item_skins26.xml",
    image = "ccs_sb_item_skins26",
    build = "ccs_sb_item_skins26",
    bank = "ccs_sb_item_skins26",
    anim = "idle_loop",
    baseanim = "idle",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CCSAPI.MakeItemSkinDefaultImage('ccs_flowerpot', 'images/inventoryimages/ccs_flowerpot.xml', 'ccs_flowerpot')
CcsItemSkin2("ccs_flowerpot", "ccs_flowerpot_skin1", {
    name = "魔法花盆",
    atlas = "images/inventoryimages/ccs_flowerpot_skin1.xml",
    image = "ccs_flowerpot_skin1",
    build = "ccs_flowerpot_skin1",
    bank = "ccs_flowerpot_skin1",
    basebuild = "ccs_flowerpot",
    basebank = "ccs_flowerpot",
})
CcsItemSkin2("ccs_flowerpot", "ccs_flowerpot_skin2", {
    name = "魔法花盆",
    atlas = "images/inventoryimages/ccs_flowerpot_skin2.xml",
    image = "ccs_flowerpot_skin2",
    build = "ccs_flowerpot_skin2",
    bank = "ccs_flowerpot_skin2",
    basebuild = "ccs_flowerpot",
    basebank = "ccs_flowerpot",
})
CcsItemSkin2("ccs_flowerpot", "ccs_flowerpot_skin3", {
    name = "魔法花盆",
    atlas = "images/inventoryimages/ccs_flowerpot_skin3.xml",
    image = "ccs_flowerpot_skin3",
    build = "ccs_flowerpot_skin3",
    bank = "ccs_flowerpot_skin3",
    basebuild = "ccs_flowerpot",
    basebank = "ccs_flowerpot",
})
CcsItemSkin2("ccs_flowerpot", "ccs_flowerpot_skin4", {
    name = "魔法花盆",
    atlas = "images/inventoryimages/ccs_flowerpot_skin4.xml",
    image = "ccs_flowerpot_skin4",
    build = "ccs_flowerpot_skin4",
    bank = "ccs_flowerpot_skin4",
    basebuild = "ccs_flowerpot",
    basebank = "ccs_flowerpot",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_hat1', 'images/inventoryimages/ccs_hat1.xml', 'ccs_hat1')
CcsItemSkin("ccs_hat1", "ccs_hat_skins3", {
    name = "樱の簪花",
    atlas = "images/inventoryimages/ccs_hat_skins3.xml",
    image = "ccs_hat_skins3",
    build = "ccs_hat_skins3",
    bank = "ccs_hat_skins3",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins_dancecat", {
    name = "定制：为你打call",
    atlas = "images/inventoryimages/ccs_hat_skins_dancecat.xml",
    image = "ccs_hat_skins_dancecat",
    build = "ccs_hat_skins_dancecat",
    bank = "ccs_hat_skins_dancecat",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
    -- checkfn = function(inventory, name)
	-- 	return true
	-- end,
	-- checkclientfn = function(inventory, userid, name)
	-- 	return true
	-- end
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins4", {
    name = "98颗星星",
    atlas = "images/inventoryimages/ccs_hat_skins4.xml",
    image = "ccs_hat_skins4",
    build = "ccs_hat_skins4",
    bank = "ccs_hat_skins4",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins5", {
    name = "98颗流星",
    atlas = "images/inventoryimages/ccs_hat_skins4.xml",
    image = "ccs_hat_skins4",
    build = "ccs_hat_skins4",
    bank = "ccs_hat_skins4",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins6", {
    name = "红桃王冠",
    atlas = "images/inventoryimages/ccs_hat_skins6.xml",
    image = "ccs_hat_skins6",
    build = "ccs_hat_skins6",
    bank = "ccs_hat_skins6",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins7", {
    name = "星星王冠",
    atlas = "images/inventoryimages/ccs_hat_skins7.xml",
    image = "ccs_hat_skins7",
    build = "ccs_hat_skins7",
    bank = "ccs_hat_skins7",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins8", {
    name = "格格帽",
    atlas = "images/inventoryimages/ccs_hat_skins8.xml",
    image = "ccs_hat_skins8",
    build = "ccs_hat_skins8",
    bank = "ccs_hat_skins8",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin2("ccs_hat1", "ccs_hat_skin_cn", {
    name = "中华娘",
    atlas = "images/inventoryimages/ccs_hat_skin_cn.xml",
    image = "ccs_hat_skin_cn",
    build = "ccs_hat_skin_cn",
    bank = "ccs_hat_skin_cn",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_kinomoto", {
    name = "定制：Kinomoto",
    atlas = "images/inventoryimages/ccs_hat_kinomoto.xml",
    image = "ccs_hat_kinomoto",
    build = "ccs_hat_kinomoto",
    bank = "ccs_hat_kinomoto",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skins_pinkcollege", {
    name = "粉色学院帽",
    atlas = "images/inventoryimages/ccs_hat_skins_pinkcollege.xml",
    image = "ccs_hat_skins_pinkcollege",
    build = "ccs_hat_skins_pinkcollege",
    bank = "ccs_hat_skins_pinkcollege",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_spring", {
    name = "春之樱",
    atlas = "images/inventoryimages/ccs_hat_skin_spring.xml",
    image = "ccs_hat_skin_spring",
    build = "ccs_hat_skin_spring",
    bank = "ccs_hat_skin_spring",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_limao", {
    name = "礼帽",
    atlas = "images/inventoryimages/ccs_hat_skin_limao.xml",
    image = "ccs_hat_skin_limao",
    build = "ccs_hat_skin_limao",
    bank = "ccs_hat_skin_limao",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_qqj", {
    name = "定制：千千绝",
    atlas = "images/inventoryimages/ccs_hat_skin_qqj.xml",
    image = "ccs_hat_skin_qqj",
    build = "ccs_hat_skin_qqj",
    bank = "ccs_hat_skin_qqj",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_alice", {
    name = "爱丽丝",
    atlas = "images/inventoryimages/ccs_hat_skin_alice.xml",
    image = "ccs_hat_skin_alice",
    build = "ccs_hat_skin_alice",
    bank = "ccs_hat_skin_alice",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_catear", {
    name = "粉色猫耳",
    atlas = "images/inventoryimages/ccs_hat_skin_catear.xml",
    image = "ccs_hat_skin_catear",
    build = "ccs_hat_skin_catear",
    bank = "ccs_hat_skin_catear",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_kioku", {
    name = "定制：小小回忆",
    atlas = "images/inventoryimages/ccs_hat_skin_kioku.xml",
    image = "ccs_hat_skin_kioku",
    build = "ccs_hat_skin_kioku",
    bank = "ccs_hat_skin_kioku",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_star", {
    name = "星河入梦",
    atlas = "images/inventoryimages/ccs_hat_skin_star.xml",
    image = "ccs_hat_skin_star",
    build = "ccs_hat_skin_star",
    bank = "ccs_hat_skin_star",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
    clear_fn = function(inst)
        inst.AnimState:PlayAnimation("idle")
    end,
    init_fn = function(inst)
        inst.AnimState:PlayAnimation("idle", true)
    end
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_bronya", {
    name = "定制：蝴蝶结丝带",
    atlas = "images/inventoryimages/ccs_hat_skin_bronya.xml",
    image = "ccs_hat_skin_bronya",
    build = "ccs_hat_skin_bronya",
    bank = "ccs_hat_skin_bronya",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
    clear_fn = function(inst)
        inst.AnimState:PlayAnimation("idle")
    end,
    init_fn = function(inst)
        inst.AnimState:PlayAnimation("idle", true)
    end
})

CcsItemSkin("ccs_hat1", "ccs_hat_skin_chuqing", {
    name = "定制：初晴",
    atlas = "images/inventoryimages/ccs_hat_skin_chuqing.xml",
    image = "ccs_hat_skin_chuqing",
    build = "ccs_hat_skin_chuqing",
    bank = "ccs_hat_skin_chuqing",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_hat1", "ccs_hat_skin_white", {
    name = "白色头冠",
    atlas = "images/inventoryimages/ccs_hat_skin_white.xml",
    image = "ccs_hat_skin_white",
    build = "ccs_hat_skin_white",
    bank = "ccs_hat_skin_white",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_hat1", "ccs_hat_skin_lotus", {
    name = "荷花",
    atlas = "images/inventoryimages/ccs_hat_skin_lotus.xml",
    image = "ccs_hat_skin_lotus",
    build = "ccs_hat_skin_lotus",
    bank = "ccs_hat_skin_lotus",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})

CcsItemSkin("ccs_hat1", "ccs_hat_zr", {
    name = "灼蕊",
    atlas = "images/inventoryimages/ccs_hat_zr.xml",
    image = "ccs_hat_zr",
    build = "ccs_hat_zr",
    bank = "ccs_hat_zr",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_hat1", "ccs_hat_skin_rb", {
    name = "定制：桂花兔兔",
    atlas = "images/inventoryimages/ccs_hat_skin_rb.xml",
    image = "ccs_hat_skin_rb",
    build = "ccs_hat_skin_rb",
    bank = "ccs_hat_skin_rb",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_hat1", "ccs_hat_skin_ylxm", {
    name = "定制：雨落星芒",
    atlas = "images/inventoryimages/ccs_hat_skin_ylxm.xml",
    image = "ccs_hat_skin_ylxm",
    build = "ccs_hat_skin_ylxm",
    bank = "ccs_hat_skin_ylxm",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_hat1", "ccs_hat_skin_sdyy", {
    name = "圣诞游园",
    atlas = "images/inventoryimages/ccs_hat_skin_sdyy.xml",
    image = "ccs_hat_skin_sdyy",
    build = "ccs_hat_skin_sdyy",
    bank = "ccs_hat_skin_sdyy",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_hat_skin_dzm", true, true)
CcsItemSkin("ccs_hat1", "ccs_hat_skin_dzm", {
    name = "定制：蝶之梦",
    atlas = "images/inventoryimages/ccs_hat_skin_dzm.xml",
    image = "ccs_hat_skin_dzm",
    build = "ccs_hat_skin_dzm",
    bank = "ccs_hat_skin_dzm",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_hat_skin_jgzw", true, true)
CcsItemSkin("ccs_hat1", "ccs_hat_skin_jgzw", {
    name = "定制：极光之吻",
    atlas = "images/inventoryimages/ccs_hat_skin_jgzw.xml",
    image = "ccs_hat_skin_jgzw",
    build = "ccs_hat_skin_jgzw",
    bank = "ccs_hat_skin_jgzw",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_hat_skin_chwy", true, true)
CcsItemSkin("ccs_hat1", "ccs_hat_skin_chwy", {
    name = "春和物语",
    atlas = "images/inventoryimages/ccs_hat_skin_chwy.xml",
    image = "ccs_hat_skin_chwy",
    build = "ccs_hat_skin_chwy",
    bank = "ccs_hat_skin_chwy",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_hat_skin_adastra", true, true)
CcsItemSkin("ccs_hat1", "ccs_hat_skin_adastra", {
    name = "定制：Per aspera",
    atlas = "images/inventoryimages/ccs_hat_skin_adastra.xml",
    image = "ccs_hat_skin_adastra",
    build = "ccs_hat_skin_adastra",
    bank = "ccs_hat_skin_adastra",
    basebuild = "ccs_hat1",
    basebank = "ccs_hat1",
})
CcsItemSkin("ccs_light3", "ccs_light3_skins1", {
    name = "森林里的星星",
    atlas = "images/inventoryimages/ccs_light3_skins1.xml",
    image = "ccs_light3_skins1",
    build = "ccs_light3_skins1",
    bank = "ccs_light3_skins1",
    basebuild = "ccs_light3",
    basebank = "ccs_light3",
    clear_fn = function(inst)
        inst.AnimState:PlayAnimation("idle")
    end,
    init_fn = function(inst)
        inst.AnimState:PlayAnimation("idle", true)
    end
})

CcsItemSkin2("ccs_light3", "ccs_light3_skins2", {
    name = "小可的灯",
    atlas = "images/inventoryimages/ccs_light3_skins2.xml",
    image = "ccs_light3_skins2",
    build = "ccs_light3_skins2",
    bank = "ccs_light3_skins2",
    basebuild = "ccs_light3",
    basebank = "ccs_light3",
})
CcsItemSkin("ccs_light3", "ccs_light3_skins3", {
    name = "定制：彩虹菇菇",
    atlas = "images/inventoryimages/ccs_light3_skins3.xml",
    image = "ccs_light3_skins3",
    build = "ccs_light3_skins3",
    bank = "ccs_light3_skins3",
    basebuild = "ccs_light3",
    basebank = "ccs_light3",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ui_ccs_light3_skins3")
            inst.components.container:Close()
        end
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_light3")
        inst.components.container:Close()
        if inst.Transform then
            inst.Transform:SetScale(2.2, 2.2, 2.2)
        end
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_light3_skin_xingyuan", true, true)
CcsItemSkin("ccs_light3", "ccs_light3_skin_xingyuan", {
    name = "定制：星愿",
    atlas = "images/inventoryimages/ccs_light3_skin_xingyuan.xml",
    image = "ccs_light3_skin_xingyuan",
    build = "ccs_light3_skin_xingyuan",
    bank = "ccs_light3_skin_xingyuan",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_light3",
    basebank = "ccs_light3",
    baseanim = "idle",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ui_ccs_light3_skin_xingyuan")
            inst.components.container:Close()
        end
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_light3")
        inst.components.container:Close()
        if inst.Transform then
            inst.Transform:SetScale(2.2, 2.2, 2.2)
        end
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_light3_lyxz", true, true)
CcsItemSkin("ccs_light3", "ccs_light3_lyxz", {
    name = "定制-落樱星盏",
    atlas = "images/inventoryimages/ccs_light3_lyxz.xml",
    image = "ccs_light3_lyxz",
    build = "ccs_light3_lyxz",
    bank = "ccs_light3_lyxz",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_light3",
    basebank = "ccs_light3",
    baseanim = "idle",
})
CcsItemSkin2("ccs_miniboatlantern", "ccs_miniboatlantern_skins1", {
    name = "水灯2",
    atlas = "images/inventoryimages/ccs_miniboatlantern_skins1.xml",
    image = "ccs_miniboatlantern_skins1",
    build = "ccs_miniboatlantern_skins1",
    bank = "ccs_miniboatlantern_skins1",
    basebuild = "ccs_miniboatlantern",
    basebank = "ccs_miniboatlantern",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_cards_12', 'images/inventoryimages/ccs_cards/ccs_cards_12.xml', 'ccs_cards_12')
CcsItemSkin("ccs_cards_12", "ccs_sword_skins1", {
    name = "冰花之剑",
    atlas = "images/inventoryimages/ccs_sword_skins1.xml",
    image = "ccs_sword_skins1",
    build = "ccs_sword_skins1",
    bank = "ccs_sword_skins1",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_12", "ccs_sword_skins2", {
    name = "定制-一念花开",
    atlas = "images/inventoryimages/ccs_sword_skins2.xml",
    image = "ccs_sword_skins2",
    build = "ccs_sword_skins2",
    bank = "ccs_sword_skins2",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_12", "ccs_sword_skins3", {
    name = "定制-青霜之刃",
    atlas = "images/inventoryimages/ccs_sword_skins3.xml",
    image = "ccs_sword_skins3",
    build = "ccs_sword_skins3",
    bank = "ccs_sword_skins3",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_12", "ccs_sword_skins4", {
    name = "定制-闇一文字",
    atlas = "images/inventoryimages/ccs_sword_skins4.xml",
    image = "ccs_sword_skins4",
    build = "ccs_sword_skins4",
    bank = "ccs_sword_skins4",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skin_qingying", {
    name = "定制-清影",
    atlas = "images/inventoryimages/ccs_sword_skin_qingying.xml",
    image = "ccs_sword_skin_qingying",
    build = "ccs_sword_skin_qingying",
    bank = "ccs_sword_skin_qingying",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins6", {
    name = "定制-擷生之径",
    atlas = "images/inventoryimages/ccs_sword_skins6.xml",
    image = "ccs_sword_skins6",
    build = "ccs_sword_skins6",
    bank = "ccs_sword_skins6",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins7", {
    name = "定制：知梨浅浅",
    atlas = "images/inventoryimages/ccs_sword_skins7.xml",
    image = "ccs_sword_skins7",
    build = "ccs_sword_skins7",
    bank = "ccs_sword_skins7",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins8a", {
    name = "定制：绯樱幻梦",
    atlas = "images/inventoryimages/ccs_sword_skins8.xml",
    image = "ccs_sword_skins8",
    build = "ccs_sword_skins8",
    bank = "ccs_sword_skins8",
    build_name_override = "ccs_sword_skins8",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
    clear_fn = function(inst)
        inst:RemoveTag("ccs_flhm_fx")
    end,
    init_fn = function(inst)
        inst:AddTag("ccs_flhm_fx")
    end
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins9", {
    name = "定制--星芒紫绽",
    atlas = "images/inventoryimages/ccs_sword_skins9.xml",
    image = "ccs_sword_skins9",
    build = "ccs_sword_skins9",
    bank = "ccs_sword_skins9",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins10", {
    name = "定制--樱之凛",
    atlas = "images/inventoryimages/ccs_sword_skins10.xml",
    image = "ccs_sword_skins10",
    build = "ccs_sword_skins10",
    bank = "ccs_sword_skins10",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_12", "ccs_sword_skins_chaidie", {
    name = "钗蝶语双",
    atlas = "images/inventoryimages/ccs_sword_skins_chaidie.xml",
    image = "ccs_sword_skins_chaidie",
    build = "ccs_sword_skins_chaidie",
    bank = "ccs_sword_skins_chaidie",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_12", "ccs_sword_skins11", {
    name = "定制-绯红之主",
    atlas = "images/inventoryimages/ccs_sword_skins11.xml",
    image = "ccs_sword_skins11",
    build = "ccs_sword_skins11",
    bank = "ccs_sword_skins11",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
    clear_fn = function(inst)
        inst:RemoveTag("ccs_redswordfx")
    end,
    init_fn = function(inst)
        inst:AddTag("ccs_redswordfx")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_sword_skin_dieying", true, true)
CcsItemSkin("ccs_cards_12", "ccs_sword_skin_dieying", {
    name = "定制-蝶影",
    atlas = "images/inventoryimages/ccs_sword_skin_dieying.xml",
    image = "ccs_sword_skin_dieying",
    build = "ccs_sword_skin_dieying",
    bank = "ccs_sword_skin_dieying",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.MakeItemSkin(
    'ccs_cards_12',
    'ccs_sword_skins5',
    {
        name = "定制-救济",
        atlas = "images/inventoryimages/ccs_sword_skins5.xml",
        image = "ccs_sword_skins5",
        build = "ccs_sword_skins5",
        bank = "ccs_sword_skins5",
        basebuild = "ccs_cards",
        basebank = "ccs_cards",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_magic_wand3_skins6")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_magic_wand3_skins6")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_sword_skin_yzr", true, true)
CcsItemSkin("ccs_cards_12", "ccs_sword_skin_yzr", {
    name = "定制-刃中月",
    atlas = "images/inventoryimages/ccs_sword_skin_yzr.xml",
    image = "ccs_sword_skin_yzr",
    build = "ccs_sword_skin_yzr",
    bank = "ccs_sword_skin_yzr",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sword_skin_mmd", true, true)
CcsItemSkin("ccs_cards_12", "ccs_sword_skin_mmd", {
    name = "定制-喵喵打",
    atlas = "images/inventoryimages/ccs_sword_skin_mmd.xml",
    image = "ccs_sword_skin_mmd",
    build = "ccs_sword_skin_mmd",
    bank = "ccs_sword_skin_mmd",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_cards_15', 'images/inventoryimages/ccs_cards/ccs_cards_15.xml', 'ccs_cards_15')
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_rain", {
    name = "白雨心弦",
    atlas = "images/inventoryimages/ccs_bow_skin_rain.xml",
    image = "ccs_bow_skin_rain",
    build = "ccs_bow_skin_rain",
    bank = "ccs_bow_skin_rain",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_rain2", {
    name = "白雨心弦",
    atlas = "images/inventoryimages/ccs_bow_skin_rain2.xml",
    image = "ccs_bow_skin_rain2",
    build = "ccs_bow_skin_rain2",
    bank = "ccs_bow_skin_rain2",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bow_skin_mwml", true, true, {
    Asset("ANIM", "anim/ccs_arrow_skin_mwml.zip"),
})
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_mwml", {
    name = "定制：莓完莓了",
    atlas = "images/inventoryimages/ccs_bow_skin_mwml.xml",
    image = "ccs_bow_skin_mwml",
    build = "ccs_bow_skin_mwml",
    bank = "ccs_bow_skin_mwml",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_15", "ccs_bow_skin_madoka", {
    name = "定制-圆环之理",
    atlas = "images/inventoryimages/ccs_bow_skin_madoka.xml",
    image = "ccs_bow_skin_madoka",
    build = "ccs_bow_skin_madoka",
    bank = "ccs_bow_skin_madoka",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_15", "ccs_bow_skin_amosi", {
    name = "定制-阿莫斯之弓",
    atlas = "images/inventoryimages/ccs_bow_skin_amosi.xml",
    image = "ccs_bow_skin_amosi",
    build = "ccs_bow_skin_amosi",
    bank = "ccs_bow_skin_amosi",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})

CcsItemSkin("ccs_cards_15", "ccs_bow_skin_rose", {
    name = "定制：荆棘玫瑰之弓",
    atlas = "images/inventoryimages/ccs_bow_skin_rose.xml",
    image = "ccs_bow_skin_rose",
    build = "ccs_bow_skin_rose",
    bank = "ccs_bow_skin_rose",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_green", {
    name = "定制：祈月微微",
    atlas = "images/inventoryimages/ccs_bow_skin_green.xml",
    image = "ccs_bow_skin_green",
    build = "ccs_bow_skin_green",
    bank = "ccs_bow_skin_green",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_bycx", {
    name = "定制--碧叶缠弦",
    atlas = "images/inventoryimages/ccs_bow_skin_bycx.xml",
    image = "ccs_bow_skin_bycx",
    build = "ccs_bow_skin_bycx",
    bank = "ccs_bow_skin_bycx",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_wing", {
    name = "白银翼弓",
    atlas = "images/inventoryimages/ccs_bow_skin_wing.xml",
    image = "ccs_bow_skin_wing",
    build = "ccs_bow_skin_wing",
    bank = "ccs_bow_skin_wing",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bow_skin_xingchen", true, true)
CcsItemSkin("ccs_cards_15", "ccs_bow_skin_xingchen", {
    name = "定制：星辰弓",
    atlas = "images/inventoryimages/ccs_bow_skin_xingchen.xml",
    image = "ccs_bow_skin_xingchen",
    build = "ccs_bow_skin_xingchen",
    bank = "ccs_bow_skin_xingchen",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.CcsItemAssets(Assets, "ccs_bow_zwzj", true, true)
CcsItemSkin("ccs_cards_15", "ccs_bow_zwzj", {
    name = "定制-真我之境",
    atlas = "images/inventoryimages/ccs_bow_zwzj.xml",
    image = "ccs_bow_zwzj",
    build = "ccs_bow_zwzj",
    bank = "ccs_bow_zwzj",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CCSAPI.MakeItemSkinDefaultImage('ccs_cards_21', 'images/inventoryimages/ccs_cards/ccs_cards_21.xml', 'ccs_cards_21')
CcsItemSkin("ccs_cards_21", "ccs_cards_21_skins1", {
    name = "定制-未命名",
    atlas = "images/inventoryimages/ccs_cards_21_skins1.xml",
    image = "ccs_cards_21_skins1",
    build = "ccs_cards_21_skins1",
    bank = "ccs_cards_21_skins1",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_21", "ccs_cards_21_skins2", {
    name = "定制-气场-星宫莓",
    atlas = "images/inventoryimages/ccs_cards_21_skins2.xml",
    image = "ccs_cards_21_skins2",
    build = "ccs_cards_21_skins2",
    bank = "ccs_cards_21_skins2",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
CcsItemSkin("ccs_cards_21", "ccs_cards_21_skins3", {
    name = "定制-糖牌",
    atlas = "images/inventoryimages/ccs_cards_21_skins3.xml",
    image = "ccs_cards_21_skins3",
    build = "ccs_cards_21_skins3",
    bank = "ccs_cards_21_skins3",
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
})
--飞牌：地面动画循环播放 ccs_cards_26；飞行时改播 ccs_fly_zhimeng（见 ccs_api.lua 的 CCS_FLY_SKINS）
CCSAPI.CcsItemAssets(Assets, "ccs_cards_26_skin_zhimeng", true, true, {Asset("ANIM", "anim/ccs_fly_zhimeng.zip")})
CCSAPI.MakeItemSkinDefaultImage('ccs_cards_26', 'images/inventoryimages/ccs_cards/ccs_cards_26.xml', 'ccs_cards_26')
CcsItemSkin("ccs_cards_26", "ccs_cards_26_skin_zhimeng", { --TODO 测试用，无需解锁；测试完改回 CcsItemSkin
    name = "定制：织梦",
    atlas = "images/inventoryimages/ccs_cards_26_skin_zhimeng.xml",
    image = "ccs_cards_26_skin_zhimeng",
    build = "ccs_cards_26_skin_zhimeng",
    bank = "ccs_cards_26_skin_zhimeng",
    anim = "ccs_cards_26",
    animloop = true,
    basebuild = "ccs_cards",
    basebank = "ccs_cards",
    baseanim = "ccs_cards_26",
    baseanimloop = true,
})
--
CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins1", {
    name = "吉依",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins1.xml",
    image = "ccs_sb_item_sxz_skins1",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins1",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins2", {
    name = "吉依2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins1.xml",
    image = "ccs_sb_item_sxz_skins1",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins1",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins3", {
    name = "乌萨奇",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins3.xml",
    image = "ccs_sb_item_sxz_skins3",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins3",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins4", {
    name = "乌萨奇2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins3.xml",
    image = "ccs_sb_item_sxz_skins3",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins3",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins5", {
    name = "小八",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins2.xml",
    image = "ccs_sb_item_sxz_skins2",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins2",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_sxz_skins6", {
    name = "小八2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins2.xml",
    image = "ccs_sb_item_sxz_skins2",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins2",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins7", {
    name = "蛋黄哥",
    atlas = "images/inventoryimages/ccs_sb_item_skins7.xml",
    image = "ccs_sb_item_skins7",
    build = "ccs_sb_item_skins7",
    bank = "ccs_sb_item_skins7",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})


CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins8", {
    name = "美乐蒂",
    atlas = "images/inventoryimages/ccs_sb_item_skins8.xml",
    image = "ccs_sb_item_skins8",
    build = "ccs_sb_item_skins8",
    bank = "ccs_sb_item_skins8",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins9", {
    name = "玉桂狗",
    atlas = "images/inventoryimages/ccs_sb_item_skins9.xml",
    image = "ccs_sb_item_skins9",
    build = "ccs_sb_item_skins9",
    bank = "ccs_sb_item_skins9",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
--
CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins1", {
    name = "吉依",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins1.xml",
    image = "ccs_sb_item_sxz_skins1",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins1",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins2", {
    name = "吉依2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins1.xml",
    image = "ccs_sb_item_sxz_skins1",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins1",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins3", {
    name = "乌萨奇",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins3.xml",
    image = "ccs_sb_item_sxz_skins3",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins3",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})


CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins4", {
    name = "乌萨奇2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins3.xml",
    image = "ccs_sb_item_sxz_skins3",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins3",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})


CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins5", {
    name = "小八",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins2.xml",
    image = "ccs_sb_item_sxz_skins2",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins2",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_sxz_skins6", {
    name = "小八2",
    atlas = "images/inventoryimages/ccs_sb_item_sxz_skins2.xml",
    image = "ccs_sb_item_sxz_skins2",
    build = "ccs_xk_item_sxz_skins",
    bank = "ccs_sb_item_sxz_skins2",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})


CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins7", {
    name = "蛋黄哥",
    atlas = "images/inventoryimages/ccs_sb_item_skins7.xml",
    image = "ccs_sb_item_skins7",
    build = "ccs_sb_item_skins7",
    bank = "ccs_sb_item_skins7",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})


CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins8", {
    name = "美乐蒂",
    atlas = "images/inventoryimages/ccs_sb_item_skins8.xml",
    image = "ccs_sb_item_skins8",
    build = "ccs_sb_item_skins8",
    bank = "ccs_sb_item_skins8",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins9", {
    name = "玉桂狗",
    atlas = "images/inventoryimages/ccs_sb_item_skins9.xml",
    image = "ccs_sb_item_skins9",
    build = "ccs_sb_item_skins9",
    bank = "ccs_sb_item_skins9",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_sb_item", "ccs_sbxk_item_tusi", {
    name = "定制：吐司啵啵",
    atlas = "images/inventoryimages/ccs_sbxk_item_tusi.xml",
    image = "ccs_sbxk_item_tusi",
    build = "ccs_sbxk_item_tusi",
    bank = "ccs_sbxk_item_tusi",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_xk_item", "ccs_sbxk_item_tusi", {
    name = "定制：吐司啵啵",
    atlas = "images/inventoryimages/ccs_sbxk_item_tusi.xml",
    image = "ccs_sbxk_item_tusi",
    build = "ccs_sbxk_item_tusi",
    bank = "ccs_sbxk_item_tusi",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})

CcsItemSkin("ccs_sb_item", "ccs_sb_item_skins_sdz", {
    name = "史迪仔",
    atlas = "images/inventoryimages/ccs_sb_item_skins_sdz.xml",
    image = "ccs_sb_item_skins_sdz",
    build = "ccs_sb_item_skins_sdz",
    bank = "ccs_sb_item_skins_sdz",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})

CcsItemSkin("ccs_xk_item", "ccs_xk_item_skins_sdz", {
    name = "史迪仔",
    atlas = "images/inventoryimages/ccs_sb_item_skins_sdz.xml",
    image = "ccs_sb_item_skins_sdz",
    build = "ccs_sb_item_skins_sdz",
    bank = "ccs_sb_item_skins_sdz",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_daergou", {
    name = "定制：大耳帽兜",
    atlas = "images/inventoryimages/ccs_sb_item_skin_daergou.xml",
    image = "ccs_sb_item_skin_daergou",
    build = "ccs_sb_item_skin_daergoudimian",
    bank = "moonrock_seed",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
    baseanim = "idle",
})
CcsItemSkin("ccs_sb_item", "ccs_sb_item_skin_baihe", {
    name = "定制：百合少女",
    atlas = "images/inventoryimages/ccs_sb_item_skin_baihe.xml",
    image = "ccs_sb_item_skin_baihe",
    build = "ccs_sb_item_skin_baihe",
    bank = "ccs_sb_item_skin_baihe",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CCSAPI.CcsItemAssets(Assets, "ccs_sb_item_szn", true, true)
CcsItemSkin("ccs_sb_item", "ccs_sb_item_szn", {
    name = "定制：首长鸟",
    atlas = "images/inventoryimages/ccs_sb_item_szn.xml",
    image = "ccs_sb_item_szn",
    build = "ccs_sb_item_szn",
    bank = "ccs_sb_item_szn",
    basebuild = "ccs_sb_item",
    basebank = "ccs_sb_item",
})
CcsItemSkin("ccs_xk_item", "ccs_xk_item_szn", {
    name = "定制：首长鸟",
    atlas = "images/inventoryimages/ccs_sb_item_szn.xml",
    image = "ccs_sb_item_szn",
    build = "ccs_sb_item_szn",
    bank = "ccs_sb_item_szn",
    basebuild = "ccs_pack_gift",
    basebank = "ccs_pack_gift",
})
CcsItemSkin("ccs_skirt1", "ccs_skirt_skins1", {
    name = "格格裙",
    atlas = "images/inventoryimages/ccs_skirt_skins1.xml",
    image = "ccs_skirt_skins1",
    build = "ccs_skirt_skins1",
    bank = "ccs_skirt_skins1",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
-- CcsItemSkin("ccs_skirt1","ccs_skirt_skin_flower",{
--     name = "春之樱",
--     atlas = "images/inventoryimages/ccs_skirt_skin_flower.xml",
--     image = "ccs_skirt_skin_flower",
--     build = "ccs_skirt_skin_flower",
--     bank =  "ccs_skirt_skin_flower",
--     basebuild = "ccs_skirt1",
--     basebank =  "ccs_skirt1",
-- })		

CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_xigewen", {
    name = "定制-看你啦",
    atlas = "images/inventoryimages/ccs_skirt_skin_xigewen.xml",
    image = "ccs_skirt_skin_xigewen",
    build = "ccs_skirt_skin_xigewen",
    bank = "ccs_skirt_skin_xigewen",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})

CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_madoka", {
    name = "定制-小圆的礼服",
    atlas = "images/inventoryimages/ccs_skirt_skin_madoka.xml",
    image = "ccs_skirt_skin_madoka",
    build = "ccs_skirt_skin_madoka",
    bank = "ccs_skirt_skin_madoka",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_sdlf", {
    name = "定制：盛典礼服",
    atlas = "images/inventoryimages/ccs_skirt_skin_sdlf.xml",
    image = "ccs_skirt_skin_sdlf",
    build = "ccs_skirt_skin_sdlf",
    bank = "ccs_skirt_skin_sdlf",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_qzm", {
    name = "定制：千织锦",
    atlas = "images/inventoryimages/ccs_skirt_skin_qzm.xml",
    image = "ccs_skirt_skin_qzm",
    build = "ccs_skirt_skin_qzm",
    bank = "ccs_skirt_skin_qzm",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_llf", {
    name = "定制：夜之礼服",
    atlas = "images/inventoryimages/ccs_skirt_skin_llf.xml",
    image = "ccs_skirt_skin_llf",
    build = "ccs_skirt_skin_llf",
    bank = "ccs_skirt_skin_llf",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_skirt_skin_dzm", true, true)
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_dzm", {
    name = "定制：蝶之梦",
    atlas = "images/inventoryimages/ccs_skirt_skin_dzm.xml",
    image = "ccs_skirt_skin_dzm",
    build = "ccs_skirt_skin_dzm",
    bank = "ccs_skirt_skin_dzm",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_skirt_skin_jgzw", true, true)
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_jgzw", {
    name = "定制：极光之吻",
    atlas = "images/inventoryimages/ccs_skirt_skin_jgzw.xml",
    image = "ccs_skirt_skin_jgzw",
    build = "ccs_skirt_skin_jgzw",
    bank = "ccs_skirt_skin_jgzw",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CCSAPI.CcsItemAssets(Assets, "ccs_skirt_skin_msnzs", true, true)
CcsItemSkin("ccs_bag", "ccs_skirt_skin_msnzs", {
    name = "定制：童年回忆",
    atlas = "images/inventoryimages/ccs_skirt_skin_msnzs.xml",
    image = "ccs_skirt_skin_msnzs",
    build = "ccs_skirt_skin_msnzs",
    bank = "ccs_skirt_skin_msnzs",
    basebuild = "ccs_bag",
    basebank = "ccs_bag",
})
CCSAPI.CcsItemAssets(Assets, "ccs_skirt_skin_hlh", true, true)
CcsItemSkin("ccs_skirt1", "ccs_skirt_skin_hlh", {
    name = "定制：小红的裙子",
    atlas = "images/inventoryimages/ccs_skirt_skin_hlh.xml",
    image = "ccs_skirt_skin_hlh",
    build = "ccs_skirt_skin_hlh",
    bank = "ccs_skirt_skin_hlh",
    basebuild = "ccs_skirt1",
    basebank = "ccs_skirt1",
})
CcsItemSkin("ccs_street_lamp", "ccs_street_lamp_skin1", {
    name = "兔子灯",
    atlas = "images/inventoryimages/ccs_street_lamp_skin1.xml",
    image = "ccs_street_lamp_skin1",
    build = "ccs_street_lamp_skin1",
    bank = "ccs_street_lamp_skin1",
    basebuild = "ccs_street_lamp",
    basebank = "ccs_street_lamp",
})
CcsItemSkin2("ccs_street_lamp", "ccs_street_lamp_skin2", {
    name = "浮空灯",
    atlas = "images/inventoryimages/ccs_street_lamp_skin2.xml",
    image = "ccs_street_lamp_skin2",
    build = "ccs_street_lamp_skin2",
    bank = "ccs_street_lamp_skin2",
    basebuild = "ccs_street_lamp",
    basebank = "ccs_street_lamp",
    init_fn = function(inst)
        if inst.AnimState then
            inst.AnimState:PlayAnimation("idle", true)
        end
    end,
    clear_fn = function(inst)
        if inst.AnimState then
            inst.AnimState:PlayAnimation("idle")
        end
    end,
})

CCSAPI.MakeItemSkinDefaultImage('ccs_ice_box', 'images/inventoryimages/ccs_ice_box.xml', 'ccs_ice_box')
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin1", {
    name = "菠萝包",
    atlas = "images/inventoryimages/ccs_ice_box_skin1.xml",
    image = "ccs_ice_box_skin1",
    build = "ccs_ice_box_skin1",
    bank = "ccs_ice_box_skin1",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin2", {
    name = "定制：星之鼓动",
    atlas = "images/inventoryimages/ccs_ice_box_skin2.xml",
    image = "ccs_ice_box_skin2",
    build = "ccs_ice_box_skin2",
    bank = "ccs_ice_box_skin2",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin3", {
    name = "定制：宝宝奶昔",
    atlas = "images/inventoryimages/ccs_ice_box_skin3.xml",
    image = "ccs_ice_box_skin3",
    build = "ccs_ice_box_skin3",
    bank = "ccs_ice_box_skin3",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ccs_ice_box_xigewen")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_ice_box_rq")
        inst.components.container:Close()
    end,
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin4", {
    name = "定制：CoCoの爱心便当",
    atlas = "images/inventoryimages/ccs_ice_box_skin4.xml",
    image = "ccs_ice_box_skin4",
    build = "ccs_ice_box_skin4",
    bank = "ccs_ice_box_skin4",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ccs_ice_box_shoe")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_ice_box_rq")
        inst.components.container:Close()
    end,
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin5", {
    name = "定制：甜喵蜜罐",
    atlas = "images/inventoryimages/ccs_ice_box_skin5.xml",
    image = "ccs_ice_box_skin5",
    build = "ccs_ice_box_skin5",
    bank = "ccs_ice_box_skin5",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(4)
            inst.components.container:WidgetSetup("ccs_ice_box_cat")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_ice_box_rq")
        inst.components.container:Close()
    end,
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin6", {
    name = "定制：猫猫甜品盒",
    atlas = "images/inventoryimages/ccs_ice_box_skin6.xml",
    image = "ccs_ice_box_skin6",
    build = "ccs_ice_box_skin6",
    bank = "ccs_ice_box_skin6",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
})
CcsItemSkin("ccs_ice_box", "ccs_ice_box_skin7", {
    name = "定制：樱之愿",
    atlas = "images/inventoryimages/ccs_ice_box_skin7.xml",
    image = "ccs_ice_box_skin7",
    build = "ccs_ice_box_skin7",
    bank = "ccs_ice_box_skin7",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ccs_ice_box_shoe")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_ice_box_rq")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_ice_box_guhe", true, true)
CcsItemSkin("ccs_ice_box", "ccs_ice_box_guhe", {
    name = "定制-骨盒",
    atlas = "images/inventoryimages/ccs_ice_box_guhe.xml",
    image = "ccs_ice_box_guhe",
    build = "ccs_ice_box_guhe",
    bank = "ccs_ice_box_guhe",
    basebuild = "ccs_ice_box",
    basebank = "ccs_ice_box",
})
CCSAPI.MakeItemSkinDefaultImage('ccs_trash', 'images/inventoryimages/ccs_trash.xml', 'ccs_trash')
CcsItemSkin2("ccs_trash", "ccs_trash_skin1", {
    name = "仓鼠噗噗",
    atlas = "images/inventoryimages/ccs_trash_skin1.xml",
    image = "ccs_trash_skin1",
    build = "ccs_trash_skin1",
    bank = "ccs_trash_skin1",
    basebuild = "ccs_trash",
    basebank = "ccs_trash",
})

CcsItemSkin("ccs_trash", "ccs_trash_skin2", {
    name = "瓶中玫瑰",
    atlas = "images/inventoryimages/ccs_trash_skin2.xml",
    image = "ccs_trash_skin2",
    build = "ccs_trash_skin2",
    bank = "ccs_trash_skin2",
    basebuild = "ccs_trash",
    basebank = "ccs_trash",
})

CcsItemSkin("ccs_trash", "ccs_trash_skin3", {
    name = "定制：丘比",
    atlas = "images/inventoryimages/ccs_trash_skin3.xml",
    image = "ccs_trash_skin3",
    build = "ccs_trash_skin3",
    bank = "ccs_trash_skin3",
    basebuild = "ccs_trash",
    basebank = "ccs_trash",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_guard', 'images/inventoryimages/ccs_guard.xml', 'ccs_guard')
CcsItemSkin2("ccs_guard", "ccs_guard_skin1", {
    name = "仓鼠噗噗",
    atlas = "images/inventoryimages/ccs_guard_skin1.xml",
    image = "ccs_guard_skin1",
    build = "ccs_guard_skin1",
    bank = "ccs_guard_skin1",
    basebuild = "ccs_guard",
    basebank = "ccs_guard",
})
CcsItemSkin("ccs_guard", "ccs_guard_skin2", {
    name = "定制：恶魔的救赎",
    atlas = "images/inventoryimages/ccs_guard_skin2.xml",
    image = "ccs_guard_skin2",
    build = "ccs_guard_skin2",
    bank = "ccs_guard_skin2",
    basebuild = "ccs_guard",
    basebank = "ccs_guard",
})
CCSAPI.CcsItemAssets(Assets, "ccs_guard_xinyu", true, true)
CcsItemSkin("ccs_guard", "ccs_guard_xinyu", {
    name = "定制-喵の语",
    atlas = "images/inventoryimages/ccs_guard_xinyu.xml",
    image = "ccs_guard_xinyu",
    build = "ccs_guard_xinyu",
    bank = "ccs_guard_xinyu",
    basebuild = "ccs_guard",
    basebank = "ccs_guard",
})
CcsItemSkin("ccs_guard", "ccs_guard_pipo", {
    name = "定制：Pipo",
    atlas = "images/inventoryimages/ccs_guard_pipo.xml",
    image = "ccs_guard_pipo",
    build = "ccs_guard_pipo",
    bank = "ccs_guard_pipo",
    basebuild = "ccs_guard",
    basebank = "ccs_guard",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_jt', 'images/inventoryimages/ccs_jt.xml', 'ccs_jt')
CcsItemSkin("ccs_jt", "ccs_jt_skins1", {
    name = "瓶中爱心",
    atlas = "images/inventoryimages/ccs_jt_skins1.xml",
    image = "ccs_jt_skins1",
    build = "ccs_jt_skins1",
    bank = "ccs_jt_skins1",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
})

CcsItemSkin("ccs_jt", "ccs_jt_skins2", {
    name = "定制：焰魔",
    atlas = "images/inventoryimages/ccs_jt_skins2.xml",
    image = "ccs_jt_skins2",
    build = "ccs_jt_skins2",
    bank = "ccs_jt_skins2",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.Light:SetColour(216 / 255, 160 / 255, 255 / 255, 1)
            inst.Transform:SetScale(1.6, 1.6, 1.6)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
        inst.Transform:SetScale(2, 2, 2)
    end,

})

CcsItemSkin("ccs_jt", "ccs_jt_skins3", {
    name = "定制：圆神",
    atlas = "images/inventoryimages/ccs_jt_skins3.xml",
    image = "ccs_jt_skins3",
    build = "ccs_jt_skins3",
    bank = "ccs_jt_skins3",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
            inst.Transform:SetScale(1.8, 1.8, 1.8)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
        inst.Transform:SetScale(2, 2, 2)
    end,

})

CcsItemSkin("ccs_jt", "ccs_jt_skins4", {
    name = "定制：咖啡甜心",
    atlas = "images/inventoryimages/ccs_jt_skins4.xml",
    image = "ccs_jt_skins4",
    build = "ccs_jt_skins4",
    bank = "ccs_jt_skins4",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
})
CcsItemSkin("ccs_jt", "ccs_jt_skins5", {
    name = "定制：月神树",
    atlas = "images/inventoryimages/ccs_jt_skins5.xml",
    image = "ccs_jt_skins5",
    build = "ccs_jt_skins5",
    bank = "ccs_jt_skins5",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
            inst.Transform:SetScale(1.5, 1.5, 1.5)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
        inst.Transform:SetScale(2, 2, 2)
    end,

})

CcsItemSkin("ccs_jt", "ccs_jt_skins_tiannv", {
    name = "定制：天女兽",
    atlas = "images/inventoryimages/ccs_jt_skins_tiannv.xml",
    image = "ccs_jt_skins_tiannv",
    build = "ccs_jt_skins_tiannv",
    bank = "ccs_jt_skins_tiannv",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
            --inst.Transform:SetScale(1.5, 1.5, 1.5)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
        --inst.Transform:SetScale(2, 2, 2)
    end,

})

CcsItemSkin("ccs_jt", "ccs_jt_skins6", {
    name = "定制：阳辰树",
    atlas = "images/inventoryimages/ccs_jt_skins6.xml",
    image = "ccs_jt_skins6",
    build = "ccs_jt_skins6",
    bank = "ccs_jt_skins6",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.Light:SetColour(255 / 255, 182 / 255, 193 / 255, 1)
            inst.Transform:SetScale(1.5, 1.5, 1.5)
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.Light:SetColour(0 / 255, 245 / 255, 255 / 255, 1)
        inst.Transform:SetScale(2, 2, 2)
    end,

})
-- CcsItemSkin("ccs_jt", "ccs_jt_skins7", {
--     name = "定制：双萌甜心",
--     atlas = "images/inventoryimages/ccs_jt_skins7.xml",
--     image = "ccs_jt_skins7",
--     build = "ccs_jt_skins7",
--     bank = "ccs_jt_skins7",
--     basebuild = "ccs_jt",
--     basebank = "ccs_jt",
--     init_fn = function(inst)
--         if inst.Transform then
--             inst.Transform:SetScale(1.5, 1.5, 1.5)
--         end
--     end,
--     clear_fn = function(inst)
--         inst.Transform:SetScale(2, 2, 2)
--     end,

-- })
CcsItemSkin("ccs_jt", "ccs_jt_skins8", {
    name = "白银城",
    atlas = "images/inventoryimages/ccs_jt_skins8.xml",
    image = "ccs_jt_skins8",
    build = "ccs_jt_skins8",
    bank = "ccs_jt_skins8",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,

})
CcsItemSkin("ccs_jt", "ccs_jt_skins9", {
    name = "定制：草莓兔兔",
    atlas = "images/inventoryimages/ccs_jt_skins9.xml",
    image = "ccs_jt_skins9",
    build = "ccs_jt_skins9",
    bank = "ccs_jt_skins9",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_jt_skin_ll", "ccs_jt_skin_ll", true)
CcsItemSkin("ccs_jt", "ccs_jt_skin_ll", {
    name = "定制：铃兰",
    atlas = "images/inventoryimages/ccs_jt_skin_ll.xml",
    image = "ccs_jt_skin_ll",
    build = "ccs_jt_skin_ll",
    bank = "ccs_jt_skin_ll",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,

})
CCSAPI.CcsItemAssets(Assets, "ccs_jt_blx", "ccs_jt_blx", true)
CcsItemSkin("ccs_jt", "ccs_jt_blx", {
    name = "定制-汐灵",
    atlas = "images/inventoryimages/ccs_jt_blx.xml",
    image = "ccs_jt_blx",
    build = "ccs_jt_blx",
    bank = "ccs_jt_blx",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,

})
CCSAPI.CcsItemAssets(Assets, "ccs_jt_skins10", "ccs_jt_skins10", true)
CcsItemSkin("ccs_jt", "ccs_jt_skins10", {
    name = "定制：派总",
    atlas = "images/inventoryimages/ccs_jt_skins10.xml",
    image = "ccs_jt_skins10",
    build = "ccs_jt_skins10",
    bank = "ccs_jt_skins10",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,

})
CCSAPI.CcsItemAssets(Assets, "ccs_jt_skins11", "ccs_jt_skins11", true)
CcsItemSkin("ccs_jt", "ccs_jt_skins11", {
    name = "定制：银杏",
    atlas = "images/inventoryimages/ccs_jt_skins11.xml",
    image = "ccs_jt_skins11",
    build = "ccs_jt_skins11",
    bank = "ccs_jt_skins11",
    basebuild = "ccs_jt",
    basebank = "ccs_jt",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1, 1, 1)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,

})

CCSAPI.MakeItemSkinDefaultImage('ccs_amulet', 'images/inventoryimages/ccs_amulet.xml', 'ccs_amulet')
CcsItemSkin("ccs_amulet", "ccs_amulet_skin1", {
    name = "飘浮法球",
    atlas = "images/inventoryimages/ccs_amulet_skin1.xml",
    image = "ccs_amulet_skin1",
    build = "ccs_amulet_skin1",
    bank = "ccs_amulet_skin1",
    basebuild = "ccs_amulet",
    basebank = "ccs_amulet",
})
CcsItemSkin("ccs_amulet", "ccs_amulet_skin2", {
    name = "定制-圆环之理",
    atlas = "images/inventoryimages/ccs_amulet_skin2.xml",
    image = "ccs_amulet_skin2",
    build = "ccs_amulet_skin2",
    bank = "ccs_amulet_skin2",
    basebuild = "ccs_amulet",
    basebank = "ccs_amulet",
})
CcsItemSkin("ccs_amulet", "ccs_amulet_skin3", {
    name = "定制-天使熊",
    atlas = "images/inventoryimages/ccs_amulet_skin3.xml",
    image = "ccs_amulet_skin3",
    build = "ccs_amulet_skin3",
    bank = "ccs_amulet_skin3",
    basebuild = "ccs_amulet",
    basebank = "ccs_amulet",
})
CcsItemSkin("ccs_amulet", "ccs_amulet_skin4", {
    name = "定制-EphEmEral",
    atlas = "images/inventoryimages/ccs_amulet_skin4.xml",
    image = "ccs_amulet_skin4",
    build = "ccs_amulet_skin4",
    bank = "ccs_amulet_skin4",
    basebuild = "ccs_amulet",
    basebank = "ccs_amulet",
})
CCSAPI.CcsItemAssets(Assets, "ccs_amulet_skin_bkm", true, true)
CcsItemSkin("ccs_amulet", "ccs_amulet_skin_bkm", {
    name = "定制：宝可梦",
    atlas = "images/inventoryimages/ccs_amulet_skin_bkm.xml",
    image = "ccs_amulet_skin_bkm",
    build = "ccs_amulet_skin_bkm",
    bank = "ccs_amulet_skin_bkm",
    basebuild = "ccs_amulet",
    basebank = "ccs_amulet",
})
local function PlayIdleLoop(inst, animation_queue, index)
    if inst.should_stop then
        return
    end
    local current_animation = animation_queue[index]
    if current_animation then
        inst.AnimState:PlayAnimation(current_animation)
        --递归调用下一动画
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), function()
            if not inst.should_stop then
                local next_index = index + 1
                if next_index > #animation_queue then
                    next_index = 1 --回到队列的第一个动画
                end
                PlayIdleLoop(inst, animation_queue, next_index)
            end
        end)
    end
end

CCSAPI.MakeItemSkinDefaultImage('ccs_pack_gift', 'images/inventoryimages/ccs_pack_gift.xml', 'ccs_pack_gift')
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin1',
    {
        name = "斯比",
        atlas = "images/inventoryimages/ccs_pack_gift_skin1.xml",
        image = "ccs_pack_gift_skin1",
        build = "ccs_pack_gift_skin1",
        bank = "ccs_pack_gift_skin1",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        clear_fn = function(inst)
            inst.should_stop = true
            inst.AnimState:PlayAnimation("idle")
        end,
        init_fn = function(inst)
            inst.should_stop = false
            local animation_queue = { "idle1", "idle2" }
            PlayIdleLoop(inst, animation_queue, 1)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin1")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin2',
    {
        name = "兔子",
        atlas = "images/inventoryimages/ccs_pack_gift_skin2.xml",
        image = "ccs_pack_gift_skin2",
        build = "ccs_pack_gift_skin2",
        bank = "ccs_pack_gift_skin2",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        clear_fn = function(inst)
            inst.should_stop = true
            inst.AnimState:PlayAnimation("idle")
        end,
        init_fn = function(inst)
            inst.should_stop = false
            local animation_queue = { "idle1", "idle2" }
            PlayIdleLoop(inst, animation_queue, 1)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin1")
        end
    }
)

CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin3',
    {
        name = "兔子",
        atlas = "images/inventoryimages/ccs_pack_gift_skin3.xml",
        image = "ccs_pack_gift_skin3",
        build = "ccs_pack_gift_skin3",
        bank = "ccs_pack_gift_skin3",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        clear_fn = function(inst)
            inst.should_stop = true
            inst.AnimState:PlayAnimation("idle")
        end,
        init_fn = function(inst)
            inst.should_stop = false
            local animation_queue = { "idle1", "idle2" }
            PlayIdleLoop(inst, animation_queue, 1)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin1")
        end
    }
)

CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin4',
    {
        name = "圆环之理",
        atlas = "images/inventoryimages/ccs_pack_gift_skin4.xml",
        image = "ccs_pack_gift_skin4",
        build = "ccs_pack_gift_skin4",
        bank = "ccs_pack_gift_skin4",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin2")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin2")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin5',
    {
        name = "天使熊",
        atlas = "images/inventoryimages/ccs_pack_gift_skin5.xml",
        image = "ccs_pack_gift_skin5",
        build = "ccs_pack_gift_skin5",
        bank = "ccs_pack_gift_skin5",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin3")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin3")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin6',
    {
        name = "天使熊",
        atlas = "images/inventoryimages/ccs_amulet_skin3.xml",
        image = "ccs_amulet_skin3",
        build = "ccs_amulet_skin3",
        bank = "ccs_amulet_skin3",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin3")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin3")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_skin7',
    {
        name = "熊",
        atlas = "images/inventoryimages/ccs_pack_gift_skin7.xml",
        image = "ccs_pack_gift_skin7",
        build = "ccs_pack_gift_skin7",
        bank = "ccs_pack_gift_skin7",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin4")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin4")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_pack_gift_bkm1", true, true)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_bkm1',
    {
        name = "定制：宝可梦",
        atlas = "images/inventoryimages/ccs_pack_gift_bkm1.xml",
        image = "ccs_pack_gift_bkm1",
        build = "ccs_pack_gift_bkm1",
        bank = "ccs_pack_gift_bkm1",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        -- checkfn = function(inventory, name)
        --     return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin_bkm")
        -- end,
        -- checkclientfn = function(inventory, userid, name)
        --     return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin_bkm")
        -- end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_pack_gift_bkm2", true, true)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_bkm2',
    {
        name = "定制：宝可梦",
        atlas = "images/inventoryimages/ccs_pack_gift_bkm2.xml",
        image = "ccs_pack_gift_bkm2",
        build = "ccs_pack_gift_bkm2",
        bank = "ccs_pack_gift_bkm2",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        -- checkfn = function(inventory, name)
        --     return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin_bkm")
        -- end,
        -- checkclientfn = function(inventory, userid, name)
        --     return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin_bkm")
        -- end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_pack_gift_bkm3", true, true)
CCSAPI.MakeItemSkin(
    'ccs_pack_gift',
    'ccs_pack_gift_bkm3',
    {
        name = "定制：宝可梦",
        atlas = "images/inventoryimages/ccs_pack_gift_bkm3.xml",
        image = "ccs_pack_gift_bkm3",
        build = "ccs_pack_gift_bkm3",
        bank = "ccs_pack_gift_bkm3",
        basebuild = "ccs_pack_gift",
        basebank = "ccs_pack_gift",
        -- checkfn = function(inventory, name)
        --     return CCSAPI.CcsSkinCheckFn(inventory, "ccs_amulet_skin_bkm")
        -- end,
        -- checkclientfn = function(inventory, userid, name)
        --     return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_amulet_skin_bkm")
        -- end
    }
)
CCSAPI.MakeItemSkinDefaultImage('ccs_cookpot_item', 'images/inventoryimages/ccs_cookpot.xml', 'ccs_cookpot')
CcsItemSkin2("ccs_cookpot_item", "ccs_cookpot_item_skin_purple", {
    name = "香水锅(紫)",
    atlas = "images/inventoryimages/ccs_cookpot_skin_purple.xml",
    image = "ccs_cookpot_skin_purple",
    build = "ccs_cookpot_skin_purple",
    bank = "ccs_cookpot_skin_purple",
    basebuild = "ccs_cookpot",
    basebank = "ccs_cookpot",
})
CcsItemSkin("ccs_cookpot_item", "ccs_cookpot_item_skin_green", {
    name = "香水锅(绿)",
    atlas = "images/inventoryimages/ccs_cookpot_skin_green.xml",
    image = "ccs_cookpot_skin_green",
    build = "ccs_cookpot_skin_green",
    bank = "ccs_cookpot_skin_green",
    basebuild = "ccs_cookpot",
    basebank = "ccs_cookpot",
})

CCSAPI.MakeItemSkinDefaultImage('ccs_cookpot', 'images/inventoryimages/ccs_cookpot.xml', 'ccs_cookpot')
CcsItemSkin("ccs_cookpot", "ccs_cookpot_skin_green", {
    name = "香水锅(绿)",
    atlas = "images/inventoryimages/ccs_cookpot_skin_green.xml",
    image = "ccs_cookpot_skin_green",
    build = "ccs_cookpot_skin_green",
    bank = "ccs_cookpot_skin_green",
    basebuild = "ccs_cookpot",
    basebank = "ccs_cookpot",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ccs_cookpot_green")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_cookpot")
        inst.components.container:Close()
    end,
})
CcsItemSkin2("ccs_cookpot", "ccs_cookpot_skin_purple", {
    name = "香水锅(紫)",
    atlas = "images/inventoryimages/ccs_cookpot_skin_purple.xml",
    image = "ccs_cookpot_skin_purple",
    build = "ccs_cookpot_skin_purple",
    bank = "ccs_cookpot_skin_purple",
    basebuild = "ccs_cookpot",
    basebank = "ccs_cookpot",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ccs_cookpot_purple")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_cookpot")
        inst.components.container:Close()
    end,
})

CCSAPI.MakeItemSkinDefaultImage('ccs_cookpot2', 'images/inventoryimages/ccs_cookpot2.xml', 'ccs_cookpot2')
CcsItemSkin("ccs_cookpot2", "ccs_cookpot2_skin_white", {
    name = "白色沙漏",
    atlas = "images/inventoryimages/ccs_cookpot2_skin_white.xml",
    image = "ccs_cookpot2_skin_white",
    build = "ccs_cookpot2_skin_white",
    bank = "ccs_cookpot2_skin_white",
    basebuild = "ccs_cookpot2",
    basebank = "ccs_cookpot2",
})
CcsItemSkin("ccs_cookpot2", "ccs_cookpot2_skin_rabbit", {
    name = "定制：兔子沙漏",
    atlas = "images/inventoryimages/ccs_cookpot2_skin_rabbit.xml",
    image = "ccs_cookpot2_skin_rabbit",
    build = "ccs_cookpot2_skin_rabbit",
    bank = "ccs_cookpot2_skin_rabbit",
    basebuild = "ccs_cookpot2",
    basebank = "ccs_cookpot2",
})
CcsItemSkin("ccs_cookpot2", "ccs_cookpot2_skin_kokomi", {
    name = "定制：抱抱心海",
    atlas = "images/inventoryimages/ccs_cookpot2_skin_kokomi.xml",
    image = "ccs_cookpot2_skin_kokomi",
    build = "ccs_cookpot2_skin_kokomi",
    bank = "ccs_cookpot2_skin_kokomi",
    basebuild = "ccs_cookpot2",
    basebank = "ccs_cookpot2",
})
CCSAPI.CcsItemAssets(Assets, "ccs_cookpot2_skin_xiaoke", true, true, {
    Asset("ANIM", "anim/ui_ccs_cookpot2_skin_xiaoke.zip"),
    Asset("IMAGE", "images/inventoryimages/ccs_cookpot2_skin_xiaoke_slot.tex"),
    Asset("ATLAS", "images/inventoryimages/ccs_cookpot2_skin_xiaoke_slot.xml"),
})
CcsItemSkin("ccs_cookpot2", "ccs_cookpot2_skin_xiaoke", {
    name = "定制：小可你又在偷吃",
    atlas = "images/inventoryimages/ccs_cookpot2_skin_xiaoke.xml",
    image = "ccs_cookpot2_skin_xiaoke",
    build = "ccs_cookpot2_skin_xiaoke",
    bank = "ccs_cookpot2_skin_xiaoke",
    basebuild = "ccs_cookpot2",
    basebank = "ccs_cookpot2",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ui_ccs_cookpot2_skin_xiaoke")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        if inst._state then
            inst._state:set(1)
        end
        if inst.components.container then
            inst.components.container:WidgetSetup("ccs_cookpot2")
            inst.components.container:Close()
        end
    end,
})

CCSAPI.MakeItemSkinDefaultImage('ccs_light2', 'images/inventoryimages/ccs_light.xml', 'ccs_light')
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins2',
    {
        name = "定制：焰魔",
        atlas = "images/inventoryimages/ccs_jt_skins2.xml",
        image = "ccs_jt_skins2",
        build = "ccs_jt_skins2",
        bank = "ccs_jt_skins2",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins2")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins2")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins3',
    {
        name = "定制：圆神",
        atlas = "images/inventoryimages/ccs_jt_skins3.xml",
        image = "ccs_jt_skins3",
        build = "ccs_jt_skins3",
        bank = "ccs_jt_skins3",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins3")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins3")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins4',
    {
        name = "定制：咖啡甜心",
        atlas = "images/inventoryimages/ccs_jt_skins4.xml",
        image = "ccs_jt_skins4",
        build = "ccs_jt_skins4",
        bank = "ccs_jt_skins4",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins4")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins4")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins5',
    {
        name = "定制：月神树",
        atlas = "images/inventoryimages/ccs_jt_skins5.xml",
        image = "ccs_jt_skins5",
        build = "ccs_jt_skins5",
        bank = "ccs_jt_skins5",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins5")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins5")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins6',
    {
        name = "定制：阳辰树",
        atlas = "images/inventoryimages/ccs_jt_skins6.xml",
        image = "ccs_jt_skins6",
        build = "ccs_jt_skins6",
        bank = "ccs_jt_skins6",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins6")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins6")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light2',
    'ccs_light2_skins_candy',
    {
        name = "糖果罐",
        atlas = "images/inventoryimages/ccs_light_skins_candy.xml",
        image = "ccs_light_skins_candy",
        build = "ccs_light_skins_candy",
        bank = "ccs_light_skins_candy",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_light_skins_candy")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_light_skins_candy")
        end
    }
)
CCSAPI.MakeItemSkinDefaultImage('ccs_light', 'images/inventoryimages/ccs_light.xml', 'ccs_light')
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light2_skins2',
    {
        name = "定制：焰魔",
        atlas = "images/inventoryimages/ccs_jt_skins2.xml",
        image = "ccs_jt_skins2",
        build = "ccs_jt_skins2",
        bank = "ccs_jt_skins2",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins2")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins2")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light2_skins3',
    {
        name = "定制：圆神",
        atlas = "images/inventoryimages/ccs_jt_skins3.xml",
        image = "ccs_jt_skins3",
        build = "ccs_jt_skins3",
        bank = "ccs_jt_skins3",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins3")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins3")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light2_skins4',
    {
        name = "定制：咖啡甜心",
        atlas = "images/inventoryimages/ccs_jt_skins4.xml",
        image = "ccs_jt_skins4",
        build = "ccs_jt_skins4",
        bank = "ccs_jt_skins4",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins4")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins4")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light2_skins5',
    {
        name = "定制：月神树",
        atlas = "images/inventoryimages/ccs_jt_skins5.xml",
        image = "ccs_jt_skins5",
        build = "ccs_jt_skins5",
        bank = "ccs_jt_skins5",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins5")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins5")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light2_skins6',
    {
        name = "定制：阳辰树",
        atlas = "images/inventoryimages/ccs_jt_skins6.xml",
        image = "ccs_jt_skins6",
        build = "ccs_jt_skins6",
        bank = "ccs_jt_skins6",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        clear_fn = function(inst)
            inst.AnimState:PlayAnimation("anim", true)
        end,
        init_fn = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_jt_skins6")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_jt_skins6")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_light2_wzxy", true, true)
CCSAPI.MakeItemSkin("ccs_light2", "ccs_light2_wzxy", {
    name = "定制-双子小羊",
    atlas = "images/inventoryimages/ccs_light2_wzxy.xml",
    image = "ccs_light2_wzxy",
    build = "ccs_light2_wzxy",
    bank = "ccs_light2_wzxy",
    basebuild = "ccs_light",
    basebank = "ccs_light",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_light2_wzxy")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_light2_wzxy")
    end
})
CCSAPI.CcsItemAssets(Assets, "ccs_light2_wzxy2", true, true)
CCSAPI.MakeItemSkin("ccs_light2", "ccs_light2_wzxy2", {
    name = "定制-双子小羊",
    atlas = "images/inventoryimages/ccs_light2_wzxy2.xml",
    image = "ccs_light2_wzxy2",
    build = "ccs_light2_wzxy2",
    bank = "ccs_light2_wzxy2",
    basebuild = "ccs_light",
    basebank = "ccs_light",
    checkfn = function(inventory, name)
        return CCSAPI.CcsSkinCheckFn(inventory, "ccs_light2_wzxy2")
    end,
    checkclientfn = function(inventory, userid, name)
        return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_light2_wzxy2")
    end
})
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light_wzxy',
    {
        name = "定制：双子小羊",
        atlas = "images/inventoryimages/ccs_light2_wzxy.xml",
        image = "ccs_light2_wzxy",
        build = "ccs_light2_wzxy",
        bank = "ccs_light2_wzxy",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_light2_wzxy")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_light2_wzxy")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_light',
    'ccs_light_wzxy2',
    {
        name = "定制：双子小羊",
        atlas = "images/inventoryimages/ccs_light2_wzxy2.xml",
        image = "ccs_light2_wzxy2",
        build = "ccs_light2_wzxy2",
        bank = "ccs_light2_wzxy2",
        basebuild = "ccs_light",
        basebank = "ccs_light",
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_light2_wzxy2")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_light2_wzxy2")
        end
    }
)
CcsItemSkin("ccs_light", "ccs_light_skins_candy", {
    name = "糖果罐",
    atlas = "images/inventoryimages/ccs_light_skins_candy.xml",
    image = "ccs_light_skins_candy",
    build = "ccs_light_skins_candy",
    bank = "ccs_light_skins_candy",
    basebuild = "ccs_light",
    basebank = "ccs_light",
    clear_fn = function(inst)
        inst.AnimState:PlayAnimation("anim", true)
    end,
    init_fn = function(inst)
        inst.AnimState:PlayAnimation("idle", true)
    end,
})
CcsItemSkin("ccs_card_box", "ccs_card_box_fluff", {
    name = "绒朵",
    atlas = "images/inventoryimages/ccs_card_box_fluff.xml",
    image = "ccs_card_box_fluff",
    build = "ccs_card_box_fluff",
    bank = "ccs_card_box_fluff",
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
    end,
})

CcsItemSkin("ccs_card_box", "ccs_card_box_skin2", {
    name = "定制：小熊晚睡",
    atlas = "images/inventoryimages/ccs_card_box_skin2.xml",
    image = "ccs_card_box_skin2",
    build = "ccs_card_box_skin2",
    bank = "ccs_card_box_skin2",
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
    end,
})
CcsItemSkin("ccs_card_box", "ccs_card_box_skin3", {
    name = "定制：魔镜魔镜",
    atlas = "images/inventoryimages/ccs_card_box_skin3.xml",
    image = "ccs_card_box_skin3",
    build = "ccs_card_box_skin3",
    bank = "ccs_card_box_skin3",
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_card_box_alxy", true, true)
CcsItemSkin("ccs_card_box", "ccs_card_box_alxy", {
    name = "定制-爱丽希雅的礼物",
    atlas = "images/inventoryimages/ccs_card_box_alxy.xml",
    image = "ccs_card_box_alxy",
    build = "ccs_card_box_alxy",
    bank = "ccs_card_box_alxy",
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(3)
            inst.components.container:WidgetSetup("ccs_card_box_alxy_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_card_box")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_card_box_caomei", true, true)
CcsItemSkin("ccs_card_box", "ccs_card_box_caomei", {
    name = "定制-草莓",
    atlas = "images/inventoryimages/ccs_card_box_caomei.xml",
    image = "ccs_card_box_caomei",
    build = "ccs_card_box_caomei",
    bank = "ccs_card_box_caomei",
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    init_fn = function(inst)
        if inst._lighttask then
            inst._lighttask:Cancel()
            inst._lighttask = nil
        end
        inst._lighttask = inst:DoTaskInTime(0, function()
            if inst.Light then
                inst.Light:Enable(true)
            end
        end)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ccs_card_box_caomei_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        if inst._lighttask then
            inst._lighttask:Cancel()
            inst._lighttask = nil
        end
        inst._lighttask = inst:DoTaskInTime(0, function()
            if inst.Light then
                inst.Light:Enable(false)
            end
        end)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_card_box")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_card_box_flxy", true, true)
CcsItemSkin("ccs_card_box", "ccs_card_box_flxy", {
    name = "定制-风铃小羊",
    atlas = "images/inventoryimages/ccs_card_box_flxy.xml",
    image = "ccs_card_box_flxy",
    build = "ccs_card_box_flxy",
    bank = "ccs_card_box_flxy",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    baseanim = "idle",
    baseanimloop = false,
    init_fn = function(inst)
        if inst._state then
            inst._state:set(4)
            inst.components.container:WidgetSetup("ccs_card_box_flxy_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_card_box")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_card_box_flxy2", true, true)
CcsItemSkin("ccs_card_box", "ccs_card_box_flxy2", {
    name = "定制-风铃小羊",
    atlas = "images/inventoryimages/ccs_card_box_flxy2.xml",
    image = "ccs_card_box_flxy2",
    build = "ccs_card_box_flxy2",
    bank = "ccs_card_box_flxy2",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    baseanim = "idle",
    baseanimloop = false,
    init_fn = function(inst)
        if inst._state then
            inst._state:set(5)
            inst.components.container:WidgetSetup("ccs_card_box_flxy2_ui")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        if inst.components.inventoryitem then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/ccs_card_box.xml"
        end
        if inst.components.container then
            inst.components.container:Close()
        end
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_card_box")
        inst.components.container:Close()
    end,
})
CCSAPI.CcsItemAssets(Assets, "ccs_card_box_fengyue", true, true)
CcsItemSkin("ccs_card_box", "ccs_card_box_fengyue", {
    name = "定制：风月",
    atlas = "images/inventoryimages/ccs_card_box_fengyue.xml",
    image = "ccs_card_box_fengyue",
    build = "ccs_card_box_fengyue",
    bank = "ccs_card_box_fengyue",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_card_box",
    basebank = "ccs_card_box",
    baseanim = "idle",
    init_fn = function(inst)
        local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
        if owner and inst.components.equippable and inst.components.equippable:IsEquipped() and inst.SpawnFengyueFx ~= nil then
            inst:SpawnFengyueFx(owner)
        end
    end,
    clear_fn = function(inst)
        if inst.RemoveFengyueFx ~= nil then
            inst:RemoveFengyueFx()
        elseif inst._vfx_fx_inst ~= nil then
            inst._vfx_fx_inst:Remove()
            inst._vfx_fx_inst = nil
        end
    end,
})
CCSAPI.MakeItemSkinDefaultImage('ccs_lifestaff', 'images/inventoryimages/ccs_lifestaff.xml', 'ccs_lifestaff')
CcsItemSkin("ccs_lifestaff", "ccs_lifestaff_skin1", {
    name = "绿萝",
    atlas = "images/inventoryimages/ccs_lifestaff_skin1.xml",
    image = "ccs_lifestaff_skin1",
    build = "ccs_lifestaff_skin1",
    bank = "ccs_lifestaff_skin1",
    basebuild = "ccs_lifestaff",
    basebank = "ccs_lifestaff",
})

CcsItemSkin("ccs_lifestaff", "ccs_lifestaff_skin2", {
    name = "定制：屿花辞",
    atlas = "images/inventoryimages/ccs_lifestaff_skin2.xml",
    image = "ccs_lifestaff_skin2",
    build = "ccs_lifestaff_skin2",
    bank = "ccs_lifestaff_skin2",
    basebuild = "ccs_lifestaff",
    basebank = "ccs_lifestaff",
    -- checkfn = function(inventory, name)
    --     --return CCSAPI.CcsSkinCheckFn(inventory, k)
    --     return true
    -- end,
    -- checkclientfn = function(inventory, userid, name)
    --     --return CCSAPI.CcsSkinCheckClientFn(inventory, userid, k)
    --     return true
    -- end,
})


CCSAPI.MakeItemSkinDefaultImage('ccs_chest2', 'images/inventoryimages/ccs_chest2.xml', 'ccs_chest2')
CcsItemSkin("ccs_chest2", "ccs_chest2_skin1", {
    name = "小可",
    atlas = "images/inventoryimages/ccs_chest2_skin1.xml",
    image = "ccs_chest2_skin1",
    build = "ccs_chest2_skin1",
    bank = "ccs_chest2_skin1",
    basebuild = "ccs_chest2",
    basebank = "ccs_chest2",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1.5, 1.5, 1.5)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,
})

CCSAPI.MakeItemSkinDefaultImage('ccs_chest3', 'images/inventoryimages/ccs_chest3.xml', 'ccs_chest3')
CcsItemSkin("ccs_chest3", "ccs_chest3_skin1", {
    name = "斯比",
    atlas = "images/inventoryimages/ccs_chest3_skin1.xml",
    image = "ccs_chest3_skin1",
    build = "ccs_chest3_skin1",
    bank = "ccs_chest3_skin1",
    basebuild = "ccs_chest3",
    basebank = "ccs_chest3",
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(1.5, 1.5, 1.5)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(2, 2, 2)
    end,
})



CCSAPI.CcsItemAssets(Assets, "ccs_plantflower_fhh", true, true)
CCSAPI.MakeItemSkinDefaultImage('ccs_plantflower_fhh', 'images/inventoryimages/ccs_plantflower_fhh.xml',
    'ccs_plantflower_fhh')
CCSAPI.MakeItemSkin(
    'ccs_plantflower_fhh',
    'ccs_plantflower_fhh_skin1',
    {
        name = "番红花",
        atlas = 'images/inventoryimages/ccs_plantflower_fhh_skin1.xml',
        image = 'ccs_plantflower_fhh_skin1',
        build = 'ccs_plantflower_fhh',
        basebuild = 'ccs_plantflower_fhh',
        bank = 'ccs_plantflower_fhh',
        basebank = 'ccs_plantflower_fhh',
        anim = 'idle1',
        animloop = true,
        baseanim = 'idle',
        baseanimloop = true,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_plantflower_fhh_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_plantflower_fhh_skin1")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_plantflower_ss", true, true)
CCSAPI.MakeItemSkinDefaultImage('ccs_plantflower_ss', 'images/inventoryimages/ccs_plantflower_ss.xml',
    'ccs_plantflower_ss')
CCSAPI.MakeItemSkin(
    'ccs_plantflower_ss',
    'ccs_plantflower_ss_skin1',
    {
        name = "石蒜",
        atlas = 'images/inventoryimages/ccs_plantflower_ss_skin1.xml',
        image = 'ccs_plantflower_ss_skin1',
        build = 'ccs_plantflower_ss',
        basebuild = 'ccs_plantflower_ss',
        bank = 'ccs_plantflower_ss',
        basebank = 'ccs_plantflower_ss',
        anim = 'idle1',
        animloop = true,
        baseanim = 'idle',
        baseanimloop = true,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_plantflower_fhh_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_plantflower_fhh_skin1")
        end
    }
)
CCSAPI.MakeItemSkin(
    'ccs_plantflower_ss',
    'ccs_plantflower_ss_skin2',
    {
        name = "石蒜",
        atlas = 'images/inventoryimages/ccs_plantflower_ss_skin2.xml',
        image = 'ccs_plantflower_ss_skin2',
        build = 'ccs_plantflower_ss',
        basebuild = 'ccs_plantflower_ss',
        bank = 'ccs_plantflower_ss',
        basebank = 'ccs_plantflower_ss',
        anim = 'idle2',
        animloop = true,
        baseanim = 'idle',
        baseanimloop = true,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_plantflower_fhh_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_plantflower_fhh_skin1")
        end
    }
)
CCSAPI.CcsItemAssets(Assets, "ccs_plantflower_www", true, true)
CCSAPI.MakeItemSkinDefaultImage('ccs_plantflower_www', 'images/inventoryimages/ccs_plantflower_www.xml',
    'ccs_plantflower_www')
CCSAPI.MakeItemSkin(
    'ccs_plantflower_www',
    'ccs_plantflower_www_skin1',
    {
        name = "勿忘我",
        atlas = 'images/inventoryimages/ccs_plantflower_www_skin1.xml',
        image = 'ccs_plantflower_www_skin1',
        build = 'ccs_plantflower_www',
        basebuild = 'ccs_plantflower_www',
        bank = 'ccs_plantflower_www',
        basebank = 'ccs_plantflower_www',
        anim = 'idle1',
        animloop = true,
        baseanim = 'idle',
        baseanimloop = true,
        checkfn = function(inventory, name)
            return CCSAPI.CcsSkinCheckFn(inventory, "ccs_plantflower_fhh_skin1")
        end,
        checkclientfn = function(inventory, userid, name)
            return CCSAPI.CcsSkinCheckClientFn(inventory, userid, "ccs_plantflower_fhh_skin1")
        end
    }
)


CCSAPI.CcsItemAssets(Assets, "ccs_trash_skin_zkbb", true, true)
CcsItemSkin("ccs_trash", "ccs_trash_skin_zkbb", {
    name = "定制-扎克婊婊",
    atlas = "images/inventoryimages/ccs_trash_skin_zkbb.xml",
    image = "ccs_trash_skin_zkbb",
    build = "ccs_trash_skin_zkbb",
    bank = "ccs_trash_skin_zkbb",
    basebuild = "ccs_trash",
    basebank = "ccs_trash",
    init_fn = function(inst)
        if inst._state then
            inst._state:set(2)
            inst.components.container:WidgetSetup("ui_ccs_trash_skin_zkbb")
            inst.components.container:Close()
        end
    end,
    clear_fn = function(inst)
        inst._state:set(1)
        inst.components.container:WidgetSetup("ccs_trash")
        inst.components.container:Close()
    end,
})



CCSAPI.MakeItemSkinDefaultImage('ccs_piano', 'images/inventoryimages/ccs_piano.xml', 'ccs_piano')
CCSAPI.CcsItemAssets(Assets, "ccs_piano_skin_yueding", true, true)
CcsItemSkin("ccs_piano", "ccs_piano_skin_yueding", {
    name = "约定",
    atlas = "images/inventoryimages/ccs_piano_skin_yueding.xml",
    image = "ccs_piano_skin_yueding",
    build = "ccs_piano_skin_yueding",
    bank = "ccs_piano_skin_yueding",
    anim = "idle",
    animloop = true,
    basebuild = "ccs_piano",
    basebank = "ccs_piano",
    baseanim = "idle",
    baseanimloop = false,
    init_fn = function(inst)
        if inst.Transform then
            inst.Transform:SetScale(0.8, 0.8, 0.8)
        end
    end,
    clear_fn = function(inst)
        inst.Transform:SetScale(1.5, 1.5, 1.5)
    end,
})
