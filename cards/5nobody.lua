SMODS.Joker {
    key = 'nobody',
    loc_txt = {
        name = "Nobody",
        text = {
            "If {C:attention}first hand{} of round is",
            "a single {C:attention}2{}, destroy it and",
            "create a {C:dark_edition}Random {}{C:attention}Tag{}",
            "{C:inactive} nobody? who's nobody?",
        }
    },

    loc_vars = function(self, info_queue, card, center)
        info_queue[#info_queue+1] = {key = 'tag_charm', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_meteor', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_holo', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_foil', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_uncommon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
        return {vars = {card.ability.extra.selection, card.ability.extra.options}}
    end,

    atlas = 'KHJokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},

    config = {
        extra = {
            selection = 1,
            options = {
                [1] = 'tag_charm',
                [2] = 'tag_meteor',
                [3] = 'tag_foil',
                [4] = 'tag_holo',
                [5] = 'tag_rare',
                [6] = 'tag_uncommon',
                [7] = 'tag_polychrome'
            }
        }
    },

    calculate = function(self, card, context)
    if context.destroying_card and not context.blueprint and #context.full_hand == 1 and context.full_hand[1]:get_id() == 2 and G.GAME.current_round.hands_played == 0 then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag(pseudorandom_element(card.ability.extra.options, pseudoseed('x'))))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
            return true
        end
    end
}
