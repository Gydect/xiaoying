
local assets=
{
	Asset("ANIM", "anim/sfy.zip"),  --动画文件
	Asset("ANIM", "anim/ccs_fx2.zip"),
	Asset("ANIM", "anim/ccs_cards_xz.zip"),
}

local assets3 = {
    Asset("ANIM", "anim/lavaarena_shadow_lunge.zip"),	
    Asset("ANIM", "anim/ccs.zip"),	
	Asset("ANIM", "anim/waxwell_shadow_mod.zip"),
    Asset("ANIM", "anim/swap_nightmaresword_shadow.zip"),
}

local assets4=
{
	Asset("ANIM", "anim/ccs_starburst.zip"), 

}
local assets5=
{
	Asset("ANIM", "anim/magic_circle_madoko.zip"), 
	Asset("ANIM", "anim/magic_circle_madoko1.zip"), 

}
local assets6=
{
	Asset("ANIM", "anim/ccs_whale_footprints_fx.zip"),

}
local assets_ccs_dripfx = {

    Asset("ANIM", "anim/ccs_dripfx.zip"),
    Asset("ANIM", "anim/abigail_buff_drip.zip"),
    Asset("ANIM", "anim/abigail_vial_fx.zip")
}
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 

	inst.AnimState:SetBank("syfy")  
    inst.AnimState:SetBuild("sfy")  
    inst.AnimState:PlayAnimation("animation")
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 


local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 

	inst.AnimState:SetBank("ccs_fx2")  
    inst.AnimState:SetBuild("ccs_fx2")  
    inst.AnimState:PlayAnimation("ccs_fx2")
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

local function onupdate(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	for i,v in ipairs(TheSim:FindEntities(x, y, z, 7,nil,{"FX","INLIMBO","player"})) do
		if v and v.components and v.components.combat and v.components.health then
			local owner = inst.entity:GetParent()
			if owner then
				v.components.combat:GetAttacked(owner,inst.dam,owner)
			end
		end
	end
	
	inst.task_djs = inst.task_djs + 1
	if inst.task_djs >= 20 then
		inst.task_fx:Cancel()
		inst.task_fx = nil
	end
end

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag("nonpackable")
	
	inst.AnimState:SetBank("shadow_bishop")  
    inst.AnimState:SetBuild("shadow_bishop")  
    inst.AnimState:PlayAnimation("atk_side_loop",true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(2)
    inst.Light:Enable(true)

	inst.Transform:SetScale(2, 2, 2)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.task_djs = 0
	inst.dam = 30
	
	inst:DoTaskInTime(20, function()
		local owner = inst.entity:GetParent()
		if owner then
			owner.AnimState:ClearOverrideBuild("player_transparent")  
			owner.components.locomotor:RemoveExternalSpeedMultiplier(owner, "ccs_cards25")
			owner.components.health:SetInvincible(false)
			owner:RemoveTag("isbf")
			if owner.ccs_cards_25_fx ~= nil then
				for i, fx in ipairs(owner.ccs_cards_25_fx) do
					fx:Remove()
				end
				owner.ccs_cards_25_fx = nil
			end
			inst:Remove()
		end
	end)
	
	if inst.task_fx ~= nil then
		inst.task_fx:Cancel()
		inst.task_fx = nil
	end
	inst.task_fx = inst:DoPeriodicTask(1, onupdate,0)
	
    return inst
end

local function fn4()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	inst:AddTag("nonpackable")
	inst:AddTag("ccs_card_6_fx")
	
	inst.AnimState:SetBank("ccs_cards_xz")  
    inst.AnimState:SetBuild("ccs_cards_xz")  
    inst.AnimState:PlayAnimation("ccs_card_6",true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	
	inst.Transform:SetScale(2, 2, 2)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("ccs_card_6_fx")
	inst:DoTaskInTime(10, function()
		inst:Remove()
	end)
    return inst
end
 
local function SetDuration(inst,duration)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
	inst.task = inst:DoTaskInTime(duration, function()
		inst:Remove()
	end)
end

local function getpm(x1,x2)
	if x1 == x2 then
		return 0
	end
	return x1 > x2 and FRAMES or -FRAMES
end

local function onupdate(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	for i,v in ipairs(TheSim:FindEntities(x, y, z, 8,nil,{"FX","INLIMBO","player"})) do
		if v and v.components and v.components.health and v.components.combat and v.components.health.currenthealth <= 1200 then
			local px, py, pz = v.Transform:GetWorldPosition()
			v.Transform:SetPosition(px + getpm(x,px), 0, pz + getpm(z,pz))
			if v.components.locomotor ~= nil then
				v.components.locomotor:SetExternalSpeedMultiplier(inst, inst.prefab, 0.001)
			end
		end
	end
	inst.djs = inst.djs + 0.01
	if inst.djs >= 5 then
		inst.task_fx:Cancel()
		inst.task_fx = nil
	end
end

local function fn5()
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("tornado")
    inst.AnimState:SetBuild("tornado")
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.SetDuration = SetDuration
	inst:SetDuration(10)
	
	inst.djs = 0
	inst.task_fx = inst:DoPeriodicTask(.1, onupdate,0)
	
    return inst
end

local function StartShadows(self)
	SpawnPrefab("statue_transition_2").Transform:SetPosition(self.Transform:GetWorldPosition())
	self.AnimState:PlayAnimation("lunge_pre")
	self.AnimState:PushAnimation("lunge_lag")
	--self.AnimState:PushAnimation("lunge_pst")
	
	self:ListenForEvent("animover",function()
		if self.AnimState:IsCurrentAnimation("lunge_lag") then
			-- self:Ccs_InitAnim(nil,nil,true)
			self.AnimState:PlayAnimation("lunge_pst")
		end
	end)
	
	self:DoTaskInTime(12*FRAMES, function(inst) inst.Physics:SetMotorVel(30, 0, 0) end )
	self:DoTaskInTime(15*FRAMES, function(inst)
		inst:Attack()
	end )
	--self:DoTaskInTime(20*FRAMES, function(inst) inst.Physics:SetMotorVelOverride(5, 0, 0) end )
	self:DoTaskInTime(22*FRAMES, function(inst) inst.Physics:ClearMotorVelOverride() end)
	self:DoTaskInTime(35*FRAMES, function(inst) inst:Remove() end)
end

local function ccs_striker()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddPhysics()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced(inst)

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:SetCapsule(.5, 1)

    inst:AddTag("scarytoprey")
    inst:AddTag("NOBLOCK")
	
	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	-- inst.AnimState:SetMultColour( 195/255, 255/255, 250/255, 1)
	inst.AnimState:OverrideSymbol("swap_object", "ccs_sword","swap_weapon")
	inst.Ccs_InitAnim = function(self,build,override)
		inst.AnimState:SetBuild(build or "ccs")
		if override then 
			inst.AnimState:AddOverrideBuild("lavaarena_shadow_lunge")
		end
        if build then
            if build == "ccs_skins_chuqing" then
                inst.AnimState:OverrideSymbol("swap_object", "ccs_magic_wand3_skins7", "swap_weapon")
                if inst._vfx_fx_inst == nil then
                    inst._vfx_fx_inst = SpawnPrefab('ccs_lizifx_bubble')
                    inst._vfx_fx_inst.entity:AddFollower()
                end
                inst._vfx_fx_inst.entity:SetParent(inst.entity)
                inst._vfx_fx_inst.Follower:FollowSymbol(inst.GUID, 'swap_object', 0, -220, 0)
            elseif build == "ccs_skins_hyly" then
                self.fx = "ccs_sakura_bouncehit"
                inst.AnimState:OverrideSymbol("swap_object", "ccs_sword_skins9", "swap_weapon")
                if inst._vfx_fx_inst == nil then
                    inst._vfx_fx_inst = SpawnPrefab('cane_rose_fx')
                    inst._vfx_fx_inst.entity:AddFollower()
                end
                inst._vfx_fx_inst.entity:SetParent(inst.entity)
                inst._vfx_fx_inst.Follower:FollowSymbol(inst.GUID, 'swap_object', 0, -220, 0)
            elseif build == "ccs_skins_zxyy" then
                inst.AnimState:OverrideSymbol("swap_object", "ccs_sword_skins10", "swap_weapon")
                if inst._atk_fx_inst == nil then
                    inst._atk_fx_inst = SpawnPrefab('ccs_curve_fx')
                    inst._atk_fx_inst.entity:AddFollower()
                end
                inst._atk_fx_inst.entity:SetParent(inst.entity)
                inst._atk_fx_inst.Follower:FollowSymbol(inst.GUID, 'swap_object', 0, -220, 0)
                if inst._vfx_fx_inst == nil then
                    inst._vfx_fx_inst = SpawnPrefab('ccs_lizifx_snow')
                    inst._vfx_fx_inst.entity:AddFollower()
                end
                inst._vfx_fx_inst.entity:SetParent(inst.entity)
            elseif build == "ccs_skins_hlh" then
                inst.AnimState:OverrideSymbol("swap_object", "ccs_skirt_skin_hlh_swap", "swap_spear")
                if inst._atk_fx_inst == nil then
                    inst._atk_fx_inst = SpawnPrefab('ccs_lizifx_heart')
                    inst._atk_fx_inst.entity:AddFollower()
                end
                inst._atk_fx_inst.entity:SetParent(inst.entity)
                inst._atk_fx_inst.Follower:FollowSymbol(inst.GUID, 'swap_object', 0, -220, 0)
            end
        end
	end
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
	inst.SetPlayer = function(self, player)
		inst.player = player
	end
	
	inst.SetDamage = function(self,damage)
		inst.damage = damage or 0
	end 
	
    inst.SetTarget = function(self, target)
		inst.target = target
		inst.target_pos = Point(target.Transform:GetWorldPosition())
		inst:FacePoint(inst.target_pos)
	end
	
	inst.SetPosition = function(self, target_pos, offset)
		inst.offset = offset
		self.Transform:SetPosition(target_pos.x + offset.x, target_pos.y + offset.y, target_pos.z + offset.z)
		StartShadows(self)
	end
	
	inst.Attack = function(self)
        local function RotateFX(fx)
            fx.Transform:SetPosition(self.target_pos.x, self.target_pos.y, self.target_pos.z)
            fx.Transform:SetRotation(self.Transform:GetRotation())
        end
        if self.fx then
            SpawnPrefab(self.fx).Transform:SetPosition(self.target_pos.x, self.target_pos.y,
            self.target_pos.z)
        else
            local rand = math.random(1, 2)
            if rand == 1 then
                RotateFX(SpawnPrefab("shadowstrike_slash_fx"))
            else
                RotateFX(SpawnPrefab("shadowstrike_slash2_fx"))
            end
        end
    
        if self and self:IsValid() and self.target and self.target:IsValid() then 
            local dist = math.sqrt( self:GetDistanceSqToInst(self.target) )
            if self.player and self.target and dist <= 3.5 
                and self.target.components.health 
                and not self.target.components.health:IsDead() 
                and self.target.components.combat 
            then 
                local player = self.player
                if player and player:IsValid() then
                    local w_d = player.components.ccs_wanly_damage
                    if not w_d then 
                        player:AddComponent("ccs_wanly_damage")
                        w_d = player.components.ccs_wanly_damage
                    end
                    if w_d then
                        local damage = (self.target.components.health.currenthealth or 0) * 0.02
                        w_d:ApplyTemporaryDamage(self.target, damage)
                    end
                end
            end 
        end 

        inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fireball")
    end
	
	
    return inst
end

local function onhit(inst, attacker, target)
    local impactfx = SpawnPrefab("impact")
    if impactfx ~= nil and target.components.combat then
        local follower = impactfx.entity:AddFollower()
        follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
        if attacker ~= nil and attacker:IsValid() then
            impactfx:FacePoint(attacker.Transform:GetWorldPosition())
        end
    end
    inst:Remove()
end

local function onthrown(inst, data)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
end

local function ccs_bow_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeProjectilePhysics(inst, nil, 2)

    inst.AnimState:SetOrientation(1)

    inst:AddTag("fx")
    inst:AddTag("noclick")

    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("blow_dart")
    inst.AnimState:PlayAnimation("dart_pipe")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(60)
    --inst.components.projectile:SetLaunchOffset(Vector3(1.5, 1.0))
    inst.components.projectile:SetOnHitFn(onhit)
	inst:ListenForEvent("onthrown", onthrown)

    inst:DoTaskInTime(10, inst.Remove)

    return inst
end

local function ccs_star_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:SetCanSleep(false)	

	MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
	inst:AddTag("ccs_star_fx")
	--inst.Transform:SetScale(.5, .5, .5)	
	
	local a = math.random(1,4)
	inst.AnimState:SetBank("ccs_star_fx")  
    inst.AnimState:SetBuild("ccs_star_fx") 


	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")	
    inst.AnimState:PlayAnimation("anim1")
	
	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(.5) --范围半径
	inst.Light:SetFalloff(0.8) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 197/255, 126/255, 126/255  ) --颜色
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent("animover", inst.Remove)
	return inst
end

local function ccs_star_fx_pink()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:SetCanSleep(false)	

	MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
	inst:AddTag("ccs_star_fx")
	--inst.Transform:SetScale(.5, .5, .5)	
	
	local a = math.random(1,4)
	inst.AnimState:SetBank("ccs_star_fx")  
    inst.AnimState:SetBuild("ccs_star_fx") 
    inst.AnimState:SetMultColour( 255/255, 192/255, 203/255, 1) --粉色

	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")	
    inst.AnimState:PlayAnimation("anim1")
	
	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(.5) --范围半径
	inst.Light:SetFalloff(0.8) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 197/255, 126/255, 126/255  ) --颜色
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent("animover", inst.Remove)
	return inst
end

local function ccs_star_fx_gold()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:SetCanSleep(false)

    MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
    inst:AddTag("ccs_star_fx")
    --inst.Transform:SetScale(.5, .5, .5)	

    local a = math.random(1, 4)
    inst.AnimState:SetBank("ccs_star_fx")
    inst.AnimState:SetBuild("ccs_star_fx")
    inst.AnimState:SetMultColour(255 / 255, 215 / 255, 0 / 255, 1) --金色 (Gold/Rich Yellow)

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:PlayAnimation("anim1")

    inst.Light:Enable(true)                         --打开
    inst.Light:SetRadius(.5)                        --范围半径
    inst.Light:SetFalloff(0.8)                      --削减
    inst.Light:SetIntensity(.7)                     --强度
    inst.Light:SetColour(255 / 255, 215 / 255, 0 / 255) --金色 (Gold)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)
    return inst
end

local function ccs_rose_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:SetCanSleep(false)	

	MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
	inst:AddTag("ccs_star_fx")
	--inst.Transform:SetScale(.5, .5, .5)	
	
	inst.AnimState:SetBank("ccs_star_fx")  
    inst.AnimState:SetBuild("ccs_star_fx") 
    local a = math.random(0, 5)
    local symbol_name = "tx" .. tostring(a)
    inst.AnimState:OverrideSymbol("ccs_star_fx", "ccs_rose_fx", symbol_name)


	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")	
    inst.AnimState:PlayAnimation("anim1")
	
	inst.Light:Enable(true) --打开
	inst.Light:SetRadius(.5) --范围半径
	inst.Light:SetFalloff(0.8) --削减
	inst.Light:SetIntensity(.7) --强度
	inst.Light:SetColour( 197/255, 126/255, 126/255  ) --颜色
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent("animover", inst.Remove)
	return inst
end

local function ccs_magic_wand3_skin_alxy_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:SetCanSleep(false)

    MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
    inst:AddTag("ccs_star_fx")
    --inst.Transform:SetScale(.5, .5, .5)	

    inst.AnimState:SetBank("ccs_star_fx")
    inst.AnimState:SetBuild("ccs_star_fx")
    local a = math.random(1, 2)
    local symbol_name = "flower" .. tostring(a)
    inst.AnimState:OverrideSymbol("ccs_star_fx", "ccs_magic_wand3_skin_alxy_fx", symbol_name)


    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:PlayAnimation("anim1")

    inst.Light:Enable(true)                         --打开
    inst.Light:SetRadius(.5)                        --范围半径
    inst.Light:SetFalloff(0.8)                      --削减
    inst.Light:SetIntensity(.7)                     --强度
    inst.Light:SetColour(197 / 255, 126 / 255, 126 / 255) --颜色

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)
    return inst
end

local function ccs_bs_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:SetCanSleep(false)

    MakeInventoryPhysics(inst)

    inst:AddTag("FX") --特效标签
    inst:AddTag("ccs_star_fx")
    --inst.Transform:SetScale(.5, .5, .5)	

    inst.AnimState:SetBank("ccs_star_fx")
    inst.AnimState:SetBuild("ccs_star_fx")
    local a = math.random(0, 5)
    local symbol_name = "tx" .. tostring(a)
    inst.AnimState:OverrideSymbol("ccs_star_fx", "ccs_bs_fx", symbol_name)


    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:PlayAnimation("anim1")

    inst.Light:Enable(true)                         --打开
    inst.Light:SetRadius(.5)                        --范围半径
    inst.Light:SetFalloff(0.8)                      --削减
    inst.Light:SetIntensity(.7)                     --强度
    inst.Light:SetColour(197 / 255, 126 / 255, 126 / 255) --颜色

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)
    return inst
end

local function fn_star_burst()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_starburst")  
    inst.AnimState:SetBuild("ccs_starburst")  
    inst.AnimState:PlayAnimation("idle")
	-- inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	-- inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    -- inst.AnimState:SetLayer(LAYER_BACKGROUND)
	-- inst.Light:SetColour(111/255, 111/255, 227/255)
    -- inst.Light:SetIntensity(0.75)
    -- inst.Light:SetFalloff(0.6)
    -- inst.Light:SetRadius(4)
    -- inst.Light:Enable(true)
	inst.Transform:SetScale(2.5, 2.5, 2.5)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    inst.persists = false
    inst:ListenForEvent("animover",inst.Remove)
	
	
    return inst
end 

local function magic_circle_madoko_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_madoko")  
    inst.AnimState:SetBuild("magic_circle_madoko")  
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

--这个是没有外环的魔法阵
local function magic_circle_madoko1_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_madoko1")  
    inst.AnimState:SetBuild("magic_circle_madoko1")  
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

local function ccs_whale_footprints_fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_whale_footprints_fx")  
    inst.AnimState:SetBuild("ccs_whale_footprints_fx")  
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.persists = false
    inst:ListenForEvent("animover",inst.Remove)
	
    return inst
end 

local function ccs_sb_item_skins14fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_sb_item_skins14")  
    inst.AnimState:SetBuild("ccs_sb_item_skins14")  
    inst.AnimState:PlayAnimation("fx")
    inst.AnimState:SetScale(1.5,1.5,1.5)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.persists = false
	
    return inst
end 

local function ccs_flowerl_tracks_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_flowerl_tracks")  
    inst.AnimState:SetBuild("ccs_flowerl_tracks")  
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.persists = false
    inst:ListenForEvent("animover",inst.Remove)
	
    return inst
end

local function ccs_sdrawberry_track_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_sdrawberry_track")  
    inst.AnimState:SetBuild("ccs_sdrawberry_track")  
    inst.AnimState:PlayAnimation("idle")

    -- inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    -- inst.AnimState:SetLayer( LAYER_BACKGROUND )
    -- inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.persists = false
    inst:ListenForEvent("animover",inst.Remove)
	
    return inst
end

--希格雯法杖魔法阵
local function magic_circle_hailuhua_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_hailuhua")  
    inst.AnimState:SetBuild("magic_circle_hailuhua")  
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

local function magic_circle_hudie_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_hudie")  
    inst.AnimState:SetBuild("magic_circle_hudie")  
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

local function magic_circle_star_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_star")  
    inst.AnimState:SetBuild("magic_circle_star")  
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end 

local function magic_circle_skr_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("magic_circle_skr")
    inst.AnimState:SetBuild("magic_circle_skr")
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	
	inst.Light:SetColour(111/255, 111/255, 227/255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
    return inst
end


local function ccs_bear_footprints_fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX") 
	inst:AddTag('NOCLICK')

	inst.AnimState:SetBank("ccs_bear_footprints_fx")  
    inst.AnimState:SetBuild("ccs_bear_footprints_fx")  
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.persists = false
    inst:ListenForEvent("animover",inst.Remove)
	
    return inst
end

local function fn6()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    inst.entity:SetSelected(false)

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.yj = false
    inst:DoPeriodicTask(1, function(inst)
        if inst.yj == false then
             inst:Remove()
        end
    end)
    return inst
end

local function magic_circle_huameng_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_huameng")
    inst.AnimState:SetBuild("magic_circle_huameng")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_xrzx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_xrzx")
    inst.AnimState:SetBuild("magic_circle_xrzx")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_dmxh_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_dmxh")
    inst.AnimState:SetBuild("magic_circle_dmxh")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_bs_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_bs")
    inst.AnimState:SetBuild("magic_circle_bs")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_flowers_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(0.1, function()
        local x, y, z = inst.Transform:GetWorldPosition()
        local radius = 6
        local spacing = 1.5
        local max_radius = math.floor(radius / spacing) -- 计算最大半径的圈数

        for current_radius = 1, max_radius do
            local row_variation = math.random(1, 4)
            local circumference = 2 * math.pi * current_radius * spacing
            local num_plants = math.floor(circumference / spacing) -- 计算当前半径可以容纳的植物数量

            for i = 1, num_plants do
                local angle = 2 * math.pi * i / num_plants
                local plant_x = x + current_radius * spacing * math.cos(angle)
                local plant_z = z + current_radius * spacing * math.sin(angle)

                local plant = SpawnPrefab("wormwood_plant_fx")
                plant:SetVariation(row_variation)
                plant.Transform:SetPosition(plant_x, y, plant_z)
            end
        end
    end)


    return inst
end

local function magic_circle_xdzz_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_xdzz")
    inst.AnimState:SetBuild("magic_circle_xdzz")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function ccs_magic_wand3_skin_xyfz()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("ccs_magic_wand3_skin_xyfz")
    inst.AnimState:SetBuild("ccs_magic_wand3_skin_xyfz")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function ccs_magic_wand3_skin_hyjl_cr_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("ccs_magic_wand3_skin_hyjl_fx")
    inst.AnimState:SetBuild("ccs_magic_wand3_skin_hyjl_fx")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function ccs_magic_wand3_skin_goldwing_atkfx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("ccs_magic_wand3_skin_goldwing_atkfx")
    inst.entity:AddFollower()
    inst:AddComponent("highlightchild")

    inst.AnimState:SetBank("ccs_magic_wand3_skin_goldwing_atkfx")
    inst.AnimState:SetBuild("ccs_magic_wand3_skin_goldwing_atkfx")
    inst.AnimState:PlayAnimation("hit2", false)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:ListenForEvent("animover", inst.Remove)
    return inst
end

local function ccs_bow_skin_zwzj_fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("ccs_bow_skin_zwzj_fx")
    inst.AnimState:SetBuild("ccs_bow_skin_zwzj_fx")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end


local function magic_circle_dieying_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_dieying")
    inst.AnimState:SetBuild("magic_circle_dieying")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end


local function magic_circle_xsys_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_xsys")
    inst.AnimState:SetBuild("magic_circle_xsys")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end


local function magic_circle_xyym_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_xyym")
    inst.AnimState:SetBuild("magic_circle_xyym")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end


local function magic_circle_ygt_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_ygt")
    inst.AnimState:SetBuild("magic_circle_ygt")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_hscs_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_hscs")
    inst.AnimState:SetBuild("magic_circle_hscs")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_xingyu_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_xingyu")
    inst.AnimState:SetBuild("magic_circle_xingyu")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_chenxingyuyue_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_chenxingyuyue")
    inst.AnimState:SetBuild("magic_circle_chenxingyuyue")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_pingguo_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_pingguo")
    inst.AnimState:SetBuild("magic_circle_pingguo")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

local function magic_circle_bh_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_bh")
    inst.AnimState:SetBuild("magic_circle_bh")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local function magic_circle_lxy_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag('NOCLICK')

    inst.AnimState:SetBank("magic_circle_lxy")
    inst.AnimState:SetBuild("magic_circle_lxy")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    return inst
end

local dripfx = {
    ccs_dripfx_purpleflower =
    {
        name = "ccs_dripfx_purpleflower",
        bank = "abigail_buff_drip",
        build = "abigail_vial_fx",
        anim = "abigail_buff_drip",
        commonfn = function(inst)
            inst.AnimState:SetScale(1.2, 1.2, 1.2)
            inst.AnimState:OverrideSymbol("fx_swap", "ccs_dripfx", "fx_purpleflower")
            inst.AnimState:SetFinalOffset(3)
        end,
    },

    ccs_dripfx_yellowflower =
    {
        name = "ccs_dripfx_yellowflower",
        bank = "abigail_buff_drip",
        build = "abigail_vial_fx",
        anim = "abigail_buff_drip",
        commonfn = function(inst)
            inst.AnimState:SetScale(1.2,1.2,1.2)
            inst.AnimState:OverrideSymbol("fx_swap", "ccs_dripfx", "fx_yellowflower")
            inst.AnimState:SetFinalOffset(3)
        end,
    },
}
local function create_dripfx(data)
    if not data then
        return
    end
    local function dripfx_fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(data.bank or "abigail_buff_drip")
        inst.AnimState:SetBuild(data.build or "abigail_vial_fx")
        inst.AnimState:PlayAnimation(data.anim or "abigail_buff_drip")

        if data.commonfn then
            data.commonfn(inst)
        end

        inst:AddTag("FX")
        inst:AddTag('NOCLICK')

        if not TheWorld.ismastersim then
            return inst
        end

        if data.masterfn then
            data.masterfn(inst)
        end

        inst.persists = false
        inst:ListenForEvent("animover", inst.Remove)

        return inst
    end

    return Prefab(data.name, dripfx_fn, assets_ccs_dripfx)
end

local function ccs_redheartfx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank('ccs_redheartfx')
    inst.AnimState:SetBuild('ccs_redheartfx')
    inst.AnimState:PlayAnimation('idle_' .. math.random(1, 3))
    inst.AnimState:SetScale(1.3,1.3,1.3)
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag('FX')
    inst:AddTag('NOCLICK')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent('animover', inst.Remove)

    return inst
end

local function ccs_redswordfx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank('ccs_redswordfx')
    inst.AnimState:SetBuild('ccs_redswordfx')
    inst.AnimState:PlayAnimation('idle' .. math.random(1, 4))
    inst.AnimState:SetFinalOffset(3)

    inst.Transform:SetFourFaced()

    inst:AddTag('FX')
    inst:AddTag('NOCLICK')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent('animover', inst.Remove)

    return inst
end

local function ccs_flhm_fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank('ccs_flhm_fx')
    inst.AnimState:SetBuild('ccs_flhm_fx')
    inst.AnimState:PlayAnimation('blast' .. math.random(1, 3))
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag('FX')
    inst:AddTag('NOCLICK')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent('animover', inst.Remove)

    return inst
end

local function ccs_amulet_skin_bkm_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.AnimState:SetBank("ccs_amulet_skin_bkm_fx")
    inst.AnimState:SetBuild("ccs_amulet_skin_bkm_fx")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetScale(2,2,2)
    inst.Transform:SetEightFaced()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent("animover", inst.Remove)


    return inst
end

local function lavaarena_player_teleport_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank('ccs_lavaarena_player_teleport')
    inst.AnimState:SetBuild('ccs_lavaarena_player_teleport')
    inst.AnimState:PlayAnimation('idle')
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag('FX')
    inst:AddTag('NOCLICK')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent('animover', inst.Remove)

    return inst
end

local function ccs_card_box_fengyue_fx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddPhysics()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("notarget")
    inst:AddTag("nonpackable")
    inst.entity:SetCanSleep(false)

    inst.AnimState:SetBank("ccs_card_box_fengyue_fx")
    inst.AnimState:SetBuild("ccs_card_box_fengyue_fx")
    inst.AnimState:PlayAnimation("animation", true)

    MakeGhostPhysics(inst, 1, .1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("ccsfollewer")
    inst.persists = false

    return inst
end

return Prefab( "ccs_fx1", fn, assets) ,
		Prefab( "ccs_fx2", fn2, assets),
		Prefab( "ccs_fx3", fn3),
		Prefab( "ccs_fx4", fn4,assets),
        Prefab( "ccs_fx5", fn6),
		Prefab( "ccs_xf", fn5),
		Prefab( "ccs_striker", ccs_striker,assets3),
		Prefab( "ccs_bow_fx", ccs_bow_fx),
		Prefab("ccs_star_fx", ccs_star_fx,{Asset("ANIM", "anim/ccs_star_fx.zip")}),
        Prefab("ccs_star_fx_pink", ccs_star_fx_pink,{Asset("ANIM", "anim/ccs_star_fx.zip")}),
        Prefab("ccs_star_fx_gold", ccs_star_fx_gold,{Asset("ANIM", "anim/ccs_star_fx.zip")}),
        Prefab("ccs_rose_fx", ccs_rose_fx,{Asset("ANIM", "anim/ccs_star_fx.zip"),Asset("ANIM", "anim/ccs_rose_fx.zip")}),
        Prefab("ccs_magic_wand3_skin_alxy_fx", ccs_magic_wand3_skin_alxy_fx,{Asset("ANIM", "anim/ccs_magic_wand3_skin_alxy_fx.zip")}),
        Prefab("ccs_bs_fx", ccs_bs_fx,{Asset("ANIM", "anim/ccs_star_fx.zip"),Asset("ANIM", "anim/ccs_bs_fx.zip")}),
		Prefab( "ccs_star_burst", fn_star_burst,assets4),
		Prefab( "magic_circle_madoko", magic_circle_madoko_fn,assets5),
		Prefab( "magic_circle_madoko1", magic_circle_madoko1_fn,assets5),
		Prefab( "ccs_whale_footprints_fx", ccs_whale_footprints_fx_fn,assets6),
		Prefab( "ccs_sb_item_skins14fx", ccs_sb_item_skins14fx_fn,{Asset("ANIM", "anim/ccs_sb_item_skins14.zip")}),
        Prefab( "ccs_flowerl_tracks_fx", ccs_flowerl_tracks_fn,{Asset("ANIM", "anim/ccs_flowerl_tracks.zip")}),
        Prefab( "ccs_sdrawberry_track", ccs_sdrawberry_track_fn,{Asset("ANIM", "anim/ccs_sdrawberry_track.zip")}),
        Prefab( "ccs_bear_footprints_fx", ccs_bear_footprints_fx_fn,{Asset("ANIM", "anim/ccs_bear_footprints_fx.zip")}),
        Prefab( "magic_circle_hailuhua", magic_circle_hailuhua_fn,{Asset("ANIM", "anim/magic_circle_hailuhua.zip")}),
        Prefab( "magic_circle_hudie", magic_circle_hudie_fn,{Asset("ANIM", "anim/magic_circle_hudie.zip")}),
        Prefab( "magic_circle_star", magic_circle_star_fn,{Asset("ANIM", "anim/magic_circle_star.zip")}),
        Prefab( "magic_circle_skr", magic_circle_skr_fn,{Asset("ANIM", "anim/magic_circle_skr.zip")}),
    Prefab("magic_circle_xrzx", magic_circle_xrzx_fn, { Asset("ANIM", "anim/magic_circle_xrzx.zip") }),
    Prefab("magic_circle_dmxh", magic_circle_dmxh_fn, { Asset("ANIM", "anim/magic_circle_dmxh.zip") }),
    Prefab("magic_circle_huameng", magic_circle_huameng_fn, { Asset("ANIM", "anim/magic_circle_huameng.zip") }),
    Prefab("magic_circle_bs", magic_circle_bs_fn, { Asset("ANIM", "anim/magic_circle_bs.zip") }),
    Prefab("magic_circle_dieying", magic_circle_dieying_fn, { Asset("ANIM", "anim/magic_circle_dieying.zip") }),
    Prefab("ccs_redheartfx", ccs_redheartfx_fn, { Asset("ANIM", "anim/ccs_redheartfx.zip") }),
    Prefab("ccs_flhm_fx", ccs_flhm_fx_fn, { Asset("ANIM", "anim/ccs_flhm_fx.zip") }),
    Prefab("ccs_redswordfx", ccs_redswordfx_fn, { Asset("ANIM", "anim/ccs_redswordfx.zip") }),
    Prefab("magic_circle_flowers", magic_circle_flowers_fn),
    Prefab("magic_circle_xdzz", magic_circle_xdzz_fn, { Asset("ANIM", "anim/magic_circle_xdzz.zip") }),
    Prefab("magic_circle_xsys", magic_circle_xsys_fn, { Asset("ANIM", "anim/magic_circle_xsys.zip") }),
    Prefab("magic_circle_xyym", magic_circle_xyym_fn, { Asset("ANIM", "anim/magic_circle_xyym.zip") }),
    Prefab("magic_circle_ygt", magic_circle_ygt_fn, { Asset("ANIM", "anim/magic_circle_ygt.zip") }),
    Prefab("magic_circle_hscs", magic_circle_hscs_fn, { Asset("ANIM", "anim/magic_circle_hscs.zip") }),
    Prefab("magic_circle_xingyu", magic_circle_xingyu_fn, { Asset("ANIM", "anim/magic_circle_xingyu.zip") }),
    Prefab("magic_circle_chenxingyuyue", magic_circle_chenxingyuyue_fn, { Asset("ANIM", "anim/magic_circle_chenxingyuyue.zip") }),
    Prefab("magic_circle_pingguo", magic_circle_pingguo_fn, { Asset("ANIM", "anim/magic_circle_pingguo.zip") }),
    Prefab("magic_circle_bh", magic_circle_bh_fn, { Asset("ANIM", "anim/magic_circle_bh.zip") }),
    Prefab("magic_circle_lxy", magic_circle_lxy_fn, { Asset("ANIM", "anim/magic_circle_lxy.zip") }),
    Prefab("ccs_magic_wand3_skin_xyfz", ccs_magic_wand3_skin_xyfz, { Asset("ANIM", "anim/ccs_magic_wand3_skin_xyfz.zip") }),
    Prefab("ccs_magic_wand3_skin_hyjl_cr", ccs_magic_wand3_skin_hyjl_cr_fn,
    { Asset("ANIM", "anim/ccs_magic_wand3_skin_hyjl_fx.zip") }),
    Prefab("ccs_magic_wand3_skin_goldwing_atkfx", ccs_magic_wand3_skin_goldwing_atkfx_fn,
    { Asset("ANIM", "anim/ccs_magic_wand3_skin_goldwing_atkfx.zip") }),
    Prefab("ccs_bow_skin_zwzj_fx", ccs_bow_skin_zwzj_fx_fn, { Asset("ANIM", "anim/ccs_bow_skin_zwzj_fx.zip") }),
    Prefab("ccs_amulet_skin_bkm_fx", ccs_amulet_skin_bkm_fx, { Asset("ANIM", "anim/ccs_amulet_skin_bkm_fx.zip") }),
    Prefab("ccs_lavaarena_player_teleport", lavaarena_player_teleport_fn, { Asset("ANIM", "anim/ccs_lavaarena_player_teleport.zip") }),
    Prefab("ccs_card_box_fengyue_fx", ccs_card_box_fengyue_fx_fn, { Asset("ANIM", "anim/ccs_card_box_fengyue_fx.zip") }),
    create_dripfx(dripfx.ccs_dripfx_purpleflower),
    create_dripfx(dripfx.ccs_dripfx_yellowflower)
