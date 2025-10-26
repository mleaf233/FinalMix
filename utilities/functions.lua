XIII = {
    funcs = {},
    REND = {}
}

-- Credits to Rofflatro and Rensnek for the doubling logic in the "Axel" Joker! Check them out!

local function should_modify_key(k, v, config, ref)
    local keywords = config.keywords
    local unkeywords = config.unkeywords or {}
    local x_protect = config.x_protect ~= false

    if unkeywords[k] then return false end
    if keywords and not keywords[k] then return false end
    if x_protect and ref[k] == 1 then
        if k:sub(1, 2) == "x_" or k:sub(1, 4) == "h_x_" then -- if k == "Xmult"
            return false
        end
    end
    return type(v) == "number"
end

XIII.funcs.mod_card_values = function(table_in, config)
    if not table_in then return end
    config = config or {}

    local add = config.add or 0
    local multiply = config.multiply or 1
    local reference = config.reference or table_in

    local function modify(t, ref)
        for k, v in pairs(t) do
            if type(v) == "table" and type(ref[k]) == "table" then
                modify(v, ref[k])
            elseif should_modify_key(k, v, config, ref) then
                t[k] = (ref[k] + add) * multiply
            end
        end
    end

    modify(table_in, reference)
end

XIII.funcs.xmult_playing_card = function(card, mult)
    local tablein = {
        nominal = card.base.nominal,
        ability = card.ability
    }

    XIII.funcs.mod_card_values(tablein, { multiply = mult })
    card.base.nominal = tablein.nominal
    card.ability = tablein.ability
end

-- Credit to Rensnek for these functions!

XIII.REND.starts_with = function(str, start)
    return str:sub(1, #start) == start
end

XIII.REND.table_contains = function(tbl, val)
    for _, v in pairs(tbl) do
        if v == val then return true end
    end
    return false
end

-- Function to get a Joker by its unique key from a list of Jokers. (Donald)
function GetJokerByKey(jokers, key)
    for _, joker in ipairs(jokers) do
        if joker.config.center.key == key then
            return joker
        end
    end
    return nil
end

function GetResourceWithPrefix(prefix)
    local results = {}
    for k, v in pairs(G.P_CENTERS) do
        if k:sub(1, #prefix) == prefix then
            table.insert(results, k)
        end
    end
    return results
end

-- Gets a random Poker Hand
function GetPokerHand()
    local poker_hands = {}
    local total_weight = 0
    for _, handname in ipairs(G.handlist) do
        if G.GAME.hands[handname].visible then
            local weight = G.GAME.hands[handname].played + 1
            total_weight = total_weight + weight
            poker_hands[#poker_hands + 1] = { handname, total_weight }
        end
    end

    local weight = pseudorandom("yensid") * total_weight
    local hand
    for _, h in ipairs(poker_hands) do
        if weight < h[2] then
            hand = h[1]
            break
        end
    end

    return hand
end

-- Function to create a consumable, currently unused
function CreateConsumable(joker, type, seed, key, message, colour)
    if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then -- checks space in consumable slots
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex")                                                   -- gives a "No Space!" message if there isn't any space
        })
        return
    end

    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = "before",
        delay = 0.0,
        func = function()
            local card = create_card(type, G.consumeables, nil, nil, nil, nil, key, seed)
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
            return true
        end
    }))

    card_eval_status_text(joker, "extra", nil, nil, nil, {
        message = localize(message),
        colour = colour
    })
end

-- Function to get a random poker hand name, excluding the specials (Currently unused)
function RandomPokerHand(card)
    local _poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and handname ~= 'Five of a Kind' and handname ~= 'Flush Five' and handname ~= 'Flush House' then
            _poker_hands[#_poker_hands + 1] = handname
        end
    end

    card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'kh_poker_hand' .. (card.round or 0))
end
