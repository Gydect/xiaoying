AddModRPCHandler("CCS","CCS_trash_rpc",function(player,chest)
	if chest and chest:HasTag("ccs_trash") then
		chest.components.container:DestroyContents()
	end
end)

AddModRPCHandler("CCS", "ccs_light3_sn", function(player,container)
	if container and container:HasTag("ccs_light3") then
		container.CloseSnFn(container,player)
	end
end)

AddModRPCHandler("CCS", "ccs_light3_cc", function(player,container)
	if container and container:HasTag("ccs_light3") then
		container.InstCcFn(container,player)
	end
end)

AddModRPCHandler("CCS", "ccs_collect", function(player, container)
	if container and container:HasTag("ccs_spbox") and container.collect then
		container.collect(container, player)
	end
end)
