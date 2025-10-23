local function reset_keyblade_rank()
    G.GAME.current_round.keyblade_rank = { rank = 'Seven', }
    local valid_keyblade_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_keyblade_cards[#valid_keyblade_cards + 1] = playing_card
        end
    end
    local keyblade_card = pseudorandom_element(valid_keyblade_cards, 'cloudzXIII' .. G.GAME.round_resets.ante)
    if keyblade_card then
        G.GAME.current_round.keyblade_rank.rank = keyblade_card.base.value
        G.GAME.current_round.keyblade_rank.id = keyblade_card.base.id
    end
end


local function reset_kh_bryce_card()
    G.GAME.current_round.kh_bryce_card = G.GAME.current_round.kh_bryce_card or { suit = 'Hearts' }
    local bryce_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.kh_bryce_card.suit then bryce_suits[#bryce_suits + 1] = v end
    end
    local bryce_card = pseudorandom_element(bryce_suits, 'kh_bryce' .. G.GAME.round_resets.ante)
    G.GAME.current_round.kh_bryce_card.suit = bryce_card
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_kh_bryce_card()
    reset_keyblade_rank()
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local ret = use_and_sell_buttonsref(card)


    if card.area ~= G.pack_cards and card.config and card.config.center_key == 'j_kh_helpwanted' then
        local kh_reroll_button = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = { card },
                        align = "cr",
                        maxw = 1.25,
                        padding = 0.1,
                        r = 0.08,
                        minw = 1.25,
                        hover = true,
                        shadow = true,
                        colour = G.C.RED,
                        button = 'kh_reroll',
                        func = "kh_can_reroll",
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "REROLL",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4,
                                                shadow = true
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "$",
                                                colour = G.C.WHITE,
                                                scale = 0.4,
                                                shadow = true
                                            }
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "4",
                                                colour = G.C.WHITE,
                                                scale = 0.55,
                                                shadow = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        ret.nodes[1].nodes[2].nodes = ret.nodes[1].nodes[2].nodes or {}
        table.insert(ret.nodes[1].nodes[2].nodes, kh_reroll_button)
    end

    return ret
end
