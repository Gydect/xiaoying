require("stategraphs/commonstates")

local actionhandlers =
{
}

local events =
{
    CommonHandlers.OnLocomote(false, true),
	--[[EventHandler("floater_startfloating", function(inst)
		inst.sg:GoToState("idle")
    end),]]
	EventHandler("floater_stopfloating", function(inst)
		inst.sg:GoToState("idle")
    end),
    EventHandler("onturnoff", function(inst)
        inst.sg:GoToState("idle")
    end),
}

local function walkonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("walk")
    end
end

local function walkontimeout(inst)
    inst.sg:GoToState("walk")
end

local function idleonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("idle")
    end
end

local function AddWalkStates(states, timelines, anims, softstop, delaystart, fns)
    table.insert(states, State{
        name = "walk_start",
        tags = { "moving", },

        onenter = function(inst)
			if fns ~= nil and fns.startonenter ~= nil then -- this has to run before WalkForward so that startonenter has a chance to update the walk speed
				fns.startonenter(inst)
			end
			if not delaystart then
	            inst.components.locomotor:WalkForward()
			end
            inst.AnimState:PlayAnimation("idel_sway")
        end,

        timeline = timelines ~= nil and timelines.starttimeline or nil,

		onupdate = fns ~= nil and fns.startonupdate or nil,

		onexit = fns ~= nil and fns.startonexit or nil,

        events =
        {
            EventHandler("animover", walkonanimover),
        },
    })

    table.insert(states, State{
        name = "walk",
        tags = { "moving", },

        onenter = function(inst)
			if fns ~= nil and fns.walkonenter ~= nil then
				fns.walkonenter(inst)
			end
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("idel_sway", true)
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline = timelines ~= nil and timelines.walktimeline or nil,

		onupdate = fns ~= nil and fns.walkonupdate or nil,

		onexit = fns ~= nil and fns.walkonexit or nil,

        ontimeout = walkontimeout,
    })

    table.insert(states, State{
        name = "walk_stop",
        tags = {},

        onenter = function(inst)
			if fns ~= nil and fns.endonenter ~= nil then
				fns.endonenter(inst)
			end
            inst.components.locomotor:StopMoving()
            if softstop == true or (type(softstop) == "function" and softstop(inst)) then
                inst.AnimState:PushAnimation("idel", false)
            else
                inst.AnimState:PlayAnimation("idel_sway")
            end
        end,

        timeline = timelines ~= nil and timelines.endtimeline or nil,

		onupdate = fns ~= nil and fns.endonupdate or nil,

		onexit = fns ~= nil and fns.endonexit or nil,

        events =
        {
            EventHandler("animqueueover", idleonanimover),
        },
    })
end

local states =
{
    State{
        name = "idle",
        tags = {"idle"},
        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation(
                TheWorld.Map:IsOceanAtPoint(inst.Transform:GetWorldPosition()) and "idel" 
                or "idel_ground",
                true)
        end,
    },
}

AddWalkStates(states)

return StateGraph("SGccs_miniboatlantern", states, events, "idle", actionhandlers)
