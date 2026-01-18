SMODS.Joker {
	name = 'Sora',
	key = 'sora',

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.x_mult, --1
				card.ability.extra.Xmult_gain --2
			}
		}
	end,

	rarity = 3,
	atlas = 'KHJokers',
	pos = { x = 0, y = 0 },
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = {
			x_mult = 1,
			Xmult_gain = 0.2,
		}
	},

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:is_suit("Hearts") then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "Xmult_gain",
					operation = '+',
				})
			end
		end

		if context.joker_main and card.ability.extra.x_mult > 1 then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if context.beat_boss then
				card.ability.extra.x_mult = 1
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
		end
	end
}
