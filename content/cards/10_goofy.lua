SMODS.Joker {
    name = 'Goofy',
    key = "goofy",

    loc_vars = function(self, info_queue, card)
        local wild_tally = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wild_tally = wild_tally + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult, --1
                card.ability.extra.mult * wild_tally --2
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 2, y = 2 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            mult = 7
        }
    },

    calculate = function(self, card, context)
        
        if context.joker_main and G.playing_cards then
            local wild_tally = 0
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wild_tally = wild_tally + 1
                end
            end
            return {
                mult = card.ability.extra.mult * wild_tally
            }
        end
    end,
    
    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}

--[[


    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                context.other_card.should_destroy = true
            end
            if context.other_card.should_destroy then
                return {
                    message = "Gawrsh!"
                }
            end
        end
    end,
    
    ]]