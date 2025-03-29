SMODS.Joker {
	key = 'mickey',
	
	loc_txt = {
		name = 'Meeska Mooska',
		text = {
			"Retrigger all",
			"played {C:hearts}heart{} cards",
			"{C:green}#1# in #2#{} chance this card is",
			"destroyed at the end of the round",
		}
	},

	config = { extra = { repetitions = 1, odds = 7} },
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 2, y = 0 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
	end,
	
	calculate = function(self, card, context)
		-- Checks that the current cardarea is G.play, or the cards that have been played, then checks to see if it's time to check for repetition.
		-- The "not context.repetition_only" is there to keep it separate from seals.
		
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			-- context.other_card is something that's used when either context.individual or context.repetition is true
			-- It is each card 1 by 1, but in other cases, you'd need to iterate over the scoring hand to check which cards are there.
			if context.other_card:is_suit("Hearts") then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					-- The card the repetitions are applying to is context.other_card
					card = card
				}
			end
		end
		
		-- Checks to see if it's end of round, and if context.game_over is false.
		-- Also, not context.repetition ensures it doesn't get called during repetitions.
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			-- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
			if pseudorandom('mickey') < G.GAME.probabilities.normal / card.ability.extra.odds then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				-- Extinct/Survival Message
				return {
					message = 'Gawrsh!'
				}
			else
				return {
					message = 'Hot Dog!'
				}
			end
		end
	end
}
