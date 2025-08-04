SMODS.Joker {
	name = 'Kingdom Hearts',
    key = "khtrilogy",

    loc_vars = function(self, info_queue, card)
			return {
				key = self.key..'_kh'..tostring(card.ability.extra.level),
				vars = {
					card.ability.extra.mult, --1
					card.ability.extra.xmult, --2
					card.ability.extra.counter, --3
					card.ability.extra.total, --4
					card.ability.extra.chips, --5
				}
			}
    end,


    rarity = 2,
    atlas = 'KHJokers',
    pos = {x = 2, y = 3},
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    config = {
        extra = { 
			chips = 100,
			mult = 25,
			xmult = 3,
			counter = 0,
			total = 1,
			level = 1
		},
    },

	calculate = function(self, card, context)
		
		if context.joker_main then
			local level = {
				[1] = {chips = card.ability.extra.chips},
				[2] = {mult = card.ability.extra.mult},
				[3] = {xmult = card.ability.extra.xmult},
			}
			return level[card.ability.extra.level]
		end

		if context.after and not context.blueprint and not context.repetition and not context.other_card then
			local hand_score = hand_chips * mult
			local blind_score = G.GAME.blind.chips * 2
			if hand_score >= blind_score then
				card.ability.extra.counter = card.ability.extra.counter + 1

				if card.ability.extra.counter >= card.ability.extra.total and card.ability.extra.level < 3 then
					card.ability.extra.counter = 0
					card.ability.extra.total = card.ability.extra.total + 2 --makes total 3
					card.ability.extra.level = card.ability.extra.level + 1 -- upgrades joker

					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									card:juice_up(1, 0.5)
									card.config.center.pos.x = card.ability.extra.level + 1
									return true
								end
							}))
							SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.FILTER}, card)
							return true
						end
					}))
					return
				elseif card.ability.extra.level < 3 then
					return {
						message = card.ability.extra.counter..'/'..card.ability.extra.total,
						colour = G.C.FILTER
					}
				end
			end
		end
	end
}