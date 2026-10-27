-- 卡牌盒技能解锁组件（最终无日志版）

local SKILL_CONFIG = {
    {
        name = "自然亲和",
        tag = "bramble_resistant",
        effect = "免疫植物反伤",
        requirements = { { prefab = "ccs_cards_9", min_level = 4, max_level = 4 } },
    },
    {
        name = "禁疗",
        tag = "healing_block",
        effect = "攻击附带禁疗效果",
        requirements = {
            { prefab = "ccs_cards_11", min_level = 3, max_level = 3 },
            { prefab = "ccs_cards_21", min_level = 2, max_level = 2 },
        },
    },
    {
        name = "锁血",
        tag = "lock_blood",
        effect = "死亡时锁血30秒，冷却16分钟",
        requirements = {
            { prefab = "ccs_cards_8", min_level = 1, max_level = 1 },
            { prefab = "ccs_cards_1", min_level = 1, max_level = 1 },
        },
    },
    {
        name = "锁血回满",
        tag = "lock_blood_full",
        effect = "死亡时回复满血并锁血30秒，冷却8分钟",
        requirements = {
            { prefab = "ccs_cards_8", min_level = 1, max_level = 1 },
            { prefab = "ccs_cards_1", min_level = 1, max_level = 1 },
            { prefab = "ccs_cards_28", min_level = 3, max_level = 3 },
        },
    },
    {
        name = "眩晕",
        tag = "stun",
        effect = "攻击20%概率触发催眠",
        requirements = {
            { prefab = "ccs_cards_13", min_level = 1, max_level = 1 },
            { prefab = "ccs_cards_19", min_level = 1, max_level = 1 },
        },
    },
    -- {
    --     name = "破甲",
    --     tag = "armor_break",
    --     effect = "攻击附加60%破甲效果",
    --     requirements = {
    --         { prefab = "ccs_cards_22", min_level = 1, max_level = 1 },
    --     },
    -- },
    {
        name = "闪避",
        tag = "dodge",
        effect = "被攻击时35%概率闪避伤害",
        requirements = {
            { prefab = "ccs_cards_25", min_level = 2, max_level = 2 },
            { prefab = "ccs_cards_1", min_level = 1, max_level = 1 },
        },
    },
    {
        name = "暴击",
        tag = "critical",
        effect = "攻击20%概率造成双倍伤害",
        requirements = {
            { prefab = "ccs_cards_17", min_level = 1, max_level = 1 },
            { prefab = "ccs_cards_13", min_level = 1, max_level = 1 },
        },
    },
    {
        name = "牢笼",
        tag = "shadow_cage",
        effect = "攻击时触发暗影牢笼",
        requirements = {
            { prefab = "ccs_cards_21", min_level = 2, max_level = 2 },
            { prefab = "ccs_cards_1", min_level = 1, max_level = 1 },
        },
    },
}

local SKILL_CARD_MAP = {}
for _, skill in ipairs(SKILL_CONFIG) do
    for _, req in ipairs(skill.requirements) do
        if not SKILL_CARD_MAP[req.prefab] then
            SKILL_CARD_MAP[req.prefab] = {}
        end
        table.insert(SKILL_CARD_MAP[req.prefab], skill)
    end
end

local function FormatRequirement(req)
    local chname = STRINGS.NAMES[string.upper(req.prefab)] or req.prefab
    local level_info = (req.min_level == req.max_level) and "满级" or ("≥" .. req.min_level .. "级")
    return chname .. "(" .. level_info .. ")"
end

local Ccs_CardBox_Skill = Class(function(self, inst)
    self.inst = inst
    self._active_skills = {}
    self._check_task = nil

    inst:DoTaskInTime(0, function()
        if inst.components.container then
            self:Init()
        end
    end)
end)

function Ccs_CardBox_Skill:Init()
    self.inst:ListenForEvent("itemget", function(_, data)
        if data and data.item and data.item.components.ccs_card_level then
            local prefab = data.item.prefab
            if self._check_task then
                self._check_task:Cancel()
                self._check_task = nil
            end
            self._check_task = self.inst:DoTaskInTime(0, function()
                self._check_task = nil
                self:CheckRelatedSkills(prefab, false)
            end)
        end
    end)

    self.inst:ListenForEvent("itemlose", function()
        if self._check_task then
            self._check_task:Cancel()
            self._check_task = nil
        end
        self._check_task = self.inst:DoTaskInTime(0, function()
            self._check_task = nil
            self:CheckAllSkills(true)
        end)
    end)

    self.inst:ListenForEvent("onclose", function()
        if self._check_task then
            self._check_task:Cancel()
            self._check_task = nil
        end
        self._check_task = self.inst:DoTaskInTime(0, function()
            self._check_task = nil
            self:CheckAllSkills(true)
        end)
    end)

    self:CheckAllSkills(true)
end

function Ccs_CardBox_Skill:CheckAllSkills(silent)
    local container = self.inst.components.container
    if not container then return end
    for _, skill in ipairs(SKILL_CONFIG) do
        self:EvaluateSkill(skill, silent)
    end
end

function Ccs_CardBox_Skill:CheckRelatedSkills(prefab, silent)
    local skills = SKILL_CARD_MAP[prefab]
    if not skills then return end
    local container = self.inst.components.container
    if not container then return end
    local unique = {}
    for _, skill in ipairs(skills) do
        unique[skill] = true
    end
    for skill, _ in pairs(unique) do
        self:EvaluateSkill(skill, silent)
    end
end

function Ccs_CardBox_Skill:EvaluateSkill(skill, silent)
    local container = self.inst.components.container
    if not container then return end

    local qualified = true
    for _, req in ipairs(skill.requirements) do
        if self:CountQualifiedCards(container, req) < 1 then
            qualified = false
            break
        end
    end

    local was_active = self._active_skills[skill.name]
    local is_active = qualified

    if is_active and not was_active then
        self.inst:AddTag(skill.tag)
        self._active_skills[skill.name] = true
        if not silent then
            self:UnlockSkillHint(skill)
        end
    elseif not is_active and was_active then
        self.inst:RemoveTag(skill.tag)
        self._active_skills[skill.name] = nil
    end
end

function Ccs_CardBox_Skill:CountQualifiedCards(container, req)
    local count = 0
    for i = 1, container:GetNumSlots() do
        local item = container:GetItemInSlot(i)
        if item and item.prefab == req.prefab then
            local card = item.components.ccs_card_level
            if card then
                local lvl = card:GetLevel()
                if lvl >= req.min_level and (req.max_level == nil or lvl == req.max_level) then
                    count = count + 1
                end
            end
        end
    end
    return count
end

function Ccs_CardBox_Skill:GetOwner()
    if self.inst.components.inventoryitem then
        local owner = self.inst.components.inventoryitem:GetGrandOwner()
        if owner and owner.userid then return owner end
    end
    return nil
end

function Ccs_CardBox_Skill:UnlockSkillHint(skill)
    local owner = self:GetOwner()
    if not owner then return end

    local timer = self.inst.components.ccs_timer
    if timer then
        if not timer:Try("get_" .. skill.tag) then
            return
        end
    end

    local title = "卡牌组合技能❀" .. skill.name .. "❀已解锁"
    local cond_parts = {}
    for _, req in ipairs(skill.requirements) do
        table.insert(cond_parts, FormatRequirement(req))
    end
    local cond = "解锁条件：" .. table.concat(cond_parts, "、")
    local effect = "效果：" .. skill.effect

    if CCSWHISPER then
        CCSWHISPER(owner, {
            sender_name = "卡牌盒",
            s_colour = {1, 0.8, 0.2, 1},
            m_colour = {1, 1, 0, 1},
            message = title,
            icondata = "profileflair_rose",
        })
        CCSWHISPER(owner, {
            sender_name = "卡牌盒",
            s_colour = {1, 0.8, 0.2, 1},
            m_colour = {1, 1, 0, 1},
            message = cond,
            icondata = "profileflair_rose",
        })
        CCSWHISPER(owner, {
            sender_name = "卡牌盒",
            s_colour = {1, 0.8, 0.2, 1},
            m_colour = {1, 1, 0, 1},
            message = effect,
            icondata = "profileflair_rose",
        })
    end
end

function Ccs_CardBox_Skill:ForceCheck()
    if self._check_task then
        self._check_task:Cancel()
        self._check_task = nil
    end
    self:CheckAllSkills(false)
end

function Ccs_CardBox_Skill:SilentCheck()
    if self._check_task then
        self._check_task:Cancel()
        self._check_task = nil
    end
    self:CheckAllSkills(true)
end

function Ccs_CardBox_Skill:OnRemoveFromEntity()
    if self._check_task then
        self._check_task:Cancel()
        self._check_task = nil
    end
    self.inst:RemoveEventCallback("itemget", self)
    self.inst:RemoveEventCallback("itemlose", self)
    self.inst:RemoveEventCallback("onclose", self)
end

return Ccs_CardBox_Skill