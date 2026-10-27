require("stategraphs/commonstates")
require("stategraphs/SGcritter_common")

local actionhandlers =
{
}

local events =
{
	SGCritterEvents.OnEat(),
    SGCritterEvents.OnAvoidCombat(),
	
    CommonHandlers.OnWakeEx(),
    CommonHandlers.OnLocomote(false,true),
}

local function GetAnimName(inst)
	local skinname = inst.item and inst.item:GetSkinBuild()
	if skinname then
		if skinname == "ccs_sb_item_skins2" or skinname == "ccs_sb_item_skins3" or skinname == "ccs_xk_item_skins2" or skinname == "ccs_xk_item_skins3" then  
			return "animation"
		end
	end
	return "idle"
end

local states=
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, pushanim)
			if inst.components.locomotor ~= nil then
				inst.components.locomotor:StopMoving()
			end
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)

            inst.sg:SetTimeout(1 + math.random())
        end,

		events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "open",
        tags = {"busy", "open"},
        
        onenter = function(inst)
            inst.Physics:Stop()
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("open_idle") end ),
        },        
    },

    State{
        name = "open_idle",
        tags = {"busy", "open"},
        
        onenter = function(inst)
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true) 
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("open_idle") end ),  
        },
       
    },

    State{
        name = "close",
        
        onenter = function(inst)
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
      
    },
	State{
        name = "eat",
        tags = { "busy","canrotate"},

        onenter = function(inst, pushanim)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
        end,

        events =
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),	
        },

    },
    State{
        name = "walk_start",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("walk")
            end),
        },
    },

    State{
        name = "walk",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
			inst.components.locomotor:WalkForward()
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
 
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("walk")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("walk")
        end,  
    },  

    State{
        name = "walk_stop",
        tags = { "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    }, 
	State{
		name = "emote_pet",
		tags = {"busy"},

		onenter = function(inst)
			local animname = GetAnimName(inst)
            inst.AnimState:PlayAnimation(animname, true)
		end,

		events =
		{
			EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					inst:PushEvent("critter_onpet")
					inst.sg:GoToState("idle")
				end
			end)
		},
    }	
}

return StateGraph("SGccs_xk", states, events, "idle", actionhandlers)