SMODS.Joker {
    name = 'Luxord',
    key = 'luxord',
    loc_vars = function(self, info_queue, card)
        local vars = {
            card.ability.extra.chips,      --1
            card.ability.extra.cap,        --2
            card.ability.extra.chips_lose, --3
        }
        local main_start = {
            {
                n = G.UIT.T,
                config = {
                    text = "+",
                    colour = G.C.CHIPS,
                    scale = 0.32
                }
            },
            {
                n = G.UIT.T,
                config = {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    colour = G.C.CHIPS,
                    scale = 0.32
                }
            },
            {
                n = G.UIT.T,
                config = {
                    text = " Chips",
                    colour = G.C.UI.TEXT_DARK,
                    scale = 0.32
                }
            },
        }

        return { main_start = main_start, vars = vars, }
    end,
    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 1, y = 4, },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            chips = 100,
            cap = 100,
            chips_lose = 1,
            time_spent = 0,
        },
    },

    update = function(self, card, dt)
        if G.GAME.blind and G.GAME.blind.in_blind then
            -- checks if game is not paused and hand isn't being played
            if not G.SETTINGS.paused and G.STATE ~= G.STATES.HAND_PLAYED then
                card.ability.extra.time_spent = card.ability.extra.time_spent + G.real_dt
                card.ability.extra.chips = math.floor(card.ability.extra.cap -
                    (card.ability.extra.time_spent * card.ability.extra.chips_lose))
            end
        end

        if card.ability.extra.chips <= 0 and not G.GAME.kh.luxord_destroyed then
            G.GAME.kh.luxord_destroyed = true
            SMODS.destroy_cards(card, nil, nil, true)
            SMODS.calculate_effect({ message = "Time's Up!", colour = G.C.FILTER }, card)
        end
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            G.GAME.kh.luxord_sold = true -- for the challenge, no idea if this is the best way of doing it but hey, it works!
        end

        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.cap
            SMODS.calculate_effect({ message = "Start!", colour = G.C.FILTER }, card)
        end

        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return card.ability.extra.active and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if context.beat_boss then
                card.ability.extra.chips_lose = card.ability.extra.chips_lose * 1.5
                card.ability.extra.cap = card.ability.extra.cap * 1.5
            end
            card.ability.extra.time_spent = 0
            card.ability.extra.chips = card.ability.extra.cap
            SMODS.calculate_effect(
                { context.beat_boss and localize('k_upgrade_ex') or localize('k_reset'), colour = G.C.FILTER }, card)
        end
    end,
}
