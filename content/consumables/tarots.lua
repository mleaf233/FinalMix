SMODS.Tag {
    key = "kingdom",
    atlas = "modicon",
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local joker_keys = XIII.get_resource_with_prefix("j_kh_")

            for i = #joker_keys, 1, -1 do
                if joker_keys[i] == "j_kh_nobody" or joker_keys[i] == "j_kh_munny" then
                    table.remove(joker_keys, i)
                end
            end

            local owned_jokers = {}
            for _, j in ipairs(G.jokers.cards) do
                owned_jokers[j.config.center.key] = true
            end

            local available_jokers = {}
            for _, key in ipairs(joker_keys) do
                if not owned_jokers[key] then
                    table.insert(available_jokers, key)
                end
            end

            local random_joker = pseudorandom_element(available_jokers, pseudoseed("KH_RareTag"))

            if random_joker then
                local card = SMODS.create_card {
                    set = "Joker",
                    key = random_joker,
                    area = context.area,
                }
                create_shop_card_ui(card, 'Joker', context.area)
                card.states.visible = false

                tag:yep('+', G.C.PURPLE, function()
                    play_sound('timpani')
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_cost()
                    return true
                end)
                tag.triggered = true
                return card
            else
                tag:nope()
            end
        end
    end
}

SMODS.Tarot {
    key = 'awakening',
    set = 'Tarot',
    atlas = "KHConsumeables",
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,

    use = function(self, card, area, copier)
        local used_card = copier or card
        local joker_keys = XIII.get_resource_with_prefix("j_kh_")

        for i = #joker_keys, 1, -1 do
            if joker_keys[i] == "j_kh_nobody" or joker_keys[i] == "j_kh_munny" then
                table.remove(joker_keys, i)
            end
        end

        local owned_jokers = {}
        for _, j in ipairs(G.jokers.cards) do
            owned_jokers[j.config.center.key] = true
        end

        local available_jokers = {}
        for _, key in ipairs(joker_keys) do
            if not owned_jokers[key] then
                table.insert(available_jokers, key)
            end
        end

        local random_joker = pseudorandom_element(available_jokers, pseudoseed("KHTarots"))

        if random_joker then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({ key = random_joker, set = 'Joker' })
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end

        delay(0.6)
    end,

    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}
