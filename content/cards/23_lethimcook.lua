-- Credit to Rensnek for this function!
local function deep_copy(orig, cutoff_value)
	cutoff_value = cutoff_value or orig
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		if orig_type ~= cutoff_value then
			copy = {}
			for orig_key, orig_value in next, orig, nil do
				copy[deep_copy(orig_key)] = deep_copy(orig_value)
			end
		end
	else
		copy = orig
	end
	return copy
end

SMODS.Joker {
	name = 'Let Him Cook',
	key = 'lethimcook',
	AddRunningAnimation({ "j_kh_lethimcook", 0.65, 8, 0, "loop", 0, 0, card }), -- check utilities/animateObject.lua, credits to B'!
	loc_vars = function(self, info_queue, card)
		if card.area == G.jokers then
			-- Find position of Joker
			local pos
			for i, v in ipairs(G.jokers.cards) do
				if v == card then
					pos = i; break
				end
			end
			if not pos then return { vars = {} } end

			local adjacent = { G.jokers.cards[pos - 1], G.jokers.cards[pos + 1] }
			local main_end_nodes = {}

			for i = 1, 2 do
				local adj = adjacent[i]
				local compatible = adj and adj ~= card and not adj.ability.perishable and
					not Exclude_list[adj.ability.name]
				if not adj then compatible = false end -- default to incompatible if no jokers adjacent

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
								text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ',
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

			return { vars = {}, main_end = main_end }
		end

		return { vars = { card.ability.extra.multiplier } }
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
			multiplier = 1.5,
			last_left_joker = nil,
			last_right_joker = nil,
			sold = false
		}
	},

	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.buffed = {}
		local find = SMODS.find_card('j_kh_lethimcook');
		if #find > 0 then
			SMODS.calculate_effect({ message = "Friend inside me...", colour = G.C.MULT, instant = false }, find[1])
			card:start_dissolve(nil, true);
			return
		end
	end,

	update = function(self, card)
		if G.jokers and G.jokers.cards then
			local pos
			for i, v in ipairs(G.jokers.cards) do
				if v == card then
					pos = i; break
				end
			end
			if not pos then return end

			local left = G.jokers.cards[pos - 1]
			local right = G.jokers.cards[pos + 1]

			-- Reset buffed jokers that are no longer adjacent
			local new_buffed = {}
			for _, old_card in pairs(card.ability.extra.buffed) do
				if old_card ~= left and old_card ~= right and old_card.ability then
					-- Reset to original values
					if old_card.ability.original_values then
						old_card.ability = deep_copy(old_card.ability.original_values)
					end
				else
					table.insert(new_buffed, old_card)
				end
			end
			card.ability.extra.buffed = new_buffed

			-- Apply buff to current adjacent jokers
			for _, adj in pairs({ left, right }) do
				local name = adj.ability.name
				local is_excluded = Exclude_list[name]
				if adj and not adj.ability.perishable and not is_excluded and not XIII.REND.table_contains(card.ability.extra.buffed, adj) then
					-- Store original values if not already stored
					if not adj.ability.original_values then
						adj.ability.original_values = deep_copy(adj.ability)
					end
					local joker_rules = { -- do roxas
						["Riku"] = { keywords = { levels = true }, unkeywords = { counter = true, total = true } },
						["Loyalty Card"] = { unkeywords = { loyalty_remaining = true, every = true } },
						["Caino"] = { unkeywords = { caino_xmult = true } },
						["Yorick"] = { unkeywords = { yorick_discards = true, discards = true } },
						["Wee Joker"] = { keywords = { chip_mod = true } },
						["Stuntman"] = { keywords = { chip_mod = true } },
						["Square Joker"] = { keywords = { chip_mod = true } },
						["Runner"] = { keywords = { chip_mod = true } },
						["Faceless Joker"] = { keywords = { dollars = true } },
						["Roxas"] = { unkeywords = { discards_remaining = true, discards = true, chips = true } },
						["Joker Menu"] = { unkeywords = { pos = true } },
						["Kingdom Hearts"] = { keywords = { chips = true, mult = true, xmult = true } },
					}
					local rules = joker_rules[name] or {
						unkeywords = {
							odds = true,
							Xmult_mod = true,
							mult_mod = true,
							chips_mod = true,
							hand_add = true,
							discard_sub = true,
							h_mod = true,
							size = true,
							chip_mod = true,
							h_size = true,
							increase = true
						}
					}
					XIII.funcs.mod_card_values(
						adj.ability,
						{
							multiply = card.ability.extra.multiplier,
							reference = adj.ability.original_values,
							x_protect = true,
							keywords = rules.keywords,
							unkeywords = rules.unkeywords
						}
					)
					table.insert(card.ability.extra.buffed, adj)
				end
			end
		end
	end,
}
