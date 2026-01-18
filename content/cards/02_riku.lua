SMODS.Joker {
	name = 'Riku',
	key = 'riku',

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.most_played, --1
				card.ability.extra.levels, --2
				card.ability.extra.counter, --3
				card.ability.extra.total --4
			}
		}
	end,

	rarity = 2,
	atlas = "KHJokers",
	pos = { x = 4, y = 1 },
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = {
			condition_satisfied = true,
			most_played = 'Pair',
			old_most_played = 'Pair',
			levels = 1,
			counter = 4,
			total = 4
		}
	},

	set_ability = function(self, card, initial, delay_sprites)
		local most_played = XIII.most_played_hand()
		card.ability.extra.most_played = most_played
		card.ability.extra.old_most_played = card.ability.extra.most_played
	end,

	calculate = function(self, card, context)
		-- Update most played hand after every hand played/ at end of round
		if context.final_scoring_step or context.end_of_round and not context.individual then
			local most_played = XIII.most_played_hand()
			card.ability.extra.most_played = most_played
			card.ability.extra.old_most_played = card.ability.extra.most_played
		end

		if context.reroll_shop then
			card.ability.extra.counter = card.ability.extra.counter - 1

			if card.ability.extra.counter <= 0 then
				-- resets reroll counter
				card.ability.extra.counter = card.ability.extra.total
				local _card = context.blueprint_card or card
				if card.ability.extra.condition_satisfied == true then
					card_eval_status_text(_card, 'extra', nil, nil, nil, {
						message = localize('k_level_up_ex'), colour = G.C.FILTER
					})

					local _hand = card.ability.extra.old_most_played
					SMODS.smart_level_up_hand(card, _hand, nil, card.ability.extra.levels)
					return nil, true
				end
			end
		end
	end
}
