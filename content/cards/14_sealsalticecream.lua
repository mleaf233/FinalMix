SMODS.Joker {
    name = 'Seal Salt Ice Cream',
    key = "sealsalt",

    loc_vars = function(self, info_queue, card)
    end,

    rarity = 2,
    atlas = "KHJokers",
    pos = { x = 3, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
        }
    },

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local has_seal = false
            for _, c in ipairs(context.full_hand) do
                if c.seal then
                    has_seal = true
                    break
                end
            end

            if has_seal then
                local valid_cards = {}
                for _, c in ipairs(G.hand.cards) do
                    if not c.seal then
                        table.insert(valid_cards, c)
                    end
                end

                if #valid_cards > 0 then
                    local chosen = pseudorandom_element(valid_cards, pseudoseed("seal_salt"))
                    local random_seal = SMODS.poll_seal { key = "kh_seed", guaranteed = true }
                    chosen:set_seal(random_seal)

                    return {
                        message = "Sealed!",
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end,

    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.seal then
                return true
            end
        end
        return false
    end
}
