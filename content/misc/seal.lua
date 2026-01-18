SMODS.Seal {
    name = "kingdom",
    key = "kingdom",
    badge_colour = HEX("5d5e8d"), --G.C.BLUE,
    atlas = "KHSeals",
    pos = { x = 1, y = 0 },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.chips
            }
        }
    end,

    config = {
        extra = {
            chips = 5
        }
    },
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            local cards_to_chip = {}
            if G.hand.cards and #G.hand.cards > 0 then
                for _, c in ipairs(G.hand.cards) do
                    if c ~= card then
                        table.insert(cards_to_chip, c)
                        c.ability.perma_bonus = c.ability.perma_bonus + self.config.extra.chips
                        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, c)
                    end
                end
            end
        end
    end
}

SMODS.Seal {
    name = "luckyemblem",
    key = "luckyemblem",
    badge_colour = HEX("fab950"),
    atlas = "KHSeals",
    pos = { x = 0, y = 0 },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    config = {
        extra = {
        }
    },

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local valid_cards = {}
            for _, c in ipairs(G.hand.cards) do
                if not c.lucky_reserved then
                    table.insert(valid_cards, c)
                end
            end

            if #valid_cards > 0 then
                local seed_str = "luckyemblem" .. tostring(card:get_id() or card.id or math.random())
                local chosen = pseudorandom_element(valid_cards, pseudoseed(seed_str))
                chosen.lucky_reserved = true

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        chosen:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        chosen:flip()
                        play_sound('card1', 1)
                        chosen:juice_up(0.3, 0.3)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        assert(SMODS.change_base(chosen, card.base.suit, card.base.value))
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        chosen:flip()
                        play_sound('tarot2', 1, 0.6)
                        chosen:juice_up(0.3, 0.3)
                        return true
                    end
                }))

                delay(0.5)
            end
        end
    end
}


SMODS.Sticker({
    needs_enable_flag = false,
    rate = 0.05,
    key = "shuffled",
    badge_colour = HEX("5d5e8d"),
    config = {
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {},
        }
    end,
    calculate = function(self, card, context)
        if context.press_play then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    for i = 1, 3 do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.15 * (i - 1),
                            func = function()
                                local current_pos = XIII.get_pos(card, G.jokers.cards)
                                if current_pos and #G.jokers.cards > 1 then
                                    local new_pos = pseudorandom('kh_shuffled', 1, #G.jokers.cards)

                                    table.remove(G.jokers.cards, current_pos)
                                    table.insert(G.jokers.cards, new_pos, card)

                                    G.jokers:set_ranks()
                                    play_sound('cardSlide1', 0.85 + 0.15 * i)
                                end
                                return true
                            end
                        }))
                    end
                    return true
                end
            }))
        end
    end,
    atlas = "KHStickers",
    pos = { x = 0, y = 0, },
    should_apply = function(self, card, center, area, bypass_roll)
        return G.GAME.modifiers.enable_eternals_in_shop and
            SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
    end,
})
