AddSimPostInit(function()
	TUNING.TIMESTOPPER_PERFORMANCE = 50
	TUNING.TIMESTOPPER_IGNORE_SHADOW = false
	TUNING.TIMESTOPPER_IGNORE_WORTOX = false
	TUNING.TIMESTOPPER_IGNORE_WANDA = false
	TUNING.TIMESTOPPER_IGNORE_CHARLIE = false
	TUNING.TIMESTOPPER_INVINCIBLE_FOE = false
	TUNING.TIMESTOPPER_GREYSCREEN = true

	TUNING.TIMESTOPPER_DEFAULT_DURATION = 10
end)

AddPlayerPostInit(function(inst)
	if TheWorld.ismastersim then
		inst:AddComponent("timestopper")
		inst:AddTag("canmoveintime")
		inst:AddTag("timemaster")
	end
end)