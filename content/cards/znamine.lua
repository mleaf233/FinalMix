--[[
a lot of axel dumps


--[[
SMODS.Joker{
	key = 'axel',
	atlas = 'KHJokers',
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = { x = 4, y = 2 },
	config = { extra = {}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = "kh_perishable", set = "Other"}
		info_queue[#info_queue+1] = {key = "kh_unstackable", set = "Other"}
		return {vars = {}}
	end,
calculate = function(self,card,context)
	
	if context.end_of_round and context.cardarea == G.jokers and not context.individual and not context.repetition and G.GAME.blind.boss  then
		
		local _card = card
		local target =G.jokers.cards[1] -- makes target the leftmost joker
		if target and target ~= card and not target.ability.perishable then
					
					local exclude_extra = {
										"Shoot the Moon", -- doubles it but doesn't work properly
										"Castle",
										"Constellation",
										"Flash Card",
										--"Glass Joker", works
										-- "Hologram", works
										--"Lucky Cat", works
										"Obelisk",
										--"Red Card", works
										--"Ride the Bus", works
										"Runner", -- doesnt work
										"Square Joker", -- doesnt work\
										"Spare Trousers",
										"Vampire",
										"Wee Joker",
										"Yorick",
										"Invisible Joker",
										"Madness",
										"Popcorn",
										"Rough Gem",
										"Marble Joker",
										"Perkeo",
										"Blueprint",
										"Brainstorm",
										"Business Card",
                                        "Riff Raff"
									}
					local doExclude = false

					for e = 1 , #exclude_extra do
						if target.ability.name == exclude_extra[e]then
							doExclude = true
						end
					end

					if target.ability.name ~= "j_kh_namine" then
						if doExclude == true then
							XIII.funcs.mod_card_values(target.ability,{
								multiply = 1,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									extra = true
								}
							})
							return {
								message = localize("k_khjokers_incompatible"), colour = G.C.MULT 
							}	

						else							
							XIII.funcs.mod_card_values(target.ability,{
								multiply = 2,
								x_protect = true,
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
							})

							if not target.ability.perishable then
								SMODS.Stickers["perishable"]:apply(target, true)
							end
						end
					end	

				if context.blueprint then
					_card = context.blueprint_card
				end	

			return {
				message = localize("k_upgrade_ex"), colour = G.C.GREEN
			}
			end
		end
	end
}
--]]

--[[
SMODS.Joker {
	key = 'axel',
	loc_txt = {},
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 4, y = 2},
	cost = 4,
	unlocked = true,
    discovered = true,
	blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 0.5
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 0.5
        end
    end,
}
--]]
--[[s
-- set custom globals
ROFF = {
    funcs = {
        --- Credit to Aikoyori for this function, and RenSnek for expanding it. Given a `table_in` (value table or card object) and a config table, modifies the values in `table_in` depending 
        --- on the `config` provided. `config` accepts these values:
        --- * `add`
        --- * `multiply`
        --- * `keywords`: list of specific values to change in `table_in`. If nil, change every value in `table_in`.
        --- * `unkeywords`: list of specific values to *not* change in `table_in`.
        --- * `x_protect`: if true (or not set), any X effects (Xmult, Xchips, etc.) whose value is currently 1 are not modified. If false, this check is bypassed - which may result in some unlisted values being 
        --- modified.
        --- * `reference`: initial values for the provided table. If nil, defaults to `table_in`.
        --- 
        --- This function scans all sub-tables for numeric values, so it's recommended to pass the card's ability table rather than the entire card object.
        ---@param table_in table|Card
        ---@param config table
        mod_card_values = function (table_in, config)
            if not config then config = {} end
            local add = config.add or 0
            local multiply = config.multiply or 1
            local keywords = config.keywords or {}
            local unkeyword = config.unkeywords or {}
            local x_protect = config.x_protect or true -- If true and a key starts with x_ and the value is 1, it won't multiply
            local reference = config.reference or table_in
            local function modify_values(table_in, ref)
                for k,v in pairs(table_in) do -- For key, value in the table
                    if type(v) == "number" then -- If it's a number
                        if (keywords[k] or (ROFF.REND.table_true_size(keywords) < 1)) and not unkeyword[k] then -- If it's in the keywords, OR there's no keywords and it isn't in the unkeywords
                            if ref and ref[k] then -- If it exists in the reference
                                if not (x_protect and (ROFF.REND.starts_with(k,"x_") or ROFF.REND.starts_with(k,"h_x_")) and ref[k] == 1) then
                                    table_in[k] = (ref[k] + add) * multiply -- Set it to (reference's value + add) * multiply
                                end
                            end
                        end
                    elseif type(v) == "table" then -- If it's a table
                        modify_values(v, ref[k]) -- Recurse for values in the table
                    end
                end
            end
            if table_in == nil then
                return
            end
            modify_values(table_in, reference)
        end,

        --- Calls `mod_card_values` to multiply `card`'s values by `mult`, making sure to also modify the nominal value.
        ---@param card table|Card
        ---@param mult number
        xmult_playing_card = function(card, mult)
            local tablein = {
                nominal = card.base.nominal,
                ability = card.ability
            }

            ROFF.funcs.mod_card_values(tablein, {multiply = mult})

            card.base.nominal = tablein.nominal
            card.ability = tablein.ability
        end,
    },
}

-- couple util funcs nabbed from https://github.com/RenSnek/Balatro-Rendoms :33 (nested into ROFF to avoid compatibility issues)
ROFF.REND = {}

--- Credit to RenSnek. Given a string `str` and a shorter string `start`, checks if the string's first `#start` characters are the same as `start`.
---@param str string
---@param start string
---@return boolean
ROFF.REND.starts_with = function(str,start)
    return str:sub(1, #start) == start
end

--- Credit to RenSnek. Given a `table` and a `value`, returns true if `value` is found in `table`.
---@param table table
---@param value any
---@return boolean
ROFF.REND.table_contains = function(table,value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end

--- Credit to RenSnek. Given a table, returns a more accurate estimate of its size than the `#` operator.
---@param table table
---@return number
ROFF.REND.table_true_size = function(table)
    local n = 0
    for k,v in pairs(table) do
        n = n+1
    end
    return n
end


SMODS.Joker{
	key = 'namine',
	atlas = 'KHJokers',
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pos = { x = 3, y = 2 },
	config = { extra = {}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = "kh_perishable", set = "Other"}
		info_queue[#info_queue+1] = {key = "kh_unstackable", set = "Other"}
		return {vars = {}}
	end,
calculate = function(self,card,context)
	
	if context.end_of_round and context.cardarea == G.jokers and not context.individual and not context.repetition and G.GAME.blind.boss  then
		
		local _card = card
		local target =G.jokers.cards[1] -- makes target the leftmost joker
		if target and target ~= card and not target.ability.perishable then
					
					local exclude_extra = {
										"Shoot the Moon", -- doubles it but doesn't work properly
										"Castle",
										"Constellation",
										"Flash Card",
										--"Glass Joker", works
										-- "Hologram", works
										--"Lucky Cat", works
										"Obelisk",
										--"Red Card", works
										--"Ride the Bus", works
										"Runner", -- doesnt work
										"Square Joker", -- doesnt work\
										"Spare Trousers",
										"Vampire",
										"Wee Joker",
										"Yorick",
										"Invisible Joker",
										"Madness",
										"Popcorn",
										"Rough Gem",
										"Marble Joker",
										"Perkeo",
										"Blueprint",
										"Brainstorm",
										"Business Card",
									}
					local doExclude = false

					for e = 1 , #exclude_extra do
						if target.ability.name == exclude_extra[e]then
							doExclude = true
						end
					end

					if target.ability.name ~= "j_kh_namine" then
						if doExclude == true then
							ROFF.funcs.mod_card_values(target.ability,{
								multiply = 1,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									extra = true
								}
							})
							return {
								message = localize("k_khjokers_incompatible"), colour = G.C.MULT 
							}	

						else							
							ROFF.funcs.mod_card_values(target.ability,{
								multiply = 2,
								x_protect = true,
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
							})

							if not target.ability.perishable then
								SMODS.Stickers["perishable"]:apply(target, true)
							end
						end
					end	

				if context.blueprint then
					_card = context.blueprint_card
				end	

			return {
				message = localize("k_upgrade_ex"), colour = G.C.GREEN
			}
			end
		end
	end
}
--]]

























					--[[
					if G.jokers.cards[i].ability.name ~= "j_kh_MainChannel"then
						if doExclude then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 2,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									extra = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Ramen" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 2,
								x_protect = true,
								unkeywords = {
									Xmult = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Loyalty Card" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 2,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									loyalty_remaining = true,
									every = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Campfire" or G.jokers.cards[i].ability.name == "Hit the Road" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 2,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true
								}
							})
							--]]
					








--[[
function is_number(x)
  if type(x) == 'number' then return true end
  if type(x) == 'table' and ((x.e and x.m) or (x.array and x.sign)) then return true end
  return false
end

function Card:no(m, no_no)
	if no_no then
		return self.config.center[m] or (G.GAME and G.GAME[m] and G.GAME[m][self.config.center_key]) or false
	end
	return Card.no(self, "no_" .. m, true)
end


function with_deck_effects(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		return ret
	end
end

function deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[deep_copy(k, s)] = deep_copy(v, s)
	end
	return res
end


--Redefine these here because they're always used
base_values = {}
function misprintize_tbl(name, ref_tbl, ref_value, clear, override, stack, big)
	if name and ref_tbl and ref_value then
		tbl = deep_copy(ref_tbl[ref_value])
		for k, v in pairs(tbl) do
			if (type(tbl[k]) ~= "table") or is_number(tbl[k]) then --
				if
					is_number(tbl[k])
					and not (k == "perish_tally")
					and not (k == "id")
					and not (k == "colour")
					and not (k == "suit_nominal")
					and not (k == "base_nominal")
					and not (k == "face_nominal")
					and not (k == "qty")
					and not (k == "x_mult" and v == 1 and not tbl.override_x_mult_check)
					and not (k == "x_chips" and v == 1 and not tbl.override_x_chips_check)
					and not (k == "h_x_chips")
					and not (k == "selected_d6_face")
				then --Temp fix, even if I did clamp the number to values that wouldn't crash the game, the fact that it did get randomized means that there's a higher chance for 1 or 6 than other values
					if not base_values[name] then
						base_values[name] = {}
					end
					if not base_values[name][k] then
						base_values[name][k] = tbl[k]
					end
					tbl[k] = sanity_check(
						clear and base_values[name][k]
							or cry_format(
								(stack and tbl[k] or base_values[name][k])
									* log_random(
										pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
										override and override.min or G.GAME.modifiers.cry_misprint_min,
										override and override.max or G.GAME.modifiers.cry_misprint_max
									),
								"%.2g"
							),
						big
					)
				end
			elseif not (k == "immutable") then
				for _k, _v in pairs(tbl[k]) do
					if
						is_number(tbl[k][_k])
						and not (_k == "id")
						and not (k == "colour")
						and not (_k == "suit_nominal")
						and not (_k == "base_nominal")
						and not (_k == "face_nominal")
						and not (_k == "qty")
						and not (k == "x_mult" and v == 1 and not tbl[k].override_x_mult_check)
						and not (k == "x_chips" and v == 1 and not tbl[k].override_x_chips_check)
						and not (k == "h_x_chips")
						and not (_k == "selected_d6_face")
					then --Refer to above
						if not base_values[name] then
							base_values[name] = {}
						end
						if not base_values[name][k] then
							base_values[name][k] = {}
						end
						if not base_values[name][k][_k] then
							base_values[name][k][_k] = tbl[k][_k]
						end
						tbl[k][_k] = sanity_check(
							clear and base_values[name][k][_k]
								or cry_format(
									(stack and tbl[k][_k] or base_values[name][k][_k])
										* log_random(
											pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
											override and override.min or G.GAME.modifiers.cry_misprint_min,
											override and override.max or G.GAME.modifiers.cry_misprint_max
										),
									"%.2g"
								),
							big
						)
					end
				end
			end
		end
		ref_tbl[ref_value] = tbl
	end
end

function sanity_check(val, is_big)
	if is_big then
		if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
			val = 1e300
		end
		if type(val) == "table" then
			return val
		end
		if val > 1e100 or val < -1e100 then
			return to_big(val)
		end
	end
	if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
		return 1e300
	end
	return val
end

function misprintize(card, override, force_reset, stack)
	if Card.no(card, "immutable", true) then
		force_reset = true
	end
	if
		(not force_reset or G.GAME.modifiers.cry_jkr_misprint_mod)
			and (G.GAME.modifiers.cry_misprint_min or override or card.ability.set == "Joker")
			and not stack
		or not Card.no(card, "immutable", true)
	then
		if card.ability.name == "Ace Aequilibrium" then
			return
		end
		if G.GAME.modifiers.cry_jkr_misprint_mod and card.ability.set == "Joker" then
			if not override then
				override = {}
			end
			override.min = override.min or G.GAME.modifiers.cry_misprint_min or 1
			override.max = override.max or G.GAME.modifiers.cry_misprint_max or 1
			override.min = override.min * G.GAME.modifiers.cry_jkr_misprint_mod
			override.max = override.max * G.GAME.modifiers.cry_jkr_misprint_mod
		end
		if G.GAME.modifiers.cry_misprint_min or override and override.min then
			misprintize_tbl(
				card.config.center_key,
				card,
				"ability",
				nil,
				override,
				stack,
				false
			)
			if card.base then
				misprintize_tbl(
					card.config.card_key,
					card,
					"base",
					nil,
					override,
					stack,
					false
				)
			end
		end
		if G.GAME.modifiers.cry_misprint_min then
			card.misprint_cost_fac = 1
				/ log_random(
					pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
					override and override.min or G.GAME.modifiers.cry_misprint_min,
					override and override.max or G.GAME.modifiers.cry_misprint_max
				)
			card:set_cost()
		end
	else
		misprintize_tbl(card.config.center_key, card, "ability", true, nil, nil, false) --is_card_big(card))
	end
	if card.ability.consumeable then
		for k, v in pairs(card.ability.consumeable) do
			card.ability.consumeable[k] = deep_copy(card.ability[k])
		end
	end
end

function log_random(seed, min, max)
	math.randomseed(seed)
	local lmin = math.log(min, 2.718281828459045)
	local lmax = math.log(max, 2.718281828459045)
	local poll = math.random() * (lmax - lmin) + lmin
	return math.exp(poll)
end

to_big = to_big or function(x) return x end

function cry_format(number, str)
	if math.abs(to_big(number)) >= to_big(1e300) then
		return number
	end
	return tonumber(str:format((Big and to_number(to_big(number)) or number)))
end

SMODS.Joker {
    name = "Naminé",
    key = "namine",
    atlas = 'KHJokers',
    pos = { x = 3, y = 2 },
    cost = 6,
    rarity = 3,
    blueprint_compat = false,
    eternal = false,
    perishable = false,
    config = { extra = { jokerMult = 2 } },

    loc_txt = {
    },

    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = "kh_perishable", set = "Other"}
		info_queue[#info_queue+1] = {key = "kh_unstackable", set = "Other"}
        return { vars = { center.ability.extra.jokerMult } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then --and G.GAME.blind.boss and not context.repetition then
            local target = G.jokers.cards[1]
            if target and target ~= card and not Card.no(target, "immutable", true) and not target.ability.perishable then
                with_deck_effects(target, function(c)
                    misprintize(c, {
                        min = card.ability.extra.jokerMult,
                        max = card.ability.extra.jokerMult
                    }, nil, true)
                end)
				
				SMODS.Stickers["perishable"]:apply(target, true)
				
                card_eval_status_text(
                    context.blueprint_card or card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                )
            end
        end
    end
}

--[[

function is_number(x)
  if type(x) == 'number' then return true end
  if type(x) == 'table' and ((x.e and x.m) or (x.array and x.sign)) then return true end
  return false
end

Cryptid = {}
function Card:no(m, no_no)
	if no_no then
		-- Infinifusion Compat
		if self.infinifusion then
			for i = 1, #self.infinifusion do
				if
					G.P_CENTERS[self.infinifusion[i].key][m]
					or (G.GAME and G.GAME[m] and G.GAME[m][self.infinifusion[i].key])
				then
					return true
				end
			end
			return false
		end
		if not self.config then
			--assume this is from one component of infinifusion
			return G.P_CENTERS[self.key][m] or (G.GAME and G.GAME[m] and G.GAME[m][self.key])
		end

		return self.config.center[m] or (G.GAME and G.GAME[m] and G.GAME[m][self.config.center_key]) or false
	end
	return Card.no(self, "no_" .. m, true)
end
-- o

function Cryptid.is_card_big(joker)
	local center = joker.config and joker.config.center
	if not center then
		return false
	end

	if center.immutable and center.immutable == true then
		return false
	end

end

function Cryptid.with_deck_effects(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		return ret
	end
end

function Cryptid.deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[Cryptid.deep_copy(k, s)] = Cryptid.deep_copy(v, s)
	end
	return res
end

-- misprintize.lua - functions for card value randomization

--Redefine these here because they're always used
Cryptid.base_values = {}
function Cryptid.misprintize_tbl(name, ref_tbl, ref_value, clear, override, stack, big)
	if name and ref_tbl and ref_value then
		tbl = Cryptid.deep_copy(ref_tbl[ref_value])
		for k, v in pairs(tbl) do
			if (type(tbl[k]) ~= "table") or is_number(tbl[k]) then --
				if
					is_number(tbl[k])
					and not (k == "perish_tally")
					and not (k == "id")
					and not (k == "colour")
					and not (k == "suit_nominal")
					and not (k == "base_nominal")
					and not (k == "face_nominal")
					and not (k == "qty")
					and not (k == "x_mult" and v == 1 and not tbl.override_x_mult_check)
					and not (k == "x_chips" and v == 1 and not tbl.override_x_chips_check)
					and not (k == "h_x_chips")
					and not (k == "selected_d6_face")
				then --Temp fix, even if I did clamp the number to values that wouldn't crash the game, the fact that it did get randomized means that there's a higher chance for 1 or 6 than other values
					if not Cryptid.base_values[name] then
						Cryptid.base_values[name] = {}
					end
					if not Cryptid.base_values[name][k] then
						Cryptid.base_values[name][k] = tbl[k]
					end
					tbl[k] = Cryptid.sanity_check(
						clear and Cryptid.base_values[name][k]
							or cry_format(
								(stack and tbl[k] or Cryptid.base_values[name][k])
									* Cryptid.log_random(
										pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
										override and override.min or G.GAME.modifiers.cry_misprint_min,
										override and override.max or G.GAME.modifiers.cry_misprint_max
									),
								"%.2g"
							),
						big
					)
				end
			elseif not (k == "immutable") then
				for _k, _v in pairs(tbl[k]) do
					if
						is_number(tbl[k][_k])
						and not (_k == "id")
						and not (k == "colour")
						and not (_k == "suit_nominal")
						and not (_k == "base_nominal")
						and not (_k == "face_nominal")
						and not (_k == "qty")
						and not (k == "x_mult" and v == 1 and not tbl[k].override_x_mult_check)
						and not (k == "x_chips" and v == 1 and not tbl[k].override_x_chips_check)
						and not (k == "h_x_chips")
						and not (_k == "selected_d6_face")
					then --Refer to above
						if not Cryptid.base_values[name] then
							Cryptid.base_values[name] = {}
						end
						if not Cryptid.base_values[name][k] then
							Cryptid.base_values[name][k] = {}
						end
						if not Cryptid.base_values[name][k][_k] then
							Cryptid.base_values[name][k][_k] = tbl[k][_k]
						end
						tbl[k][_k] = Cryptid.sanity_check(
							clear and Cryptid.base_values[name][k][_k]
								or cry_format(
									(stack and tbl[k][_k] or Cryptid.base_values[name][k][_k])
										* Cryptid.log_random(
											pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
											override and override.min or G.GAME.modifiers.cry_misprint_min,
											override and override.max or G.GAME.modifiers.cry_misprint_max
										),
									"%.2g"
								),
							big
						)
					end
				end
			end
		end
		ref_tbl[ref_value] = tbl
	end
end
function Cryptid.misprintize_val(val, override, big)
	if is_number(val) then
		val = Cryptid.sanity_check(
			cry_format(
				val
					* Cryptid.log_random(
						pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
						override and override.min or G.GAME.modifiers.cry_misprint_min,
						override and override.max or G.GAME.modifiers.cry_misprint_max
					),
				"%.2g"
			),
			big
		)
	end
	return val
end
function Cryptid.sanity_check(val, is_big)
	if is_big then
		if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
			val = 1e300
		end
		if type(val) == "table" then
			return val
		end
		if val > 1e100 or val < -1e100 then
			return to_big(val)
		end
	end
	if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
		return 1e300
	end
	return val
end
function Cryptid.misprintize(card, override, force_reset, stack)
	if Card.no(card, "immutable", true) then
		force_reset = true
	end
	--infinifusion compat
	if card.infinifusion then
		if card.config.center == card.infinifusion_center or card.config.center.key == "j_infus_fused" then
			calculate_infinifusion(card, nil, function(i)
				Cryptid.misprintize(card, override, force_reset, stack)
			end)
		end
	end
	if
		(not force_reset or G.GAME.modifiers.cry_jkr_misprint_mod)
			and (G.GAME.modifiers.cry_misprint_min or override or card.ability.set == "Joker")
			and not stack
		or not Card.no(card, "immutable", true)
	then
		if card.ability.name == "Ace Aequilibrium" then
			return
		end
		if G.GAME.modifiers.cry_jkr_misprint_mod and card.ability.set == "Joker" then
			if not override then
				override = {}
			end
			override.min = override.min or G.GAME.modifiers.cry_misprint_min or 1
			override.max = override.max or G.GAME.modifiers.cry_misprint_max or 1
			override.min = override.min * G.GAME.modifiers.cry_jkr_misprint_mod
			override.max = override.max * G.GAME.modifiers.cry_jkr_misprint_mod
		end
		if G.GAME.modifiers.cry_misprint_min or override and override.min then
			Cryptid.misprintize_tbl(
				card.config.center_key,
				card,
				"ability",
				nil,
				override,
				stack,
				Cryptid.is_card_big(card)
			)
			if card.base then
				Cryptid.misprintize_tbl(
					card.config.card_key,
					card,
					"base",
					nil,
					override,
					stack,
					Cryptid.is_card_big(card)
				)
			end
		end
		if G.GAME.modifiers.cry_misprint_min then
			--card.cost = cry_format(card.cost / Cryptid.log_random(pseudoseed('cry_misprint'..G.GAME.round_resets.ante),override and override.min or G.GAME.modifiers.cry_misprint_min,override and override.max or G.GAME.modifiers.cry_misprint_max),"%.2f")
			card.misprint_cost_fac = 1
				/ Cryptid.log_random(
					pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
					override and override.min or G.GAME.modifiers.cry_misprint_min,
					override and override.max or G.GAME.modifiers.cry_misprint_max
				)
			card:set_cost()
		end
	else
		Cryptid.misprintize_tbl(card.config.center_key, card, "ability", true, nil, nil, Cryptid.is_card_big(card))
	end
	if card.ability.consumeable then
		for k, v in pairs(card.ability.consumeable) do
			card.ability.consumeable[k] = Cryptid.deep_copy(card.ability[k])
		end
	end
end
function Cryptid.log_random(seed, min, max)
	math.randomseed(seed)
	local lmin = math.log(min, 2.718281828459045)
	local lmax = math.log(max, 2.718281828459045)
	local poll = math.random() * (lmax - lmin) + lmin
	return math.exp(poll)
end
function cry_format(number, str)
	if math.abs(to_big(number)) >= to_big(1e300) then
		return number
	end
	return tonumber(str:format((Big and to_number(to_big(number)) or number)))
end
--use ID to work with glitched/misprint
function Card:get_nominal(mod)
	local mult = 1
	local rank_mult = 1
	if mod == "suit" then
		mult = 1000000
	end
	if self.ability.effect == "Stone Card" or (self.config.center.no_suit and self.config.center.no_rank) then
		mult = -10000
	elseif self.config.center.no_suit then
		mult = 0
	elseif self.config.center.no_rank then
		rank_mult = 0
	end
	return 10 * (self.base.id or 0.1) * rank_mult
		+ self.base.suit_nominal * mult
		+ (self.base.suit_nominal_original or 0) * 0.0001 * mult
		+ 10 * self.base.face_nominal * rank_mult
		+ 0.000001 * self.unique_val
end

SMODS.Joker {
    name = "Naminé",
    key = "namine",
    atlas = 'KHJokers',
    pos = { x = 3, y = 2 },
    cost = 6,
    rarity = 3,
    blueprint_compat = false,
    eternal = false,
    perishable = false,
    config = { extra = { jokerMult = 2 } },

    loc_txt = {
    },

    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = "kh_perishable", set = "Other"}
		info_queue[#info_queue+1] = {key = "kh_unstackable", set = "Other"}
        return { vars = { center.ability.extra.jokerMult } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and G.GAME.blind.boss and not context.repetition then
            local target = G.jokers.cards[1]
            if target and target ~= card and not Card.no(target, "immutable", true) and not target.ability.perishable then
                Cryptid.with_deck_effects(target, function(c)
                    Cryptid.misprintize(c, {
                        min = card.ability.extra.jokerMult,
                        max = card.ability.extra.jokerMult
                    }, nil, true)
                end)
				
				SMODS.Stickers["perishable"]:apply(target, true)
				
				--if target.ability.eternal then
					--target.ability.eternal = false
				--end
				
                card_eval_status_text(
                    context.blueprint_card or card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                )
            end
        end
    end
}


--]]
