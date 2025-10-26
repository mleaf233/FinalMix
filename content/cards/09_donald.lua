SMODS.Joker {
    name = 'Donald',
    key = 'donald',

    loc_vars = function(self, info_queue, card)
        local copied_joker_key = card.ability.extra.copied_joker_key
        local copied_name = "None"

        if G.jokers then
            local copied_joker = GetJokerByKey(G.jokers.cards, copied_joker_key)
            if copied_joker then
                copied_name = copied_joker.config.center.name
            end
        end

        return {
            vars = {
                copied_name --1
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 4, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            copied_joker_key = nil
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
            local available_jokers = {}

            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and joker.config.center.blueprint_compat then
                    table.insert(available_jokers, joker)
                end
            end

            if #available_jokers > 0 then
                local random_joker = pseudorandom_element(available_jokers, pseudoseed("pleaseberandom"))
                card.ability.extra.copied_joker_key = random_joker.config.center.key
                card:update()

                return {
                    message = 'Copying!',
                    card = card,
                }
            else
                card.ability.extra.copied_joker_key = nil
            end
        end

        if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
            local copied_joker = GetJokerByKey(G.jokers.cards, card.ability.extra.copied_joker_key)

            if copied_joker then
                -- Applying copied joker's effect
                local success, effect = pcall(SMODS.blueprint_effect, card, copied_joker, context)
                -- If successful, apply effect
                if success and effect then
                    return effect
                end
            end
        end
    end
}
