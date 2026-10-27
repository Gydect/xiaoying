AddClassPostConstruct("widgets/hoverer",function(self)
	local old_SetString = self.text.SetString
	self.text.SetString = function(text,str)
		local target = TheInput:GetHUDEntityUnderMouse()
		if target ~= nil then
			target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item
		else
			target = TheInput:GetWorldEntityUnderMouse()
		end
		if target and target.entity ~= nil then
			if target.replica.ccs_card_level and target:HasTag("ccs_card") then
				local maxlevel = target.replica.ccs_card_level:GetMaxLevel()  
				local level = target.replica.ccs_card_level:GetLevel()   
				local master = target.replica.ccs_card_level:GetMaster()  
				str = str.."\n该卡牌最大等级："..maxlevel.."\n该卡牌当前等级："..level.."\n该卡牌主人："..master
			end
			if target.replica.ccs_card_level and not target:HasTag("ccs_card") then
				local master = target.replica.ccs_card_level:GetMaster()  
				str = str.."\n该物品主人："..master
			end
		end
		return old_SetString(text,str)
	end
end)