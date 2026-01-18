-- Decks
SMODS.Back {
    key = 'kingdom',
    atlas = 'KHDecks',
    pos = { x = 2, y = 0 },
    discovered = true,
    config = { vouchers = { "v_overstock_norm" }, },
    loc_vars = function(self, info_queue, center)
    end,
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
    end
}

SMODS.Back {
    key = 'rechain',
    atlas = 'KHDecks',
    pos = { x = 1, y = 0 },
    discovered = true,
    config = { vouchers = { "v_kh_moogleskip" }, },
    loc_vars = function(self, info_queue, back)
    end,
    apply = function(self, back)
    end,
    calculate = function(self, back, context)

    end
}
