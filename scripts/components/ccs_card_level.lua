local function card_level(self, level)  --最大值
	if self.inst.replica.ccs_card_level then
		self.inst.replica.ccs_card_level.level:set(level)
	end
end

local function card_max_level(self, maxlevel)  --最大值
	if self.inst.replica.ccs_card_level then
		self.inst.replica.ccs_card_level.maxlevel:set(maxlevel) 
	end
end

local function card_master(self, master)  --最大值
	if self.inst.replica.ccs_card_level then
		self.inst.replica.ccs_card_level.master:set(master) 
	end
end

local  Ccs_Card_Level = Class(function(self, inst)
	self.inst = inst
	self.level = 1
	self.maxlevel = 1
	self.master = "无"
	self.masterid = nil
end,
nil,
{
	level = card_level,
	maxlevel = card_max_level,
	master = card_master,
})

function Ccs_Card_Level:GetLevel()  
	return self.inst.replica.ccs_card_level.level:value() or self.level
end

function Ccs_Card_Level:UpLevel()  
	self.level = self.level + 1
    local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem:GetGrandOwner()
    if owner ~= nil then owner:PushEvent("ccs_carried_cards_changed") end
end

function Ccs_Card_Level:GetMaxLevel()  
	return self.inst.replica.ccs_card_level.maxlevel:value() or self.maxlevel
end

function Ccs_Card_Level:GetMaster()  
	return self.inst.replica.ccs_card_level.master:value() or self.master
end

function Ccs_Card_Level:SetMaster(master,masterid)  
	self.masterid = masterid
	self.master = master
end

function Ccs_Card_Level:AbandonMaster()  
	self.masterid = nil
	self.master = "无"
end

function Ccs_Card_Level:SetMaxLevel(level)  
	self.maxlevel = level
end

function Ccs_Card_Level:IsMaxLevel()  
	return self.level >= self.maxlevel
end

--保存
function Ccs_Card_Level:OnSave() 
    return 
	{ 
		level = self:GetLevel(),
		master = self:GetMaster(),
		masterid = self.masterid,
	}  
end

--加载
function Ccs_Card_Level:OnLoad(data) 
    if data.level ~= nil  then
        self.level = data.level
    end
	if data.master ~= nil  then
        self.master = data.master
    end
	if data.masterid ~= nil  then
        self.masterid = data.masterid
    end
end


return Ccs_Card_Level
