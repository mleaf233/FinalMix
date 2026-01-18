SMODS.Joker {
	name = 'Joker Menu',
	key = "commandmenu",

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "kh_attack", set = "Other" }
		info_queue[#info_queue + 1] = { key = "kh_magic", set = "Other" }
		info_queue[#info_queue + 1] = { key = "kh_items", set = "Other" }
		info_queue[#info_queue + 1] = { key = "kh_drive", set = "Other" }
		return {
			key = self.key .. '_kh' .. tostring(card.ability.extra.pos),
			vars = {
			}
		}
	end,


	rarity = 3,
	atlas = 'command',
	pos = { x = 0, y = 0 },
	cost = 10,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,

	config = {
		extra = {
			pos = 0,
			pos_override = { x = 0, y = 0 },
			xmult = 4
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

	add_to_deck = function(self, card, context)
		card.ability.extra.pos = 0
		card.config.center.pos.x = 0
	end,

	calculate = function(self, card, context)
		local pos = card.ability.extra.pos

		if context.setting_blind then
			local total_cycles = 12
			local current_pos = card.ability.extra.pos or 0
			local final_pos = (current_pos + 1) % 4 -- goes in order

			local delays = {}
			local base_delay = 0.2
			local increment = 0.1
			for i = 1, total_cycles do
				delays[i] = base_delay + (i - 1) * increment
			end

			for i = 1, total_cycles do
				G.E_MANAGER:add_event(Event({
					delay = delays[i],
					func = function()
						card:juice_up(0.3, 0.2)
						card.ability.extra.pos = (card.ability.extra.pos + 1) % 4
						card.ability.extra.pos_override.x = card.ability.extra.pos
						card.children.center:set_sprite_pos(card.ability.extra.pos_override)
						return true
					end
				}))
			end

			G.E_MANAGER:add_event(Event({
				delay = delays[#delays] + 0.05,
				func = function()
					card.ability.extra.pos = final_pos
					card.ability.extra.pos_override.x = final_pos
					card.children.center:set_sprite_pos(card.ability.extra.pos_override)
					return true
				end
			}))

			SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
		end

		if pos == 0 then -- Attack: If hand contains at least 4 cards destroy all cards held in hand
			if not context.blueprint and context.after and context.main_eval and #context.full_hand >= 4 then
				local cards_to_destroy = {}
				if G.hand.cards and #G.hand.cards > 0 then
					for _, card in ipairs(G.hand.cards) do
						table.insert(cards_to_destroy, card)
					end
				end
				if #cards_to_destroy > 0 then
					SMODS.destroy_cards(cards_to_destroy)
					SMODS.calculate_effect({ message = localize('kh_destroyed'), colour = G.C.FILTER }, card)
				end
			end
		elseif pos == 1 then -- Magic - First card returns to hand (to be changed, but thanks bluelatro for hook)
			if context.after and context.main_eval and not context.blueprint then
				local i = 0
				for _, played_card in ipairs(G.play.cards) do
					-- See G.FUNCS.draw_from_play_to_discard override
					played_card.finalmix_return_to_hand = true
					i = i + 1
					if i >= 1 then
						return
					end
				end
				return {
					message = localize("kh_returned"),
					colour = G.C.GREEN
				}
			end
		elseif pos == 2 then -- items, Played aces create a random consumable
			if context.individual and context.cardarea == G.play and not context.blueprint then
				if context.other_card:get_id() == 14 then
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
						G.E_MANAGER:add_event(Event({
							func = (function()
								G.E_MANAGER:add_event(Event({
									func = function()
										SMODS.add_card {
											set = "Consumeables",
											area = G.consumeables
										}
										G.GAME.consumeable_buffer = 0
										return true
									end
								}))
								SMODS.calculate_effect({ message = localize('kh_plus_consumeable'), colour = G.C.BLUE },
									context.blueprint_card or card)
								return true
							end)
						}))
						return nil, true
					end
				end
			end
		end
		if pos == 3 then -- Drive, give 4X Mult
			if context.joker_main then
				return {
					x_mult = card.ability.extra.xmult
				}
			end
		end
	end
}
