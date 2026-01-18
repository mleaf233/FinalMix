if Blockbuster then
    SMODS.Joker {
        name = 'Axel',
        key = 'axel',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = { key = "kh_perishable", set = "Other" }
            info_queue[#info_queue + 1] = { key = "kh_unstackable", set = "Other" }

            if card.area == G.jokers then
                local target = G.jokers.cards[1]
                local compatible = XIII.compat_check(card, target)
                local main_end = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", minh = 0.4 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    ref_table = card,
                                    align = "m",
                                    colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or
                                        mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
                                    r = 0.05,
                                    padding = 0.06
                                },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = ' ' ..
                                                localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ',
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.256
                                        }
                                    },
                                }
                            }
                        }
                    }
                }
                return { vars = {}, main_end = main_end }
            end

            return { vars = {} }
        end,

        rarity = 3,
        atlas = 'KHJokers',
        pos = { x = 4, y = 2 },
        cost = 10,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = true,

        config = {
            extra = {
                value = 2
            }
        },

        calculate = function(self, card, context)
            if context.end_of_round and context.beat_boss and context.cardarea == G.jokers and not context.individual and not context.repetition and not context.blueprint then
                local target = G.jokers.cards[1]
                if not target or target == card or target.ability.perishable then
                    return
                end

                local compatible = XIII.compat_check(card, target) and not target.ability.perishable

                if compatible then
                    SMODS.Stickers["perishable"]:apply(target, true)
                    Blockbuster.manipulate_value(target, "j_kh_axel", card.ability.extra.value)
                end

                return {
                    message = compatible and localize("k_upgrade_ex") or localize("k_incompatible"),
                    colour = compatible and G.C.FILTER or G.C.RED,
                    card = card
                }
            end
        end
    }
else
    SMODS.Joker {
        name = 'Axel',
        key = 'axel_alt',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = { key = "kh_no_blockbuster", set = "Other" }
            info_queue[#info_queue + 1] = { key = "kh_axleffect", set = "Other" }
            if card.area == G.jokers then
                local target = G.jokers.cards[1]
                local compatible = not target.edition
                local main_end = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", minh = 0.4 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    ref_table = card,
                                    align = "m",
                                    colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or
                                        mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
                                    r = 0.05,
                                    padding = 0.06
                                },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = ' ' ..
                                                localize('k_' .. (compatible and 'compatible' or 'incompatible')) ..
                                                ' ',
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.256
                                        }
                                    },
                                }
                            }
                        }
                    }
                }
                return { vars = {}, main_end = main_end }
            end

            return { vars = {} }
        end,

        rarity = 3,
        atlas = 'KHJokers',
        pos = { x = 4, y = 2 },
        cost = 10,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = true,

        config = {
            extra = {
                value = 2
            }
        },

        calculate = function(self, card, context)
            if context.end_of_round and context.beat_boss and context.cardarea == G.jokers and not context.individual and not context.repetition and not context.blueprint then
                local target = G.jokers.cards[1]
                if not target or target == card then
                    return
                end

                local compatible = not target.edition

                if compatible then
                    local edition = poll_edition('kh_paopufruit', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
                    target:set_edition(edition, true)
                end

                return {
                    message = compatible and localize("k_upgrade_ex") or localize("k_incompatible"),
                    colour = compatible and G.C.FILTER or G.C.RED,
                    card = card
                }
            end
        end
    }
end
