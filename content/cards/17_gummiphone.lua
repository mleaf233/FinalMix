-- When a blind is selected, add a tenth of the chips of the last played hand to this Joker's Mult
SMODS.Joker {
    name = 'Gummiphone',
    key = "chipanddale",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.old_hand_chips,
                card.ability.extra.mult
            }
        }
    end,

    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 0, y = 4 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            old_hand_chips = 0,
            mult = 0
        }
    },

    calculate = function(self, card, context)
        if context.after and not context.blueprint and not context.repetition and not context.other_card then
            local handy = to_number(hand_chips)
            card.ability.extra.old_hand_chips = handy / 10
        end
        if context.setting_blind and card.ability.extra.old_hand_chips > 0 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.old_hand_chips
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.old_hand_chips } },
                colour = G.C.RED,
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return { mult = card.ability.extra.mult }
        end
    end
}
