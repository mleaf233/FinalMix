SMODS.Challenge {
  button_colour = G.C.PURPLE,
  key = 'got_it_memorized',
  loc_txt = {
    name = "Got it Memorized?"
  },
  jokers = {
    { id = "j_kh_axel_alt", eternal = true },
    { id = "j_joker" },
  },
  rules = {
    custom = {
      { id = "kh_got_it_memorized" },
      { id = "no_skipping" },
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_luchador" },
      { id = "j_chicot" },
      { id = "j_throwback" },
      { id = "j_diet_cola" },
      { id = "v_directors_cut" },
      { id = "v_retcon" },
    },
    banned_other = {},
  },
}

SMODS.Challenge {
  key = 'boss_rush',
  button_colour = G.C.PURPLE,
  loc_txt = {
    name = "Boss Rush"
  },
  jokers = {
  },
  rules = {
    custom = {
      { id = "kh_got_it_memorized" },
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_luchador" },
      { id = "j_chicot" },
      { id = "v_directors_cut" },
      { id = "v_retcon" },
    },
    banned_other = {},
  },
  calculate = function(self, context)
  end
}

SMODS.Challenge {
  key = 'tick_tock',
  button_colour = G.C.PURPLE,
  loc_txt = {
    name = "Tick Tock"
  },
  jokers = {
    { id = "j_kh_luxord" },
  },
  rules = {
    custom = {
      { id = "kh_got_it_memorized" },
      { id = "no_time" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_throwback" },
      { id = "j_diet_cola" },
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if G.GAME.kh.luxord_destroyed or G.GAME.kh.luxord_sold then
      G.STATE = G.STATES.GAME_OVER
      if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
      end
      G:save_settings()
      G.FILE_HANDLER.force = true
      G.STATE_COMPLETE = false
    end
  end
}

SMODS.Challenge {
  key = 'chain_reaction',
  button_colour = G.C.PURPLE,
  loc_txt = {
    name = "Chain Reaction"
  },
  jokers = {
  },
  rules = {
    custom = {
      { id = "chain_reaction" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if context.card_added and context.card.ability.set == "Joker" then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.key ~= context.card.config.center.key then
          G.jokers.cards[i]:set_ability(context.card.config.center.key)
        end
      end
    end
  end
}

SMODS.Challenge {
  key = 'finalmix_only',
  button_colour = G.C.PURPLE,
  loc_txt = {
    name = "Balatro: Final Mix"
  },
  jokers = {
  },
  rules = {
    custom = {
      { id = "finalmix_only" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if G.GAME.modifiers.finalmix_only then
      for k, v in pairs(G.P_CENTER_POOLS['Joker']) do
        local joker_temp = G.P_CENTER_POOLS['Joker'][k]
        local key = joker_temp.key

        local is_kh_joker = key:sub(1, 5) == "j_kh_"

        if not G.GAME.banned_keys[key] and not is_kh_joker and v ~= self then
          G.GAME.banned_keys[key] = "j_kh_cool"
        end
      end
    end
  end,
}
