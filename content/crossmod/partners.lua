local pnr_def = Partner_API.Partner
pnr_def {
    key = "sora",
    name = "Sora",
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    atlas = "KHPartner",
    config = { extra = { Xmult = 0.1 } },
    link_config = { j_kh_sora = 1 },
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return { vars = { card.ability.extra.Xmult * benefits } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult +
                    card.ability.extra.Xmult * benefits
                SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
            end
        end
    end,
}

pnr_def { -- art is currently placeholder, will change eventually
    key = "donald",
    name = "Donald",
    unlocked = true,
    discovered = true,
    pos = { x = 1, y = 0 },
    atlas = "KHPartner",
    config = { extra = { copied_joker_key = nil } },
    link_config = { j_kh_donald = 1 },
    loc_vars = function(self, info_queue, card)
        local copied_joker_key = card.ability.extra.copied_joker_key
        local copied_name = "None"

        if G.jokers then
            local copied_joker = XIII.get_joker_by_key(G.jokers.cards, copied_joker_key)
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
    calculate = function(self, card, context)
        if context.after and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
            local available_jokers = {}

            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and joker.config.center.blueprint_compat then
                    table.insert(available_jokers, joker)
                end
            end

            if #available_jokers > 0 then
                local random_joker = pseudorandom_element(available_jokers, pseudoseed("randompartner"))
                card.ability.extra.copied_joker_key = random_joker.config.center.key
                card:update()

                SMODS.calculate_effect({ message = localize('kh_copying'), colour = G.C.FILTER }, card)
            else
                card.ability.extra.copied_joker_key = nil
            end
        end

        if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
            local copied_joker = XIII.get_joker_by_key(G.jokers.cards, card.ability.extra.copied_joker_key)

            local copied_joker_ret = SMODS.blueprint_effect(card, copied_joker, context)
            if copied_joker_ret then
                return copied_joker_ret
            end
        end
    end,
}

pnr_def {
    key = "mickey",
    name = "Mickey",
    unlocked = true,
    discovered = true,
    pos = { x = 2, y = 0 },
    atlas = "KHPartner",
    config = {
        extra = {
            base = 1,
            odds = 2
        }
    },
    link_config = { j_kh_mickey = 1 },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
            'Kmickey')
        return {
            vars = {
                numerator,   -- 1
                denominator, -- 2
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card == context.scoring_hand[1] then -- looks at first scoring card
                if SMODS.pseudorandom_probability(card, 'mickeypartner', card.ability.extra.base, card.ability.extra.odds, 'Kmickey') then
                    local playing_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('tarot1')
                            playing_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            playing_card:flip()
                            play_sound('card1', 1)
                            playing_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            assert(SMODS.change_base(playing_card, nil, "King"))
                            return true
                        end
                    }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            playing_card:flip()
                            play_sound('tarot2', 1, 0.6)
                            playing_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))

                    delay(0.5)
                end
            end
        end
    end
}


pnr_def {
    key = "randompartner",
    name = "Random Partner",
    unlocked = true,
    discovered = true,
    pos = { x = 3, y = 0 },
    atlas = "KHPartner",
    config = {
        extra = {
            percent = 0,
            percent_plus = 1,
            cost = 1,
        }
    },
    link_config = { j_kh_randomjoker = 1 },
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return {
            vars = {
                card.ability.extra.percent,
                card.ability.extra.percent_plus * benefits,
                card.ability.extra.cost,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step and card.ability.extra.percent > 0 then
            XIII.balance_percent(card, (card.ability.extra.percent * 0.01))
        end
        if context.partner_click and ((to_big(G.GAME.dollars) - to_big(G.GAME.bankrupt_at)) >= to_big(card.ability.extra.cost)) then
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            card.ability.extra.percent = card.ability.extra.percent + card.ability.extra.percent_plus * benefits
            ease_dollars(-card.ability.extra.cost)
            card_eval_status_text(card, "dollars", -card.ability.extra.cost)
        end
    end
}
pnr_def {
    key = "nobody",
    name = "Nobody",
    unlocked = true,
    discovered = true,
    pos = { x = 4, y = 0 },
    atlas = "KHPartner",
    config = {
        extra = {}
    },
    link_config = { j_kh_nobody = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
}

local old_smods_scorecard = SMODS.score_card
function SMODS.score_card(card, context)
    local has_random_partner = false

    if G.GAME.selected_partner_card
        and G.GAME.selected_partner_card.ability
        and G.GAME.selected_partner_card.config
        and G.GAME.selected_partner_card.config.center.key == "pnr_kh_nobody" then
        has_random_partner = true
    end

    if has_random_partner and context.cardarea == G.hand and not G.scorehand then
        local first_card = G.hand.cards[1]
        local last_card = G.hand.cards[#G.hand.cards]
        if card == first_card or card == last_card then
            G.scorehand = true
            context.cardarea = G.play
            SMODS.score_card(card, context)
            context.cardarea = G.hand
            G.scorehand = nil
        end
    end

    return old_smods_scorecard(card, context)
end
