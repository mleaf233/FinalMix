if Blockbuster then
	SMODS.Joker {
		name = 'Let Him Cook',
		key = 'lethimcook',
		loc_vars = function(self, info_queue, card)
			if card.area == G.jokers then
				local pos = XIII.get_pos(card, G.jokers.cards)
				if not pos then return { vars = {} } end

				local adjacent = { G.jokers.cards[pos - 1], G.jokers.cards[pos + 1] }
				local main_end_nodes = {}

				for i = 1, 2 do
					local adj = adjacent[i]
					local compatible = XIII.compat_check(card, adj)
					table.insert(main_end_nodes, {
						n = G.UIT.C,
						config = {
							ref_table = card,
							align = "m",
							colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
								or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
							r = 0.05,
							padding = 0.06
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = ' ' ..
										localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ',
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.256
								}
							}
						}
					})
				end

				local main_end = {
					{
						n = G.UIT.C,
						config = { align = "bm", minh = 0.4 },
						nodes = main_end_nodes
					}
				}

				return {
					vars = {

					},
					main_end = main_end
				}
			end

			return {
				vars = {
					card.ability.extra.multiplier
				}
			}
		end,

		rarity = 3,
		atlas = 'cooking',
		pos = { x = 0, y = 0 },
		cost = 8,
		unlocked = true,
		discovered = true,
		blueprint_compat = false,
		eternal_compat = true,
		perishable_compat = true,

		config = {
			extra = {
				multiplier = 0.05,
			}
		},

		add_to_deck = function(self, card, from_debuff)
			local find = SMODS.find_card('j_kh_lethimcook')
			if #find > 0 then
				SMODS.calculate_effect({ message = "Friend inside me...", colour = G.C.MULT, instant = false }, find[1])
				card:start_dissolve(nil, true)
				return
			end
		end,

		calculate = function(self, card, context)
			if context.post_trigger and context.cardarea == G.jokers then
				local triggered_joker = context.other_card
				local pos = XIII.get_pos(card, G.jokers.cards)
				local left = G.jokers.cards[pos - 1]
				local right = G.jokers.cards[pos + 1]


				for _, adj in pairs({ left, right }) do
					if adj == triggered_joker and XIII.compat_check(card, adj) then
						Blockbuster.manipulate_value(adj, "lethimcook", card.ability.extra.multiplier, nil,
							true)
						SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER },
							adj)
					end
				end
			end

			if context.selling_self then
				local pos = XIII.get_pos(card, G.jokers.cards)
				local left = G.jokers.cards[pos - 1]
				local right = G.jokers.cards[pos + 1]

				for _, adj in pairs({ left, right }) do
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							adj.T.r = -0.2
							adj:juice_up(0.3, 0.4)
							adj.states.drag.is = true
							adj.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									G.jokers:remove_card(adj)
									adj:remove()
									adj = nil
									return true;
								end
							}))
							return true
						end
					}))
				end
			end
		end,
		calc_dollar_bonus = function(self, card)
			local pos = XIII.get_pos(card, G.jokers.cards)
			local left = G.jokers.cards[pos - 1]
			local right = G.jokers.cards[pos + 1]

			for _, adj in pairs({ left, right }) do
				if adj and XIII.compat_check(card, adj) then
					local money = Card.calculate_dollar_bonus(adj)
					if money and money > 0 then
						Blockbuster.manipulate_value(adj, "lethimcook", card.ability.extra.multiplier, nil, true)
						SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER },
							adj)
					end
				end
			end
		end
	}
else -- if blockbuster is not available
	SMODS.Joker {
		name = 'Let Him Cook',
		key = 'lethimcook_alt',
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "kh_lhceffect", set = "Other" }
			info_queue[#info_queue + 1] = { key = "kh_no_blockbuster", set = "Other" }
			return {
				vars = {
					card.ability.extra.x_mult, --1
					card.ability.extra.xmult_gain --2
				}
			}
		end,

		rarity = 3,
		atlas = 'cooking',
		pos = { x = 0, y = 0 },
		cost = 8,
		unlocked = true,
		discovered = true,
		blueprint_compat = false,
		eternal_compat = true,
		perishable_compat = true,

		config = {
			extra = {
				x_mult = 1,
				xmult_gain = 0.05,
			}
		},

		calculate = function(self, card, context)
			if context.post_trigger and context.cardarea == G.jokers then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "xmult_gain",
					operation = '+',
				})
			end
			if context.joker_main and card.ability.extra.x_mult > 1 then
				return {
					x_mult = card.ability.extra.x_mult
				}
			end
		end,
	}
end
