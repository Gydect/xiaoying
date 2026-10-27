local ANIM_HEART_TEXTURE = resolvefilepath("images/fx/ccs_lizifx_bubble.tex")
local REVEAL_SHADER = "shaders/vfx_particle_add.ksh"

local COLOUR_ENVELOPE_NAME = "ccs_lizifx_bubble_colourenvelope"
local SCALE_ENVELOPE_NAME = "ccs_lizifx_bubble_scaleenvelope"

local assets = {
    Asset("IMAGE", ANIM_HEART_TEXTURE),
    Asset("SHADER", REVEAL_SHADER),
}

local function IntColour(r, g, b, a)
    return { r / 255, g / 255, b / 255, a / 255 }
end

local function InitEnvelope()

    local colour_envelope = {
        { 0, IntColour(219, 206, 224, 255) },
        { 0.5, IntColour(219, 206, 224, 255) },
        { 1, IntColour(219, 206, 224, 0) },
    }
    

    EnvelopeManager:AddColourEnvelope(COLOUR_ENVELOPE_NAME, colour_envelope)

    local max_scale = 0.7
    local scale_envelope = {
        { 0,    { max_scale * 0.4, max_scale * 0.4 } },
        { 0.3,  { max_scale * 0.5, max_scale * 0.5 } },
        { 0.6,  { max_scale * 0.6, max_scale * 0.6 } },
        { 1,    { max_scale * 0.7, max_scale * 0.7 } },
    }
    EnvelopeManager:AddVector2Envelope(SCALE_ENVELOPE_NAME, scale_envelope)

    InitEnvelope = nil
    IntColour = nil
end

local MAX_LIFETIME = 0.7

local function emit_fn(effect, emitter_fn)
    local vx, vy, vz = 0.005 * UnitRand(), 0, 0.005 * UnitRand()
    local px, py, pz = emitter_fn()
    px = px + math.random(-1, 1) * 0.2
    py = py + math.random(-1, 1) * 0.2
    pz = pz + math.random(-1, 1) * 0.2
    effect:AddRotatingParticle(0, MAX_LIFETIME, px, py, pz, vx, vy, vz, 0, 0)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst:AddTag("FX")
    inst.entity:SetPristine()
    inst.persists = false

    if TheNet:IsDedicated() then
        return inst
    elseif InitEnvelope then
        InitEnvelope()
    end

    local effect = inst.entity:AddVFXEffect()
    effect:InitEmitters(1)

    effect:SetRenderResources(0, ANIM_HEART_TEXTURE, REVEAL_SHADER)
    effect:SetMaxNumParticles(0, 128)
    effect:SetRotationStatus(0, true)
    effect:SetMaxLifetime(0, MAX_LIFETIME)
    effect:SetColourEnvelope(0, COLOUR_ENVELOPE_NAME)
    effect:SetScaleEnvelope(0, SCALE_ENVELOPE_NAME)
    effect:SetBlendMode(0, BLENDMODE.Premultiplied)
    -- effect:EnableBloomPass(0, true)
    effect:SetSortOrder(0, 0)
    effect:SetSortOffset(0, 0)
    effect:SetKillOnEntityDeath(0, true)


    local tick_time = TheSim:GetTickTime()
    local low_per_tick = 5 * tick_time
    local high_per_tick = 50 * tick_time
    local num_to_emit = 0
    local sphere_emitter = CreateSphereEmitter(0.25)
    inst.last_pos = inst:GetPosition()

    EmitterManager:AddEmitter(inst, nil, function()
        local dist_moved = (inst:GetPosition() - inst.last_pos):Length()
        local move = math.clamp(dist_moved * 3, 0, 1)
        local per_tick = Lerp(low_per_tick, high_per_tick, move)
        inst.last_pos = inst:GetPosition()
        num_to_emit = num_to_emit + per_tick * math.random() * 3
        while num_to_emit > 1 do
            emit_fn(effect, sphere_emitter)
            num_to_emit = num_to_emit - 1
        end
    end)

    return inst
end

return Prefab("ccs_lizifx_bubble", fn, assets)
