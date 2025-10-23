SMODS.Joker { -- i dont like this ability at all, might have to scrap
	name = 'Meeska Mooska',
	key = 'mickey',

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
			'mickey1')
		return {
			vars = {
				numerator, -- 1
				denominator, -- 2
			}
		}
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
		extra = {
			base = 1,
			odds = 4
		}
	},


	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'mickey', card.ability.extra.base, card.ability.extra.odds, 'mickey1') then
				for _, scored_card in ipairs(context.scoring_hand) do
					local first_card = context.scoring_hand[1]
					local last_card = context.scoring_hand[#context.scoring_hand]

					if first_card then
						assert(SMODS.change_base(first_card, nil, "King"))
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:juice_up()
								return true
							end
						}))
					end

					if last_card then
						assert(SMODS.change_base(last_card, nil, "King"))
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:juice_up()
								return true
							end
						}))
					end
				end
				return {
					message = localize('kh_king'),
					colour = G.C.MONEY
				}
			end
		end
	end
}
