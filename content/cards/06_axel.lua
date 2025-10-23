Exclude_list = { -- List of incompatible Jokers
    ["Astronomer"] = true,
    ["Axel"] = true,
    ["Blueprint"] = true,
    ["Brainstorm"] = true,
    ["Burnt Joker"] = true,
    ["Business Card"] = true,
    ["Cartomancer"] = true,
    ["Castle"] = true,
    ["Ceremonial Dagger"] = true,
    ["Certificate"] = true,
    ["Chaos the Clown"] = true,
    ["Credit Card"] = true,
    ["DNA"] = true,
    ["Diet Cola"] = true,
    ["Donald"] = true,
    ["Drunkard"] = true,
    ["Dusk"] = true,
    ["Flash Card"] = true,
    ["Four Fingers"] = true,
    ["Fortune Teller"] = true,
    ["Hallucination"] = true,
    ["Invisible Joker"] = true,
    ["Joker Stencil"] = true,
    ["Juggler"] = true,
    ["Keyblade"] = true,
    ["Luchador"] = true,
    ["Marble Joker"] = true,
    ["Merry Andy"] = true,
    ["Midas Mask"] = true,
    ["Mime"] = true,
    ["Mr. Bones"] = true,
    ["Munny"] = true,
    ["Munny Pouch"] = true,
    ["Oops! All 6s"] = true,
    ["Pareidolia"] = true,
    ["Perkeo"] = true,
    ["Raised Fist"] = true,
    ["Riff Raff"] = true,
    ["Rough Gem"] = true,
    ["Seance"] = true,
    ["Seal Salt Ice Cream"] = true,
    ["Shoot the Moon"] = true,
    ["Shortcut"] = true,
    ["Sixth Sense"] = true,
    ["Smeared Joker"] = true,
    ["Sock and Buskin"] = true,
    ["Showman"] = true,
    ["Splash"] = true,
    ["Supernova"] = true,
    ["Superposition"] = true,
    ["Swashbuckler"] = true,
    ["Troubadour"] = true,
    ["Turtle Bean"] = true,
    ["Vagabond"] = true,
    ["Let Him Cook"] = true,

}

SMODS.Joker {
    name = 'Axel',
    key = 'axel',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "kh_perishable", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_unstackable", set = "Other" }

        if card.area == G.jokers then
            local target = G.jokers.cards[1]
            local compatible = target and target ~= card and not target.ability.perishable and
                not Exclude_list[target.ability.name]

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
        if context.end_of_round and G.GAME.blind.boss and context.cardarea == G.jokers and not context.individual and not context.repetition and not context.blueprint then
            local target = G.jokers.cards[1]
            if not target or target == card or target.ability.perishable then return end

            local name = target.ability.name
            local is_excluded = Exclude_list[name]

            local joker_rules = { -- do roxas
                ["Riku"] = { keywords = { levels = true }, unkeywords = { counter = true, total = true } },
                ["Loyalty Card"] = { unkeywords = { loyalty_remaining = true, every = true } },
                ["Caino"] = { unkeywords = { caino_xmult = true } },
                ["Yorick"] = { unkeywords = { yorick_discards = true, discards = true } },
                ["Wee Joker"] = { keywords = { chip_mod = true } },
                ["Stuntman"] = { keywords = { chip_mod = true } },
                ["Square Joker"] = { keywords = { chip_mod = true } },
                ["Runner"] = { keywords = { chip_mod = true } },
                ["Faceless Joker"] = { keywords = { dollars = true } },
                ["Roxas"] = { unkeywords = { discards_remaining = true, discards = true, chips = true } },
                ["Joker Menu"] = { unkeywords = { pos = true } },
                ["Kingdom Hearts"] = { keywords = { chips = true, mult = true, xmult = true } },
            }

            local rules = joker_rules[name] or {
                unkeywords = {
                    odds = true,
                    Xmult_mod = true,
                    mult_mod = true,
                    chips_mod = true,
                    hand_add = true,
                    discard_sub = true,
                    h_mod = true,
                    size = true,
                    chip_mod = true,
                    h_size = true,
                    increase = true
                }
            }

            XIII.funcs.mod_card_values(target.ability, {
                multiply = is_excluded and 1 or card.ability.extra.value,
                x_protect = true,
                keywords = rules.keywords,
                unkeywords = rules.unkeywords
            })

            if not is_excluded and not target.ability.perishable then
                SMODS.Stickers["perishable"]:apply(target, true)
            end

            return {
                message = is_excluded and localize("k_incompatible") or localize("k_upgrade_ex"),
                colour = is_excluded and G.C.RED or G.C.GREEN,
                card = card
            }
        end
    end
}
