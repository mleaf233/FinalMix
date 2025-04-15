SMODS.Joker {
	key = 'roxas',
	
	loc_txt = {
		name = 'Roxas',
		text = {
			"Gives {X:chips,C:white}X#2#{} Chips {C:attention}and{} {X:mult,C:white}X#1# {} Mult",
			"Mult increases by {X:mult,C:white}X#3#{} every round ",
			"{C:inactive}looks like our summer vacation",
			"{C:inactive}is finally over..."
		}
	},
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.Xmult, card.ability.extra.x_chips, card.ability.extra.Xmult_gain } }
	end,
		
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 1, y = 0},
	cost = 5,
	blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	config = {
		extra = { Xmult = 0.5,x_chips = 2,Xmult_gain = 0.1 }
		},
	
	
	calculate = function(self, card, context)
	
		if context.joker_main then
			return {
				x_chips = card.ability.extra.x_chips,
				xmult = card.ability.extra.Xmult,
				card = context.other_card
				}
		end
		
		-- xmult upgrade at end of the round
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = 'Upgraded!',
                    card = card,
                }
		end
		
		
	end
}

