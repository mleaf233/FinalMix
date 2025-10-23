SMODS.Joker {
	name = "Paopu Fruit",
	key = "paopufruit",

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands_left } }
	end,

	rarity = 2,
	atlas = "KHJokers",
	pos = { x = 2, y = 1 },
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = {
			hands_left = 5
		}
	},

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local first_card = context.scoring_hand[1]
			local edition = poll_edition('kh_paopufruit', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
			local random_seal = SMODS.poll_seal { key = "kh_seed", guaranteed = true }
			local enhancement = SMODS.poll_enhancement { key = "kh_seed", guaranteed = true }
			first_card:set_edition(edition, true)
			first_card:set_seal(random_seal, true)
			first_card:set_ability(enhancement, true)
		end

		if context.after and not context.blueprint then
			if card.ability.extra.hands_left - 1 <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = "RIKU NO!",
					colour = G.C.FILTER
				}
			else
				card.ability.extra.hands_left = card.ability.extra.hands_left - 1
				return {
					message = card.ability.extra.hands_left .. '',
					colour = G.C.FILTER
				}
			end
		end
	end
}
