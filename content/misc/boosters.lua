SMODS.Booster {
    key = "drive_normal",
    weight = 0.6,
    kind = 'kh_Drive',
    cost = 4,
    atlas = "KHBoosters",
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = 2, choose = 1 },
    group_key = "k_drive_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            --key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        return { set = "Drive", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "kh_drive" }
    end,
}

SMODS.Booster {
    key = "drive_jumbo",
    weight = 0.6,
    kind = 'kh_Drive',
    cost = 6,
    atlas = "KHBoosters",
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = 4, choose = 1 },
    group_key = "k_drive_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        return { set = "Drive", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "kh_drive" }
    end,
}

SMODS.Booster {
    key = "drive_mega",
    weight = 0.6,
    kind = 'kh_Drive',
    cost = 8,
    atlas = "KHBoosters",
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = 5, choose = 2 },
    group_key = "k_drive_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        return { set = "Drive", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "kh_drive" }
    end,
}
