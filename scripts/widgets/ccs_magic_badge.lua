local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

--设置UI可拖拽
local function MakeCcsDragableUI(self)
	--修改鼠标控制
	local oldOnControl=self.OnControl
	self.OnControl = function (self,control, down)
		--按下热键可拖动
		if TheInput:IsKeyDown(KEY_F1) then 
            self:Passive_OnControl(control, down)
		elseif oldOnControl~=nil then
			return oldOnControl(self,control,down)
		end
	end
	
	self:MoveToBack()
	--被控制(控制状态，是否按下)
	function self:Passive_OnControl(control, down)
		if control == CONTROL_ACCEPT then
			if down then
				self:StartDrag()
			else
				self:EndDrag()
			end
		end
	end
	--设置拖拽坐标
	function self:SetDragPosition(x, y, z)
		local pos
		if type(x) == "number" then
			pos = Vector3(x, y, z)
		else
			pos = x
		end
		local newpos=pos + self.dragPosDiff
		-- print("坐标x:"..newpos.x.."y:"..newpos.y)
		if newpos.x>=-134 and newpos.x<=-114 and newpos.y>=25 and newpos.y<=45 then
			newpos=Vector3(-124,35,0)
		elseif newpos.x>=-71 and newpos.x<=-51 and newpos.y>=-63 and newpos.y<=-43 then
			newpos=Vector3(-61,-53,0)
		elseif newpos.x>=-10 and newpos.x<=10 and newpos.y>=-63 and newpos.y<=-43 then
			newpos=Vector3(0,-53,0)
		elseif newpos.x>=-194 and newpos.x<=-174 and newpos.y>=25 and newpos.y<=45 then
			newpos=Vector3(-184,35,0)
		end
		self:SetPosition(newpos)
		-- self:SetPosition(pos + self.dragPosDiff)
	end
	
	--开始拖动
	function self:StartDrag()
		if not self.followhandler then
			local mousepos = TheInput:GetScreenPosition()
			self.dragPosDiff = self:GetPosition() - mousepos--坐标修正值
			self.followhandler = TheInput:AddMoveHandler(function(x,y)
				self:SetDragPosition(x,y,0)
				--松开按键停止拖拽
				if not TheInput:IsKeyDown(KEY_F1) then 
					self:EndDrag()
				end 
			end)
			self:SetDragPosition(mousepos)
		end
	end
	--停止拖动
	function self:EndDrag()
		if self.followhandler then
			self.followhandler:Remove()
		end
		self.followhandler = nil
		self.dragPosDiff = nil
		self:MoveToBack()
	end

	function self:Scale_DoDelta(delta)
		self.scale = math.max(self.scale+delta,0.1)
		self:SetScale(self.scale,self.scale,self.scale)
		self:MoveToBack()
	end
end

local Ccs_Magic_Badge = Class(Badge, function(self, owner, art)
    Badge._ctor(self, "ccs_magic", owner)
	
	self.magicarrow = self.underNumber:AddChild(UIAnim())
    self.magicarrow:GetAnimState():SetBank("sanity_arrow")
    self.magicarrow:GetAnimState():SetBuild("sanity_arrow")
    self.magicarrow:GetAnimState():PlayAnimation("neutral")
    self.magicarrow:SetClickable(false)
	self:SetTooltip("按住F1可拖动")
	
	self:StartUpdating()		
	MakeCcsDragableUI(self)
end)

function Ccs_Magic_Badge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

local RATE_SCALE_ANIM =
{
    [RATE_SCALE.INCREASE_HIGH] = "arrow_loop_increase_most",
    [RATE_SCALE.INCREASE_MED] = "arrow_loop_increase_more",
    [RATE_SCALE.INCREASE_LOW] = "arrow_loop_increase",
    [RATE_SCALE.DECREASE_HIGH] = "arrow_loop_decrease_most",
    [RATE_SCALE.DECREASE_MED] = "arrow_loop_decrease_more",
    [RATE_SCALE.DECREASE_LOW] = "arrow_loop_decrease",
}


function Ccs_Magic_Badge:OnUpdate(dt)
	local ccs_magic = self.owner.replica.ccs_magic
	if ccs_magic then
		local maxmagic = math.floor(ccs_magic:GetMaxMagic()) or 100
		local currentmagic = math.floor(ccs_magic:GetMagic()) or 0  
		local a = ccs_magic:GetRecovery()
		local anim = "neutral"	
		self:SetPercent(currentmagic/maxmagic, maxmagic)
		if a ~= nil and currentmagic < maxmagic then  
			if a >= 1/60 then
				anim = "arrow_loop_increase" --小箭头上升
				if a >= 5/60 then
					anim = "arrow_loop_increase_more" --中箭头上升
					if a >= 10/60 then
						anim = "arrow_loop_increase_most" --大箭头上升	
					end
				end
			end
			if a <= -1/60 then
				anim = RATE_SCALE_ANIM[RATE_SCALE.DECREASE_LOW]
				if a <= -5/60 then
					anim = RATE_SCALE_ANIM[RATE_SCALE.DECREASE_MED]
					if a <= -10/60 then
						anim = RATE_SCALE_ANIM[RATE_SCALE.DECREASE_HIGH]
					end
				end
			end
		end	
		if self.arrowdir ~= anim then
			self.arrowdir = anim
			self.magicarrow:GetAnimState():PlayAnimation(anim, true)
	    end
	end
end
return Ccs_Magic_Badge