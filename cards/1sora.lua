SMODS.Joker {
	key = 'Sora',
	
	loc_txt = {
		name = 'Sora',
        text = {'This Joker gains {X:mult,C:white}X#2#{} Mult',
                'For each scored {C:hearts}heart{} card, resets',
                'when {C:attention}Boss Blind{} is defeated.{}',
                '{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)'}
    },

	config = { extra = { Xmult = 1, Xmult_gain = 0.1} },
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
	end,
	blueprint_compat = true,	
	rarity = 3,
	atlas = 'KHJokers',
	pos = { x = 0, y = 0},
	cost = 7,

	calculate = function(self, card, context)
		
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:is_suit("Hearts") then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = 'Upgraded!',
                    card = card,
                }
            end
        end
		
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
	  
			if G.GAME.blind.boss then
				card.ability.extra.Xmult = 1
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
	
		end
	end
}

