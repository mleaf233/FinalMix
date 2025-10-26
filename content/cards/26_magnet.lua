SMODS.Joker {
    name = 'Munny Magnet',
    key = "magnet",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    rarity = 3,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 3, y = 5 },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            dollars = 3
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_steel") then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then
                return true
            end
        end
        return false
    end
}
