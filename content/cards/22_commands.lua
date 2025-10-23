function get_least_common_cards_from_hand(played_hand)
	local global_counts = {}

	-- Count all ranks in the full deck
	for _, card in ipairs(G.playing_cards) do
		local rank = card.base.value
		global_counts[rank] = (global_counts[rank] or 0) + 1
	end

	-- Find the minimum global count among played ranks
	local min_count = math.huge
	local played_ranks = {}

	-- First pass: find the lowest global count among played ranks
	for _, card in ipairs(played_hand) do
		local rank = card.base.value
		local global_count = global_counts[rank] or 0

		if global_count < min_count then
			min_count = global_count
		end

		-- Track which ranks we actually played
		if not played_ranks[rank] then
			played_ranks[rank] = true
		end
	end

	-- Check if there's a tie for lowest count
	local lowest_ranks = {}
	for rank, _ in pairs(played_ranks) do
		if global_counts[rank] == min_count then
			table.insert(lowest_ranks, rank)
		end
	end

	-- If multiple ranks share the lowest count, it's a tie - return nothing
	if #lowest_ranks > 1 then
		return {}
	end

	-- Otherwise, return all cards of the single lowest rank
	local cards_to_destroy = {}
	local target_rank = lowest_ranks[1]
	for _, card in ipairs(played_hand) do
		if card.base.value == target_rank then
			table.insert(cards_to_destroy, card)
		end
	end

	return cards_to_destroy
end

-- bluelatro credits!
-- After playing a hand, cards marked with `card.blueatro_return_to_hand` are returned to hand instead
G.FUNCS.draw_from_play_to_discard = function(_)
	local play_count = #G.play.cards
	local i = 1
	for _, card in ipairs(G.play.cards) do
		if (not card.shattered) and not card.destroyed then
			if card.blueatro_return_to_hand then
				card.blueatro_return_to_hand = nil
				draw_card(G.play, G.hand, i * 100 / play_count, "up", true, card)
			else
				draw_card(G.play, G.discard, i * 100 / play_count, "down", false, card)
			end
			i = i + 1
		end
	end
end

SMODS.Joker {
	name = 'Joker Menu',
	key = "commandmenu",

	loc_vars = function(self, info_queue, card)
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
	update = function(self, card, dt)
	end,


	add_to_deck = function(self, card, context)
		card.ability.extra.pos = 0
		card.config.center.pos.x = 0
	end,

	calculate = function(self, card, context)
		local pos = card.ability.extra.pos

		if context.setting_blind then
			local total_spins = 12         -- total steps to spin
			local current_pos = card.ability.extra.pos or 0
			local final_pos = (current_pos + 1) % 4 -- goes in order

			-- precompute delays to gradually slow down
			local delays = {}
			local base_delay = 0.2
			local increment = 0.1
			for i = 1, total_spins do
				delays[i] = base_delay + (i - 1) * increment
			end

			-- spin steps
			for i = 1, total_spins do
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

			-- final alignment to the next position (not random)
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

		-- to be changed, logic is pretty bad
		if pos == 0 then -- Attack: Destroy all cards of the least common rank
			if not context.blueprint and context.after and context.main_eval then
				local played_hand = G.play.cards

				if played_hand and #played_hand > 0 then
					local cards_to_destroy = get_least_common_cards_from_hand(played_hand)

					if #cards_to_destroy > 0 then
						SMODS.destroy_cards(cards_to_destroy)
						return {
							message = "Upgrade!",
							colour = G.C.MULT
						}
					end
				end
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
			-- to be changed
		elseif pos == 1 then
			if context.after and context.main_eval and not context.blueprint then
				local i = 0
				for _, played_card in ipairs(G.play.cards) do
					-- See G.FUNCS.draw_from_play_to_discard override
					played_card.blueatro_return_to_hand = true
					i = i + 1
					if i >= 1 then
						return
					end
				end
				return {
					message = "Returned!",
					colour = G.C.GREEN
				}
			end
		end
		if context.joker_main then
			if pos == 3 then -- DRIVE, give X4 mult(to be changed)
				return {
					x_mult = card.ability.extra.xmult
				}
			end
		end
	end
}
