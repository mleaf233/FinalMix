local jd_def = JokerDisplay.Definitions

jd_def["j_kh_lethimcook"] = {
    text = {
        { text = "<-- ",                           colour = G.C.UI.TEXT_INACTIVE },
        { ref_table = "card.joker_display_values", ref_value = "left",           colour = G.C.RED },
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "right", colour = G.C.RED },
        { text = " -->" }
    },

    calc_function = function(card)
        card.joker_display_values       = card.joker_display_values or {}

        -- Default both to incompatible
        card.joker_display_values.left  = localize("k_incompatible")
        card.joker_display_values.right = localize("k_incompatible")

        if G.jokers and G.jokers.cards then
            local pos = XIII.get_pos(card, G.jokers.cards)

            -- Left Joker
            local left = G.jokers.cards[pos - 1]
            if left and left ~= card then
                local left_compat = XIII.compat_check(card, left)
                card.joker_display_values.left = left_compat and localize("k_compatible") or localize("k_incompatible")
            end

            -- Right Joker
            local right = G.jokers.cards[pos + 1]
            if right and right ~= card then
                local right_compat = XIII.compat_check(card, right)
                card.joker_display_values.right = right_compat and localize("k_compatible") or localize("k_incompatible")
            end
        end
    end,


    style_function = function(card, text, reminder_text, extra)
        if text and text.children then
            for _, child in ipairs(text.children) do
                if child.config and child.config.ref_value then
                    local val = card.joker_display_values and card.joker_display_values[child.config.ref_value]
                    if val == localize("k_compatible") then
                        child.config.colour = G.C.GREEN
                    else
                        child.config.colour = G.C.RED
                    end
                end
            end
        end
        if reminder_text and reminder_text.children then
            for _, child in ipairs(reminder_text.children) do
                if child.config and child.config.ref_value then
                    local val = card.joker_display_values and card.joker_display_values[child.config.ref_value]
                    if val == localize("k_compatible") then
                        child.config.colour = G.C.GREEN
                    else
                        child.config.colour = G.C.RED
                    end
                end
            end
        end
        return false
    end,
}

jd_def["j_kh_lethimcook_alt"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    }
}


-- Sora
jd_def["j_kh_sora"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("Hearts", 'suits_plural')
    end
}

-- Riku
jd_def["j_kh_riku"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "most_played", colour = G.C.CHIPS }
    },

    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "counter" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "total" },
        { text = ")" },
    },
    calc_function = function(card)
        local _handname, _played, _order = 'High Card', -1, 100
        for k, v in pairs(G.GAME.hands) do
            if v.played > _played or (v.played == _played and _order > v.order) then
                _played = v.played
                _handname = k
            end
        end
        card.ability.extra.most_played = _handname
        card.ability.extra.old_most_played = card.ability.extra.most_played
        card.joker_display_values.most_played = card.ability.extra.most_played
    end
}

-- Kairi/Namine
jd_def["j_kh_kairi"] = {

    text = {
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT },

    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", },
        { text = "," },
        { ref_table = "card.joker_display_values", ref_value = "localised_text", },
    },
    calc_function = function(card)
        local chips = card.ability.extra.chips or 0
        local mult = card.ability.extra.mult or 0

        card.joker_display_values.chips = (chips >= 0 and "+" or "") .. tostring(chips)
        card.joker_display_values.mult = (mult >= 0 and "+" or "") .. tostring(mult)

        local side = card.ability.extra.side
        card.joker_display_values.localized_text = side == "B" and "Dark Suits" or "Light Suits"
        card.joker_display_values.localised_text = side == "B" and "Mult" or "Chips"
    end,
    style_function = function(card, text, reminder_text, extra)
        local side = card.ability.extra.side

        if reminder_text and reminder_text.children then
            for _, child in ipairs(reminder_text.children) do
                if child.config and child.config.ref_value then
                    if child.config.ref_value == "localized_text" then
                        child.config.colour = (side == "B") and G.C.BLUE or G.C.SUITS.Diamonds
                    elseif child.config.ref_value == "localised_text" then
                        child.config.colour = (side == "B") and G.C.MULT or G.C.CHIPS
                    end
                end
            end
        end

        return false
    end
}

-- Roxas
jd_def["j_kh_roxas"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
    },

    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit_count" },
        { text = " suits",                         scale = 0.35, },
        { text = ")" },
    },

    calc_function = function(card)
        local d = card.joker_display_values
        local extra = card.ability.extra

        -- Default values
        d.chips = extra.total_chips
        d.suit_count = 0

        -- Try to evaluate upcoming or last scoring hand
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        if scoring_hand then
            local suits = {}
            for _, v in ipairs(scoring_hand) do
                if v.base and v.base.suit then
                    suits[v.base.suit] = true
                end
            end

            local unique_suits = 0
            for _ in pairs(suits) do
                unique_suits = unique_suits + 1
            end

            d.suit_count = unique_suits
        end

        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[1] and reminder_text.children[2] and reminder_text.children[3] and reminder_text.children[4] then
            reminder_text.children[1].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
            reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
            reminder_text.children[3].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
            reminder_text.children[4].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
        end
        return false
    end
}
-- Bryce the Nobody
jd_def["j_kh_brycethenobody"] = {

    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
    },

    reminder_text = {
        { text = "(" },

        { ref_table = "card.joker_display_values", ref_value = "bryce_card_suit" },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.mult = card.ability.extra.mult
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
        card.joker_display_values.bryce_card_suit = localize(G.GAME.current_round.kh_bryce_card.suit,
            'suits_singular')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.current_round.kh_bryce_card.suit], 0.35)
        end
        return false
    end
}

--Axel
jd_def["j_kh_axel"] = {
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "compatibility", colour = G.C.RED },
        { text = ")" },
    },

    reminder_text = {
        { text = "(Boss Blind)" }
    },

    calc_function = function(card)
        local target = G.jokers.cards[1]
        local compatible = XIII.compat_check(card, target) and not target.ability.perishable

        if target and target ~= card then
            card.joker_display_values.compatibility = compatible and localize('k_compatible') or
                localize('k_incompatible')
        else
            card.joker_display_values.compatibility = localize('k_incompatible')
        end
    end,

    style_function = function(card, text, reminder_text, extra)
        if text and text.children then
            for _, child in ipairs(text.children) do
                if child.config and child.config.ref_value == "compatibility" then
                    local val = card.joker_display_values.compatibility
                    if val == localize("k_compatible") then
                        child.config.colour = G.C.GREEN
                    else
                        child.config.colour = G.C.RED
                    end
                end
            end
        end
        return false
    end,
}

-- Xigbar
jd_def["j_kh_xigbar"] = {

    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult" }
            }
        }
    },

    calc_function = function(card)
    end

}

-- Mickey
jd_def["j_kh_mickey"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds2" },
            { text = ")" },
        }
    },

    extra_config = { colour = G.C.GREEN, scale = 0.3 },

    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
        card.joker_display_values.odds2 = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds2 } }
    end,
}

-- invitation
jd_def["j_kh_invitation"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },

    extra_config = { colour = G.C.GREEN, scale = 0.3 },

    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
    end,
}

-- Donald
jd_def["j_kh_donald"] = {

    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "copied_name",
            colour = G.C.ATTENTION,
        }
    },

    calc_function = function(card)
        local copied_joker_key = card.ability.extra.copied_joker_key
        local copied_name = "[None]"

        if G.jokers then
            local copied_joker = XIII.get_joker_by_key(G.jokers.cards, copied_joker_key)
            if copied_joker then
                copied_name = copied_joker.config.center.name or "None"
            end
        end

        card.joker_display_values.copied_name = copied_name
    end
}

-- Goofy
jd_def["j_kh_goofy"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            },
            colour = G.C.MULT
        },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "dollars", colour = G.C.MONEY, },
    },

    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT, },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
    },

    calc_function = function(card)
        local extra = card.ability.extra
        card.joker_display_values.mult = string.format("+%d", extra.mult)
        card.joker_display_values.chips = string.format("+%d", extra.chips)
        card.joker_display_values.dollars = string.format("+$%d", extra.dollars)
    end,
}

-- Master Yen Sid
jd_def["j_kh_disney"] = {

    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },

    extra_config = { colour = G.C.GREEN, scale = 0.3 },

    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
    end,
}

-- Keyblade
jd_def["j_kh_keyblade"] = {

    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }
    },

    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "keyblade_card", scale = 0.35 },
        { text = ")" },
    },

    calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local keyblade_eval = #scoring_hand == 1 and scoring_hand[1]:get_id() == G.GAME.current_round.keyblade_rank.id
        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
        card.joker_display_values.count = keyblade_eval and 1 or 0

        card.joker_display_values.keyblade_card = localize(G.GAME.current_round.keyblade_rank.rank, 'ranks')
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] then
            text.children[1].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
            text.children[2].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
                G.C.UI.TEXT_INACTIVE
        end
        return false
    end
}


-- Paopu Fruit
jd_def["j_kh_paopufruit"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "hands_left" },
        { text = ")" },
    },
}

-- Nobody
jd_def["j_kh_nobody"] = {

    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },

    extra_config = { colour = G.C.GREEN, scale = 0.3 },

    calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
    end,
}

-- Moogle
jd_def["j_kh_moogle"] = {

    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "joker_count",
            scale = 0.40,
            colour = G.C.MONEY,
        }
    },

    reminder_text = {
        { text = "(Round)" }
    },

    calc_function = function(card)
        local joker_count = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    joker_count = joker_count + 1
                end
            end
        end
        card.joker_display_values.joker_count = string.format("+$%d", card.ability.extra.dollars * joker_count)
    end
}

-- Gummi Phone
jd_def["j_kh_chipanddale"] = {

    text = {
        { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "old_hand_chips", colour = G.C.CHIPS }
    },

    calc_function = function(card)
        local mult = card.ability.extra.mult
        card.joker_display_values.mult = (mult >= 0 and "+" or "") .. tostring(mult)
        card.joker_display_values.old_hand_chips = card.ability.extra.old_hand_chips
    end

}

-- Luxord
jd_def["j_kh_luxord"] = {

    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "cap",   colour = G.C.UI.ATTENTION },
        { text = ")" },
    },
    reminder_text = {
        { text = "(Round)" },
    },
    calc_function = function(card)
        card.joker_display_values.chips = string.format("+%d", card.ability.extra.chips)
        card.joker_display_values.cap = tostring(card.ability.extra.cap)
    end,
}

-- Disc Trilogy
jd_def["j_kh_khtrilogy"] = {

    text = {
        { ref_table = "card.joker_display_values", ref_value = "value", colour = G.C.CHIPS }
    },

    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "open" },
        { ref_table = "card.joker_display_values", ref_value = "counter" },
        { ref_table = "card.joker_display_values", ref_value = "slash" },
        { ref_table = "card.joker_display_values", ref_value = "total" },
        { ref_table = "card.joker_display_values", ref_value = "close" },
    },

    calc_function = function(card)
        local d = card.joker_display_values
        local extra = card.ability.extra
        d.value = ""

        if extra.level == 1 then
            d.value = string.format("+%d", extra.chips)
        elseif extra.level == 2 then
            d.value = string.format("+%d", extra.mult)
        elseif extra.level == 3 then
            d.prefix = ""
            d.value = "X" .. tostring(extra.xmult or 0)
        end

        if extra.level == 1 then
            d.counter = tostring(extra.counter or 0)
            d.total = tostring(extra.total or 0)
            d.open = "("
            d.close = ")"
            d.slash = "/"
        elseif extra.level == 2 then
            d.counter = ""
            d.total = ""
            d.open = "("
            d.close = ")"
            d.slash = tostring(extra.discards_remaining or 0)
        else
            d.counter = ""
            d.total = ""
            d.slash = "Max"
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        -- Adjust value color depending on level
        local level = card.ability.extra.level or 1
        if text and text.children and #text.children >= 1 then
            local colour = (level == 1 and G.C.CHIPS) or
                (level == 2 and G.C.RED) or
                (level == 3 and G.C.XMULT)
            text.children[1].config.colour = colour
        end
        return false
    end
}

-- Help Wanted!
jd_def["j_kh_helpwanted"] = {

    text = {
        { ref_table = "card.joker_display_values", ref_value = "task_desc", colour = G.C.BLUE },
    },

    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "progress", colour = G.C.UI.TEXT_INACTIVE },
    },

    calc_function = function(card)
        local task = card.ability.current_task
        local prog = card.ability.progress or 0
        local task_desc = "loading..."
        local progress = "loading..."

        if task == "play_face" then
            task_desc = "Grand Stander"
            progress = "(" .. prog .. "/7)"
        elseif task == "drawing" then
            task_desc = "Cargo Climb"
            progress = "(" .. prog .. "/20)"
        elseif card.ability.current_task == "shopping" then
            task_desc = "Poster Duty"
            progress = "($" .. prog .. "/20)"
        end

        card.joker_display_values.task_desc = task_desc
        card.joker_display_values.progress = progress
    end,
}


jd_def["j_kh_munnypouch"] = {

    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "sell_cost",
            scale = 0.40,
            colour = G.C.MONEY,
        }
    },

    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.RED, scale = 0.3 },

    calc_function = function(card)
        card.joker_display_values.sell_cost = string.format("+$%d", card.sell_cost)

        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
    end
}

jd_def["j_kh_munny"] = {

    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "dollars",
            scale = 0.40,
            colour = G.C.MONEY,
        }
    },

    reminder_text = {
        { text = "(Round)" }
    },

    calc_function = function(card)
        card.joker_display_values.dollars = string.format("+$%d", card.ability.extra.dollars)
    end
}

jd_def["j_kh_tamagotchi"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    }
}

jd_def["j_kh_magnet"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { text = "(" },
        { text = "Steel Card" },
        { text = ")" },
    },
    calc_function = function(card)
        local dollars = 0
        local playing_hand = next(G.play.cards)
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card.ability.name and playing_card.ability.name == 'Steel Card' then
                    dollars = dollars +
                        3 * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.dollars = dollars
    end
}

jd_def["j_kh_kingdomhearts"] = {

    text = {
        { ref_table = "card.joker_display_values", ref_value = "discards", colour = G.C.MULT },
        { text = "Discards" },
    },
    reminder_text = {
        { text = "(" },
        { text = "Boss Blind" },
        { text = ")" },
    },

    calc_function = function(card)
        card.joker_display_values.hands = card.ability.extra.hands_remaining
        card.joker_display_values.discards = card.ability.extra.discards_remaining
    end

}

-- Chain of Memories
jd_def["j_kh_com"] = {
    text = {
        {
            border_nodes = {
                { ref_table = "card.ability.extra", ref_value = "old_hand_chips" }
            },
            border_colour = G.C.CHIPS
        },
        { text = " X " },
        {
            border_nodes = {
                { ref_table = "card.ability.extra", ref_value = "old_hand_mult" }
            },
        },
    },

    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "last_played", colour = G.C.UI.TEXT_INACTIVE, },
        { text = ")" },
    },

    calc_function = function(card)
    end,
}
