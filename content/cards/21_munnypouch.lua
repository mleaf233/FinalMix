SMODS.Joker {
    key = 'munnypouch',
    name = "Munny Pouch",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["j_kh_munny"]
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
            'munnypouch1')
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.price1,
                card.ability.extra.price2,
            }
        }
    end,
    rarity = 2,
    atlas = "KHJokers",
    pos = { x = 4, y = 4 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            base = 1,
            odds = 8,
            price = 1,
            price1 = 1,
            price2 = 5,
        }
    },

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'munnypouch', card.ability.extra.base, card.ability.extra.odds, 'munnypouch1') then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                -- Extinct/Survival Message
                SMODS.calculate_effect({ message = localize('kh_stolen'), colour = G.C.FILTER }, card)
            else
                card.ability.extra.price = pseudorandom('cool', card.ability.extra.price1, card.ability.extra.price2)
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
                SMODS.calculate_effect({ message = localize('k_val_up'), colour = G.C.MONEY }, card)
            end
        end
        if context.selling_self then
            local payout = card.sell_cost

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = (SMODS.add_card { set = 'Joker', key = 'j_kh_munny', })

                            if new_card then
                                new_card.ability.extra.dollars = payout
                            end

                            G.GAME.joker_buffer = 0
                            SMODS.calculate_effect({ message = localize('kh_munny'), colour = G.C.BLUE }, card)
                            return true
                        end
                    }))

                    return true
                end
            }))
        end
    end
}

SMODS.Joker {
    key = 'munny',
    name = "Munny",

    loc_vars = function(self, info_queue, card)
        local text = "[pouch sell value]"
        if card.ability.extra.dollars > 0 then
            text = card.ability.extra.dollars
        else
            text = "[pouch sell value]"
        end
        return {
            vars = {
                text
            }
        }
    end,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if desc_nodes ~= full_UI_table.main and G.jokers then
            G.munny_area = CardArea(
                G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
                1.05 * G.CARD_W,
                0.95 * G.CARD_H,
                { card_limit = 1, type = "title", highlight_limit = 0, collection = true }
            )
            SMODS.add_card({
                key = "j_kh_munny",
                area = G.munny_area
            })
            desc_nodes[#desc_nodes + 1] = { {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.07, no_fill = true },
                nodes = {
                    { n = G.UIT.O, config = { object = G.munny_area } }
                }
            } }
        end
        return SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end,
    no_collection = true,
    rarity = 1,
    atlas = "KHJokers",
    pos = { x = 0, y = 5 },
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            dollars = 0
        }
    },

    calculate = function(self, card, context)
        if context.starting_shop then
            card.ability.extra.dollars = card.ability.extra.dollars - 1
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Value Down!', colour = G.C.RED })
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    in_pool = function(self)
        return false
    end
}
