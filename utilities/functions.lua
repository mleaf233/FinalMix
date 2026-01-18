-- Find position of card
XIII.get_pos = function(card, area)
    for i, v in ipairs(area) do
        if v == card then
            return i
        end
    end
    return nil
end

-- Use Blockbuster API to see if cards are compatible with value manipulation or not
XIII.compat_check = function(card, target)
    if not target or target == card then
        return false
    end

    for _, standard in pairs(Blockbuster.ValueManipulation.CompatStandards) do
        if standard.exempt_jokers and standard.exempt_jokers[target.config.center.key] then
            return false
        end
    end

    return true
end

-- Function to get a Joker by its key from a list of Jokers. (Donald)
XIII.get_joker_by_key = function(jokers, key)
    for _, j in ipairs(jokers) do
        if j.config.center.key == key then
            return j
        end
    end
    return nil
end

-- Function to find stuff with a specific prefix, used for Awakening Tarot and Kingdom Tag
XIII.get_resource_with_prefix = function(prefix)
    local results = {}
    for k, v in pairs(G.P_CENTERS) do
        if k:sub(1, #prefix) == prefix then
            table.insert(results, k)
        end
    end
    return results
end

-- Gets a random Poker Hand (Master Yen Sid)
XIII.get_poker_hand = function()
    local poker_hands = {}
    local total_weight = 0
    for _, handname in ipairs(G.handlist) do
        if G.GAME.hands[handname].visible then
            local weight = G.GAME.hands[handname].played + 1
            total_weight = total_weight + weight
            poker_hands[#poker_hands + 1] = { handname, total_weight }
        end
    end

    local weight = pseudorandom("yensid") * total_weight
    local hand
    for _, h in ipairs(poker_hands) do
        if weight < h[2] then
            hand = h[1]
            break
        end
    end

    return hand
end

-- Gets most played Poker Hand
XIII.most_played_hand = function()
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end
    return _handname
end

-- Function to balance a percentage of score
XIII.balance_percent = function(card, percent)
    local chip_mod = percent * hand_chips
    local mult_mod = percent * mult
    local average = (chip_mod + mult_mod) / 2
    hand_chips = hand_chips + (average - chip_mod)
    mult = mult + (average - mult_mod)

    update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
    card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = (percent * 100) .. "% " .. localize('k_balanced'),
        colour = { 0.8, 0.45, 0.85, 1 },
        sound = 'gong'
    })

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
            ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                blocking = false,
                delay = 4.3,
                func = (function()
                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                    ease_colour(G.C.UI_MULT, G.C.RED, 2)
                    return true
                end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                blocking = false,
                no_delete = true,
                delay = 6.3,
                func = (function()
                    G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2],
                        G.C.BLUE[3],
                        G.C.BLUE[4]
                    G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3],
                        G.C.RED
                        [4]
                    return true
                end)
            }))
            return true
        end)
    }))

    delay(0.6)
    return hand_chips, mult
end

-- function to send player to an area
XIII.send_to_room = function(area)
    -- Credits to All in Jest!
    stop_use()

    G.deck:shuffle('cashout' .. G.GAME.round_resets.ante)
    G.deck:hard_set_T()
    G.GAME.current_round.used_packs = {}

    local rechain = (G.GAME.selected_back_key or {}).key == 'b_kh_rechain' or
        G.GAME.selected_sleeve == 'sleeve_kh_rechain'
    if not rechain or G.GAME.round_resets.blind.boss then
        G.GAME.current_round.reroll_cost_increase = 0
    end

    G.GAME.current_round.free_rerolls = G.GAME.round_resets.free_rerolls
    calculate_reroll_cost(true)

    if G.blind_prompt_box then
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object.pop_delay = 0
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object:pop_out(5)
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object.pop_delay = 0
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object:pop_out(5)
    end

    delay(0.3)
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            if G.blind_select then
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
            end
            G.GAME.current_round.jokers_purchased = 0
            G.STATE = area
            G.GAME.kh.moogle_shop = true
            G.GAME.shop_free = nil
            G.GAME.shop_d6ed = nil
            G.STATE_COMPLETE = false
            G.GAME.current_round.used_packs = {}
            return true
        end,
    }))
end

-- Reroll Button for "Help Wanted" Joker

G.FUNCS.kh_can_reroll = function(e)
    local reroll_cost = 4
    local can_afford = to_big(G.GAME.dollars) >= to_big(reroll_cost)
    if can_afford then
        e.config.colour = G.C.RED
        e.config.button = 'kh_reroll'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.kh_reroll = function(e)
    local ref = e.config and e.config.ref_table
    local card = ref and ref[1]

    local reroll_cost = 4
    card.ability.current_task = nil

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            ease_dollars(-math.min(reroll_cost, G.GAME.dollars), true)
            return true
        end
    }))
end


XIII.create_random_tag = function(card)
    local tag_pool = get_current_pool('Tag')
    local selected_tag = pseudorandom_element(tag_pool, 'kh_seed')
    local it = 1
    while selected_tag == 'UNAVAILABLE' do
        it = it + 1
        selected_tag = pseudorandom_element(tag_pool, 'kh_kingdom_key_seed' .. it)
    end

    SMODS.calculate_effect({ message = "+1 Tag!" }, card)
    G.E_MANAGER:add_event(Event({
        func = (function()
            add_tag(Tag(selected_tag, false, 'Small'))
            return true
        end)
    }))
end


SMODS.Keybind {
    key_pressed = 'a',
    held_keys = { "lshift" },
    event = 'pressed',
    action = function(self)
        if G.hand then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_dissolve = nil
                    local new_cards = {}

                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = XIII.create_random_card("kingdom")
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card

                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    return true
                end
            }))
        end
    end
}
