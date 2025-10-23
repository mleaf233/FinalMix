local task_rewards = {

    play_face = function(card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Hand", colour = G.C.BLUE })

                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                ease_hands_played(1)

                return true
            end
        }))
        delay(0.6)
    end,

    destroy_cards = function(card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Discard", colour = G.C.ORANGE })

                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)

                return true
            end
        }))
        delay(0.6)
    end,

    selling = function(card)
        -- Reduce Ante
        local mod = -card.ability.ante_value or -1
        G.E_MANAGER:add_event(Event({
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "-" .. tostring(1) .. " Ante", colour = G.C.ORANGE })
                ease_ante(mod)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
                return true
            end
        }))
    end,

    skipping = function(card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Hand Size", colour = G.C.BLUE })
                G.hand:change_size(1)
                return true
            end
        }))
        delay(0.6)
    end,

    shopping = function(card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Shop slot", colour = G.C.BLUE })
                change_shop_size(1)
                return true
            end
        }))
    end

}

SMODS.Joker {
    key = 'helpwanted',
    name = "Help Wanted!",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "kh_play_face", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_destroy_cards", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_selling", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_skipping", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_shopping", set = "Other" }
        local task_desc = "None"
        local reward_desc = "None"
        local prog = card.ability.progress

        if card.ability.current_task == "play_face" then
            task_desc = "Score 15 face cards (" .. prog .. "/15)"
            reward_desc = "+1 Hand"
        elseif card.ability.current_task == "destroy_cards" then
            task_desc = "Destroy 7 cards (" .. prog .. "/7)"
            reward_desc = "+1 Discard"
        elseif card.ability.current_task == "selling" then
            task_desc = "Sell 7 cards (" .. prog .. "/7)"
            reward_desc = "-1 Ante"
        elseif card.ability.current_task == "skipping" then
            task_desc = "Skip 4 Blinds (" .. prog .. "/2)"
            reward_desc = "+1 Hand Size"
        elseif card.ability.current_task == "shopping" then
            local spent = card.ability.money_spent or 0
            task_desc = "Spend $30 in one shop ($" .. spent .. "/30)"
            reward_desc = "+1 Shop Slot"
        end

        return {
            vars = {
                task_desc,
                reward_desc
            }
        }
    end,

    rarity = 3,
    atlas = "KHJokers",
    pos = { x = 3, y = 4 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        -- challenges
        current_task = nil,
        progress = 0,
        task_done = {},
        -- rewards
        ante_value = 1,
        money_spent = 0
    },

    calculate = function(self, card, context)
        local completed = card.ability.task_done

        -- Set initial task
        if not card.ability.current_task then
            local task_pool = { "play_face", "destroy_cards", "selling", "skipping", "shopping" }


            local filtered_pool = {}
            for _, task in ipairs(task_pool) do
                if not completed[task] then
                    table.insert(filtered_pool, task)
                end
            end

            if #filtered_pool > 0 then
                card.ability.current_task = pseudorandom_element(filtered_pool, pseudoseed("tasks"))
                card.ability.progress = 0
            else
                card.ability.current_task = nil
            end

            if #filtered_pool <= 0 then
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
                -- Extinct Message
                return {
                    message = 'Tasks Complete!'
                }
            end
        end


        if card.ability.current_task then
            local c = card.ability.current_task

            if c == "play_face" and card.ability.progress < 15 then
                if context.individual and context.cardarea == G.play and context.other_card:is_face() then
                    card.ability.progress = (card.ability.progress or 0) + 1
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Upgrade!", colour = G.C.GREEN })
                end

                if card.ability.progress >= 15 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end

                    completed[task_key] = true
                    card.ability.task_done = completed

                    return {
                        message = 'Completed!',
                        card = card,
                    }
                end
            end

            if c == "destroy_cards" and card.ability.progress < 7 then
                if context.remove_playing_cards and not context.blueprint then
                    for _, removed_card in ipairs(context.removed) do
                        if removed_card then
                            card.ability.progress = (card.ability.progress or 0) + 1
                            card_eval_status_text(card, 'extra', nil, nil, nil,
                                { message = "Upgrade!", colour = G.C.GREEN })
                        end
                    end
                end

                if card.ability.progress >= 7 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end

                    completed[task_key] = true
                    card.ability.task_done = completed

                    return {
                        message = 'Completed!',
                        card = card,
                    }
                end
            end

            if c == "selling" and card.ability.progress < 7 then
                if context.selling_card then
                    card.ability.progress = (card.ability.progress or 0) + 1
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Upgrade!", colour = G.C.GREEN })
                end

                if card.ability.progress >= 7 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end

                    completed[task_key] = true
                    card.ability.task_done = completed

                    return {
                        message = 'Completed!',
                        card = card,
                    }
                end
            end

            if c == "skipping" and card.ability.progress < 2 then
                if context.skip_blind and not context.blueprint then
                    card.ability.progress = (card.ability.progress or 0) + 1
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Upgrade!", colour = G.C.GREEN })
                end

                if card.ability.progress >= 2 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end

                    completed[task_key] = true
                    card.ability.task_done = completed


                    return {
                        message = 'Completed!',
                        card = card,
                    }
                end
            end

            if c == "shopping" then
                -- Resetting after exit shop
                if context.ending_shop then
                    card.ability.money_spent = 0
                end

                -- Buying a Joker
                if context.buying_card and context.card and context.card.cost then
                    card.ability.money_spent = card.ability.money_spent + context.card.cost
                    context.card.cost = 0
                end

                --Buying a booster pack
                if context.open_booster and context.card and context.card.cost then
                    card.ability.money_spent = card.ability.money_spent + context.card.cost
                    context.card.cost = 0
                end
                -- Buying a Voucher
                if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Voucher' and context.card.cost then
                    card.ability.money_spent = card.ability.money_spent + context.card.cost
                    context.card.cost = 0
                end

                -- Rerolling the shop
                if context.reroll_shop then
                    card.ability.money_spent = card.ability.money_spent + (G.GAME.current_round.reroll_cost - 1)
                end

                if card.ability.money_spent >= 30 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end
                    card.ability.money_spent = 0

                    completed[task_key] = true
                    card.ability.task_done = completed

                    return {
                        message = 'Completed!',
                        card = card,
                    }
                end
            end
        end
    end
}
