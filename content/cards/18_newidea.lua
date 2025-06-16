SMODS.Joker {
	name = "lil bro",
	key = "lil bro",
	config = {
		 extra = {
			 condition_satisfied = true,
			 winged_poker_hand = 'Pair',
			 old_winged_poker_hand = 'Pair',
			 levels = 1,
			 counter = 0
			} 
		}, -- old_winged_poker_hand is internal, winged_poker_hand is external
	pos = { x = 5, y = 1 },
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "KHJokers",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.winged_poker_hand,
				card.ability.extra.levels,
				card.ability.extra.counter
			} 
		}
	end,

set_ability = function(self, card, initial, delay_sprites)
	local _handname, _played, _order = 'High Card', -1, 100
	for k, v in pairs(G.GAME.hands) do
		if v.played > _played or (v.played == _played and _order > v.order) then 
			_played = v.played
			_handname = k
		end
	end
	card.ability.extra.winged_poker_hand = _handname
	card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand
end,
calculate = function(self, card, context)
	if context.end_of_round then
		-- Save the most recently played hand
		local _handname, _played, _order = 'High Card', -1, 100
		for k, v in pairs(G.GAME.hands) do
			if v.played > _played or (v.played == _played and _order > v.order) then 
				_played = v.played
				_handname = k
			end
		end
		card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand
		card.ability.extra.winged_poker_hand = _handname
	end

	if context.reroll_shop then
		card.ability.extra.counter = card.ability.extra.counter or 0
		card.ability.extra.counter = card.ability.extra.counter + 1

		if card.ability.extra.counter == 4 then
			local _card = context.blueprint_card or card
			if card.ability.extra.condition_satisfied == true then
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						local _hand = card.ability.extra.old_winged_poker_hand
						update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
							handname = localize(_hand, 'poker_hands'),
							chips = G.GAME.hands[_hand].chips,
							mult = G.GAME.hands[_hand].mult,
							level = G.GAME.hands[_hand].level
						})
						level_up_hand(_card, _hand, nil, card.ability.extra.levels)
						update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {
							mult = 0, chips = 0, handname = '', level = ''
						})
						return true
					end)
				}))
				card_eval_status_text(_card, 'extra', nil, nil, nil, {
					message = localize('k_level_up_ex'), colour = G.C.FILTER
				})
				return nil, true
			end
			card.ability.extra.counter = 0
		end
	end
end
}



--[[
SMODS.Joker {
	name = "lil bro",
	key = "lil bro",
	config = {
		 extra = {
			 condition_satisfied = true,
			 winged_poker_hand = 'Pair',
			 old_winged_poker_hand = 'Pair',
			 levels = 2 
			} 
		}, -- old_winged_poker_hand is internal, winged_poker_hand is external
	pos = { x = 5, y = 1 },
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "KHJokers",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.winged_poker_hand,
				card.ability.extra.levels
			} 
		}
	end,

set_ability = function(self, card, initial, delay_sprites)
	local _handname, _played, _order = 'High Card', -1, 100
	for k, v in pairs(G.GAME.hands) do
		if v.played > _played or (v.played == _played and _order > v.order) then 
			_played = v.played
			_handname = k
		end
	end
	card.ability.extra.winged_poker_hand = _handname
	card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand
end,

calculate = function(self, card, context)
	if context.end_of_round then
		card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand		-- delay old_winged_poker_hand from changing due to brainstorm
	end
	if context.reroll_shop then -- context.end_of_round and not context.repetition and not context.individual then --
		
		local _card = context.blueprint_card or card
		if card.ability.extra.condition_satisfied == true then
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					local _hand = card.ability.extra.old_winged_poker_hand
					update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
					level_up_hand(_card, _hand, nil, card.ability.extra.levels)
					update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
					return true
				end)
			}))
		end
		if not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = (function()
					local _handname, _played, _order = 'High Card', -1, 100
					for k, v in pairs(G.GAME.hands) do
						if v.played > _played or (v.played == _played and _order > v.order) then 
							_played = v.played
							_handname = k
						end
					end
					card.ability.extra.winged_poker_hand = _handname
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Reset", colour = G.C.FILTER })
					return true
				end)
			}))
		end
		if card.ability.extra.condition_satisfied == true then
			card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
				{ message = localize('k_level_up_ex'), colour = G.C.FILTER })
			return nil, true
		end
	end
end
}
--]]