local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"

local Ccs_Equip_Set = Class(Widget, function(self, owner)
	Widget._ctor(self, "Ccs_Equip_Set", owner)

	self.owner = owner

	self.text_enble = self:AddChild(TextButton())              --添加文本按钮
	self.text_enble.enble = false                              --是否已展开
	self.text_enble:SetFont(BODYTEXTFONT)                      --字体
	self.text_enble:SetTextSize(44)                            --大小
	self.text_enble:SetTextColour({ 254 / 255, 255 / 255, 0 / 255, 1 }) --颜色
	self.text_enble:SetTextFocusColour({ 254 / 255, 255 / 255, 0 / 255, 1 })

	self.text_enble:SetPosition(-450, 230, 0)
	self.text_enble:MoveToFront()
	self.text_enble:SetText("衣着设置")
	self.text_enble:SetColour(254 / 255, 255 / 255, 0 / 255, 1)
	self.text_enble:SetTooltip("点击显示")
	self.text_enble:SetOnClick(function()
		if self.text_enble.enble == false then
			self.text_enble.enble = true
			self.text_enble:SetTooltip("点击隐藏")
			self.self_text_yigui:Show()
			self.self_text_enble_tip_x3:Show()
		else
			self.text_enble.enble = false
			self.text_enble:SetTooltip("点击显示")
			self.self_text_yigui:Hide()
			self.self_text_enble_tip_x3:Hide()
		end
	end)

	self.self_text_yigui = self.text_enble:AddChild(TextButton())
	self.self_text_yigui:SetFont(BODYTEXTFONT)       --字体
	self.self_text_yigui:SetTextSize(44)             --大小
	self.self_text_yigui:SetTextColour({ 1, 1, 1, .8 }) --颜色
	self.self_text_yigui:SetText("立刻换装")
	self.self_text_yigui:SetTooltip("点击立即打开随身衣柜换装")

	self.self_text_yigui:SetPosition(165, 0, 0)
	self.self_text_yigui:MoveToFront()
	self.self_text_yigui:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["Ccs"]["Ccs_Equip_show_set"])
	end)
	

	self.self_text_enble_tip_x3 = self.text_enble:AddChild(TextButton())
	self.self_text_enble_tip_x3:SetFont(BODYTEXTFONT)       --字体
	self.self_text_enble_tip_x3:SetTextSize(44)             --大小
	self.self_text_enble_tip_x3:SetTextColour({ 1, 1, 1, .8 }) --颜色
	self.self_text_enble_tip_x3:SetPosition(80, -3, 0)
	self.self_text_enble_tip_x3:SetText("/")
	self.self_text_enble_tip_x3:SetRotation(80)
	self.self_text_enble_tip_x3:SetTooltip("")

	self.self_text_yigui:Hide()
	self.self_text_enble_tip_x3:Hide()
end)


return Ccs_Equip_Set
