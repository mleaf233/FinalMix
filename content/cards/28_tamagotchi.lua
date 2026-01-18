SMODS.Joker {
    name = 'Tamagotchi',
    key = "tamagotchi",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.xmult_gain
            }
        }
    end,

    rarity = 2,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 0, y = 6 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            x_mult = 1,
            xmult_gain = 0.2
        }
    },

    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local _first_dissolve = nil
                    for _, consumable in pairs(G.consumeables.cards) do
                        consumable:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "x_mult",
                            scalar_value = "xmult_gain",
                            operation = '+',
                            no_message = true
                        })
                    end
                    SMODS.calculate_effect({ message = localize('kh_destroyed'), colour = G.C.FILTER }, card)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
}
