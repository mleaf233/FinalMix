CardSleeves.Sleeve {
    key        = 'kingdom',
    discovered = true,
    deck_buff  = 'b_kh_kingdom',
    atlas      = 'KHSleeves',
    pos        = { x = 0, y = 0 },

    loc_vars   = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_kh_kingdom" then
            key = self.key .. "_alt"
            self.config = { vouchers = { "v_overstock_plus" } }
            vars = { self.config.vouchers }
        else
            key = self.key
            self.config = { vouchers = { "v_overstock_norm" } }
            vars = { self.config.vouchers }
        end
        return { key = key, vars = vars }
    end,

    calculate  = function(self, sleeve, context)
    end
}

CardSleeves.Sleeve {
    key        = 'fairgame',
    discovered = true,
    deck_buff  = 'b_kh_kingdom',
    atlas      = 'KHSleeves',
    pos        = { x = 1, y = 0 },

    config     = {
        base = 1,
        odds = 2,
    },
    loc_vars   = function(self, info_queue, center)
        local numerator, denominator = SMODS.get_probability_vars(self, self.config.base, self.config.odds,
            'fairgame1')
        return {
            vars = { numerator, denominator }
        }
    end,

    calculate  = function(self, back, context)
        if context.modify_hand then
            -- 1 in 2 chance to half base chips and mult
            if SMODS.pseudorandom_probability(self, 'fairgame', self.config.base, self.config.odds, 'fairgame1') then
                print("halved")
                mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
                hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
                attention_text({
                    text = "Tails!",
                    scale = 1.3,
                    hold = 3,
                    align = 'cm',
                    offset = { x = 0.05, y = 0 },
                    backdrop_colour = G.C.RED,
                    silent = true
                })
                -- 1 in 2 chance to double base chips & Mult
            elseif SMODS.pseudorandom_probability(self, 'fairgame67', self.config.base, self.config.odds, 'fairgame1') then
                print("doubled")
                hand_chips = mod_chips(hand_chips * 2)
                mult = mod_mult(mult * 2)
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
                attention_text({
                    text = "Heads!",
                    scale = 1.3,
                    hold = 3,
                    align = 'cm',
                    offset = { x = 0.05, y = 0 },
                    backdrop_colour = G.C.GREEN,
                    silent = true
                })
            end
        end
    end
}
