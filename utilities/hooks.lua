-- Main Menu Logo
if KH.config.menu_toggle then
    local oldfunc = Game.main_menu
    Game.main_menu = function(change_context)
        local ret = oldfunc(change_context)

        -- logo
        local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)
        G.SPLASH_KH_LOGO = Sprite(0, 0,
            6 * SC_scale,
            6 * SC_scale * (G.ASSET_ATLAS["kh_logo"].py / G.ASSET_ATLAS["kh_logo"].px),
            G.ASSET_ATLAS["kh_logo"], { x = 0, y = 0 }
        )
        G.SPLASH_KH_LOGO:set_alignment({
            major = G.title_top,
            type = 'cm',
            bond = 'Strong',
            offset = { x = 4, y = 3 }
        })
        G.SPLASH_KH_LOGO:define_draw_steps({ {
            shader = 'dissolve',
        } })

        G.SPLASH_KH_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }

        G.SPLASH_KH_LOGO.dissolve_colours = { G.C.WHITE, G.C.WHITE }
        G.SPLASH_KH_LOGO.dissolve = 1

        G.SPLASH_KH_LOGO.states.collide.can = true

        function G.SPLASH_KH_LOGO:click()
            play_sound('button', 1, 0.3)
            G.FUNCS['openModUI_kingdomhearts']()
        end

        function G.SPLASH_KH_LOGO:hover()
            G.SPLASH_KH_LOGO:juice_up(0.05, 0.03)
            play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
            Node.hover(self)
        end

        function G.SPLASH_KH_LOGO:stop_hover() Node.stop_hover(self) end

        --Logo animation
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1,
            blockable = false,
            blocking = false,
            func = (function()
                play_sound('magic_crumple' .. (change_context == 'splash' and 2 or 3),
                    (change_context == 'splash' and 1 or 1.3), 0.9)
                play_sound('whoosh1', 0.2, 0.8)
                ease_value(G.SPLASH_KH_LOGO, 'dissolve', -1, nil, nil, nil,
                    change_context == 'splash' and 2.3 or 0.9)
                G.VIBRATION = G.VIBRATION + 1.5
                return true
            end)
        }))

        return ret
    end
end

-- Extra Buttons on Jokers (Check functions.lua for what the button actually does)
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

-- Munny Magnet, Steel cards shuffled to the top of deck
local shuffle_ref = CardArea.shuffle
function CardArea:shuffle(_seed)
    local g = shuffle_ref(self, _seed)
    if self == G.deck then
        local priorities = {}
        local others = {}
        for k, v in pairs(self.cards) do
            if next(SMODS.find_card("j_kh_magnet")) and SMODS.has_enhancement(v, "m_steel") then
                table.insert(priorities, v)
            else
                table.insert(others, v)
            end
        end
        for _, card in ipairs(priorities) do
            table.insert(others, card)
        end
        self.cards = others
        self:set_ranks()
    end
    return g
end

-- Extra Skip button in blind selection
G.FUNCS.skip_blind_alt = function(e)
    stop_use()
    G.CONTROLLER.locks.skip_blind = true
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        trigger = 'after',
        blocking = false,
        blockable = false,
        delay = 2.5,
        timer = 'TOTAL',
        func = function()
            G.CONTROLLER.locks.skip_blind = nil
            return true
        end
    }))

    local _tag = e.UIBox:get_UIE_by_ID('tag_container_alt')
    G.GAME.skips = (G.GAME.skips or 0) + 1
    if _tag then
        add_tag(_tag.config.ref_table)
        local skipped, skip_to = G.GAME.blind_on_deck or 'Small',
            G.GAME.blind_on_deck == 'Small' and 'Big' or G.GAME.blind_on_deck == 'Big' and 'Boss' or 'Boss'
        G.GAME.round_resets.blind_states[skipped] = 'Skipped'
        G.GAME.round_resets.blind_states[skip_to] = 'Select'
        G.GAME.blind_on_deck = skip_to
        play_sound('generic1')
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                delay(0.3)
                SMODS.calculate_context({ skip_blind = true })
                save_run()
                for i = 1, #G.GAME.tags do
                    G.GAME.tags[i]:apply_to_run({ type = 'immediate' })
                end
                for i = 1, #G.GAME.tags do
                    if G.GAME.tags[i]:apply_to_run({ type = 'new_blind_choice' }) then break end
                end
                return true
            end
        }))
    end
end


-- Misc Joker stuff

local function reset_keyblade_rank()
    G.GAME.current_round.keyblade_rank = { rank = 'Seven', }
    local valid_keyblade_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_keyblade_cards[#valid_keyblade_cards + 1] = playing_card
        end
    end
    local keyblade_card = pseudorandom_element(valid_keyblade_cards, 'j_kh_keyblade' .. G.GAME.round_resets.ante)
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
    local bryce_card = pseudorandom_element(bryce_suits, 'j_kh_bryce' .. G.GAME.round_resets.ante)
    G.GAME.current_round.kh_bryce_card.suit = bryce_card
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_kh_bryce_card()
    reset_keyblade_rank()
end

-- Credits to Bluelatro for the function!
-- After playing a hand, cards marked with `card.finalmix_return_to_hand` are returned to hand instead
G.FUNCS.draw_from_play_to_discard = function(e)
    local play_count = #G.play.cards
    local i = 1
    for _, card in ipairs(G.play.cards) do
        if (not card.shattered) and not card.destroyed then
            if card.finalmix_return_to_hand then
                card.finalmix_return_to_hand = nil
                draw_card(G.play, G.hand, i * 100 / play_count, "up", true, card)
            else
                draw_card(G.play, G.discard, i * 100 / play_count, "down", false, card)
            end
            i = i + 1
        end
    end
end

-- used for XIII.send_to_room

local toggle_shop_ref = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    if G.GAME.kh.moogle_shop then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                G.GAME.kh.moogle_shop = false
                return true
            end,
        }))
    end
    return toggle_shop_ref(e)
end

local update_shop_ref = Game.update_shop
function Game:update_shop(dt)
    if G.GAME.kh.moogle_shop and G.STATE_COMPLETE and G.shop then
        G.shop.alignment.offset.y = -5.3
    end
    return update_shop_ref(self, dt)
end
