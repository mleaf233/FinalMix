SMODS.Joker {
	key = 'mickey',
	
	loc_txt = {
		name = 'Meeska Mooska',
		text = {
			"Every scored {C:attention}King{} has a",
			"{C:green,E:1}#1# in #2#{} chance to gain",
			"{C:chips}+#6#{} Chips and {X:mult,C:white}X#4#{} Mult",
			"{C:inactive}(Currently {C:chips}+#5#{C:inactive} Chips and {X:mult,C:white}X#3#{C:inactive} Mult )",
			"{C:inactive,s:0.8} They'll pay for this."
		}
	},
	
	loc_vars = function(self, info_queue, card)
		return { vars = { 
		(G.GAME.probabilities.normal or 1),
		card.ability.extra.odds,
		card.ability.extra.Xmult,
		card.ability.extra.Xmult_gain,
		card.ability.extra.chips,
		card.ability.extra.chips_gain 
		} }
	end,
	
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 3, y = 0 },
	cost = 6,
	unlocked = true,
    discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	config = {
		extra = { chips = 0, chips_gain = 2, Xmult = 1, Xmult_gain = 0.5, odds = 4}
		},
	

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == 13 then
				if pseudorandom('mickey') < G.GAME.probabilities.normal / card.ability.extra.odds then
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
					return {
                    message = 'Upgraded!',
                    card = card,
					}
				end
		
			end
		end
		
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult,
				chips = card.ability.extra.chips,				
				card = context.other_card

				}
		end
	end
}