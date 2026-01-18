SMODS.Voucher {
    key = 'moogleskip',
    atlas = "KHVouchers",
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
    end,
    redeem = function(self, card)
        G.GAME.kh.moogle_skip = true
    end
}

SMODS.Voucher {
    key = 'moogleshop',
    atlas = "KHVouchers",
    unlocked = true,
    discovered = true,
    pos = { x = 1, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
    end,
    requires = { 'v_kh_moogleskip' },
    calculate = function(self, card, context)
        if context.skip_blind then
            XIII.send_to_room(G.STATES.SHOP)
        end
    end
}
