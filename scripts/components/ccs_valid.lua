local Ccs_Valid = Class(function(self, inst)
	self.inst = inst
	self.zs = false
	self.hp_bd = 0
	self.ccs_light = false
end)

function Ccs_Valid:InIt()
	if self.inst:HasTag("ccs") then 
		self.inst:DoTaskInTime(1,function()
			if self.zs == false then
				local card = SpawnPrefab("ccs_cards_5")
				self.inst.components.inventory:GiveItem(card)
				card.components.ccs_card_level:SetMaster(self.inst.name,self.inst.userid)
				local box = SpawnPrefab("ccs_card_box")
				self.inst.components.inventory:GiveItem(box)
				box.components.ccs_card_level:SetMaster(self.inst.name,self.inst.userid)
				-- local magic_wand = SpawnPrefab("ccs_magic_wand3")
				-- self.inst.components.inventory:GiveItem(magic_wand)
				-- magic_wand.components.ccs_card_level:SetMaster(self.inst.name,self.inst.userid)
				self.zs = true
			end
		end)
	end
end

function Ccs_Valid:Ccs_Light_Init()
	if self.ccs_light == false then
		self.ccs_light = true
		local num = 2
		for i = 1,num do
			local light = SpawnPrefab("ccs_light")
			local x1,y,z1 = self.inst:GetPosition():Get()
			light.Transform:SetPosition(x1+i*5,y,z1-i*5)
		end
	end
end

function Ccs_Valid:OnSave()   --保存
	local data = {}
	if self.zs ~= nil then
		data.zs = self.zs
	end
	if self.hp_bd ~= nil then
		data.bd = self.hp_bd
	end
	if self.ccs_light ~= nil then
		data.ccs_light = self.ccs_light
	end
	return data
end

function Ccs_Valid:OnLoad(data)   --加载
    if data then
		if data.zs then
			self.zs = data.zs
		end
		if data.bd then
			self.hp_bd = data.bd
		end
		if data.ccs_light then
			self.ccs_light = data.ccs_light
		end
	end
end


return Ccs_Valid