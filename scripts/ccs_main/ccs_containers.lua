local containers = require "containers"
local params = containers.params

local ImageButton = require "widgets/imagebutton"
local function AddButton(config,name,pos,fn,postfn)
    local btn
    local data  = {tokill = {}}
    local CcsOnOpenFn = config.CcsOnOpenFn 
    config.CcsOnOpenFn = function(self,inst,doer,...)
        if btn and btn.inst and btn.inst.widget then btn:Kill() btn = nil end
        btn = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex", "button_small_disabled.tex", nil, nil, {1,1}, {0,0}))
        btn.image:SetScale(1.07)
        btn.text:SetPosition(2,-2)
        btn:SetPosition(pos:Get())
        btn:SetText(name)

        btn:SetFont(BUTTONFONT)
        btn:SetDisabledFont(BUTTONFONT)
        btn:SetTextSize(33)
        btn.text:SetVAlign(ANCHOR_MIDDLE)
        btn.text:SetColour(0, 0, 0, 1)

        if fn then
            btn:SetOnClick(function()
                if doer ~= nil then
                    if doer:HasTag("busy") then
                        --Ignore button click when doer is busy
                        return
                    elseif doer.components.playercontroller ~= nil then
                        local iscontrolsenabled, ishudblocking = doer.components.playercontroller:IsEnabled()
                        if not (iscontrolsenabled or ishudblocking) then
                            --Ignore button click when controls are disabled
                            --but not just because of the HUD blocking input
                            return
                        end
                    end
                end
                fn(inst, doer,btn,self,data)
            end)
        end
        if postfn then
            postfn(btn,inst,name,self,data,...)
        end
        if CcsOnOpenFn then
            return CcsOnOpenFn(self,inst, doer,...)
        end
    end
    local CcsOnCloseFn = config.CcsOnCloseFn
    config.CcsOnCloseFn = function(self,inst,doer,...)
        if btn and btn.inst and btn.inst.widget  then btn:Kill() btn = nil end
        for k,v in pairs (data.tokill) do
            if v and v.inst and v.inst.widget then 
                v:Kill()
            end
        end
    end

end

--魔杖
params.ccs_magic_wand3 =
{
    widget =
    {
        slotpos =
        {		
			Vector3(0,   32 + 24,  0),
			Vector3(0,   32 - 46,  0),
			Vector3(0,   32 - 116,  0),
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(0, 110, 0),		
    },
    type = "hand_inv",
}

function params.ccs_magic_wand3.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

--背包
params.ccs_bag =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ccs_bag_2x9",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-10, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.ccs_bag.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end

params.ccs_dinosaur_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_dinosaur_bag_2x9",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-10, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_dinosaur_bag.widget.slotpos, Vector3(-156, -75 * y + 321, 0))
    table.insert(params.ccs_dinosaur_bag.widget.slotpos, Vector3(-156 + 75, -75 * y + 321, 0))
end
for i = 0, 17 do
    table.insert(
            params.ccs_dinosaur_bag.widget.slotbg,
            {image = 'ui_dinosaur_slot.tex', atlas = 'images/inventoryimages/ui_dinosaur_slot.xml'}
        )
end

params.ccs_hanbao_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hanbao_bag_2x9",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-10, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_hanbao_bag.widget.slotpos, Vector3(-183, -75 * y + 314, 0))
    table.insert(params.ccs_hanbao_bag.widget.slotpos, Vector3(-183 + 75, -75 * y + 314, 0))
end
for i = 0, 17 do
    table.insert(
            params.ccs_hanbao_bag.widget.slotbg,
            {image = 'ui_hanbao_slot.tex', atlas = 'images/inventoryimages/ui_hanbao_slot.xml'}
        )
end

params.ccs_xiaotu_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_xiaotu_bag_2x9",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_xiaotu_bag.widget.slotpos, Vector3(-163, -72 * y + 310, 0))
    table.insert(params.ccs_xiaotu_bag.widget.slotpos, Vector3(-163 + 72, -72 * y + 310, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_xiaotu_bag.widget.slotbg,
        { image = 'ui_xigewen_slot.tex', atlas = 'images/inventoryimages/ui_xigewen_slot.xml' }
    )
end

params.ccs_huihui_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_huihui_bag_2x9",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

local ROWS = 9            -- 行数（y = 0 到 8）
local COLS = 2            -- 列数（每行 2 个格子）
local SLOT_SIZE = 72      -- 格子间距
local OFFSET_X = -153     -- 第一列的 X 位置
local OFFSET_Y = 280      -- 第一行的 Y 位置

for y = 0, ROWS - 1 do
    for x = 0, COLS - 1 do
        table.insert(params.ccs_huihui_bag.widget.slotpos,
            Vector3(OFFSET_X + SLOT_SIZE * x, OFFSET_Y - SLOT_SIZE * y, 0))
    end
end

for i = 0, 17 do
    table.insert(
        params.ccs_huihui_bag.widget.slotbg,
        { image = 'ui_huihui_bag_2x9_slot.tex', atlas = 'images/inventoryimages/ui_huihui_bag_2x9_slot.xml' }
    )
end

params.ccs_huayu_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_ccs_bag_skin_huayu",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_huayu_bag.widget.slotpos, Vector3(-163, -72 * y + 300, 0))
    table.insert(params.ccs_huayu_bag.widget.slotpos, Vector3(-163 + 72, -72 * y + 300, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_huayu_bag.widget.slotbg,
        { image = 'ui_ccs_bubbler_slot.tex', atlas = 'images/inventoryimages/ui_ccs_bubbler_slot.xml' }
    )
end

params.ccs_xxcb_bag =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_ccs_bag_skin_xxcb",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_xxcb_bag.widget.slotpos, Vector3(-163, -72 * y + 300, 0))
    table.insert(params.ccs_xxcb_bag.widget.slotpos, Vector3(-163 + 72, -72 * y + 300, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_xxcb_bag.widget.slotbg,
        { image = 'ui_ccs_bubbler_slot.tex', atlas = 'images/inventoryimages/ui_ccs_bubbler_slot.xml' }
    )
end

params.ccs_bag_skin_hana_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ccs_bag_skin_hana_ui",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag_skin_hana_ui.widget.slotpos, Vector3(-163, -72 * y + 300, 0))
    table.insert(params.ccs_bag_skin_hana_ui.widget.slotpos, Vector3(-163 + 76, -72 * y + 300, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_bag_skin_hana_ui.widget.slotbg,
        { image = 'ccs_bag_skin_hana_slot.tex', atlas = 'images/inventoryimages/ccs_bag_skin_hana_slot.xml' }
    )
end


params.ccs_bag_skin_xiaotucha_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ccs_bag_skin_xiaotucha_ui",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag_skin_xiaotucha_ui.widget.slotpos, Vector3(-163, -72 * y + 280, 0))
    table.insert(params.ccs_bag_skin_xiaotucha_ui.widget.slotpos, Vector3(-163 + 72, -72 * y + 280, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_bag_skin_xiaotucha_ui.widget.slotbg,
        { image = 'ccs_bag_skin_xiaotucha_slot.tex', atlas = 'images/inventoryimages/ccs_bag_skin_xiaotucha_slot.xml' }
    )
end

params.ccs_bag_skin_xiaohuanghua_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_ccs_bag_skin_xiaohuanghua",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag_skin_xiaohuanghua_ui.widget.slotpos, Vector3(-163, -72 * y + 280, 0))
    table.insert(params.ccs_bag_skin_xiaohuanghua_ui.widget.slotpos, Vector3(-163 + 72, -72 * y + 280, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_bag_skin_xiaohuanghua_ui.widget.slotbg,
        { image = 'ccs_bag_skin_xiaohuanghua_slot.tex', atlas = 'images/inventoryimages/ccs_bag_skin_xiaohuanghua_slot.xml' }
    )
end


params.ccs_bag_skin_wuxia_ui =
{
    widget =
    {
        slotpos = {},
        --slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ccs_bag_skin_wuxia_ui",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag_skin_wuxia_ui.widget.slotpos, Vector3(-163, -72 * y + 310, 0))
    table.insert(params.ccs_bag_skin_wuxia_ui.widget.slotpos, Vector3(-163 + 72, -72 * y + 310, 0))
end


params.ccs_bag_yyb_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ccs_bag_yyb_ui",
        --pos = Vector3(-5, -120, 0),
        pos = Vector3(-20, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 8 do
    table.insert(params.ccs_bag_yyb_ui.widget.slotpos, Vector3(-163, -72 * y + 235, 0))
    table.insert(params.ccs_bag_yyb_ui.widget.slotpos, Vector3(-163 + 72, -72 * y + 235, 0))
end
for i = 0, 17 do
    table.insert(
        params.ccs_bag_yyb_ui.widget.slotbg,
        { image = 'ccs_bag_yyb_slot.tex', atlas = 'images/inventoryimages/ccs_bag_yyb_slot.xml' }
    )
end

-- function params.ccs_bag.widget:OnOpenFn(inst)
	-- CcsMakeWidgetMovable(self, "ccs_bag", Vector3(-5, -130, 0), {
		-- drag_offset = 0.6
	-- })
-- end

--卡牌盒
params.ccs_card_box =
{
	widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_5x5",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_card_box",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_card_box.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

function params.ccs_card_box.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

function params.ccs_card_box.widget:OnOpenFn(inst)
	CcsMakeWidgetMovable(self, "ccs_card_box", Vector3(0, 100, 0), {
		drag_offset = 0.6
	})
end

params.ccs_card_box_caomei_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_caomei_ui",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_card_box",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_card_box_caomei_ui.widget.slotpos,
        Vector3(80 * x - 80 * 2 + 205, 80 * y - 80 * 2 + 120, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ccs_card_box_caomei_ui.widget.slotbg,
        { image = 'ccs_card_box_caomei_slot.tex', atlas = 'images/inventoryimages/ccs_card_box_caomei_slot.xml' }
    )
end
function params.ccs_card_box_caomei_ui.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

function params.ccs_card_box_caomei_ui.widget:OnOpenFn(inst)
    CcsMakeWidgetMovable(self, "ccs_card_box_caomei_ui", Vector3(0, 100, 0), {
        drag_offset = 0.6
    })
end


params.ccs_card_box_alxy_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_alxy_ui",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_card_box",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_card_box_alxy_ui.widget.slotpos,
            Vector3(80 * x - 80 * 2, 80 * y - 80 * 2 - 20, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ccs_card_box_alxy_ui.widget.slotbg,
        { image = 'ccs_card_box_alxy_slot.tex', atlas = 'images/inventoryimages/ccs_card_box_alxy_slot.xml' }
    )
end
function params.ccs_card_box_alxy_ui.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

function params.ccs_card_box_alxy_ui.widget:OnOpenFn(inst)
    CcsMakeWidgetMovable(self, "ccs_card_box_alxy_ui", Vector3(0, 100, 0), {
        drag_offset = 0.6
    })
end

params.ccs_card_box_flxy_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_flxy_ui",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_card_box",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_card_box_flxy_ui.widget.slotpos,
            Vector3(80 * x - 80 * 2 + 140, 80 * y - 80 * 2 + 100, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ccs_card_box_flxy_ui.widget.slotbg,
        { image = 'ccs_card_box_flxy_slot.tex', atlas = 'images/inventoryimages/ccs_card_box_flxy_slot.xml' }
    )
end
function params.ccs_card_box_flxy_ui.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

function params.ccs_card_box_flxy_ui.widget:OnOpenFn(inst)
    CcsMakeWidgetMovable(self, "ccs_card_box_flxy_ui", Vector3(0, 100, 0), {
        drag_offset = 0.6
    })
end

params.ccs_card_box_flxy2_ui =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_flxy2_ui",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_card_box",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_card_box_flxy2_ui.widget.slotpos,
            Vector3(80 * x - 80 * 2 + 140, 80 * y - 80 * 2 + 100, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ccs_card_box_flxy2_ui.widget.slotbg,
        { image = 'ccs_card_box_flxy2_slot.tex', atlas = 'images/inventoryimages/ccs_card_box_flxy2_slot.xml' }
    )
end
function params.ccs_card_box_flxy2_ui.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end

function params.ccs_card_box_flxy2_ui.widget:OnOpenFn(inst)
    CcsMakeWidgetMovable(self, "ccs_card_box_flxy2_ui", Vector3(0, 100, 0), {
        drag_offset = 0.6
    })
end

--卡牌盒2
params.ccs_bag2 =
{
	widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_5x5",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "ccs_bag2",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_bag2.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

function params.ccs_bag2.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card") or item:HasTag("ccs_monster_card") and not item.replica.container
end

function params.ccs_bag2.widget:OnOpenFn(inst)
	CcsMakeWidgetMovable(self, "ccs_bag2", Vector3(0, 100, 0), {
		drag_offset = 0.6
	})
end


--暗黑箱子
params.ccs_chest =
{
	widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_5x5",
        pos = Vector3(0, 100, 0),
        side_align_tip = 160,
    },
    type = "ccs_chest",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_chest.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end


params.ccs_oven_shasha =
{
    widget =
    {
        slotpos = {},
        animbank = "ccs_oven_shasha_ui",
        animbuild = "ccs_oven_shasha_ui",
        pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_chest",
}

local COLS, ROWS = 5, 5    -- 5*5
local SLOT_SIZE = 77       -- 格子间距
local OFFSET_X = -275       -- 值越小越往左
local OFFSET_Y = -170        -- 值越小越往下

for y = ROWS - 1, 0, -1 do
    for x = 0, COLS - 1 do
        table.insert(params.ccs_oven_shasha.widget.slotpos,
            Vector3(SLOT_SIZE * x + OFFSET_X, SLOT_SIZE * y + OFFSET_Y, 0))
    end
end

for i = 0, COLS * ROWS - 1 do
    table.insert(
        params.ccs_oven_shasha.widget.slotbg,
        { image = 'ccs_oven_shasha_slot.tex', atlas = 'images/inventoryimages/ccs_oven_shasha_slot.xml' }
    )
end

params.ccs_oven_shasha_y =
{
    widget =
    {
        slotpos = {},
        animbank = "ccs_oven_shasha_ui_y",
        animbuild = "ccs_oven_shasha_ui_y",
        pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_chest",
}

local COLS, ROWS = 5, 5    -- 5*5
local SLOT_SIZE = 77       -- 格子间距
local OFFSET_X = -275       -- 值越小越往左
local OFFSET_Y = -170        -- 值越小越往下

for y = ROWS - 1, 0, -1 do
    for x = 0, COLS - 1 do
        table.insert(params.ccs_oven_shasha_y.widget.slotpos,
            Vector3(SLOT_SIZE * x + OFFSET_X, SLOT_SIZE * y + OFFSET_Y, 0))
    end
end

for i = 0, COLS * ROWS - 1 do
    table.insert(
        params.ccs_oven_shasha_y.widget.slotbg,
        { image = 'ccs_oven_shasha_slot.tex', atlas = 'images/inventoryimages/ccs_oven_shasha_slot.xml' }
    )
end

params.ccs_oven_mixue =
{
    widget =
    {
        slotpos = {},
        animbank = "ccs_oven_mixue_ui",
        animbuild = "ccs_oven_mixue_ui",
        pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_chest",
}

local COLS, ROWS = 5, 5    -- 5*5
local SLOT_SIZE = 77       -- 格子间距
local OFFSET_X = -275       -- 值越小越往左
local OFFSET_Y = -170        -- 值越小越往下

for y = ROWS - 1, 0, -1 do
    for x = 0, COLS - 1 do
        table.insert(params.ccs_oven_mixue.widget.slotpos,
            Vector3(SLOT_SIZE * x + OFFSET_X, SLOT_SIZE * y + OFFSET_Y, 0))
    end
end

for i = 0, COLS * ROWS - 1 do
    table.insert(
        params.ccs_oven_mixue.widget.slotbg,
        { image = 'ccs_oven_mixue_slot.tex', atlas = 'images/inventoryimages/ccs_oven_mixue_slot.xml' }
    )
end

params.ccs_oven_mixue_y =
{
    widget =
    {
        slotpos = {},
        animbank = "ccs_oven_mixue_ui_y",
        animbuild = "ccs_oven_mixue_ui_y",
        pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_chest",
}

local COLS, ROWS = 5, 5    -- 5*5
local SLOT_SIZE = 77       -- 格子间距
local OFFSET_X = -275       -- 值越小越往左
local OFFSET_Y = -170        -- 值越小越往下

for y = ROWS - 1, 0, -1 do
    for x = 0, COLS - 1 do
        table.insert(params.ccs_oven_mixue_y.widget.slotpos,
            Vector3(SLOT_SIZE * x + OFFSET_X, SLOT_SIZE * y + OFFSET_Y, 0))
    end
end

for i = 0, COLS * ROWS - 1 do
    table.insert(
        params.ccs_oven_mixue_y.widget.slotbg,
        { image = 'ccs_oven_mixue_slot.tex', atlas = 'images/inventoryimages/ccs_oven_mixue_slot.xml' }
    )
end


--樱花灯
params.ccs_light3 =
{
	widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_5x5",
        pos = Vector3(0, 100, 0),
        side_align_tip = 160,
		buttoninfo =
        {
            text = "一键收纳",
            position = Vector3(0, -165, 0),
        },
    },
    type = "ccs_light3",
}

function params.ccs_light3.widget.buttoninfo.fn(inst, doer)
	SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_sn"],inst)
end

function params.ccs_light3.widget.buttoninfo.validfn(inst)
    return true
end

AddButton(params.ccs_light3.widget, "拆除包囊", Vector3(150, -165, 0), function(inst)
	SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_cc"],inst)
end)

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_light3.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

--樱花灯皮肤
params.ui_ccs_light3_skins3 =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_light3_skins3",
        pos = Vector3(0, 100, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "一键收纳",
            position = Vector3(-130, -255, 0),
        },
    },
    type = "ccs_light3",
}

function params.ui_ccs_light3_skins3.widget.buttoninfo.fn(inst, doer)
    SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_sn"], inst)
end

function params.ui_ccs_light3_skins3.widget.buttoninfo.validfn(inst)
    return true
end

AddButton(params.ui_ccs_light3_skins3.widget, "拆除包囊", Vector3(20, -255, 0), function(inst)
    SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_cc"], inst)
end)

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ui_ccs_light3_skins3.widget.slotpos, Vector3(80 * x - 80 * 2 - 3, 80 * y - 80 * 2 + 2, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ui_ccs_light3_skins3.widget.slotbg,
        { image = 'ui_ccs_light3_skins3_slot.tex', atlas = 'images/inventoryimages/ui_ccs_light3_skins3_slot.xml' }
    )
end


params.ui_ccs_light3_skin_xingyuan =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_light3_skin_xingyuan",
        pos = Vector3(0, 100, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "一键收纳",
            position = Vector3(-130, -255, 0),
        },
    },
    type = "ccs_light3",
}

function params.ui_ccs_light3_skin_xingyuan.widget.buttoninfo.fn(inst, doer)
    SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_sn"], inst)
end

function params.ui_ccs_light3_skin_xingyuan.widget.buttoninfo.validfn(inst)
    return true
end

AddButton(params.ui_ccs_light3_skin_xingyuan.widget, "拆除包囊", Vector3(20, -255, 0), function(inst)
    SendModRPCToServer(MOD_RPC["CCS"]["ccs_light3_cc"], inst)
end)

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ui_ccs_light3_skin_xingyuan.widget.slotpos,
        Vector3(80 * x - 80 * 2 - 3, 80 * y - 80 * 2 - 10, 0))
    end
end
for i = 0, 24 do
    table.insert(
        params.ui_ccs_light3_skin_xingyuan.widget.slotbg,
        { image = 'ui_xigewen_slot.tex', atlas = 'images/inventoryimages/ui_xigewen_slot.xml' }
    )
end
--小可
params.ccs_xk_rq =
{

    widget =
    {
        slotpos =
        {
            Vector3(0,   32 + 4,  0),
            Vector3(0, -(32 + 4), 0),
        },
        slotbg =
        {
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(0, 60, 0),
    },
    type = "ccs_xk_rq",
}

--冰箱
params.ccs_ice_box_rq =
{
    widget =
    {
        slotpos = {},					
        animbank = "ui_chest_3x3",		
        animbuild = "ccs_card_box_5x5",		
		pos = Vector3(0, 100, 0),
        side_align_tip = 160,				
    },
    type = "ccs_ice_box_rq",
}

for y = 4, 0, -1 do				
    for x = 0, 4 do
        table.insert(params.ccs_ice_box_rq.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

function params.ccs_ice_box_rq.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_ice_box_xigewen =
{
    widget =
    {
        slotpos = {},					
        animbank = "ui_chest_3x3",		
        animbuild = "ui_xigewen_box",		
		pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,				
    },
    type = "ccs_ice_box_rq",
}

for y = 2, -2, -1 do
    for x = -2, 2 do
        table.insert(params.ccs_ice_box_xigewen.widget.slotpos, Vector3(80 * x + 13 , 80 * y - 25, 0))
    end
end

for i = 0, 24 do
    table.insert(
            params.ccs_ice_box_xigewen.widget.slotbg,
            {image = 'ui_xigewen_slot2.tex', atlas = 'images/inventoryimages/ui_xigewen_slot2.xml'}
        )
end


function params.ccs_ice_box_xigewen.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_ice_box_shoe =
{
    widget =
    {
        slotpos = {},					
        animbank = "ui_chest_3x3",		
        animbuild = "ui_shoe_box",		
		pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,				
    },
    type = "ccs_ice_box_rq",
}

for y = 2, -2, -1 do
    for x = -2, 2 do
        table.insert(params.ccs_ice_box_shoe.widget.slotpos, Vector3(80 * x + 5 , 80 * y - 25, 0))
    end
end

for i = 0, 24 do
    table.insert(
            params.ccs_ice_box_shoe.widget.slotbg,
            {image = 'ui_xigewen_slot.tex', atlas = 'images/inventoryimages/ui_xigewen_slot.xml'}
        )
end


function params.ccs_ice_box_shoe.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_ice_box_cat =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_cat_box",
        pos = Vector3(0, 100, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_ice_box_rq",
}

for y = 2, -2, -1 do
    for x = -2, 2 do
        table.insert(params.ccs_ice_box_cat.widget.slotpos, Vector3(70 * x + 10, 70 * y - 10, 0))
    end
end

for i = 0, 24 do
    table.insert(
        params.ccs_ice_box_cat.widget.slotbg,
        { image = 'ui_pink_slot.tex', atlas = 'images/inventoryimages/ui_pink_slot.xml' }
    )
end


function params.ccs_ice_box_cat.itemtestfn(container, item, slot)
    return not item.replica.container
end

--水晶球
params.ccs_trash =
{
	widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_card_box_5x5",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
		buttoninfo =
        {
            text = "清理垃圾",
            position = Vector3(0, -165, 0),
        }
    },
    type = "ccs_trash",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ccs_trash.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

function params.ccs_trash.widget.buttoninfo.fn(inst, doer)
	SendModRPCToServer(MOD_RPC["CCS"]["CCS_trash_rpc"],inst)
end

function params.ccs_trash.widget.buttoninfo.validfn(inst)
    return true
end

function params.ccs_trash.widget:OnOpenFn(inst)
	CcsMakeWidgetMovable(self, "ccs_trash", Vector3(0, 100, 0), {
		drag_offset = 0.6
	})
end



params.ui_ccs_trash_skin_zkbb =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_trash_skin_zkbb",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "清理垃圾",
            position = Vector3(-50, -230, 0),
        }
    },
    type = "ccs_trash",
}

for y = 4, 0, -1 do
    for x = 0, 4 do
        table.insert(params.ui_ccs_trash_skin_zkbb.widget.slotpos,
        Vector3(80 * x - 80 * 2, 80 * y - 80 * 2, 0))
    end
end

function params.ui_ccs_trash_skin_zkbb.widget.buttoninfo.fn(inst, doer)
    SendModRPCToServer(MOD_RPC["CCS"]["CCS_trash_rpc"], inst)
end

function params.ui_ccs_trash_skin_zkbb.widget.buttoninfo.validfn(inst)
    return true
end

function params.ui_ccs_trash_skin_zkbb.widget:OnOpenFn(inst)
    CcsMakeWidgetMovable(self, "ccs_trash", Vector3(0, 100, 0), {
        drag_offset = 0.6
    })
end


for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

--星星法杖
params.ccs_starstaff = {
    widget = {
        slotpos = {
            Vector3(0, 32 + 4, 0)
        },
        animbank = 'ui_cookpot_1x2',
        animbuild = 'ui_cookpot_1x2',
        pos = Vector3(0, 15, 0)
    },
    type = 'hand_inv'
}

function params.ccs_starstaff.itemtestfn(container, item, slot)
    return not item.replica.container
end

--生命法杖
params.ccs_lifestaff = {
    widget = {
        slotpos = {
            Vector3(0, 32 + 4, 0)
        },
        animbank = 'ui_cookpot_1x2',
        animbuild = 'ui_cookpot_1x2',
        pos = Vector3(0, 15, 0)
    },
    type = 'hand_inv'
}

function params.ccs_lifestaff.itemtestfn(container, item, slot)
    return not item.replica.container
end

--储物箱
params.ccs_treasurechest =
{
    widget =
    {
        slotpos = {},					
        animbank = "ui_chest_3x3",		
        animbuild = "ccs_card_box_5x5",		
		pos = Vector3(0, 100, 0),
        side_align_tip = 160,				
    },
    type = "ccs_treasurechest",
}

for y = 4, 0, -1 do				
    for x = 0, 4 do
        table.insert(params.ccs_treasurechest.widget.slotpos, Vector3(80 * x - 80 * 2 + 127, 80 * y - 80 * 2 + 92, 0))
    end
end

--xksb皮肤ui
params.ccs_bluepet =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_xksb_blue",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_bluepet.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
            params.ccs_bluepet.widget.slotbg,
            {image = 'ui_xigewen_slot.tex', atlas = 'images/inventoryimages/ui_xigewen_slot.xml'}
        )
end


function params.ccs_bluepet.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_blackpet =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_xksb_black",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_blackpet.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
            params.ccs_blackpet.widget.slotbg,
            {image = 'ui_xigewen_slot.tex', atlas = 'images/inventoryimages/ui_xigewen_slot.xml'}
        )
end


function params.ccs_blackpet.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_meimeipet =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_meimeipet",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_meimeipet.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ccs_meimeipet.widget.slotbg,
        { image = 'ccs_meimeipet_slot.tex', atlas = 'images/inventoryimages/ccs_meimeipet_slot.xml' }
    )
end


function params.ccs_meimeipet.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_xuexuepet =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_xuexuepet",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_xuexuepet.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ccs_xuexuepet.widget.slotbg,
        { image = 'ccs_xuexuepet_slot.tex', atlas = 'images/inventoryimages/ccs_xuexuepet_slot.xml' }
    )
end


function params.ccs_xuexuepet.itemtestfn(container, item, slot)
    return not item.replica.container
end


params.ui_ccs_sb_item_skin_rzym =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_sb_item_skin_rzym",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ui_ccs_sb_item_skin_rzym.widget.slotpos,
        Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 120, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ui_ccs_sb_item_skin_rzym.widget.slotbg,
        { image = 'ccs_sb_item_skin_rzym_slot.tex', atlas = 'images/inventoryimages/ccs_sb_item_skin_rzym_slot.xml' }
    )
end


function params.ui_ccs_sb_item_skin_rzym.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ui_ccs_sb_item_bada =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_sb_item_bada",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ui_ccs_sb_item_bada.widget.slotpos,
        Vector3(70 * x - 80, 70 * y - 70, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ui_ccs_sb_item_bada.widget.slotbg,
        { image = 'ccs_sb_item_bada_slot.tex', atlas = 'images/inventoryimages/ccs_sb_item_bada_slot.xml' }
    )
end


function params.ui_ccs_sb_item_bada.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ui_ccs_sb_item_baozi =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_sb_item_baozi",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

local COLS, ROWS = 3, 3    -- 3*3
local SLOT_SIZE = 70       -- 格子间距
local OFFSET_X = -70       -- 值越小越往左
local OFFSET_Y = -83       -- 值越小越往下

for y = ROWS - 1, 0, -1 do
    for x = 0, COLS - 1 do
        table.insert(params.ui_ccs_sb_item_baozi.widget.slotpos,
            Vector3(SLOT_SIZE * x + OFFSET_X, SLOT_SIZE * y + OFFSET_Y, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ui_ccs_sb_item_baozi.widget.slotbg,
        { image = 'ui_ccs_sb_item_baozi_slot.tex', atlas = 'images/inventoryimages/ui_ccs_sb_item_baozi_slot.xml' }
    )
end


function params.ui_ccs_sb_item_baozi.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ui_ccs_sb_item_dilu =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_sb_item_dilu",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ui_ccs_sb_item_dilu.widget.slotpos,
        Vector3(75 * x - 80, 75 * y - 70, 0))
    end
end

for i = 0, 8 do
    table.insert(
        params.ui_ccs_sb_item_dilu.widget.slotbg,
        { image = 'ccs_sb_item_dilu_slot.tex', atlas = 'images/inventoryimages/ccs_sb_item_dilu_slot.xml' }
    )
end


function params.ui_ccs_sb_item_dilu.itemtestfn(container, item, slot)
    return not item.replica.container
end


params.ccs_apple_container =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_sb_item_skins_appale_rq",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_apple_container.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
            params.ccs_apple_container.widget.slotbg,
            {image = 'ccs_sb_item_skins_appale2_image.tex', atlas = 'images/inventoryimages/ccs_sb_item_skins_appale2_image.xml'}
        )
end


function params.ccs_apple_container.itemtestfn(container, item, slot)
    return not item.replica.container
end


params.ccs_apple2_container =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ccs_sb_item_skins_appale2_rq",
        pos = Vector3(0, 200, 0),
        slotbg = {},
        side_align_tip = 160,
    },
    type = "ccs_pet",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.ccs_apple2_container.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 85 * 2 + 80, 0))
    end
end

for i = 0, 8 do
    table.insert(
            params.ccs_apple2_container.widget.slotbg,
            {image = 'ccs_sb_item_skins_appale2_image.tex', atlas = 'images/inventoryimages/ccs_sb_item_skins_appale2_image.xml'}
        )
end


function params.ccs_apple2_container.itemtestfn(container, item, slot)
    return not item.replica.container
end

params.ccs_spbox =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_spbox",
        pos = Vector3(0, 150, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "收集",
            position = Vector3(7, -280, 0),
            fn = function(inst, doer)
                if inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                    SendModRPCToServer(MOD_RPC["CCS"]["ccs_collect"], inst)
                end
            end,
        }
    },
    type = "ccs_spbox",
}
for y = 7, 0, -1 do
    for x = 0, 7 do
        table.insert(params.ccs_spbox.widget.slotpos, Vector3(67 * x - 67 * 3.5 + 3, 67 * y - 72 * 3.5 + 25, 0))
    end
end

local cooking = require("cooking")
function params.ccs_spbox.itemtestfn(container, item, slot)
    if not item.replica.container then
        return (cooking.IsCookingIngredient(item.prefab) and
                (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled"))) or
            item:HasTag("deployedfarmplant")
    end
    return false
end

params.ui_ccs_cookpot2_skin_xiaoke =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_ccs_cookpot2_skin_xiaoke",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "魔法烹饪",
            position = Vector3(0, -180, 0),
        },
    },
    type = "ccs_cookpot2",
}

local xiaoke_input_x = -96
local xiaoke_storage_x = { 20, 92 }
local xiaoke_top_y = 104
local xiaoke_y_step = 64

for y = 0, 3 do
    table.insert(params.ui_ccs_cookpot2_skin_xiaoke.widget.slotpos, Vector3(xiaoke_input_x, xiaoke_top_y - xiaoke_y_step * y - 30, 0))
end

for _, x in ipairs(xiaoke_storage_x) do
    for y = 0, 3 do
        table.insert(params.ui_ccs_cookpot2_skin_xiaoke.widget.slotpos,
            Vector3(x, xiaoke_top_y - xiaoke_y_step * y - 30, 0))
    end
end

for i = 0, 11 do
    table.insert(
        params.ui_ccs_cookpot2_skin_xiaoke.widget.slotbg,
        { image = 'ccs_cookpot2_skin_xiaoke_slot.tex', atlas = 'images/inventoryimages/ccs_cookpot2_skin_xiaoke_slot.xml' }
    )
end

function params.ui_ccs_cookpot2_skin_xiaoke.widget.buttoninfo.fn(inst, doer)
    if CCSAPI.Cookpot2MagicCook ~= nil then
        CCSAPI.Cookpot2MagicCook(inst, doer)
    end
end

function params.ui_ccs_cookpot2_skin_xiaoke.widget.buttoninfo.validfn(inst)
    if inst.replica.container == nil then
        return false
    end
    for i = 1, 4 do
        if inst.replica.container:GetItemInSlot(i) == nil then
            return false
        end
    end
    return true
end

function params.ui_ccs_cookpot2_skin_xiaoke.itemtestfn(container, item, slot)
    if item.replica and item.replica.container then
        return false
    end
    return true
end

params.ui_ccs_cookpot2_skin_xingmian =
{
    widget =
    {
        slotpos = {
            Vector3(-32, 180, 0),
            Vector3(40, 180, 0),
            Vector3(-32, 108, 0),
            Vector3(40, 108, 0),

            Vector3(-32, 4, 0),
            Vector3(40, 4, 0),
            Vector3(-32, -68, 0),
            Vector3(40, -68, 0),
            Vector3(-32, -140, 0),
            Vector3(40, -140, 0),
            Vector3(-32, -212, 0),
            Vector3(40, -212, 0),
        },
        slotbg = {},
        animbank = "ui_ccs_cookpot2_skin_xingmian",
        animbuild = "ui_ccs_cookpot2_skin_xingmian",
        pos = Vector3(150, 0, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = "魔法烹饪",
            position = Vector3(4, 56, 0),
        },
    },
    type = "ccs_cookpot2",
}

for i = 0, 11 do
    table.insert(
        params.ui_ccs_cookpot2_skin_xingmian.widget.slotbg,
        { image = 'ccs_cookpot2_skin_xingmian_slot.tex', atlas = 'images/inventoryimages/ccs_cookpot2_skin_xingmian_slot.xml' }
    )
end

function params.ui_ccs_cookpot2_skin_xingmian.widget.buttoninfo.fn(inst, doer)
    if CCSAPI.Cookpot2MagicCook ~= nil then
        CCSAPI.Cookpot2MagicCook(inst, doer)
    end
end

function params.ui_ccs_cookpot2_skin_xingmian.widget.buttoninfo.validfn(inst)
    if inst.replica.container == nil then
        return false
    end
    for i = 1, 4 do
        if inst.replica.container:GetItemInSlot(i) == nil then
            return false
        end
    end
    return true
end

function params.ui_ccs_cookpot2_skin_xingmian.itemtestfn(container, item, slot)
    if item.replica and item.replica.container then
        return false
    end
    return true
end

params.ccs_homesign =
{
    widget =
    {
        slotpos =
        {
            Vector3(-(64 + 12), 0, 0),
            Vector3(0, 0, 0),
            Vector3(64 + 12, 0, 0),
        },
        animbank = "ui_chest_3x1",
        animbuild = "ui_chest_3x1",
        pos = Vector3(200, 0, 0),
        side_align_tip = 100,
    },
    acceptsstacks = false,
    type = "cooker",
}

function params.ccs_homesign.itemtestfn(container, item, slot)
    return item:HasTag("ccs_card")
end
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
