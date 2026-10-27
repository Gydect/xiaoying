-- 精简后的特效模板文件（只保留模板函数 + 你的绑定特效）

local pas = {}  -- 存放公共变量

local prefs = {}

-- ========== 通用非网络特效（一次性播放） ==========
local function MakeFx(data)
    local function TaskFn(proxy)
        local inst2 = CreateEntity()
        inst2.entity:AddTransform()
        inst2.entity:AddAnimState()
        inst2.entity:SetCanSleep(false)
        inst2.persists = false
        inst2:AddTag("FX")

        local parent = proxy.entity:GetParent()
        if parent ~= nil then
            inst2.entity:SetParent(parent.entity)
        end
        inst2.Transform:SetFromProxy(proxy.GUID)

        if data.fn_anim ~= nil then
            data.fn_anim(inst2, proxy)
        end
        if data.fn_remove ~= nil then
            data.fn_remove(inst2)
        else
            inst2:ListenForEvent("animover", inst2.Remove)
        end
    end

    table.insert(prefs, Prefab(data.name, function()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddNetwork()
        inst:AddTag("FX")

        if not TheNet:IsDedicated() then
            if data.notaskfn then
                inst._taskfn = TaskFn
            else
                inst:DoTaskInTime(0, TaskFn)
            end
        end

        if data.fn_common ~= nil then
            data.fn_common(inst)
        end

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then return inst end

        inst.persists = false
        inst:DoTaskInTime(data.removetime or 1, inst.Remove)

        return inst
    end, data.assets, nil))
end

-- ========== 通用网络特效（持续性，无跟随） ==========
local function MakeFx2(data)
    table.insert(prefs, Prefab(data.name, function()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        if not data.noanim then
            inst.entity:AddAnimState()
        end
        inst.entity:AddNetwork()
        inst:AddTag("FX")

        if data.fn_common ~= nil then
            data.fn_common(inst)
        end

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then return inst end

        inst.persists = false
        if data.fn_server ~= nil then
            data.fn_server(inst)
        end

        return inst
    end, data.assets, nil))
end

-- ========== 绑定式跟随特效（持续跟随实体挂点） ==========
local function OnRemove_followfx(inst)
    if inst.fx ~= nil then
        for _, v in ipairs(inst.fx) do
            v:Remove()
        end
    end
end

local function ColorChanged_followfx(inst, r, g, b, a)
    if inst.fx ~= nil then
        for _, v in ipairs(inst.fx) do
            v.AnimState:SetAddColour(r, g, b, a)
        end
    end
end

local function CreateNonNetInst(fn_anim, v)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddFollower()
    inst:AddTag("FX")
    inst.persists = false
    inst:AddComponent("highlightchild")

    if v.fn_anim ~= nil then
        v.fn_anim(inst, v)
    else
        fn_anim(inst, v)
    end

    return inst
end

local function SpawnFollowFxForOwner(inst, owner, dd)
    inst.fx = {}
    local frame
    for _, v in ipairs(dd.fx) do
        local fx = CreateNonNetInst(dd.fn_anim, v)
        if dd.randomanim or v.randomanim then
            frame = frame or math.random(fx.AnimState:GetCurrentAnimationNumFrames()) - 1
        end
        fx.entity:SetParent(owner.entity)
        fx.Follower:FollowSymbol(owner.GUID, v.symbol or dd.symbol, v.x or 0, v.y or 0, v.z or 0, true, nil, v.idx, v.idx2)
        if frame ~= nil then
            fx.AnimState:SetFrame(frame)
        end
        fx.components.highlightchild:SetOwner(owner)
        table.insert(inst.fx, fx)
    end
    inst.components.colouraddersync:SetColourChangedFn(ColorChanged_followfx)
    inst.OnRemoveEntity = OnRemove_followfx
end

local function MakeFxFollow(data)
    local function OnEntityReplicated(inst)
        local owner = inst.entity:GetParent()
        if owner ~= nil then
            SpawnFollowFxForOwner(inst, owner, data)
        end
    end

    local function AttachToOwner(inst, owner)
        inst.entity:SetParent(owner.entity)
        if not TheNet:IsDedicated() then
            SpawnFollowFxForOwner(inst, owner, data)
        end
    end

    table.insert(prefs, Prefab(data.name, function()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddNetwork()
        inst:AddTag("FX")
        inst:AddComponent("colouraddersync")

        if data.fn_common ~= nil then
            data.fn_common(inst)
        end

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            inst.OnEntityReplicated = OnEntityReplicated
            return inst
        end

        inst.persists = false
        inst.AttachToOwner = AttachToOwner

        if data.fn_server ~= nil then
            data.fn_server(inst)
        end

        return inst
    end, data.assets, nil))
end


local function FlowerAnim(inst, data)
    inst.AnimState:SetBank("flower_fx")
    inst.AnimState:SetBuild("flower_fx")
    inst.AnimState:PlayAnimation(data.anim, true)
    inst.AnimState:SetSortOrder(10)
end

local function DanceCatAnim(inst, data)
    inst.AnimState:SetBank("ccs_hat_skins_dancecat")
    inst.AnimState:SetBuild("ccs_hat_skins_dancecat")
    inst.AnimState:PlayAnimation("dance", true)  -- 循环播放
    --inst.Transform:SetTwoFaced()                 -- 只有两面（正面/背面），不随视角转四向
end

MakeFxFollow({
    name = "flower_fx1_bind",
    assets = {
        Asset("ANIM", "anim/flower_fx.zip")
    },
    fn_anim = FlowerAnim,
    fx = {
        { anim = "idle", symbol = "swap_body", x = 0, y = 200, z = 0 }
    }
})

MakeFxFollow({
    name = "flower_fx2_bind",
    assets = {
        Asset("ANIM", "anim/flower_fx.zip")
    },
    fn_anim = FlowerAnim,
    fx = {
        { anim = "idle_2", symbol = "swap_body", x = 0, y = 100, z = 0 }
    }
})

MakeFxFollow({
    name = "flower_fx3_bind",
    assets = {
        Asset("ANIM", "anim/flower_fx.zip")
    },
    fn_anim = FlowerAnim,
    fx = {
        { anim = "idle_4", symbol = "swap_body", x = 0, y = 200, z = 0 }
    }
})

MakeFxFollow({
    name = "dancecat_hat_bind",          
    assets = {
        Asset("ANIM", "anim/ccs_hat_skins_dancecat.zip"),
    },
    fn_anim = DanceCatAnim,              
    symbol = "hair",                 
    fx = {
        { anim = "dance" ,x = 0, y = -120, z = 0 }               
    }
})

return unpack(prefs)