local zb = require("widgets/ccs_magic_badge")

local function magiczb(self) 
	if self.owner:HasTag("ccs") then
		self.ccs_magic = self:AddChild(zb(self.owner))

		self.owner:DoTaskInTime(0.5, function()
			local x1 ,y1,z1 = self.stomach:GetPosition():Get()
			local x2 ,y2,z2 = self.brain:GetPosition():Get()		
			local x3 ,y3,z3 = self.heart:GetPosition():Get()		
			if y2 == y1 or  y2 == y3 then --开了三维mod
				self.ccs_magic:SetPosition(self.stomach:GetPosition() + Vector3(x1-x2, 0, 0))
			else
				self.ccs_magic:SetPosition(self.stomach:GetPosition() + Vector3(x1-x3, 0, 0))
			end
		end)


		--死亡时候的隐藏
		local old_SetGhostMode = self.SetGhostMode
		function self:SetGhostMode(ghostmode,...)
			old_SetGhostMode(self,ghostmode,...)
			if ghostmode then		
				if self.ccs_magic ~= nil then 
					self.ccs_magic:Hide()
				end	
			else
				if self.ccs_magic ~= nil then
					self.ccs_magic:Show()
				end
		    end
	    end
	end
end
AddClassPostConstruct("widgets/statusdisplays", magiczb)