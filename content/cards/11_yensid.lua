SMODS.Joker {
	name = 'Master Yen Sid',
	key = 'disney',
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
			'yensid1')
		return {
			vars = {
				numerator, --1
				denominator, --2
			}
		}
	end,

	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 0, y = 3 },
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = {
			odds = 2,
			base = 1
		}
	},

	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'yensid', card.ability.extra.base, card.ability.extra.odds, 'yensid1') then
				local hand = XIII.get_poker_hand()
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_level_up_ex"),
					colour = G.C.GREEN,
				})
				SMODS.smart_level_up_hand(card, hand, nil, 1)
			end
		end
	end
}
