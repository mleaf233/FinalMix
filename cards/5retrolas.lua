SMODS.Joker {
	key = 'retrolas',
	
	loc_txt = {
		name = 'The Wielder',
		text = {
			"here's {X:mult,C:white}X#1# {} Mult",
			"and that's no cap!"
		}
	},

	config = { extra = { Xmult = 1.5 } },
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.Xmult } }
	end,
	blueprint_compat = true,	
	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 4, y = 0},
	cost = 4,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
		end
	end
}

