SMODS.Joker {
    name = 'Half Face',
    key = 'xigbar',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,    --1
                card.ability.extra.Xmult_gain --2
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 1, y = 2 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            x_mult = 1,
            Xmult_gain = 0.2,
        }
    },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                v.scoring = true
            end

            for k, v in ipairs(context.full_hand) do
                if not v.scoring and v:is_face() then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.Xmult_gain
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.PURPLE,
                    })
                end
            end

            for k, v in ipairs(context.scoring_hand) do
                v.scoring = nil
            end
        end

        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end

}
