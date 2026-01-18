SMODS.Joker {
	key = "randomjoker",
	name = "Random Joker",
	loc_vars = function(self, info_queue, card)
		local r_percent = {}
		for i = card.ability.extra.min, card.ability.extra.max do
			r_percent[#r_percent + 1] = tostring(i)
		end
		local loc_percent = '%'
		local main_start = {
			{ n = G.UIT.T, config = { text = 'Balances ', colour = G.C.BLACK, scale = 0.32 } },
			{ n = G.UIT.O, config = { object = DynaText({ string = r_percent, colours = { G.C.PURPLE }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = '?', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent,
							loc_percent, loc_percent, loc_percent,
							{ string = '#', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent,
							{ string = '@', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent },
						colours = { G.C.PURPLE },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0
					})
				}
			},

		}
		return { main_start = main_start }
	end,

	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 1, y = 5 },
	cost = 4,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,

	config = {
		extra = {
			percent = 0,
			min = 1,
			max = 25
		}
	},


	calculate = function(self, card, context)
		if context.final_scoring_step then
			card.ability.extra.percent = pseudorandom("j_kh_randomjoker", card.ability.extra.min, card.ability.extra.max)
			XIII.balance_percent(card, (card.ability.extra.percent * 0.01))
		end
	end
}
