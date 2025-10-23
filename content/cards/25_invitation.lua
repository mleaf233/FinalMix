SMODS.Joker {
    name = 'Invitation',
    key = "invitation",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.sold,
                card.ability.extra.sold_remaining
            }
        }
    end,

    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 2, y = 5 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            dollars = 1,
            sold = 3,
            sold_remaining = 3,
        }
    },

    update = function(self, card)
    end,
    calculate = function(self,card,context)
        if context.selling_card then
            if context.card.ability.set == 'Joker' then
                card.ability.extra.sold_remaining = card.ability.extra.sold_remaining - 1
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex') })
            end
            if card.ability.extra.sold_remaining <= 0 then
                card.ability.extra.sold_remaining = card.ability.extra.sold
                      G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Joker',
                                edition = 'e_negative',
                                stickers = { "perishable" },
                                force_stickers = true
                            }
                            return true
                        end
                    }))      
            end 
            return {
                dollars = card.ability.extra.dollars
            }    


        end
    end
}
