local function onrecovery(self,magic_recovery)
	if self.inst.replica.ccs_magic then
		self.inst.replica.ccs_magic.magic_recovery:set(magic_recovery)
	end
end

local function onmax(self, max)  --最大值
	if self.inst.replica.ccs_magic then
		self.inst.replica.ccs_magic.max:set(max)
	end
end

local function oncurrent(self, current)
	if self.inst.replica.ccs_magic then
		self.inst.replica.ccs_magic.current:set(current)    --当前值
	end
end

local function recovery_text(self, equrecovery)
	if self.inst.replica.ccs_magic then
		self.inst.replica.ccs_magic.equrecovery:set(equrecovery)
	end
end

local Ccs_Magic = Class(function(self, inst)
    self.inst = inst
    self.max = 100 				--最大值
    self.current = self.max 	--当前值
	self.magic_recovery = 0		--魔力恢复
	self.equrecovery = 0		--装备显示用
	self.consume_bf = 0
    self.paper_count = 0
    self.paper_growth = 0
    self.card_count = 0
    self.power_card = false
    self._growth_damage = 0
end,
nil,
{
    max = onmax,
    current = oncurrent,
	magic_recovery = onrecovery,
	equrecovery = recovery_text
})



--获取魔法值
function Ccs_Magic:GetMagic()
	return self.inst.replica.ccs_magic and self.inst.replica.ccs_magic.current:value() or self.current
end

--魔法恢复数值
function Ccs_Magic:GetRecovery()
	return self.inst.replica.ccs_magic and self.inst.replica.ccs_magic.magic_recovery:value() or self.magic_recovery
end

--获取最大值
function Ccs_Magic:GetMaxMagic()
   return self.inst.replica.ccs_magic and self.inst.replica.ccs_magic.max:value() or self.max
end

--装备魔法恢复数值
function Ccs_Magic:GetRecoverytext()
   return self.inst.replica.ccs_magic and self.inst.replica.ccs_magic.equrecovery:value() or self.equrecovery
end

--增益消耗
function Ccs_Magic:SetConsume_bf(num)
   self.consume_bf = num
end

--设置最大值
function Ccs_Magic:SetMax(amount) 
    self.max = amount
end

--设置魔法值
function Ccs_Magic:SetMagic(amount) 
    self.current = amount
end
----------------------------------------------------------------------
 --改变魔法值的函数
function Ccs_Magic:DoDelta(amount,reason) 	--量，原因
	--print("执行了",amount)
    local old_magic = self.current  --原来的值
	local old_perenct = self:GetPercent()
	
	if amount < 0 and reason ~= "ccs_damage_shield" then
		amount = amount * (1 - self.consume_bf)
	end
    self.current = math.clamp(self.current + amount, 0, self.max)	--将增减的魔法限制到0-最大值
	--local current = self:GetMagic()
	local newpercent = self:GetPercent()
	
	--推送扣除魔法事件，未扣除前的魔法，未扣除前的百分比，新的百分比，扣除魔法量，原因
	self.inst:PushEvent("ccs_magic_delta",{old_magic = old_magic,old_perenct = old_perenct,newpercent = newpercent,amount = amount,reason = reason,current = self:GetMagic() } )	
	
    return self.current
end

function Ccs_Magic:SetCardBonus(count, power_card)
    self.card_count = count
    self.power_card = power_card == true
    self:SetMax(100 + count * 5 + self.paper_growth)
    self.current = math.min(self.current, self.max)
    local combat = self.inst.components.combat
    if combat ~= nil then
        combat.damagemultiplier = (self.power_card and 1.2 or 0.9) + self.paper_growth * 0.01
        local damage = self.paper_growth * 5
        combat.damagebonus = (combat.damagebonus or 0) - self._growth_damage + damage
        self._growth_damage = damage
    end
end

function Ccs_Magic:AbsorbPaper(count)
    self.paper_count = self.paper_count + count
    local growth = math.floor(self.paper_count / 3)
    self.paper_count = self.paper_count % 3
    self.paper_growth = self.paper_growth + growth
    self:SetCardBonus(self.card_count, self.power_card)
    return growth
end


function Ccs_Magic:SetMagicRecovery(num,reason) 
	if self.inst.magic_recovery ~= nil then
		self.inst.magic_recovery:Cancel()
		self.inst.magic_recovery = nil
	end
	self.magic_recovery = math.min(50/60,self.magic_recovery + num)
	if self.magic_recovery < 0 then
		self.magic_recovery = 0
	end
	self.inst.magic_recovery = self.inst:DoPeriodicTask(1, function()  
		self:DoDelta(self.magic_recovery,reason)
	end, 0)	
end

----------------------------------------------------------------

function Ccs_Magic:GetPercent() --获取百分比
    return self.current / self.max
end

function Ccs_Magic:SetPercent(p) --设置百分比
    local old = self.current   --当前值
    self.current  = p * self.max    --传入的参数x100,重新设置当前值
end


--保存
function Ccs_Magic:OnSave() 
    return 
	{ 
		current = self.current,
		paper_count = self.paper_count,
		paper_growth = self.paper_growth,
		--max = self.max

	}  
end

--加载
function Ccs_Magic:OnLoad(data) 
    if data == nil then return end
    self.paper_count = math.max(0, data.paper_count or 0) % 3
    self.paper_growth = math.max(0, math.floor(data.paper_growth or 0))
    self:SetCardBonus(self.card_count, self.power_card)
    if data.current ~= nil  then
        self.current = data.current
        self.inst:DoTaskInTime(0, function() self:DoDelta(0) end)
    end
	--if data.max then
		--self.max = data.max
	--end
end

return Ccs_Magic
