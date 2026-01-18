SMODS.Joker {
	name = 'Disc',
	key = "khtrilogy",

	loc_vars = function(self, info_queue, card)
		return {
			key = self.key .. '_kh' .. tostring(card.ability.extra.level),
			vars = {
				card.ability.extra.mult,   --1
				card.ability.extra.xmult,  --2
				card.ability.extra.counter, --3
				card.ability.extra.total,  --4
				card.ability.extra.chips,  --5
				card.ability.extra.discards_remaining, --6
				card.ability.extra.discards, --7
			}
		}
	end,

	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 2, y = 3 },
	cost = 6,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	display_size = { w = 71 * 1.1, h = 95 * 1.1 },

	config = {
		extra = {
			chips = 75,
			mult = 25,
			xmult = 3,
			counter = 0,
			total = 1,
			level = 1,
			pos_override = { x = 2, y = 3 },
			discards = 30,
			discards_remaining = 30,
			level_up = false
		},
	},

	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				return true
			end
		}))
	end,

	calculate = function(self, card, context)
		if card.ability.extra.level == 1 and G.GAME.current_round.hands_played == 0 then
			if context.after and not context.blueprint and not context.repetition and not context.other_card then
				local hand_score = hand_chips * mult
				local blind_score = G.GAME.blind.chips

				if hand_score >= blind_score then
					card.ability.extra.counter = card.ability.extra.counter + 1
				end
			end
		end

		if context.discard and not context.blueprint and card.ability.extra.level == 2 then
			card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1

			if card.ability.extra.discards_remaining <= 0 then
				card.ability.extra.level_up = true
			end
		end

		if (card.ability.extra.counter >= card.ability.extra.total or card.ability.extra.level_up) and card.ability.extra.level < 3 then
			card.ability.extra.counter = 0
			card.ability.extra.level_up = false
			card.ability.extra.total = card.ability.extra.total + 2 --makes total 3
			card.ability.extra.level = card.ability.extra.level + 1 -- upgrades joker

			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(1, 0.5)
							card.ability.extra.pos_override.x = card.ability.extra.level + 1
							card.children.center:set_sprite_pos(card.ability.extra.pos_override)
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
					return true
				end
			}))
			return
		end

		if context.joker_main then
			local level = {
				[1] = { chips = card.ability.extra.chips },
				[2] = { mult = card.ability.extra.mult },
				[3] = { xmult = card.ability.extra.xmult },
			}
			return level[card.ability.extra.level]
		end
	end
}
