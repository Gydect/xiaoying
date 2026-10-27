--用来记录卡牌赋予其他物品的能力
local  Ccs_Card_Magic = Class(function(self, inst)
	self.inst = inst
	self.card_20_enble = false		--甜牌能力是否启用
end)

--保存
function Ccs_Card_Magic:OnSave() 
    return 
	{ 
		card_20_enble = self.card_20_enble,

	}  
end

--加载
function Ccs_Card_Magic:OnLoad(data) 
    if data.card_20_enble ~= nil  then
        self.card_20_enble = data.card_20_enble
    end
end

return Ccs_Card_Magic