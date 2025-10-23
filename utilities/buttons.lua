-- Reroll Button for "Help Wanted" Joker

-- Check if you have enough money to reroll
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

-- What the reroll button actually does
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
