SMODS.ConsumableType {
    key = "Drive",
    collection_rows = { 3, 3 },
    primary_colour = HEX("fda302"),
    secondary_colour = HEX("c88000"),
    loc_txt = {
        collection = "Drive Cards",
        label = "Drive",
        name = "Drive",
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        },
    },
}

SMODS.UndiscoveredSprite {
    key = "Drive",
    pos = { x = 1, y = 2 },
    no_overlay = true,
    overlay_pos = { x = 2, y = 2 },
    atlas = "KHDrive",

}
SMODS.Consumable {
    set = "Drive",
    name = "Valor Form",
    key = "valorform",
    pos = { x = 1, y = 1 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_valorform = (G.GAME.kh_valorform or 0) + 4
    end,
}

SMODS.Consumable {
    set = "Drive",
    name = "Wisdom Form",
    key = "wisdomform",
    pos = { x = 1, y = 0 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind and not G.GAME.kh_wisdomform
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_wisdomform = true
    end,
}

SMODS.Consumable {
    set = "Drive",
    name = "Limit Form",
    key = "limitform",
    pos = { x = 2, y = 1 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_limitform = (G.GAME.kh_limitform or 0) + 30
    end,
}

SMODS.Consumable {
    set = "Drive",
    name = "Master Form",
    key = "masterform",
    pos = { x = 0, y = 0 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_masterform = (G.GAME.kh_masterform or 1) * 2
    end,
}

SMODS.Consumable {
    set = "Drive",
    name = "Final Form",
    key = "finalform",
    pos = { x = 2, y = 0 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_finalform = (G.GAME.kh_finalform or 1) * 2
    end,
}

SMODS.Consumable {
    set = "Drive",
    name = "Anti Form",
    key = "antiform",
    pos = { x = 0, y = 1 },
    cost = 3,
    atlas = "KHDrive",
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind and not G.GAME.kh_antiform
    end,
    use = function(self, card, area, copier)
        G.GAME.kh_antiform = true
    end,
}

KH.calculate = function(self, context)
    if context.modify_hand and G.GAME.kh_wisdomform then
        local old_mult = mult
        local old_chips = hand_chips
        mult = mod_mult(old_chips)
        hand_chips = mod_chips(old_mult)
        update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })

        G.GAME.kh_wisdomform = false
    end

    if context.modify_hand and G.GAME.kh_finalform then
        local final_double = (G.GAME.kh_finalform or 1)
        local old_mult = mult
        local old_chips = hand_chips

        if final_double > 1 then
            mult = mod_mult(old_mult * final_double)
            hand_chips = mod_chips(old_chips * final_double)

            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end

        G.GAME.kh_finalform = 1
    end

    local valor_mult = G.GAME.kh_valorform or 0
    local limit_chips = G.GAME.kh_limitform or 0
    local master_xmult = G.GAME.kh_masterform or 1

    if context.modify_hand and (limit_chips > 0 or valor_mult > 0 or master_xmult > 1) then
        G.GAME.kh_valorform = 0
        G.GAME.kh_limitform = 0
        return {
            chips = (limit_chips > 0) and limit_chips or nil,
            mult = (valor_mult > 0) and valor_mult or nil,
        }
    end

    if context.final_scoring_step and (G.GAME.kh_antiform or master_xmult > 1) then
        local balala = G.GAME.kh_antiform
        G.GAME.kh_antiform = false
        G.GAME.kh_masterform = 1
        return {
            balance = balala or nil,
            x_mult = (master_xmult > 0) and master_xmult or nil,
        }
    end
end
