SMODS.Atlas({
    key = 'KHBlindSide',
    path = 'blindside.png',
    px = 71,
    py = 95
})

BLINDSIDE.Blind({
    key = 'crown',
    atlas = 'KHBlindSide',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
        }
    },
    hues = { "Faded" },
    basic = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            if card.ability.extra.upgraded then
            else
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})

BLINDSIDE.Blind({
    key = 'kingdom_hearts',
    atlas = 'KHBlindSide',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
        }
    },
    hues = { "Blue" },
    basic = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            if card.ability.extra.upgraded then
            else
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})

BLINDSIDE.Blind({
    key = 'keyhole',
    atlas = 'KHBlindSide',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
        }
    },
    hues = { "Faded" },
    basic = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            if card.ability.extra.upgraded then
            else
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})
