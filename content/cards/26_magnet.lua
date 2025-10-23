-- carry hands over to next round??
SMODS.Joker {
    name = 'Munny Magnet',
    key = "magnet",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discards_remaining,
                card.ability.extra.hands_remaining
            }
        }
    end,

    rarity = 3,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 3, y = 5 },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            hands_remaining = 0,
            discards_remaining = 0,
        }
    },

    calculate = function(self,card,context)
        if context.setting_blind and G.GAME.blind.boss then
            if card.ability.extra.hands_remaining > 0 then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands_remaining).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands_remaining
            end

            if card.ability.extra.discards_remaining > 0 then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discards_remaining).." Discard", colour = G.C.RED})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discards_remaining
            end

        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.GAME.current_round.hands_left > 1 then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.current_round.hands_left
            end

            if G.GAME.current_round.discards_left > 1 then
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining + G.GAME.current_round.discards_left
            end

            if G.GAME.blind.boss then
                card.ability.extra.hands_remaining = 0
                card.ability.extra.discards_remaining = 0
                return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
            end
        end
    end
}
