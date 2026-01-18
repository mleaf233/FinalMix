SMODS.Joker {
	name = 'Meeska Mooska',
	key = 'mickey',
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			}
		}
	end,

	rarity = 3,
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
		}
	},

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local faces = 0
			for _, scored_card in ipairs(context.scoring_hand) do
				if scored_card:is_face() and scored_card:get_id() ~= 13 then
					faces = faces + 1
					assert(SMODS.change_base(scored_card, nil, 'King'))
					G.E_MANAGER:add_event(Event({
						func = function()
							scored_card:juice_up()
							return true
						end
					}))
				end
			end

			if faces > 0 then
				return {
					message = "King!",
					colour = G.C.FILTER
				}
			end
		end
	end
}
